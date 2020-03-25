module Instruction_Memory(input [31:0] pc,output reg [31:0] out);
reg [7:0] instrucciones [0:255];


initial begin 
    $readmemb("instructions.txt",instrucciones);
end

always@(pc)
begin 
    out <= {instrucciones[pc],instrucciones[pc+1],instrucciones[pc+2],instrucciones[pc+3]};
end


endmodule