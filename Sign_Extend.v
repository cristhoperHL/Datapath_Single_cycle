module Sign_Extend(instruction_in,instruction_out);

input [15:0] instruction_in;
output [31:0] instruction_out;



assign instruction_out = {{16{instruction_in[15]}},instruction_in};


endmodule 