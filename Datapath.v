`include "Program_Counter.v"
`include "Instruction_Memory.v"
`include "Add_pc.v"
`include "Control_Unit.v"


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



//FETCH
Program_Counter PC(.clk(clk),.reset(reset),.d(d),.q(pc));
Instruction_Memory IM(.pc(pc),.out(instruction));
Add_pc APC(.pc(pc),.pc_end(d));


//DECODE 
Control_Unit CU(.instruction(instruction[31:26]),.RegDst(RegDst),.jump(jump),.Branch(Branch),.MemRead(MemRead),.MemtoReg(MemtoReg),.ALUOP(ALUOP),.MemWrite(MemWrite),.ALUSrc(ALUSrc),.RegWrite(RegWrite));







always
begin
    #1clk=~clk;
end


initial begin
	$dumpfile("func.vcd");
	$dumpvars;
	$monitor(" pc = %b,%b,%d,%d,%d,%d",pc,instruction,RegDst,ALUOP,ALUSrc,RegWrite);
	reset<=1;
    clk<=1;
    #1;
    reset<=0;
	#13;$finish;

end

endmodule