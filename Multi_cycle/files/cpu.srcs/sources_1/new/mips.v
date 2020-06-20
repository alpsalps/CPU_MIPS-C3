`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:06:00 01/15/2020 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
    );

	wire stall;
	wire [1:0]PC_sel_ID;
	wire [31:0]NPC_ID;
	wire [31:0]RD1_ID;
	wire [31:0]RFWD_WB;
	wire regwrite_WB;
	
	
	
	
	
	wire [31:0]IR_out_D,IR_in_D,IR_in_E,IR_out_E,IR_in_M,IR_out_M,IR_in_W,IR_out_W;				//IR
	wire [31:0]PC4_out_D,PC4_in_D,PC8_in_E,PC8_out_E,PC8_in_M,PC8_out_M,PC8_in_W,PC8_out_W;	//PC
	wire [4:0] A3_in_E,A3_out_E,A3_in_M,A3_out_M,A3_in_W,A3_out_W;										//A3
	wire [31:0]V1_in_E,V1_out_E;																					//V1
	wire [4:0] A1_in_E,A1_out_E;																					//A1
	wire [31:0]V2_in_E,V2_out_E,V2_in_M,V2_out_M; 															//V2

	wire [4:0] A2_in_E,A2_out_E,A2_in_M,A2_out_M;															//A2
	wire [31:0]EXT32_in_E,EXT32_out_E;																			//EXT32
	wire [31:0]AO_in_M,AO_out_M,AO_in_W,AO_out_W;															//AO
	wire [31:0]DR_in_W,DR_out_W;																					//DR
	wire [1:0] MF_ALUD1_sel,MF_ALUD2_sel,MF_V1_sel,MF_V2_sel;
	wire MF_DMWD_sel;
	wire [31:0]RFWD_in_M,RFWD_out_M;
	
	IF pipeline_IF(
		.PC_sel(PC_sel_ID), 
		.NPC(NPC_ID), 
		.RD1(V1_in_E), 
		.clk(clk),
		.reset(reset),
		.en_PC(stall),
		.IR(IR_in_D), 
		.PC4(PC4_in_D)
	);	

	Dreg_IF_ID pipeline_Dreg (
		.IM(IR_in_D), 
		.PC4(PC4_in_D), 
		.clk(clk), 
		.en_D(stall), 
		.reset(reset), 
		.IR_D(IR_out_D), 
		.PC4_D(PC4_out_D)
	);

	ID pipeline_ID(
		.IR(IR_out_D), 
		.PC4(PC4_out_D), 
		.A3(A3_out_W), 
		.RF_WD(RFWD_WB), 
		.regwrite(regwrite_WB), 
		.clk(clk), 
		.reset(reset), 
		.V1(V1_in_E), 
		.V2(V2_in_E),
		.MFD_E(PC8_out_E),
		.MFD_M(RFWD_out_M),
		.MFD_W(RFWD_WB),
		.MF_V1_sel(MF_V1_sel), 
		.MF_V2_sel(MF_V2_sel),		
		.A1(A1_in_E), 
		.A2(A2_in_E), 
		.A3_to_Ereg(A3_in_E), 
		.EXT32(EXT32_in_E), 
		.PC8(PC8_in_E), 
		.NPC(NPC_ID), 
		.PC_sel(PC_sel_ID)
	);
	
	Ereg_ID_EX pipeline_Ereg (
		.IR(IR_out_D), 
		.PC8(PC8_in_E), 
		.V1(V1_in_E), 
		.V2(V2_in_E), 
		.A1(A1_in_E), 
		.A2(A2_in_E), 
		.A3(A3_in_E), 
		.EXT32(EXT32_in_E), 
		.clk(clk), 
		.reset(reset), 
		.clr(stall), 
		.IR_E(IR_out_E), 
		.PC8_E(PC8_out_E), 
		.V1_E(V1_out_E), 
		.V2_E(V2_out_E), 
		.A1_E(A1_out_E), 
		.A2_E(A2_out_E), 
		.A3_E(A3_out_E), 
		.EXT32_E(EXT32_out_E)
	);	
	
	EX pipeline_EX (
		.clk(clk),
		.reset(reset),
		.IR(IR_out_E),
		.PC8(PC8_out_E),
		.V1(V1_out_E), 
		.V2(V2_out_E),
		.MFD_M(RFWD_out_M),
		.MFD_W(RFWD_WB),
		.MF_ALUD1_sel(MF_ALUD1_sel), 
		.MF_ALUD2_sel(MF_ALUD2_sel), 		
		.A1(A1_out_E), 
		.A2(A2_out_E),
		.A3(A3_out_E),
		.EXT32(EXT32_out_E), 
		.AO_to_Mreg(AO_in_M), 
		.V2_to_Mreg(V2_in_M),
		.RFWD(RFWD_in_M),
		.A3_to_Mreg(A3_in_M)
	);
	
	Mreg_EX_DM pipeline_Mreg (
		.IR(IR_out_E), 
		.PC8(PC8_out_E), 
		.AO(AO_in_M), 
		.A2(A2_out_E), 
		.V2(V2_in_M), 
		.A3(A3_out_E),
		.RFWD(RFWD_in_M),
		.clk(clk), 
		.reset(reset), 
		.IR_M(IR_out_M), 
		.PC8_M(PC8_out_M), 
		.AO_M(AO_out_M), 
		.A2_M(A2_out_M), 
		.V2_M(V2_out_M), 
		.A3_M(A3_out_M),
		.RFWD_M(RFWD_out_M)
	);
	
	DMF pipeline_DM (
		.IR(IR_out_M), 
		.PC8(PC8_out_M), 
		.AO(AO_out_M), 
		.DM_WD(V2_out_M),
		.MFD_W(RFWD_WB),
		.MF_DMWD_sel(MF_DMWD_sel),
		.clk(clk), 
		.reset(reset), 
		.DR(DR_in_W)
	);	
	
	Wreg_DM_RF pipeline_Wreg (
		.IR(IR_out_M), 
		.PC8(PC8_out_M), 
		.A3(A3_out_M), 
		.AO(AO_out_M), 
		.DR(DR_in_W), 
		.clk(clk), 
		.reset(reset), 
		.IR_W(IR_out_W), 
		.PC8_W(PC8_out_W), 
		.A3_W(A3_out_W), 
		.AO_W(AO_out_W), 
		.DR_W(DR_out_W)
	);

	WB pipeline_WB (
		.IR(IR_out_W), 
		.PC8(PC8_out_W), 
		.AO(AO_out_W), 
		.DR(DR_out_W), 
		.regwrite(regwrite_WB), 
		.RF_WD(RFWD_WB)
	);
	
	hazard_control pipeline_HAZARD_C (
		.IR_D(IR_out_D), 
		.IR_E(IR_out_E), 
		.IR_M(IR_out_M), 
		.A3_E(A3_out_E), 
		.A3_M(A3_out_M), 
		.A3_W(A3_out_W), 
		.regwrite_W(regwrite_WB), 
		.clk(clk), 
		.reset(reset), 
		.stall(stall), 
		.MF_ALUD1(MF_ALUD1_sel), 
		.MF_ALUD2(MF_ALUD2_sel), 
		.MF_V1(MF_V1_sel), 
		.MF_V2(MF_V2_sel), 
		.MF_DMWD(MF_DMWD_sel)
	);	
	
endmodule
