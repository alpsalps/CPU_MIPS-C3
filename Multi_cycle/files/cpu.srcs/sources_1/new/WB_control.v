`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:38:30 01/14/2020 
// Design Name: 
// Module Name:    WB_control 
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
module WB_control(
    input [31:0] IR,
	 output regwrite,
    output [1:0] RFWD_sel,
	 output [2:0] DR_ext_op
    );
	
   wire addu,subu,add,AND,div,divu,jalr,mfhi,mflo,mthi,mtlo,mult,multu;
	wire OR,NOR,sllv,sll,slt,sltu,sra,srav,srl,srlv,sub;
	wire XOR,addi,addiu,andi,beq,bgez,bltz,bgtz,blez,bne;
	wire j,jal,lb,lbu,lh,lhu,lui,lw,ori,sb,sh,slti,sltiu,sw,xori,jr;
	DECODER WB_DEcode (
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

	assign regwrite=	addi|addiu|slti|sltiu|andi|ori|xori|lui|lb|lh|lhu|lbu|lw|add|addu|sub|subu|AND|OR|XOR|NOR|slt|sltu|sllv|srlv|
							srav|sll|srl|sra|jalr|mfhi|mflo|jal;
	assign RFWD_sel=	(lb||lh||lhu||lbu||lw)?2'b00:
							(jal||jalr)?2'b10:
							2'b01;
	assign DR_ext_op=	(lb)?3'b001:
							(lbu)?3'b010:
							(lh)?3'b011:
							(lhu)?3'b100:
							3'b000;
	
endmodule
