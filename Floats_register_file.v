module F_register_file(clk,op,cop,ft,fs,fd,write_data_f,read_f_data1,read_f_data2);

input clk;
input [5:0] op;
input [4:0] cop;
input [4:0] ft,fs;
input [4:0] fd;
input [63:0] write_data_f;

output reg [63:0] read_f_data1;
output reg [63:0] read_f_data2;

reg [31:0] variables_f[0:31];

initial begin
    $readmemb("variables_f.txt",variables_f);
end 



always@(posedge clk)
begin
   if (op==6'b111111) 
        begin
            if(cop==5'b10000) 
                begin
                    variables_f[fd] <= write_data_f[63:32] ;               
                end
            else if(cop==5'b10001)
                begin
                    variables_f[fd] <= write_data_f[63:32];
                    variables_f[fd+1] <= write_data_f[31:0];
                end
        end
end


always@(cop,op)
begin
    if(cop == 5'b10000 && op==6'b111111)
        begin
            read_f_data1 = {variables_f[fs],{32{1'b0}}};
            read_f_data2 = {variables_f[ft],{32{1'b0}}};
        end
    else if(cop == 5'b10001 && op==6'b111111)
        begin
            read_f_data1 = {variables_f[fs],variables_f[fs+1]};
            read_f_data2 = {variables_f[ft],variables_f[ft+1]};
        end


end


endmodule 