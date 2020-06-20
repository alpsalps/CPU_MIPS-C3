`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:26:06 01/15/2020
// Design Name: 
// Module Name:    hazard_decoder 
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
`define op 		IR[31:26]
`define func 	IR[5:0]
`define rs		IR[25:21]
`define rt		IR[20:16]
`define rd		IR[15:11]
`define s		IR[10:6]
module hazard_decoder(
    input [31:0] IR,
    output regwrite
    );

	assign addu=	(`op==6'b000000 && `func==6'b100001)?1:0;
	assign subu=	(`op==6'b000000 && `func==6'b100011)?1:0;
	assign jr=		(`op==6'b000000 && `func==6'b001000)?1:0;
	assign add=		(`op==6'b000000 && `func==6'b100000)?1:0;
	assign AND=		(`op==6'b000000 && `func==6'b100100)?1:0;
	assign div=		(`op==6'b000000 && `func==6'b011010)?1:0;
	assign divu=	(`op==6'b000000 && `func==6'b011011)?1:0;
	assign jalr=	(`op==6'b000000 && `func==6'b001001)?1:0;
	assign mfhi=	(`op==6'b000000 && `func==6'b010000)?1:0;
	assign mflo=	(`op==6'b000000 && `func==6'b010010)?1:0;
	assign mthi=	(`op==6'b000000 && `func==6'b010001)?1:0;
	assign mtlo=	(`op==6'b000000 && `func==6'b010011)?1:0;
	assign mult=	(`op==6'b000000 && `func==6'b011000)?1:0;
	assign multu=	(`op==6'b000000 && `func==6'b011001)?1:0;
	assign OR=		(`op==6'b000000 && `func==6'b100101)?1:0;
	assign NOR=		(`op==6'b000000 && `func==6'b100111)?1:0;
	assign sllv=	(`op==6'b000000 && `func==6'b000100)?1:0;
	assign sll=		(`op==6'b000000 && `func==6'b000000 && `rd!=6'b000000)?1:0;
	assign slt=		(`op==6'b000000 && `func==6'b101010)?1:0;
	assign sltu=	(`op==6'b000000 && `func==6'b101011)?1:0;
	assign sra=		(`op==6'b000000 && `func==6'b000011)?1:0;
	assign srav=	(`op==6'b000000 && `func==6'b000111)?1:0;
	assign srl=		(`op==6'b000000 && `func==6'b000010)?1:0;
	assign srlv=	(`op==6'b000000 && `func==6'b000110)?1:0;
	assign sub=		(`op==6'b000000 && `func==6'b100010)?1:0;
	assign XOR=		(`op==6'b000000 && `func==6'b100110)?1:0;
	assign addi=	(`op==6'b001000)?1:0;
	assign addiu=	(`op==6'b001001)?1:0;
	assign andi=	(`op==6'b001100)?1:0;
	assign beq= 	(`op==6'b000100)?1:0;
	assign bgez=	(`op==6'b000001 && `rt==5'b00001)?1:0;
	assign bltz=	(`op==6'b000001 && `rt==5'b00000)?1:0;
	assign bgtz=	(`op==6'b000111)?1:0;
	assign blez=	(`op==6'b000110)?1:0;
	assign bne=		(`op==6'b000101)?1:0;
	assign j=		(`op==6'b000010)?1:0;
	assign jal= 	(`op==6'b000011)?1:0;
	assign lb=		(`op==6'b100000)?1:0;
	assign lbu=		(`op==6'b100100)?1:0;
	assign lh=		(`op==6'b100001)?1:0;
	assign lhu=		(`op==6'b100101)?1:0;
	assign lui= 	(`op==6'b001111)?1:0;
	assign lw=		(`op==6'b100011)?1:0;
	assign ori= 	(`op==6'b001101)?1:0;
	assign sb=		(`op==6'b101000)?1:0;
	assign sh=		(`op==6'b101001)?1:0;
	assign slti=	(`op==6'b001010)?1:0;
	assign sltiu=	(`op==6'b001011)?1:0;
	assign sw=		(`op==6'b101011)?1:0;
	assign xori= 	(`op==6'b001110)?1:0;
	
	assign regwrite=	addi|addiu|slti|sltiu|andi|ori|xori|lui|lb|lh|lhu|lbu|lw|add|addu|sub|subu|AND|OR|XOR|NOR|slt|sltu|sllv|srlv|
							srav|sll|srl|sra|jalr|mfhi|mflo|jal;
	
endmodule
