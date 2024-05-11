//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Darius Fantozzi and Alvee Ahmed
//
//     Create Date: 2024-05-10
//     Module Name: Computer
//     Description: 16-bit RISC
//
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef COMPUTER
`define COMPUTER

`timescale 1ns/100ps

`include "../cpu/cpu.sv"
`include "../imem/imem.sv"
`include "../dmem/dmem.sv"

module computer
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
  (
    input  logic           clk, reset, 
    output logic [15:0] writedata, dataadr, 
    output logic           memwrite
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [15:0] pc, instr, readdata;

    // computer internal components

    // the RISC CPU
    cpu mips(clk, reset, pc, instr, memwrite, dataadr, writedata, readdata);
    
      // the instruction memory ("text segment") in main memory
  imem imem(pc[5:0], instr);
    
      // the data memory ("data segment") in main memory
    dmem dmem(clk, memwrite, dataadr, writedata, readdata);

endmodule

`endif // COMPUTER