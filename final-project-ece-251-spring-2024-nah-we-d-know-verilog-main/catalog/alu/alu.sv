//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2023
// Engineer: Darius Fantozzi and Alvee Ahmed
// 
//     Create Date: 2023-02-07
//     Module Name: alu
//     Description: 32-bit RISC-based CPU alu (MIPS)
//
// Revision: 1.0
// see https://github.com/Caskman/MIPS-Processor-in-Verilog/blob/master/ALU32Bit.v
//////////////////////////////////////////////////////////////////////////////////
`ifndef ALU
`define ALU

`timescale 1ns/100ps

module alu
  #(parameter n = 16)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic        clk,
    input  logic [(n-1):0] a, b,
    input  logic [2:0]  alucontrol,
    output logic [(n-1):0] result,
    output logic        zero
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [(n-1):0] condinvb, sumSlt;

    assign zero = (result == {n{1'b0}}); // zero result control signal
    assign condinvb = (alucontrol == 3'b110) ? (~b) + 1 : b;
    assign sumSlt = a + condinvb; // (a-b using 2s complement) test if a == b, if b<a, then sumSlt will have neg bit[31]

    always @(a,b,alucontrol) begin
        case (alucontrol)
            3'b011: result = a & b;             // and
            3'b001: result = a | b;             // or
            3'b000: result = a + b;             // add
            3'b111: result = ~(a | b);          // nor
            3'b100: result = a * (2**b);        // sll
            3'b101: result = a / (2**b);        // srl
            3'b110: result = sumSlt;            // sub
            // 3'b010: result = sumSlt[(n-1)];  // slt
            3'b010: begin                       // slt
                if (a[15] != b[15])
                    if (a[15] > b[15])
						result = 1;
					else
						result = 0;
				else
					if (a < b)
						result = 1;
					else
						result = 0;
            end
        endcase
    end

endmodule

`endif // ALU
