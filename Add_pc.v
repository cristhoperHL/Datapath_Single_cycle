module Add_pc(input [31:0] pc,output reg [31:0] pc_end);

always@(pc)
begin 
pc_end = pc + 4;
end

endmodule