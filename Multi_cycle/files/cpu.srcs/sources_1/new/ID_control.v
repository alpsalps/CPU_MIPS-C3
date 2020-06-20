`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:37:33 01/12/2020
// Design Name: 
// Module Name:    ID_control 
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
module ID_control(
	input [31:0] IR,
	input [31:0]V1,
	input [31:0]V2,
	output extop,
	output branch,
	output [1:0] A3_sel,
	output [1:0] PC_sel
    );
   wire addu,subu,add,AND,div,divu,jalr,mfhi,mflo,mthi,mtlo,mult,multu;
	wire OR,NOR,sllv,sll,slt,sltu,sra,srav,srl,srlv,sub;
	wire XOR,addi,addiu,andi,beq,bgez,bltz,bgtz,blez,bne;
	wire j,jal,lb,lbu,lh,lhu,lui,lw,ori,sb,sh,slti,sltiu,sw,xori,jr;
	wire beq_sel,bne_sel,bgez_sel,blez_sel,bgtz_sel,bltz_sel;
	DECODER ID_DEcode (
		.IR(IR), 
		.addu(addu), 
		.subu(subu), 
		.jr(jr), 
		.add(add), 
		.AND(AND), 
		.div(div), 
		.divu(divu), 
		.jalr(jalr), 
		.mfhi(mfhi), 
		.mflo(mflo), 
		.mthi(mthi), 
		.mtlo(mtlo), 
		.mult(mult), 
		.multu(multu), 
		.OR(OR), 
		.NOR(NOR), 
		.sllv(sllv), 
		.sll(sll), 
		.slt(slt), 
		.sltu(sltu), 
		.sra(sra), 
		.srav(srav), 
		.srl(srl), 
		.srlv(srlv), 
		.sub(sub), 
		.XOR(XOR), 
		.addi(addi), 
		.addiu(addiu), 
		.andi(andi), 
		.beq(beq), 
		.bgez(bgez), 
		.bltz(bltz), 
		.bgtz(bgtz), 
		.blez(blez), 
		.bne(bne), 
		.j(j), 
		.jal(jal), 
		.lb(lb), 
		.lbu(lbu), 
		.lh(lh), 
		.lhu(lhu), 
		.lui(lui), 
		.lw(lw), 
		.ori(ori), 
		.sb(sb), 
		.sh(sh), 
		.slti(slti), 
		.sltiu(sltiu), 
		.sw(sw), 
		.xori(xori)
	);
	assign beq_sel=	(V1==V2)?1:0;
	assign bne_sel=	(V1!=V2)?1:0;
	assign blez_sel=	($signed(V1)<=0)?1:0;
	assign bgtz_sel=	($signed(V1)>0)?1:0;
	assign bltz_sel=	($signed(V1)<0)?1:0;
	assign bgez_sel=	($signed(V1)>=0)?1:0;
	
	assign extop= 		addi|addiu|slti|sltiu|sb|sh|sw|lb|lbu|lh|lhu|lw;
	assign branch= 	beq|bne|blez|bgtz|bltz|bgez;
	assign A3_sel=		(addi||addiu||slti||sltiu||andi||ori||xori||lui||lb||lh||lhu||lbu||lw)?2'b00:
							(add||addu||sub||subu||AND||OR||XOR||NOR||slt||sltu||sllv||srlv||srav||sll||srl||sra||jalr||mfhi||mflo)?2'b01:
							(jal)?2'b10:
							2'b11;
	assign PC_sel= ((beq_sel&&beq)||(bne_sel&&bne)||(blez_sel&&blez)||(bgtz_sel&&bgtz)||(bltz_sel&&bltz)||(bgez_sel&&bgez)||jal||j)?2'b01:
						(jr||jalr)?2'b10:
						2'b00;
endmodule
