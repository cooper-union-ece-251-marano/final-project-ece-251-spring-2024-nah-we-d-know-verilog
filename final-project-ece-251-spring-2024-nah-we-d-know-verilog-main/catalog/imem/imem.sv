//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Darius Fantozzi and Alvee Ahmed
// 
//     Create Date: 2024-05-10
//     Module Name: imem
//     Description: 16-bit RISC memory (instruction "text" segment)
//
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef IMEM
`define IMEM

`timescale 1ns/100ps

module imem
// 16 is the bit length of an instruction
// r = bit length of addr to limit memory and not crash your verilog emulator
  #(parameter r = 6)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic [(r-1):0] address,
    output logic [15:0] instruc
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
  logic [15:0] RAM[0:(2**r-1)];

  initial
    begin
      $readmemh("fib_exe",RAM);
// instruction file is in hex, so read it from there 
    end

  assign instruc = RAM[address]; // word aligned

endmodule

`endif // IMEM
