`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:32:07 01/15/2020
// Design Name: 
// Module Name:    GRF 
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
module GPR(
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
	 input [31:0] RF_WD,
    input regwrite,
    input reset,
    input clk,
    output [31:0] RD1,
    output [31:0] RD2
    );
	reg [31:0]grf[0:31];
	integer i;
	initial begin
		for (i=0;i<=31;i=i+1)
			grf[i]=0;
	end
	always @(posedge clk)begin
		if (reset)begin
			for (i=0;i<=31;i=i+1)
				grf[i]=0;		
		end
		else begin
			if (regwrite && A3!=0)begin
				grf[A3]<=RF_WD;
				
			end
		end
	end
	assign RD1=grf[A1];
	assign RD2=grf[A2];
endmodule
