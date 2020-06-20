`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/24 12:52:36
// Design Name: 
// Module Name: MUX
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module MUX2(
    input [31:0] A,
    input [31:0] B,
    input [1:0] mux,
    output [31:0] out
    );
    
    assign out = {32{mux[0]}} & A | {32{mux[1]}} & B;
endmodule


module MUX3(
    input [31:0] A,
    input [31:0] B,
    input [31:0] C,
    input [2:0] mux,
    output [31:0] out
    );
    
    assign out = {32{mux[0]}} & A | {32{mux[1]}} & B | {32{mux[2]}} & C;
endmodule


module MUX4(
    input [31:0] A,
    input [31:0] B,
    input [31:0] C,
    input [31:0] D,
    input [3:0] mux,
    output [31:0] out
    );
    
    assign out = {32{mux[0]}} & A | {32{mux[1]}} & B | {32{mux[2]}} & C | {32{mux[3]}} & D;
endmodule


