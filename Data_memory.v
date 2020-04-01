module Data_memory(address,write_data,Memwrite,Memread,read_data);

input [31:0] address,write_data;
input [1:0] Memwrite,Memread;
output reg [31:0] read_data;

reg [7:0] memoria [0:255];

initial begin
    $readmemb("memoria.txt",memoria);
end


always@(address,write_data,Memwrite,Memread)
begin

if (Memread==2'b01) //LH
    begin
    //read_data = {memoria[address]};
    end
else if(Memread==2'b10)//LW
    begin
    read_data = {memoria[address],memoria[address+1],memoria[address+2],memoria[address+3]}; 
    end
else if(Memread==2'b11)//LB 
    begin//se escoje el primer byte mas a la izquierda y luego se extiende dependiendo del BSM 
    read_data = {{24{address[7]}},memoria[address]};
    end
    //FALTAN LAS INSTRUCCIONES STORE

end

endmodule 