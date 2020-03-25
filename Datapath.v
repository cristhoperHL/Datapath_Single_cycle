`include "Program_Counter.v"
`include "Instruction_Memory.v"
`include "Add_pc.v"


module datapath();

reg clk;
reg reset;

//FETCH
//Instruction Memory and Program Counter
wire [31:0] d;
wire [31:0] pc;
wire [31:0] instruction;



Program_Counter PC(.clk(clk),.reset(reset),.d(d),.q(pc));

Instruction_Memory IM(.pc(pc),.out(instruction));

Add_pc APC(.pc(pc),.pc_end(d));

always
begin
    #1clk=~clk;
end


initial begin
	$dumpfile("func.vcd");
	$dumpvars;
	$monitor(" pc = %b,%b",pc,instruction);
	reset<=1;
    clk<=1;
    #1;
    reset<=0;
	#13;$finish;

end



endmodule