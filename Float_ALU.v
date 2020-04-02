module F_alu(read_f_data1,read_f_data2,cop,func,alu_float_result);

input [63:0] read_f_data1;
input [63:0] read_f_data2;
input [4:0] cop;
input [6:0] func;

output reg [63:0] alu_float_result;


reg sign;

reg [7:0] exponent_s;
reg [10:0] exponent_d;

reg [22:0] single_precision;
reg [51:0] double_precision;

reg [31:0] data1;//primer operando de tipo single 
reg [31:0] data2;//segundo operando de tipo single





always@(cop,func)
begin
    if (cop==5'b10000) 
        begin
            if(func==6'b000000)
                begin


                end
        end
    else if(cop==5'b10001)
        begin
            if(func==6'b000000)
                begin
                    
                end            
        end

end






endmodule