module regdst_mux_2_1(a,b,sel,y);
input [4:0] a,b;
input sel;
output reg [4:0] y; 


always@(a,b,sel)
begin 

if (sel == 1'b1) 
    begin
        y=a;
    end
else if(sel == 1'b0)
    begin
        y=b;
    end
end


endmodule