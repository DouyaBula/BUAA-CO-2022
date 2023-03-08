`timescale 1ns / 1ps
`default_nettype none 
module ControlUnit (
    input wire [31:0] Instr,
    input wire [5:0] Opcode, Funct,
    
    output wire [2:0] PCSrc, CMP,
    output wire SignImm,
    output wire [2:0] ByteEnControl, MemDataControl,
    output wire RegWrite,
    output wire [2:0] RegDataSrc, RegDst,
    output wire [1:0] Tuse, TnewD,
    output wire [3:0] ALUControl,
    output wire ALUSrc,
    output wire Start,
    output wire [3:0] MDUOP,
    output wire [1:0] ReadHILO,
    output wire [3:0] Time
);

    wire RRCalType, ADD, SUB, AND, OR, SLT, SLTU;
    wire RICalType, ADDI, ANDI, ORI, LUI;
    wire LMType, LB, LH, LW;
    wire SMType, SB, SH, SW;
    wire MDType, MULT, MULTU, DIV, DIVU, MFHI, MFLO, MTHI, MTLO, BDS;
    wire BType, BEQ, BNE;
    wire JType, JAL, JR;
    wire NOP;
    TypeDecoder TypeDecoderCU (
        .Instr(Instr),
        .Opcode(Opcode),
        .Funct(Funct),

        .RRCalType(RRCalType),
        .ADD(ADD),
        .SUB(SUB),
        .AND(AND),
        .OR(OR),
        .SLT(SLT),
        .SLTU(SLTU),
        .RICalType(RICalType),
        .ADDI(ADDI),
        .ANDI(ANDI),
        .ORI(ORI),
        .LUI(LUI),
        .LMType(LMType),
        .LB(LB),
        .LH(LH),
        .LW(LW),
        .SMType(SMType),
        .SB(SB),
        .SH(SH),
        .SW(SW),
        .MDType(MDType),
        .MULT(MULT),
        .MULTU(MULTU),
        .DIV(DIV),
        .DIVU(DIVU),
        .MFHI(MFHI),
        .MFLO(MFLO),
        .MTHI(MTHI),
        .MTLO(MTLO),
        .BDS(BDS),
        .BType(BType),
        .BEQ(BEQ),
        .BNE(BNE),
        .JType(JType),
        .JAL(JAL),
        .JR(JR),
        .NOP(NOP)
    );

    SignalDecoder SignalDecoderCU (
        .RRCalType(RRCalType),
        .ADD(ADD),
        .SUB(SUB),
        .AND(AND),
        .OR(OR),
        .SLT(SLT),
        .SLTU(SLTU),
        .RICalType(RICalType),
        .ADDI(ADDI),
        .ANDI(ANDI),
        .ORI(ORI),
        .LUI(LUI),
        .LMType(LMType),
        .LB(LB),
        .LH(LH),
        .LW(LW),
        .SMType(SMType),
        .SB(SB),
        .SH(SH),
        .SW(SW),
        .MDType(MDType),
        .MULT(MULT),
        .MULTU(MULTU),
        .DIV(DIV),
        .DIVU(DIVU),
        .MFHI(MFHI),
        .MFLO(MFLO),
        .MTHI(MTHI),
        .MTLO(MTLO),
        .BDS(BDS),
        .BType(BType),
        .BEQ(BEQ),
        .BNE(BNE),
        .JType(JType),
        .JAL(JAL),
        .JR(JR),
        .NOP(NOP),

        .PCSrc(PCSrc),
        .CMP(CMP),
        .SignImm(SignImm),
        .ByteEnControl(ByteEnControl),
        .MemDataControl(MemDataControl),
        .RegWrite(RegWrite),
        .RegDataSrc(RegDataSrc),
        .RegDst(RegDst),
        .Tuse(Tuse),
        .TnewD(TnewD),
        .ALUControl(ALUControl),
        .ALUSrc(ALUSrc),
        .Start(Start),
        .MDUOP(MDUOP),
        .ReadHILO(ReadHILO),
        .Time(Time)
    );
endmodule