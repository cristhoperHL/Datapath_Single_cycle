module ALU(read_data1,read_data2,alu_control_out,zero,ALU_result);

input [5:0] alu_control_out;
input [31:0] read_data1,read_data2;
output reg zero;
output reg [31:0] ALU_result;


always@(read_data1,read_data2,alu_control_out)
begin
    if(alu_control_out == 6'b000000)//ADD
        begin
            ALU_result = read_data1 + read_data2;
            zero = 1'b0;
        end
    else if(alu_control_out == 6'b000001)//SUB
        begin
            ALU_result = read_data1 - read_data2;
            zero = 1'b0; 
        end
    else if(alu_control_out == 6'b000010)//AND
        begin
            ALU_result = read_data1 & read_data2;
            zero = 1'b0;

        end
    else if(alu_control_out == 6'b000011)//NOR
        begin
            ALU_result = ~(read_data1 | read_data2);
            zero = 1'b0;
        end
    else if(alu_control_out == 6'b000100)//OR
        begin
            ALU_result = read_data1 | read_data2;        
            zero = 1'b0; 
        end
    else if(alu_control_out == 6'b000101)//SLT
        begin 
            if(read_data1 < read_data2)
                begin 
                    ALU_result = 1;
                    zero = 1'b0;
                end 
            else
                begin
                    ALU_result = 0;
                    zero = 1'b0;
                end                
        end//desde aca vienen los inmediatos  
    else if(alu_control_out == 6'b000110)//ADDI
        begin
            ALU_result = read_data1 + read_data2;
            zero = 1'b0;
        end
    else if(alu_control_out==6'b000111)//ANDI
        begin 
            ALU_result = read_data1 & read_data2;
            zero = 1'b0;
        end  
    else if(alu_control_out==6'b001000)//SUBI
        begin 
            ALU_result = read_data1 - read_data2;
            zero = 1'b0;
        end 
    else if(alu_control_out==6'b001001)//ORI
        begin 
            ALU_result = read_data1 | read_data2;
            zero = 1'b0; 
        end 
    else if(alu_control_out==6'b001101)//SLTI
        begin 
            if(read_data1 < read_data2)
                begin 
                    ALU_result = 1;
                    zero = 1'b0;
                end 
            else
                begin
                    ALU_result = 0;
                    zero = 1'b0;
                end                
        end
    else if(alu_control_out==6'b001010)//BEQ
        begin 
            if(read_data1 == read_data2)
                begin
                    zero = 1'b1;
                    ALU_result = 0;
                end
            else
                begin
                    zero = 1'b0;
                    ALU_result = 0;
                end
        end
    else if(alu_control_out==6'b001011)//BNEQ
        begin 
            if(read_data1 != read_data2)
                begin
                    zero = 1'b1;
                    ALU_result = 0;
                end
            else
                begin
                    zero = 1'b0;
                    ALU_result = 0;
                end
            
        end
    else if(alu_control_out==6'b001100)//BGEZ
        begin 
            if(read_data1 >= 0)
                begin
                    zero = 1'b1;
                    ALU_result = 0;
                end
            else
                begin
                    zero = 1'b0;
                    ALU_result = 0;
                end
        end
    else if(alu_control_out==6'b001110 || alu_control_out==6'b001111 || alu_control_out==010100)//LH,LW,LB
        begin
            zero=1'b0;
            ALU_result=read_data1+read_data2;
        end
    else if(alu_control_out==6'b010011)//LUI
        begin
            zero=1'b0;
            ALU_result= read_data2 << 16;
        end 
    
    
end

endmodule