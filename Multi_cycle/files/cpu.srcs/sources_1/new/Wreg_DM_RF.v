`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:25:43 01/13/2020
// Design Name: 
// Module Name:    Wreg_DM_RF 
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
module Wreg_DM_RF(
    input [31:0] IR,
    input [31:0] PC8,
    input [4:0] A3,
    input [31:0] AO,
    input [31:0] DR,
	 input clk,
	 input reset,
    output reg [31:0] IR_W,
    output reg [31:0] PC8_W,
    output reg [4:0] A3_W,
    output reg [31:0] AO_W,
    output reg [31:0] DR_W
    );
	 
	initial begin
		IR_W<=0;
		PC8_W<=0;
		A3_W<=0;
		AO_W<=0;
		DR_W<=0;		
	end
	always @(posedge clk)begin
		if (reset)begin
			IR_W<=0;
			PC8_W<=0;
			A3_W<=0;
			AO_W<=0;
			DR_W<=0;			
		end
		else begin
			IR_W<=IR;
			PC8_W<=PC8;
			A3_W<=A3;
			AO_W<=AO;
			DR_W<=DR;
		end
	end

endmodule
