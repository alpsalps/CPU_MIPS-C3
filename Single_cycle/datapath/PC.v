`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/20 21:11:04
// Design Name: 
// Module Name: PC
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


module PC(
    input [31:0] NPC,
    input Clk,
    input Rst,
    output reg[31:0] PC
    );
    always @(posedge Clk, posedge Rst)
    begin
        if (Rst)
           PC  <= 32'h00003000;
        else if (Clk)
           PC <= NPC;
    end
endmodule

