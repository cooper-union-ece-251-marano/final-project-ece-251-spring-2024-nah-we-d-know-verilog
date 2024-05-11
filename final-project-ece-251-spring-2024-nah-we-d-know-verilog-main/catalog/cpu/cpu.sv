//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2023
// Engineer: Darius Fantozzi and Alvee Ahmed
// 
//     Create Date: 2024-05-10
//     Module Name: cpu
//     Description: 16-bit RISC-based CPU (MIPS)
//
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef CPU
`define CPU

`timescale 1ns/100ps

`include "../controller/controller.sv"
`include "../datapath/datapath.sv"

module cpu
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    (
    input  logic        clk, reset,
    output logic [15:0] pc,
    input  logic [15:0] instr,
    output logic        memwrite,
    output logic [15:0] aluout, writedata,
    input  logic [15:0] readdata
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //

    // cpu internal components
    logic       memtoreg, alusrc, regdst, regwrite, jump, save, pcsrc, zero;
    logic [2:0] alucontrol;
    
    controller c(instr[15:12], zero,
                    memtoreg, memwrite, pcsrc,
                    alusrc, regdst, regwrite, jump, save, 
                    alucontrol);

    datapath dp(clk, reset, memtoreg, pcsrc,
                    alusrc, regdst, regwrite, jump, save, 
                    alucontrol,
                    zero, pc, instr,
                    aluout, writedata, readdata);

endmodule

`endif // CPU