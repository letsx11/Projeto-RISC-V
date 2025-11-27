`timescale 1ns / 1ps

module BranchUnit #(
    parameter PC_W = 9
) (
    input logic [PC_W-1:0] Cur_PC,
    input logic [31:0] Imm,
    input logic Branch,
    input logic [31:0] AluResult,
    input logic [1:0] ALUOp, // 01 - Branch
    input logic [31:0] Reg1,
    output logic [31:0] PC_Imm,
    output logic [31:0] PC_Four,
    output logic [31:0] BrPC,
    output logic PcSel
);

  logic Branch_Sel;
  logic Jump_Sel;
  logic Result_Sel;
  logic [31:0] PC_Full;

  assign PC_Full = {23'b0, Cur_PC};

  assign PC_Imm = (Jump_Sel) ? Imm + Reg1 : PC_Full + Imm;
  assign PC_Four = PC_Full + 32'b100;
  assign Branch_Sel = Branch && AluResult[0];  // 0:Branch is taken; 1:Branch is not taken

  assign Result_Sel = Jump_Sel || Branch_Sel; //realiza salto ou branch

  assign BrPC = (Result_Sel) ? PC_Imm : 32'b0;  //se o salto ocorrer o BrPc recebe o imediato // SenÃ£o, BrPC recebe  0
  assign PcSel = Result_Sel;  // 1:desvio tomado; 0:desvio nÃ£o tomado(prÃ³xima instruÃ§Ã£o pc+4)

endmodule
