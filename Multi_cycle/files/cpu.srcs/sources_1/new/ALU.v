`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:54:58 01/14/2020 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] D1,
    input [31:0] D2,
    input [4:0] aluop,
    output [31:0] AO
	 );
	assign AO=	(aluop==5'b00001)?D1+D2:
					(aluop==5'b00010)?D1+D2:
					(aluop==5'b00011)?D1-D2:
					(aluop==5'b00100)?D1-D2:
					(aluop==5'b00101)?D1&D2:
					(aluop==5'b00110)?D1|D2:
					(aluop==5'b00111)?D1^D2:
					(aluop==5'b01000)?~(D1|D2):
					(aluop==5'b01001)?($signed(D1)<$signed(D2))?1:0:
					(aluop==5'b01010)?(D1<D2)?1:0:
					(aluop==5'b01011)?D2<<{D1[4:0]}:
					(aluop==5'b01100)?D2>>{D1[4:0]}:
					(aluop==5'b01101)?$signed($signed(D2)>>>{D1[4:0]}):
					(aluop==5'b01110)?{D2[15:0],{16'b0}}:
					0;

endmodule
