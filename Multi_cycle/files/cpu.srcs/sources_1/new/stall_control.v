`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:39:52 01/15/2020 
// Design Name: 
// Module Name:    stall_control 
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
`define A1_D IR_D[25:21]
`define A2_D IR_D[20:16]
`define A1_E IR_E[25:21]
`define A2_E IR_E[20:16]
`define A1_M IR_M[25:21]
`define A2_M IR_M[20:16]
module hazard_control(
    input [31:0] IR_D,
    input [31:0] IR_E,
    input [31:0] IR_M,
	 input [4:0] A3_E,
	 input [4:0] A3_M,
	 input [4:0] A3_W,
	 input regwrite_W,
	 input clk,
	 input reset,
    output stall,
    output [1:0] MF_ALUD1,
    output [1:0] MF_ALUD2,
	 output [1:0] MF_V1,
	 output [1:0] MF_V2,
	 output  MF_DMWD 
    );
	wire [1:0]Tuse_rs,Tuse_rt,Tnew_D;
	wire mfhi_D,mflo_D,mult_D,multu_D,div_D,divu_D,mthi_D,mtlo_D,madd_D;
	reg [1:0]Tnew_E,Tnew_M;
	reg [4:0]cnt;
	reg busy;
	
	
	wire stall_rs0_e1,stall_rs0_e2,stall_rs0_m1,stall_rs1_e2,stall_rs;
	wire stall_rt0_e1,stall_rt0_e2,stall_rt0_m1,stall_rt1_e2,stall_rt;


	hazard_decoder_spford hazard_decode_D (
		.IR(IR_D), 
		.regwrite(regwrite_D), 
		.tuse_rs(Tuse_rs), 
		.tuse_rt(Tuse_rt), 
		.tnew(Tnew_D),
		.mfhi(mfhi_D),
		.mflo(mflo_D),
		.mult(mult_D),
		.multu(multu_D),
		.div(div_D),
		.divu(divu_D),
		.mthi(mthi_D),
		.mtlo(mtlo_D),
		.madd(madd_D)
    );
	 
	hazard_decoder hazard_decode_E (
		.IR(IR_E), 
		.regwrite(regwrite_E)
    );	
	 
	hazard_decoder hazard_decode_M (
		.IR(IR_M), 
		.regwrite(regwrite_M)
    );
	 
	 
	initial begin
		Tnew_E<=2'b0;
		Tnew_M<=2'b0;
		busy<=0;
		cnt<=4'b0;
	end
	
	always @(posedge clk)begin
		if (reset)begin
			Tnew_E<=2'b0;
			Tnew_M<=2'b0;
			busy<=0;
			cnt<=4'b0;	
		end
		else begin
			if (!Tnew_D)begin
				Tnew_E<=2'b0;
			end
			else begin
				Tnew_E<=Tnew_D-1;
			end
			
			if (!Tnew_E) begin
				Tnew_M<=0;
			end
			else begin
				Tnew_M<=Tnew_E-1;
			end
			
			if (cnt==0&&(stall_rs||stall_rt))begin
				cnt<=0;
			end
			else if ((mult_D||multu_D||madd_D)&&cnt==0)begin
				cnt<=4'd5;
			end
			else if ((divu_D||div_D)&&cnt==0)begin
				cnt<=4'd10;
			end
			else if (cnt!=0)
				cnt<=cnt-1;
			
			if (cnt!=0)
				busy<=1;
			else
				busy<=0;
		end
	end
	
	
	
	assign stall_rs0_e1=(Tuse_rs==2'b0)&(Tnew_E==2'b1)&(`A1_D==A3_E)&(regwrite_E)&(A3_E!=0);
	assign stall_rs0_e2=(Tuse_rs==0)&(Tnew_E==2)&(`A1_D==A3_E)&(regwrite_E)&(A3_E!=0);
	assign stall_rs0_m1=(Tuse_rs==0)&(Tnew_M==1)&(`A1_D==A3_M)&(regwrite_M)&(A3_M!=0);
	assign stall_rs1_e2=(Tuse_rs==1)&(Tnew_E==2)&(`A1_D==A3_E)&(regwrite_E)&(A3_E!=0);
	
	assign stall_rt0_e1=(Tuse_rt==0)&(Tnew_E==1)&(`A2_D==A3_E)&(regwrite_E)&(A3_E!=0);
	assign stall_rt0_e2=(Tuse_rt==0)&(Tnew_E==2)&(`A2_D==A3_E)&(regwrite_E)&(A3_E!=0);
	assign stall_rt0_m1=(Tuse_rt==0)&(Tnew_M==1)&(`A2_D==A3_M)&(regwrite_M)&(A3_M!=0);
	assign stall_rt1_e2=(Tuse_rt==1)&(Tnew_E==2)&(`A2_D==A3_E)&(regwrite_E)&(A3_E!=0);	
	
	assign stall_rs=stall_rs0_e1|stall_rs0_e2|stall_rs0_m1|stall_rs1_e2;
	assign stall_rt=stall_rt0_e1|stall_rt0_e2|stall_rt0_m1|stall_rt1_e2;
	
	assign stall_mad=(mfhi_D|mflo_D|mult_D|multu_D|div_D|divu_D|mthi_D|mtlo_D|madd_D)&(cnt!=0);
	assign stall=stall_rs|stall_rt|stall_mad;

	forward_control HAZARD_F(
		.A1_E(`A1_E), 
		.A2_E(`A2_E), 
		.A3_E(A3_E), 
		.A3_M(A3_M), 
		.A3_W(A3_W), 
		.A1_D(`A1_D), 
		.A2_D(`A2_D), 
		.A2_M(`A2_M), 
		.Tnew_E(Tnew_E), 
		.Tnew_M(Tnew_M), 
		.regwrite_E(regwrite_E), 
		.regwrite_M(regwrite_M), 
		.regwrite_W(regwrite_W), 
		.MF_ALUD1(MF_ALUD1), 
		.MF_ALUD2(MF_ALUD2), 
		.MF_V1(MF_V1), 
		.MF_V2(MF_V2), 
		.MF_DMWD(MF_DMWD)
	);

endmodule
