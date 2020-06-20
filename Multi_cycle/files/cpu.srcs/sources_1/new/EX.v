`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:49:54 01/12/2020
// Design Name: 
// Module Name:    EX 
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
module EX(
	 input clk,
	 input reset,
    input [31:0] IR,
	 input [31:0] PC8,
    input [31:0] V1,
    input [31:0] V2,
	 input [31:0] MFD_M,
	 input [31:0] MFD_W,
	 input [1:0] MF_ALUD1_sel, 
	 input [1:0] MF_ALUD2_sel, 	
    input [4:0] A1,
    input [4:0] A2,
    input [31:0] EXT32,
    input [4:0] A3,
	 output [31:0] AO_to_Mreg,
    output [31:0] V2_to_Mreg,
	 output [31:0] RFWD,
	 output [4:0] A3_to_Mreg
    );
	 
	wire [31:0]newV1;
	wire [31:0]newV2;
	wire [31:0]D1;
	wire [31:0]D2;
	wire [31:0]HI;
	wire [31:0]LO;
	wire [31:0]AO;
	wire [1:0]AO_sel;
	wire [4:0]aluop;

	wire alusrc,rfwd_sel;
	wire [4:0]reg0;
	wire [2:0]MADop;
	wire start;
	wire [31:0]ext_s;
	wire s_sel;
	
	EX_control EX_C(
		 .IR(IR),
		 .alusrc(alusrc),
		 .rfwd_sel(rfwd_sel),
		 .aluop(aluop),
		 .MADop(MADop),
		 .start(start),
		 .AO_sel(AO_sel),
		 .s_sel(s_sel)
    );

	
	mux3#(32) MF_ALUD1(
		.data_00(V1),
		.data_01(MFD_W),
		.data_10(MFD_M),
		.sel(MF_ALUD1_sel),
		.result(newV1)
	);
	
	mux3#(32) MF_ALUD2(
		.data_00(V2),
		.data_01(MFD_W),
		.data_10(MFD_M),
		.sel(MF_ALUD2_sel),
		.result(newV2)
	);
	
	assign ext_s={{27'b0},{IR[10:6]}};
	assign D1=(s_sel==1)?ext_s:newV1;
	
	mux2#(32) MUX_ALU_D2(
		.data0(newV2),
		.data1(EXT32),
		.sel(alusrc),
		.result(D2)
	);
	
	ALU EX_A (
		.D1(D1), 
		.D2(D2), 
		.aluop(aluop), 
		.AO(AO)
	);
	
	Mult_A_Div EX_Mult_Div (
		.D1(D1), 
		.D2(D2), 
		.MADop(MADop), 
		.start(start), 
		.clk(clk), 
		.reset(reset), 
		.HI(HI), 
		.LO(LO)
	);	
	
	assign V2_to_Mreg=newV2;
	assign reg0=5'b0;
	
	mux3#(32)MUX_AO_EX(
		.data_00(AO),
		.data_01(HI),
		.data_10(LO),
		.sel(AO_sel),
		.result(AO_to_Mreg)
	);
	
	
	mux2#(32) MUX_RFWD_EX(
		.data0(AO_to_Mreg),
		.data1(PC8),
		.sel(rfwd_sel),
		.result(RFWD)
	);
	
	assign A3_to_Mreg=A3;
	
endmodule
