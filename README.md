# DatapathSinglecycle


Para ejecutarlo usar el siguiente comando :

    vvp hello.vpp


Este es el diseño que utilice para esta Ruta de datos :

[Datapath](https://i.stack.imgur.com/vCvw1.png)

**Y este es el ISA de mi Arquitectura :**

R-type : 

    add : 000000 
    sub : 000001 
    and : 000010 
    nor : 000011 
    or  : 000100 
    slt : 000101 


I-type : 

    addi : 000110 
    andi : 000111 
    subi : 001000 
    ori  : 001001 
    slti : 001101 
    
    beq  : 001010 
    bneq : 001011 
    bgez : 001100 

    lh   : 001110 
    lw   : 001111 
    sb   : 010000
    sh   : 010001
    sw   : 010010
    lui  : 010011
    lb   : 010100 


J-type :

    j   : 010101 
    jr  : 010110 
    jal : 010111 



