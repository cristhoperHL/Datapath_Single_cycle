module Control_Unit(instruction,RegDst,jump,Branch,MemRead,MemtoReg,ALUOP,MemWrite,ALUSrc,RegWrite);

input [5:0] instruction;
output reg RegDst;//falta probar 
output reg  jump;
output reg  Branch;
output reg  MemRead;
output reg  MemtoReg;
output reg  [5:0] ALUOP;
output reg MemWrite;
output reg ALUSrc;
output reg RegWrite;

always@(instruction)
begin
    if(instruction == 6'b000000) 
        begin
            RegDst<=1'b0;
            jump<=1'b0;
            Branch<=1'b0;
            MemRead<=1'b0;
            MemRead<=1'b0;
            MemtoReg<=1'b0;
            ALUOP<=6'b111111;
            MemWrite<=1'b0;
            ALUSrc<=1'b0;
            RegWrite<=1'b1;
        end
    else
        begin
            if( instruction == 6'b000110 || instruction== 6'b000111 || instruction==6'b001000 || instruction==6'b001001 )//operaciones normales como addi, subi y operaciones logicas  
                begin 
                    RegDst<=1'b1;
                    jump<=1'b0;
                    Branch<=1'b0;
                    MemRead<=1'b0;
                    MemRead<=1'b0;
                    MemtoReg<=1'b0;
                    ALUOP<=instruction;
                    MemWrite<=1'b0;
                    ALUSrc<=1'b1;
                    RegWrite<=1'b1;
                end  
            else if( instruction == 6'b000011 || instruction== 6'b000110 || instruction==6'b001001 )//operaciones de branch
                begin
                    RegDst<=1'b1;
                    jump<=1'b0;
                    Branch<=1'b1;
                    MemRead<=1'b0;
                    MemRead<=1'b0;
                    MemtoReg<=1'b0;
                    ALUOP<=instruction;
                    MemWrite<=1'b0;
                    ALUSrc<=1'b1;
                    RegWrite<=1'b1;            
                end
            
        //FALTA IMPLEMENTAR LOS ACCESOS DE MEMORIA SEAN LECTURA Y ESCRITURA.

        end
        //FALTA IMPLEMENTAR LOS JUMPS 
end


endmodule