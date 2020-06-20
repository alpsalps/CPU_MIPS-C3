`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:14:28 01/15/2020
// Design Name: 
// Module Name:    forward_control 
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
module forward_control(
    input [4:0] A1_E,
    input [4:0] A2_E,
	 input [4:0] A3_E,
    input [4:0] A3_M,
    input [4:0] A3_W,
	 input [4:0] A1_D,
	 input [4:0] A2_D,
	 input [4:0] A2_M,
    input [1:0] Tnew_E,
    input [1:0] Tnew_M,
	 input regwrite_E,
	 input regwrite_M,
	 input regwrite_W,
    output [1:0] MF_ALUD1,
    output [1:0] MF_ALUD2,
	 output [1:0] MF_V1,
	 output [1:0] MF_V2,
	 output  MF_DMWD
    );
	assign MF_ALUD1=((A1_E==A3_M)&&(A3_M!=0)&&(Tnew_M==0)&&(regwrite_M))?2'b10:
						 ((A1_E==A3_W)&&(A3_W!=0)				  &&(regwrite_W))?2'b01:
						 2'b00;
	assign MF_ALUD2=((A2_E==A3_M)&&(A3_M!=0)&&(Tnew_M==0)&&(regwrite_M))?2'b10:
						 ((A2_E==A3_W)&&(A3_W!=0)				  &&(regwrite_W))?2'b01:
						 2'b00;					 
	assign MF_V1=	 ((A1_D==A3_E)&&(A3_E!=0)&&(Tnew_E==0)&&(regwrite_E))?2'b11:
						 ((A1_D==A3_M)&&(A3_M!=0)&&(Tnew_M==0)&&(regwrite_M))?2'b10:
						 ((A1_D==A3_W)&&(A3_W!=0)				  &&(regwrite_W))?2'b01:
						 2'b00;
	assign MF_V2=	 ((A2_D==A3_E)&&(A3_E!=0)&&(Tnew_E==0)&&(regwrite_E))?2'b11:
						 ((A2_D==A3_M)&&(A3_M!=0)&&(Tnew_M==0)&&(regwrite_M))?2'b10:
						 ((A2_D==A3_W)&&(A3_W!=0)				  &&(regwrite_W))?2'b01:
						 2'b00;
	assign MF_DMWD= ((A2_M==A3_W)&&(A3_W!=0)             &&(regwrite_W))?1'b1:
						 1'b0;
endmodule
