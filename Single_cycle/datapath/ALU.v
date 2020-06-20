`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/12 18:03:02
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] A,
    input [31:0] B,
    input [3:0] Op,
    output [31:0] C,
    output Over
    );
    
    
       assign C = 
       
               (Op == 'b0001) ? A + B:
               (Op == 'b0010) ? A - B :
               (Op == 'b0100) ? (B << A[4:0]): 
               (Op == 'b1000) ? (A | B):
                
               //(Op == 'b0101) ? (B >> A[4:0]): 
               //(Op == 'b0110) ? (($signed(B)) >>> A[4:0]):           
               //(Op == 'b0111) ? (A & B): 
               //(Op == 'b1001) ? (A ^ B): 
               //(Op == 'b1010) ? (~(A | B)): 
               (Op == 'b0000) ? A + B:
               (Op == 'b0011) ? A - B: 
               0;
    assign Over = ((A[31] ^ B[31] == Op[1]) & (A[31] != C[31]) & (Op== 'b0000 || Op == 'b0010))? 1 : 0 ;
   
endmodule
