`include "Program_Counter.v"
`include "Instruction_Memory.v"
`include "Add_pc.v"
`include "Control_Unit.v"
`include "Register_File.v"
`include "regdst_mux_2_1.v"
`include "ALU_control.v"
`include "ALU.v"
`include "Sign_Extend.v"
`include "alu_mux_2_1.v"
`include "Branch_and.v"
`include "Shift_left_2.v"
`include "Adder_branch.v"
`include "mux_branch_2_1.v"
`include "Jump_shift_left.v"
`include "mux_jump.v"
`include "Data_memory.v"
`include "mux_writeback.v"



module datapath();

reg clk;
reg reset;

//FETCH
//Signals(Instruction Memory and Program Counter)
wire [31:0] d;
wire [31:0] pc;
wire [31:0] instruction;

//Signals(Control Unit)
wire RegDst,jump,Branch,MemtoReg,RegWrite;
wire [1:0] MemRead,MemWrite;
wire [1:0] ALUSrc;
wire [5:0] ALUOP;

//Signals Register File
wire [4:0] write_reg;
wire [31:0] read_data1;
wire [31:0] read_data2;

//signals ALU_CONTROL
wire [5:0] alu_control_out;

//signals Sign Extend
wire [31:0] sign_extend_out;

//Signals del mux antes del alu
wire [31:0] data_2_out;

//signals shift left 2 del branch 
wire [31:0] shift_branch_out;

//signals adder branch
wire [31:0] adder_branch_result;

//signals ALU
wire [31:0] ALU_result;
wire zero;

//signals del and del Branch.
wire out_and;

//signal mux_branch
wire [31:0] mux_branch_out;

//signal out del shift left 2 de jump
wire [31:0] jump_sl_out;

//signal mux final jump
wire [31:0] mux_pc_end;

//signal MEMORY
wire [31:0] memory_out;

//signal MUX Writeback
wire [31:0] mux_end_cycle;



////////////////////////////////////////////////////////////////////////
//FETCH
Program_Counter PC(.clk(clk),.reset(reset),.d(mux_pc_end),.q(pc));
Instruction_Memory IM(.pc(pc),.out(instruction));
Add_pc APC(.pc(pc),.pc_end(d));
	

//DECODE 
Control_Unit CU(.instruction(instruction[31:26]),.RegDst(RegDst),.jump(jump),
.Branch(Branch),.MemRead(MemRead),.MemtoReg(MemtoReg),.ALUOP(ALUOP),
.MemWrite(MemWrite),.ALUSrc(ALUSrc),.RegWrite(RegWrite));


//shift_left_jump
Jump_sl j_sl(.inst_jump(instruction[25:0]),.pc_4(d),.out(jump_sl_out));

regdst_mux_2_1 rgm2_1(.a(instruction[20:16]),.b(instruction[15:11]),.sel(RegDst),
.y(write_reg));

 
Register_file RF(.clk(clk),.read_reg1(instruction[25:21]),
.read_reg2(instruction[20:16]),
.write_reg(write_reg),.write_data(mux_end_cycle),
.RegWrite(RegWrite),.read_data1(read_data1),
.read_data2(read_data2));


ALU_control AC(.ALUOP(ALUOP),.func(instruction[5:0]),
.alu_control_out(alu_control_out));

Sign_Extend SE(.instruction_in(instruction[15:0]),
.instruction_out(sign_extend_out));

alu_mux_2_1 alu_mux(.a(read_data2),.b(sign_extend_out),.sel(ALUSrc),
.y(data_2_out));


Shift_left_2 SL2(.inmediate(sign_extend_out),.out(shift_branch_out));


//EXECUTE

Adder_branch add_b(.a(d),.b(shift_branch_out),.out(adder_branch_result));

ALU alu(.read_data1(read_data1),.read_data2(data_2_out),
.alu_control_out(alu_control_out),.zero(zero),.ALU_result(ALU_result));


//AND del Branch
Branch_and Br_a(.a(zero),.b(Branch),.out(out_and));

mux_branch m_branch(.a(adder_branch_result),.b(d),.sel(out_and),.out(mux_branch_out));


//MEMORY 

Data_memory DM(.address(ALU_result),.write_data(read_data2),
.Memwrite(MemWrite),.Memread(MemRead),.read_data(memory_out));

//WRITEBACK

mux_w MW(.a(memory_out),.b(ALU_result),.sel(MemtoReg),
.out(mux_end_cycle));



//mux del jump y branch

mux_j jump_branch(.a(jump_sl_out),.b(mux_branch_out),.sel(jump),.out(mux_pc_end));




always
begin
    #1clk=~clk;
end


initial begin
	$dumpfile("func.vcd");
	$dumpvars;
	$monitor(" pc = %d,%b,%d,%d,a=%b,b=%b,op=%d,result=%b,%d",pc,instruction,instruction[25:21],instruction[20:16],read_data1,data_2_out,alu_control_out,ALU_result,ALUSrc);
	reset<=1;
    clk<=1;
    #1;
    reset<=0;
	#20;$finish;

end

endmodule