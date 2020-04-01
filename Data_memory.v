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

if (Memread==2'b01 && Memwrite==2'b00) //LH
    begin

    //read_data = {memoria[address]};
    end
else if(Memread==2'b10 && Memwrite==2'b00 )//LW
    begin
    read_data = {memoria[address],memoria[address+1],memoria[address+2],memoria[address+3]}; 
    end
else if(Memread==2'b11 && Memwrite==2'b00)//LB 
    begin//se escoje el primer byte mas a la izquierda y luego se extiende dependiendo del BSM 
    read_data = {{24{address[7]}},memoria[address]};
    end
else if(Memread==2'b00 && Memwrite==2'b01)//SB 
    begin
    memoria[address] = {8{write_data[31]}};
    memoria[address] = {8{write_data[31]}};
    memoria[address+2] = {8{write_data[31]}};
    memoria[address+3] =  write_data[31:24]; 
    end
else if(Memread==2'b00 && Memwrite==2'b10)//SH 
    begin
    //
    end
else if(Memread==2'b00 && Memwrite==2'b11) //SW
    begin
        memoria[address] = write_data[31:24];
        memoria[address+1] = write_data[23:16];
        memoria[address+2] = write_data[15:8];
        memoria[address+3] = write_data[7:0];
    end

end

endmodule 