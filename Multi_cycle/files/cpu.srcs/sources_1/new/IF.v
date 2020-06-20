`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:39:20 01/14/2020 
// Design Name: 
// Module Name:    IF 
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
module IF(
    input [1:0] PC_sel,
    input [31:0] NPC,
    input [31:0] RD1,
	 input clk,
	 input reset,
	 input en_PC,
    output [31:0] IR,
    output [31:0] PC4
    );
	wire [31:0]PC;
	wire [31:0]nexpc;
	PC IF_P (
		.clk(clk), 
		.reset(reset),
		.en_PC(en_PC),
		.nexpc(nexpc), 
		.pc(PC)
	);	
	IM IF_I (
		.addr(PC), 
		.IR(IR)
	);
	assign PC4=PC+4;
	mux3#(32) MUX_PC(
		.data_00(PC4),
		.data_01(NPC),
		.data_10(RD1),
		.sel(PC_sel),
		.result(nexpc)
	);

endmodule
