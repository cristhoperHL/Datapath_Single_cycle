module Jump_sl(inst_jump,pc_4,out);

input [25:0] inst_jump;
input [31:0] pc_4;
output [31:0] out;

assign out = { pc_4[31:28],inst_jump,2'b00};


endmodule