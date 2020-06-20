`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:15:38 01/13/2020 
// Design Name: 
// Module Name:    EX_control 
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
module EX_control(
    input [31:0] IR,
    output alusrc,
	 output rfwd_sel,
    output [4:0] aluop,
	 output [1:0] AO_sel,
	 output start,
	 output [2:0] MADop,
	 output s_sel
    );
	 
   wire addu,subu,add,AND,div,divu,jalr,mfhi,mflo,mthi,mtlo,mult,multu;
	wire OR,NOR,sllv,sll,slt,sltu,sra,srav,srl,srlv,sub;
	wire XOR,addi,addiu,andi,beq,bgez,bltz,bgtz,blez,bne;
	wire j,jal,lb,lbu,lh,lhu,lui,lw,ori,sb,sh,slti,sltiu,sw,xori,jr,madd;
	DECODER EX_DEcode (
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
		.xori(xori),
		.madd(madd)
	);
	
	assign alusrc=addi|addiu|slti|sltiu|andi|ori|xori|lui|sb|sh|sw|lb|lbu|lh|lhu|lw;
	assign aluop=	(add||sb||sh||sw||lb||lbu||lh||lhu||lw||addi)?5'b00001:
						(addu||addiu)?	5'b00010:
						(sub)?			5'b00011:
						(subu)?			5'b00100:
						(AND||andi)?	5'b00101:
						(OR||ori)?		5'b00110:
						(XOR||xori)?	5'b00111:
						(NOR)?			5'b01000:
						(slt||slti)?	5'b01001:
						(sltu||sltiu)?	5'b01010:
						(sllv||sll)?	5'b01011:
						(srlv||srl)?	5'b01100:
						(srav||sra)?	5'b01101:
						(lui)?			5'b01110:
						0;
	assign MADop=	(mult)?	3'b001:
						(multu)?	3'b010:
						(div)?	3'b011:
						(divu)?	3'b100:
						(mthi)?	3'b101:
						(mtlo)?	3'b110:
						(madd)?	3'b111:
						0;
	assign start=	mult|multu|div|divu|mthi|mtlo|madd;
	assign rfwd_sel=(jal||jalr)?1'b1:1'b0;
	assign AO_sel=	(mfhi)?2'b01:
						(mflo)?2'b10:
						2'b00;
	assign s_sel=	sll|srl|sra;					
						
endmodule
