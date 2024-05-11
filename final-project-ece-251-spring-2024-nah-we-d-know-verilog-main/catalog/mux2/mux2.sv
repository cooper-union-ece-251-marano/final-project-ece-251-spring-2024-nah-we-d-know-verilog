//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Darius Fantozzi and Alvee Ahmed
// 
//     Create Date: 2024-05-10
//     Module Name: mux2
//     Description: 2 to 1 multiplexer
//
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef MUX2
`define MUX2

`timescale 1ns/100ps

module mux2
  #(parameter n = 16)
  
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
(
    input  logic [15:0] D0, D1,
    input  logic S,
    output logic [15:0] Y
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    assign Y = S ? D1 : D0;
endmodule

`endif // MUX2