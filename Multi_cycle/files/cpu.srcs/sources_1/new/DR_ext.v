`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:38:32 01/14/2020 
// Design Name: 
// Module Name:    DR_ext 
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
`define LW 	3'b000
`define LB 	3'b001
`define LBU 3'b010
`define LH 	3'b011
`define LHU 3'b100

module DR_ext(
    input [1:0] addr_B,
    input [31:0] Din,
    input [2:0] op,
    output [31:0] Dout
    );
	
	assign Dout=(op==`LB)?(addr_B==2'b00)?{{24{Din[7]}},{Din[7:0]}}:
								(addr_B==2'b01)?{{24{Din[15]}},{Din[15:8]}}:
								(addr_B==2'b10)?{{24{Din[23]}},{Din[23:16]}}:
								(addr_B==2'b11)?{{24{Din[31]}},{Din[31:24]}}:
								0:
					(op==`LBU)?(addr_B==2'b00)?{{24'b0},{Din[7:0]}}:
								(addr_B==2'b01)?{{24'b0},{Din[15:8]}}:
								(addr_B==2'b10)?{{24'b0},{Din[23:16]}}:
								(addr_B==2'b11)?{{24'b0},{Din[31:24]}}:
								0:
					(op==`LH)?(addr_B[1]==1'b0)?{{16{Din[15]}},{Din[15:0]}}:
								(addr_B[1]==1'b1)?{{16{Din[31]}},{Din[31:16]}}:
								0:
					(op==`LHU)?(addr_B[1]==1'b0)?{{16'b0},{Din[15:0]}}:
								(addr_B[1]==1'b1)?{{16'b0},{Din[31:16]}}:
								0:
					(op==`LW)?Din[31:0]:
					0;



endmodule
