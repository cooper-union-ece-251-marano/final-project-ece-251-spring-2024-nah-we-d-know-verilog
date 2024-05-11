//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Darius Fantozzi and Alvee Ahmed
//
//     Create Date: 2024-05-10
//     Module Name: adder
//     Description: simple behavorial adder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef ADDER
`define ADDER

`timescale 1ns/100ps

module adder
  #(parameter n = 16)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input[(n-1):0] a, b,
    output[(n-1):0] sum

);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
  
  reg[(n-1):0] y;
  
  initial begin
        y = 0;
    end
  
  always @(*) begin
    y <= a + b;
  end
  assign sum = y;

endmodule

`endif // ADDER