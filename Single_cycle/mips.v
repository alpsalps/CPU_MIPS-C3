`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/07 14:37:04
// Design Name: 
// Module Name: mips
// Project Name: 
// Target Devices: 
// Tool Versions: 
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
    wire [2:0] Wreg_CS;
    wire [2:0] Wdata_CS;
    wire DM_we_CS;
    wire WE_CS,EXT_CS;
    wire [1:0] ALU_A_CS;
    wire [1:0] ALU_B_CS;
    wire [3:0] ALU_Op_CS;
    
    wire [31:0] PC, NPC, IR, DM,Rdata1, Rdata2, Wdata, EXT;
    
    wire [31:0] PC_plus = PC + 4;
    wire [3:0] NPC_CS;
    
    wire over, ZF;
    
    wire [31:0] J_imm = {PC[31:28], IR[25:0], 2'b00};
    wire [4:0] rs = IR[25:21];
    wire [4:0] rt = IR[20:16];
    wire [4:0] rd = IR[15:11];
    wire [15:0] imm = IR[15:0];
    wire [4:0] Wreg;
    wire [31:0] ALU,ALU_A, ALU_B;
    wire [3:0] ALU_Op;
    
    assign ZF = ALU == 0; 
    
    
//CU   
    CU cu(.IR(IR), .NPC_CS(NPC_CS), .Wreg_CS(Wreg_CS), .Wdata_CS(Wdata_CS), .WE_CS(WE_CS), .ALU_A_CS(ALU_A_CS), .ALU_B_CS(ALU_B_CS), .ALU_Op_CS(ALU_Op_CS), .EXT_CS(EXT_CS), .DM_we_CS(DM_we_CS),.ZF(ZF));

	
//datapath	    
    MUX2 ALU1(.A(Rdata1), .B(16), .mux(ALU_A_CS), .out(ALU_A));
    MUX2 ALU2(.A(Rdata2), .B(EXT), .mux(ALU_B_CS), .out(ALU_B));
    MUX3 WG(.A(rd), .B(rt), .C(31), .mux(Wreg_CS), .out(Wreg));
    MUX3 W_DATA(.A(ALU), .B(DM), .C(PC_plus), .mux(Wdata_CS), .out(Wdata));
    MUX4 ALU_OP(.A(1), .B(2), .C(4), .D(8), .mux(ALU_Op_CS), .out(ALU_Op));
    MUX4 npc(.A(PC_plus), .B(PC_plus + (EXT << 2)), .C(J_imm), .D(Rdata1), .mux(NPC_CS), .out(NPC));
   		
    PC pc(.NPC(NPC), .Clk(clk), .Rst(reset), .PC(PC));
    im_4k im(.addr(PC[11:2]), .dout(IR));
    GPR GPRR(.Rreg1(rs), .Rreg2(rt), .Wreg(Wreg), .Wdata(Wdata), .WE(WE_CS), .Clk(clk), .Rdata1(Rdata1), .Rdata2(Rdata2));
    EXT EXTT(.half(imm), .signal(EXT_CS), .word(EXT));
    ALU ALU_cal(.A(ALU_A), .B(ALU_B), .Op(ALU_Op), .C(ALU), .Over(OF));
    dm_4k dm(.addr(ALU[11:2]), .din(Rdata2), .we(DM_we_CS), .clk(clk), .dout(DM));
endmodule
