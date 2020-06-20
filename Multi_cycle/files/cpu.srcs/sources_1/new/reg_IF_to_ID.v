`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:51:19 01/16/2020
// Design Name: 
// Module Name:    reg_IF_to_ID 
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
module Dreg_IF_ID(
    input [31:0] IM,
    input [31:0] PC4,
	 input clk,
	 input en_D,
	 input reset,
    output reg [31:0] IR_D,
    output reg [31:0] PC4_D
    );
	initial begin
		IR_D<=0;
		PC4_D<=0;
	end
	always @(posedge clk)begin
		if (reset) begin
			IR_D<=0;
			PC4_D<=0;			
		end
		else if (!en_D)begin
			IR_D<=IM;
			PC4_D<=PC4;
		end
	end

endmodule
