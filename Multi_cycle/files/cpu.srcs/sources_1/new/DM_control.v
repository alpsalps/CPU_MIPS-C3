`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:33:43 01/16/2020
// Design Name: 
// Module Name:    DM_control 
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
module DM_control(
    input [31:0] IR,
	 input [1:0] addr_b,
	 output [3:0] dm_BE,
    output memwrite
    );
   wire addu,subu,add,AND,div,divu,jalr,mfhi,mflo,mthi,mtlo,mult,multu;
	wire OR,NOR,sllv,sll,slt,sltu,sra,srav,srl,srlv,sub;
	wire XOR,addi,addiu,andi,beq,bgez,bltz,bgtz,blez,bne;
	wire j,jal,lb,lbu,lh,lhu,lui,lw,ori,sb,sh,slti,sltiu,sw,xori,jr;
	DECODER DM_DEcode (
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
	
	assign memwrite= sw|sh|sb;
	assign dm_BE=	(sw)?4'b1111:
						(sb)?	(addr_b==2'b00)?4'b0001:
								(addr_b==2'b01)?4'b0010:
								(addr_b==2'b10)?4'b0100:
								4'b1000:
						(sh)?	(addr_b[1]==1'b0)?4'b0011:
								4'b1100:
						4'b0000;
	
endmodule
