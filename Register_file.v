module Register_file(clk,read_reg1,read_reg2,write_reg_input,write_data,RegWrite,read_data1,read_data2);

input clk;
input [4:0] read_reg1,read_reg2,write_reg_input;
//el regwrite es el que le dice si es r o i y por lo tanto de ahi sacas donde escribir
//el resultado que obtienes del alu.
input [31:0] write_data;
input RegWrite;
output reg [31:0] read_data1,read_data2;

//aqui se guardara el contenido donde se va a guardar
reg [5:0] write_reg;

reg [31:0] variables [0:31];

initial begin
    $readmemb("variables.txt",variables);
end


always@(posedge clk)
begin
    read_data1 <= variables[read_reg1];
    read_data2 <= variables[read_reg2];
    if (RegWrite) //significa que es inmediato 
        begin
            write_reg<=read_reg2;
        end
    else 
        begin
            write_reg<=write_reg_input;
        end
end

always@(negedge clk)
begin
    variables[write_reg]<= write_data;
end



endmodule