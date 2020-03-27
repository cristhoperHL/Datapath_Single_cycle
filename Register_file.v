module Register_file(clk,read_reg1,read_reg2,write_reg,RegWrite,read_data1,read_data2);

//NOTA : Falta la entrada write reg que viene de memory.

input clk;
input [4:0] read_reg1,read_reg2;
//el regwrite es el que le dice si es r o i y por lo tanto de ahi sacas donde escribir
//el resultado que obtienes del alu.
//input [31:0] write_data;
input RegWrite;
output reg [31:0] read_data1,read_data2;

//aqui se guardara el contenido donde se va a guardar
input [4:0] write_reg;

reg [31:0] variables [0:31];

initial begin
    $readmemb("variables.txt",variables);
end


always@(*)//ademas de eso agregar el posedge a clk
begin
    read_data1 <= variables[read_reg1];
    read_data2 <= variables[read_reg2];
end




endmodule