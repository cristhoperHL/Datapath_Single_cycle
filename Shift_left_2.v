module Shift_left_2(inmediate,out);

input [31:0] inmediate;

output [31:0] out;

assign out = {inmediate[29:0],2'b00};

endmodule