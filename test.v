`include"Instruction_Memory.v"

module test_Instruction_memory();

reg [31:0] pc;
wire [31:0] out;

Instruction_Memory test(.pc(pc),.out(out));


initial begin
	$dumpfile("func.vcd");
	$dumpvars;
	$monitor(" pc = %b,%b",pc,out);
	pc<=0;
	#10;$finish;

end

endmodule