`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:16:45 12/30/2020 
// Design Name: 
// Module Name:    ID 
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
module ID(
    input [31:0] IR,
    input [31:0] PC4,
	 input [4:0] A3,
	 input [31:0] RF_WD,
	 input regwrite,
	 input clk,
	 input reset,
	 input [31:0]MFD_E,
	 input [31:0]MFD_M,
	 input [31:0] MFD_W,
	 input [1:0] MF_V1_sel, 
	 input [1:0] MF_V2_sel,	
	 output [31:0] V1,
	 output [31:0] V2,
	 output [4:0] A1,
	 output [4:0] A2,
	 output [4:0] A3_to_Ereg,
	 output [31:0] EXT32,
	 output [31:0] PC8,
	 output [31:0] NPC,
	 output [1:0] PC_sel
    );
	assign A1=IR[25:21];
	assign A2=IR[20:16];
	
	wire [31:0]RD1;
	wire [31:0]RD2;
	wire [31:0]sign_ext;
	wire [31:0]zero_ext;
	wire [31:0]pc_j,pc_b;
	wire extop;
	wire [1:0]A3_sel;
	wire [4:0]reg31;
	wire [31:0]offset_b;
	

	wire branch;
	
	ID_control ID_C(
		.IR(IR),
		.V1(V1),
		.V2(V2),
		.extop(extop),
		.branch(branch),
		.A3_sel(A3_sel),
		.PC_sel(PC_sel)
	);
	wire [31:0]ttt;
	GPR ID_G (
		.A1(A1), 
		.A2(A2), 
		.A3(A3), 
		.RF_WD(RF_WD), 
		.regwrite(regwrite), 
		.reset(reset), 
		.clk(clk), 
		.RD1(RD1), 
		.RD2(RD2)
	);
	
	mux4#(32) MF_V1(
		.data_00(RD1),
		.data_01(MFD_W),
		.data_10(MFD_M),
		.data_11(MFD_E),
		.sel(MF_V1_sel),
		.result(V1)
	);

	mux4#(32) MF_V2(
		.data_00(RD2),
		.data_01(MFD_W),
		.data_10(MFD_M),
		.data_11(MFD_E),
		.sel(MF_V2_sel),
		.result(V2)
	);


	assign sign_ext={{16{IR[15]}},{IR[15:0]}};
	assign zero_ext={{16'b0},{IR[15:0]}};
	assign PC8=PC4+4;
	assign reg31=32'b11111;
	assign imm_s={{27'b0},{IR[10:6]}};

	
	mux2#(32) MUX_EXT_I16(
		.data0(zero_ext),
		.data1(sign_ext),
		.sel(extop),
		.result(EXT32)
	);
	
	mux3#(5) MUX_A3(
		.data_00(IR[20:16]),
		.data_01(IR[15:11]),
		.data_10(reg31),
		.sel(A3_sel),
		.result(A3_to_Ereg)
	);
	
	assign pc_j={{PC4[31:28]},{IR[25:0]},{2'b00}};
	assign offset_b={{14{IR[15]}},{IR[15:0]},{2'b00}};
	assign pc_b=PC4+offset_b;
	
	mux2#(32) MUX_NPC(
		.data0(pc_j),
		.data1(pc_b),
		.sel(branch),
		.result(NPC)
	);
	
endmodule
