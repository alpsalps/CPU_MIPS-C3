`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:27:41 01/14/2020 
// Design Name: 
// Module Name:    WB 
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
module WB(
    input [31:0] IR,
    input [31:0] PC8,
    input [31:0] AO,
    input [31:0] DR,
	 output regwrite,
    output [31:0] RF_WD
    );
	
	wire [1:0]RFWD_sel;
	wire [31:0]DR_out;
	wire [2:0]DR_ext_op;

	WB_control WB_C(
		.IR(IR),
		.regwrite(regwrite),
		.RFWD_sel(RFWD_sel),
		.DR_ext_op(DR_ext_op)
    );
	

	DR_ext DR_ext_WB(
		.addr_B(AO[1:0]),
		.Din(DR),
		.op(DR_ext_op),
		.Dout(DR_out)
    );
	
	mux3#(32) MUX_RFWD(
		.data_00(DR_out),
		.data_01(AO),
		.data_10(PC8),
		.sel(RFWD_sel),
		.result(RF_WD)
	);

endmodule
