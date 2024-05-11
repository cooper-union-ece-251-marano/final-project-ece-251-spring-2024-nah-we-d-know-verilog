//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2023
// Engineer: Darius Fantozzi and Alvee Ahmed
// 
//     Create Date: 2023-02-07
//     Module Name: aludec
//     Description: 32-bit RISC ALU decoder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef ALUDEC
`define ALUDEC

`timescale 1ns/100ps

module aludec
    #(parameter n = 16)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic [3:0] op,
    output logic [2:0] alucontrol);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
  always @(*)
    begin
      case(op)
        4'b0x00: alucontrol <= 3'b000; // add
        4'b011x: alucontrol <= 3'b000; // add
        4'b0x01: alucontrol <= 3'b001; // or
        4'b0010: alucontrol <= 3'b010; // slt
        4'b0011: alucontrol <= 3'b011; // and
        4'b1000: alucontrol <= 3'b100; // sll
        4'b1001: alucontrol <= 3'b101; // slr
        4'b1010: alucontrol <= 3'b110; // sub
        4'b1011: alucontrol <= 3'b111; // nor
        default: alucontrol <= 3'bxxx; // ???
      endcase
    end

endmodule

`endif // ALUDEC