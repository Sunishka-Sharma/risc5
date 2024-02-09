module ALU_Decoder(ALUOp,funct3,funct7,op5,ALUControl);


    input [2:0] funct3;
    input [1:0]ALUOp;
    input funct7, op5;
    output [2:0] ALUControl;

    // interim wire for concatenation 
    wire [1:0] concatenation;
    assign concatenation = {op5, funct7};


    assign ALUControl = (ALUOp == 2'b00) ? 3'b000 :
                        (ALUOp == 2'b01) ? 3'b001 :
                        ((ALUOp == 2'b10) & (funct3 == 3'b000) & (concatenation == 2'b11)) ? 3'b001 : 
                        ((ALUOp == 2'b10) & (funct3 == 3'b000) & (concatenation != 2'b11)) ? 3'b000 : 
                        ((ALUOp == 2'b10) & (funct3 == 3'b010)) ? 3'b101 : 
                        ((ALUOp == 2'b10) & (funct3 == 3'b110)) ? 3'b011 : 
                        ((ALUOp == 2'b10) & (funct3 == 3'b111)) ? 3'b010 : 
                                                                  3'b000 ;
endmodule