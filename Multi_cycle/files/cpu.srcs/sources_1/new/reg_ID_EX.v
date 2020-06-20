`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:01:38 01/15/2020 
// Design Name: 
// Module Name:    reg_ID_EX 
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
module Ereg_ID_EX(
    input [31:0] IR,
    input [31:0] PC8,
    input [31:0] V1,
    input [31:0] V2,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] EXT32,
	 input clk,
	 input reset,
	 input clr,
    output reg [31:0] IR_E,
    output reg [31:0] PC8_E,
    output reg [31:0] V1_E,
    output reg [31:0] V2_E,
    output reg [4:0] A1_E,
    output reg [4:0] A2_E,
    output reg [4:0] A3_E,
    output reg [31:0] EXT32_E
    );
	 initial begin
		IR_E<=0;
		PC8_E<=0;
		V1_E<=0;
		V2_E<=0;
		A1_E<=0;
		A2_E<=0;
		A3_E<=0;
		EXT32_E<=0;		
	 end
	always @(posedge clk)begin
		if (reset)begin
			IR_E<=0;
			PC8_E<=0;
			V1_E<=0;
			V2_E<=0;
			A1_E<=0;
			A2_E<=0;
			A3_E<=0;
			EXT32_E<=0;		
		end
		else if (clr)begin
			IR_E<=0;
			PC8_E<=0;
			V1_E<=0;
			V2_E<=0;
			A1_E<=0;
			A2_E<=0;
			A3_E<=0;
			EXT32_E<=0;				
		end
		else begin
			IR_E<=IR;
			PC8_E<=PC8;
			V1_E<=V1;
			V2_E<=V2;
			A1_E<=A1;
			A2_E<=A2;
			A3_E<=A3;
			EXT32_E<=EXT32;
		end
	end

endmodule
