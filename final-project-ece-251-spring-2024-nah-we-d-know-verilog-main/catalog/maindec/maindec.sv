//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Darius Fantozzi and Alvee Ahmed
// 
//     Create Date: 2024-05-10
//     Module Name: maindec
//     Description: 32-bit RISC-based CPU main decoder (MIPS)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef MAINDEC
`define MAINDEC

`timescale 1ns/100ps

module maindec
  #(parameter n = 16)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic [3:0] op,
    output logic       memtoreg, memwrite,
    output logic       branch, alusrc,
    output logic       regdst, regwrite,
    output logic       jump,
    output logic       save,
    output logic [1:0] aluop
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
  logic [9:0] controls; // 10-bit control vector

    always @* begin
        case(op)
            4'bx0xx:   controls <= 10'b1100000010; // RTYPE
            4'b0110:   controls <= 10'b1010010000; // LW
            4'b0111:   controls <= 10'b0010100000; // SW
            4'b1111:   controls <= 10'b0001000001; // BEQ
            4'b010x:   controls <= 10'b1010000000; // ADDI / ORI
            4'b1100:   controls <= 10'b0000001000; // J
            4'b1101:   controls <= 10'b1000000100; // Save
            default:   controls <= 10'bxxxxxxxxxx; // illegal operation
        endcase
    end

    // controls has 10 logical signals
    always @* begin
        {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, save, aluop} <= controls;
    end 

endmodule

`endif // MAINDEC
