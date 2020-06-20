`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/24 10:30:38
// Design Name: 
// Module Name: GPR
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


module GPR(
    input WE,
    input Clk,
    input [4:0] Rreg1,
    input [4:0] Rreg2,
    input [4:0] Wreg,
    input [31:0] Wdata,
    output [31:0] Rdata1,
    output [31:0] Rdata2
    );
    
    reg [31:0] register [31:0];
    
    assign Rdata1 = register[Rreg1];
    assign Rdata2 = register[Rreg2];
    
    always @(posedge Clk)
        if (WE)
            register[Wreg] = Wdata;
    
    initial
        register[0] = 0;
endmodule

