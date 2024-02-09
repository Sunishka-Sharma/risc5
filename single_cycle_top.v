`include "program_counter.v"
`include "instruction_memory.v"
`include "register_file.v"
`include "sign_extend.v"
`include "alu.v"
`include "control_unit_top.v"
`include "data_mem.v"
`include "PC_Adder.v"






module Single_Cycle_Top (clk,rst);
    input clk,rst;
    wire RegWrite;
    wire [2:0] ALUControl_Top;
    wire [31:0] PC_Top,PCPlus4,RD_Instr,RD1_Top,Imm_Ext_top,ALUResult,ReadData,Result;

    P_C program_counter(
        .clk(clk),
        .rst(rst),
        .PC(PC_Top),
        .PC_NEXT(PCPlus4 )
    );

    Instr_Mem instruction_memory (
                                .rst(rst),
                                .A(PC_Top),
                                .RD(RD_Instr)
    );

    Reg_file register_file(
                            .clk(clk),
                            .rst(rst),
                            .WE3(RegWrite),
                            .WD3(ReadData),
                            .A1(RD_Instr[19:15]),
                            .A2(),
                            .A3(RD_Instr[11:7]),
                            .RD1(RD1_Top),
                            .RD2()

    );

    Sign_Extend sign_extend(
                        .In(RD_Instr),
                        .Imm_Ext(Imm_Ext_top)
    );
    ALU alu(
        .A(RD1_Top),
        .B(Imm_Ext_top),
        .Result(ALUResult),
        .ALUControl(ALUControl_Top),
        .OverFlow(),
        .Carry(),
        .Zero(),
        .Negative());

    Control_Unit_Top Control_Unit_Top (
                                    .Op(RD_Instr[6:0]),
                                    .RegWrite(RegWrite),
                                    .ImmSrc(),
                                    .ALUSrc(),
                                    .MemWrite(),
                                    .ResultSrc(),
                                    .Branch(),
                                    .funct3(RD_Instr[14:12]),
                                    .funct7(),
                                    .ALUControl(ALUControl_Top)
        

    );
    Data_Memory Data_Memory(
        .A(ALUResult), 
        .WD(), 
        .clk(clk), 
        .WE(),
        .RD(ReadData),
        .rst(rst)

    );
    PC_Adder PC_Adder(
        .a(PC_Top),
        .b(32'd4),
        .c(PCPlus4)

    );

endmodule
