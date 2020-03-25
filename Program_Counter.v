module Program_Counter(input clk,input reset,input [31:0] d,output reg [31:0] q);

always@(posedge clk,posedge reset)
if(reset==1'b1)
    q<=0;
else
    q<=d;
endmodule