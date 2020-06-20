`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:13:28 01/14/2020 
// Design Name: 
// Module Name:    Mult_A_Div 
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
`define MULT 	3'b001
`define MULTU	3'b010
`define DIV 	3'b011
`define DIVU	3'b100
`define MTHI 	3'b101
`define MTLO	3'b110
`define madd	3'b111
module Mult_A_Div(
    input [31:0] D1,
    input [31:0] D2,
    input [2:0] MADop,
	 input start,
    input clk,
	 input reset,
	 output reg [31:0] HI,
    output reg [31:0] LO
    );
	
	wire [63:0]tmp_result;

	initial begin
		HI<=0;
		LO<=0;
	end

	always @(posedge clk)begin
		if (reset)begin
			HI<=0;
			LO<=0;			
		end
		else if (start)begin
			HI<=tmp_result[63:32];
			LO<=tmp_result[31:0];
		end
	end

	assign tmp_result=(MADop==`MULT)?	$signed($signed({{32{D1[31]}},D1[31:0]})*$signed({{32{D2[31]}},D2[31:0]})):
							(MADop==`MULTU)?	D1*D2:
							(MADop==`DIV)?		{{$signed($signed(D1)%$signed(D2))},{$signed($signed(D1)/$signed(D2))}}:
							(MADop==`DIVU)?	{{D1%D2},{D1/D2}}:
							(MADop==`MTHI)?	{{D1[31:0]},{LO[31:0]}}:
							(MADop==`MTLO)?	{{HI[31:0]},{D1[31:0]}}:
							(MADop==`madd)?	{{HI[31:0]},{LO[31:0]}+{D1*D2}}:
							0;
							
endmodule
