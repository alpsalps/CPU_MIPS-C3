`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:54:47 01/10/2020
// Design Name: 
// Module Name:    PC 
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
module PC(
    input clk,
    input reset,
	 input en_PC,
	 input [31:0]nexpc,
    output reg [31:0] pc
    );
	 initial begin
		pc<=32'h00003000;
	 end
	 always @(posedge clk)begin
			if (reset)begin
				pc<=32'h00003000;
			end
			else if (!en_PC) begin
				pc<=nexpc;
			end
	 end

endmodule
