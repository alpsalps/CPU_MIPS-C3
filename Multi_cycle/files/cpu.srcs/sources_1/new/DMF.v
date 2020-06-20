`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:03:59 01/16/2020 
// Design Name: 
// Module Name:    DMF 
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
module DMF(
	 input [31:0] IR,
	 input [31:0] PC8,
    input [31:0] AO,
    input [31:0] DM_WD,
	 input [31:0] MFD_W,
	 input MF_DMWD_sel,
    input clk,
    input reset,
    output [31:0] DR
    );
	 
	 wire [31:0]wpc;
	 wire [31:0]WD;
	 wire memwrite;
	 wire [3:0]BE;

	DM_control DM_C(
		 .IR(IR),
		 .addr_b(AO[1:0]),
		 .memwrite(memwrite),
		 .dm_BE(BE)
    );
	 
	 assign wpc=PC8-32'd8;
	 
	 mux2#(32) MF_DMWD(
		.data0(DM_WD),
		.data1(MFD_W),
		.sel(MF_DMWD_sel),
		.result(WD)
	 );
	 wire [31:0]ttt;
	 assign ttt=(wpc==32'h3634)?IR:wpc;
	DM DMF_D (
		.displayaddr(AO), 
		.dm_A(AO[13:2]), 
		.dm_WD(WD), 
		.dm_BE(BE),
		.memwrite(memwrite), 
		.reset(reset), 
		.clk(clk), 
		.mem_result(DR)
	);	
	
endmodule
