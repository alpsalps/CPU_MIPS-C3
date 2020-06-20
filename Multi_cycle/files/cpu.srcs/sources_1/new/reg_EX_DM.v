`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:13:37 01/14/2020
// Design Name: 
// Module Name:    reg_EX_DM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Mreg_EX_DM(
    input [31:0] IR,
    input [31:0] PC8,
    input [31:0] AO,
    input [4:0] A2,
    input [31:0] V2,
    input [4:0] A3,
	 input [31:0]RFWD,
    input clk,
	 input reset,
	 output reg [31:0] IR_M,
    output reg [31:0] PC8_M,
    output reg [31:0] AO_M,
    output reg [4:0] A2_M,
    output reg [31:0] V2_M,
    output reg [4:0] A3_M,
	 output reg [31:0] RFWD_M
    );
	 initial begin
			IR_M<=0;
			PC8_M<=0;
			AO_M<=0;
			A2_M<=0;
			V2_M<=0;
			A3_M<=0;
			RFWD_M<=0;
	 end
	always @(posedge clk)begin
		if (reset) begin
			IR_M<=0;
			PC8_M<=0;
			AO_M<=0;
			A2_M<=0;
			V2_M<=0;
			A3_M<=0;
			RFWD_M<=0;
		end
		else begin
			IR_M<=IR;
			PC8_M<=PC8;
			AO_M<=AO;
			A2_M<=A2;
			V2_M<=V2;
			A3_M<=A3;
			RFWD_M<=RFWD;
		end
	end

endmodule
