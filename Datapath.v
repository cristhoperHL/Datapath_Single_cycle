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


module datapath();

reg clk;
reg reset;

//FETCH
//Signals(Instruction Memory and Program Counter)
wire [31:0] d;
wire [31:0] pc;
wire [31:0] instruction;

//Signals(Control Unit)
wire RegDst,jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite;
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




//FETCH
Program_Counter PC(.clk(clk),.reset(reset),.d(mux_branch_out),.q(pc));
Instruction_Memory IM(.pc(pc),.out(instruction));
Add_pc APC(.pc(pc),.pc_end(d));
	

//DECODE 
Control_Unit CU(.instruction(instruction[31:26]),.RegDst(RegDst),.jump(jump),
.Branch(Branch),.MemRead(MemRead),.MemtoReg(MemtoReg),.ALUOP(ALUOP),
.MemWrite(MemWrite),.ALUSrc(ALUSrc),.RegWrite(RegWrite));


regdst_mux_2_1 rgm2_1(.a(instruction[20:16]),.b(instruction[15:11]),.sel(RegDst),
.y(write_reg));

 
Register_file RF(.clk(clk),.read_reg1(instruction[25:21]),
.read_reg2(instruction[20:16]),
.write_reg(write_reg),.write_data(ALU_result),
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



always
begin
    #1clk=~clk;
end


initial begin
	$dumpfile("func.vcd");
	$dumpvars;
	$monitor(" pc = %d,%b,%d,%d,a=%b,b=%b,op=%d,result=%b,%d",pc,instruction,instruction[25:21],instruction[20:16],read_data1,data_2_out,alu_control_out,ALU_result,write_reg);
	reset<=1;
    clk<=1;
    #1;
    reset<=0;
	#20;$finish;

end

endmodule