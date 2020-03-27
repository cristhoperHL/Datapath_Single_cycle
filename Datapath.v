`include "Program_Counter.v"
`include "Instruction_Memory.v"
`include "Add_pc.v"
`include "Control_Unit.v"
`include "Register_File.v"
`include "regdst_mux_2_1.v"
`include "ALU_control.v"
`include "ALU.v"

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

//signals ALU
wire [31:0] ALU_result;


//FETCH
Program_Counter PC(.clk(clk),.reset(reset),.d(d),.q(pc));
Instruction_Memory IM(.pc(pc),.out(instruction));
Add_pc APC(.pc(pc),.pc_end(d));


//DECODE 
Control_Unit CU(.instruction(instruction[31:26]),.RegDst(RegDst),.jump(jump),
.Branch(Branch),.MemRead(MemRead),.MemtoReg(MemtoReg),.ALUOP(ALUOP),
.MemWrite(MemWrite),.ALUSrc(ALUSrc),.RegWrite(RegWrite));


regdst_mux_2_1 rgm2_1(.a(instruction[25:21]),.b(instruction[20:16]),.sel(RegDst),
.y(write_reg));

//EL RF falta mejorar 
Register_file RF(.clk(clk),.read_reg1(instruction[25:21]),
.read_reg2(instruction[20:16]),
.write_reg(write_reg),.RegWrite(RegWrite),.read_data1(read_data1),
.read_data2(read_data2));


ALU_control AC(.ALUOP(ALUOP),.func(instruction[5:0]),
.alu_control_out(alu_control_out));



ALU alu(.read_data1(read_data1),.read_data2(read_data2),
.alu_control_out(alu_control_out),.ALU_result(ALU_result));


always
begin
    #1clk=~clk;
end


initial begin
	$dumpfile("func.vcd");
	$dumpvars;
	$monitor(" pc = %b,%b,%d,%d,a=%b,b=%b,op=%d,result=%b",pc,instruction,instruction[25:21],instruction[21:16],read_data1,read_data2,alu_control_out,ALU_result);
	reset<=1;
    clk<=1;
    #1;
    reset<=0;
	#10;$finish;

end

endmodule