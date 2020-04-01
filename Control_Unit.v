module Control_Unit(instruction,RegDst,jump,Branch,MemRead,MemtoReg,ALUOP,MemWrite,ALUSrc,RegWrite);

input [5:0] instruction;
output reg RegDst;//falta probar 
output reg  jump;
output reg  Branch;
output reg  [1:0] MemRead;
output reg  MemtoReg;
output reg  [5:0] ALUOP;
output reg [1:0] MemWrite;
output reg [1:0] ALUSrc;
output reg RegWrite;

always@(instruction)
begin
    if(instruction == 6'b000000) 
        begin
            RegDst<=1'b0;
            jump<=1'b0;
            Branch<=1'b0;
            MemRead<=2'b00;
            MemtoReg<=1'b0;
            ALUOP<=6'b111111;
            MemWrite<=2'b00;
            ALUSrc<=2'b00;
            RegWrite<=1'b1;
        end
    else
        begin
            if( instruction == 6'b000110 || instruction== 6'b000111 || instruction==6'b001000 || instruction==6'b001001 || instruction==6'b001101 )//ADDI,ANDI,SUBI,ORI,SLTI  
                begin 
                    RegDst<=1'b1;
                    jump<=1'b0;
                    Branch<=1'b0;
                    MemRead<=2'b00;
                    MemtoReg<=1'b0;
                    ALUOP<=instruction;
                    MemWrite<=2'b00;
                    ALUSrc<=2'b01;
                    RegWrite<=1'b1;
                end  
            else if( instruction == 6'b001010 || instruction== 6'b001011 || instruction==6'b001100 )//BEQ,BNEQ,BGEZ.
                begin
                    RegDst<=1'b1;
                    jump<=1'b0;
                    Branch<=1'b1;
                    MemRead<=2'b00;
                    MemtoReg<=1'b0;
                    ALUOP<=instruction;
                    MemWrite<=2'b00;
                    ALUSrc<=2'b10;
                    RegWrite<=1'b0;            
                end
            else if (instruction == 6'b010101 || instruction == 6'b010110 || instruction == 6'b010111)//J,JR,JAL            
                begin
                    RegDst<=1'b1;
                    jump<=1'b1;
                    Branch<=1'b0;
                    MemRead<=2'b00;
                    MemtoReg<=1'b0;
                    ALUOP<=instruction;
                    MemWrite<=2'b00;
                    ALUSrc<=2'b00;
                    RegWrite<=1'b0; 
                end
            else if (instruction == 6'b001110)//LH           
                begin
                    RegDst<=1'b1;
                    jump<=1'b1;
                    Branch<=1'b0;
                    MemRead<=2'b01;
                    MemtoReg<=1'b1;
                    ALUOP<=instruction;
                    MemWrite<=2'b00;
                    ALUSrc<=2'b00;
                    RegWrite<=1'b0; 
                end
            else if (instruction == 6'b001111)//LW          
                begin
                    RegDst<=1'b1;
                    jump<=1'b1;
                    Branch<=1'b0;
                    MemRead<=2'b10;
                    MemtoReg<=1'b1;
                    ALUOP<=instruction;
                    MemWrite<=2'b00;
                    ALUSrc<=2'b00;
                    RegWrite<=1'b0; 
                end
            else if (instruction == 6'b010011)//LUI        
                begin
                    RegDst<=1'b1;
                    jump<=1'b1;
                    Branch<=1'b0;
                    MemRead<=2'b00;
                    MemtoReg<=1'b1;
                    ALUOP<=instruction;
                    MemWrite<=2'b00;
                    ALUSrc<=2'b00;
                    RegWrite<=1'b0; 
                end
            else if (instruction == 6'b010100)//LB           
                begin
                    RegDst<=1'b1;
                    jump<=1'b1;
                    Branch<=1'b0;
                    MemRead<=2'b11;
                    MemtoReg<=1'b1;
                    ALUOP<=instruction;
                    MemWrite<=2'b00;
                    ALUSrc<=2'b00;
                    RegWrite<=1'b0; 
                end
            else if (instruction == 6'b010000)//SB         
                begin
                    RegDst<=1'b1;
                    jump<=1'b1;
                    Branch<=1'b0;
                    MemRead<=2'b00;
                    MemtoReg<=1'b0;
                    ALUOP<=instruction;
                    MemWrite<=2'b01;
                    ALUSrc<=2'b00;
                    RegWrite<=1'b0; 
                end
            else if (instruction == 6'b010001)//SH        
                begin
                    RegDst<=1'b1;
                    jump<=1'b1;
                    Branch<=1'b0;
                    MemRead<=2'b00;
                    MemtoReg<=1'b0;
                    ALUOP<=instruction;
                    MemWrite<=2'b10;
                    ALUSrc<=2'b00;
                    RegWrite<=1'b0; 
                end
            else if (instruction == 6'b010010)//SW         
                begin
                    RegDst<=1'b1;
                    jump<=1'b1;
                    Branch<=1'b0;
                    MemRead<=2'b00;
                    MemtoReg<=1'b0;
                    ALUOP<=instruction;
                    MemWrite<=2'b01;
                    ALUSrc<=2'b11;
                    RegWrite<=1'b0; 
                end
        end
end


endmodule