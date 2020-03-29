module alu_mux_2_1(a,b,sel,y);

input [31:0] a,b;
input sel;

output [31:0] y;

assign y = sel ? b : a ;

endmodule