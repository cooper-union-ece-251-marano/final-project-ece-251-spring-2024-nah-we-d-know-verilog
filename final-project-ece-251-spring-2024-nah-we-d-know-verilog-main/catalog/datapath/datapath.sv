//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Darius Fantozzi and Alvee Ahmed
// 
//     Create Date: 2023-02-07
//     Module Name: datapath
//     Description: 32-bit RISC-based CPU datapath (MIPS)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef DATAPATH
`define DATAPATH

`timescale 1ns/100ps

`include "../regfile/regfile.sv"
`include "../alu/alu.sv"
`include "../dff/dff.sv"
`include "../adder/adder.sv"
`include "../mux2/mux2.sv"
`include "../signext/signext.sv"

module datapath
  #(parameter n = 16)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic        clk, reset,
    input  logic        memtoreg, pcsrc,
    input  logic        alusrc, regdst,
    input  logic        regwrite, jump,
    input  logic        save,
    input  logic [2:0]  alucontrol,
    output logic        zero,
    output logic [(n-1):0] pc,
    input  logic [(n-1):0] instr,
    output logic [(n-1):0] aluout, writedata,
    input  logic [(n-1):0] readdata
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [3:0]  writereg;
    logic [(n-1):0] pcnext, pcnextbr, pcplus1, pcbranch;
    logic [(n-1):0] signimm;
    logic [(n-1):0] srca, srcb;
    logic [(n-1):0] jamt;
    logic [(n-1):0] resimm;
    logic [(n-1):0] result;

    // "next PC" logic
    dff #(n)    pcreg(clk, reset, pcnext, pc);
    adder       pcadd1(pc, 16'b1, pcplus1);
    adder       pcadd2(pcplus1, signimm, pcbranch);
    adder       pcadd3(srca, {pcplus1[15:8], instr[7:0]}, jamt);
    mux2 #(n)   pcbrmux(pcplus1, pcbranch, pcsrc, pcnextbr);
    mux2 #(n)   pcmux(pcnextbr, jamt, jump, pcnext);

    // register file logic
    regfile     rf(clk, regwrite, instr[11:8], instr[7:4], writereg, result, srca, writedata);
    mux2 #(4)   wrmux(instr[7:4], instr[3:0], regdst, writereg);
    mux2 #(n)   resmux1(aluout, readdata, memtoreg, resimm);
    mux2 #(n)   resmux2(resimm, pc, save, result);
    signext     se(instr[3:0], signimm);

    // ALU logic
    mux2 #(n)   srcbmux(writedata, signimm, alusrc, srcb);
    alu         alu(clk, srca, srcb, alucontrol, aluout, zero);

endmodule

`endif // DATAPATH