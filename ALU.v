module ALU(read_data1,read_data2,alu_control_out,ALU_result);

input [5:0] alu_control_out;
input [31:0] read_data1,read_data2;
output reg [31:0] ALU_result;

always@(read_data1,read_data2,alu_control_out)
begin
    if(alu_control_out == 6'b000000)//ADD
        begin
            ALU_result = read_data1 + read_data2;
        end
    else if(alu_control_out == 6'b000001)//SUB
        begin
            ALU_result = read_data1 - read_data2;
        end
    else if(alu_control_out == 6'b000010)//AND
        begin
            ALU_result = read_data1 & read_data2;
        end
    else if(alu_control_out == 6'b000011)//NOR
        begin
            ALU_result = ~(read_data1 | read_data2);
        end
    else if(alu_control_out == 6'b000100)//OR
        begin
            ALU_result = read_data1 | read_data2;        
        end
end

endmodule