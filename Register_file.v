module Register_file(clk,read_reg1,read_reg2,write_reg,write_data,RegWrite,read_data1,read_data2);

//NOTA : Falta la entrada write reg que viene de memory.

input clk;
input [4:0] read_reg1,read_reg2;
input [31:0] write_data;
//el regwrite es el que le dice si es r o i y por lo tanto de ahi sacas donde escribir
//el resultado que obtienes del alu.
//input [31:0] write_data;
input RegWrite;
output [31:0] read_data1,read_data2;

//aqui se guardara el contenido donde se va a guardar
input [4:0] write_reg;

reg [31:0] variables [0:31];

initial begin
    $readmemb("variables.txt",variables);
end


always@(posedge clk)
begin
    if (RegWrite) 
        begin
            variables[write_reg] <= write_data;
        end
end


assign read_data1 = variables[read_reg1];
assign read_data2 = variables[read_reg2];




endmodule