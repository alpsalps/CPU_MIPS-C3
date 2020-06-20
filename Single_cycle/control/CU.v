`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/07 12:53:33
// Design Name: 
// Module Name: CU
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


module CU(
    input [31:0] IR,
    output [3:0] NPC_CS,
    output [2:0] Wreg_CS,
    output [2:0] Wdata_CS,
    output WE_CS,
    output [1:0] ALU_A_CS,
    output [1:0] ALU_B_CS,
    output [3:0] ALU_Op_CS,
    output EXT_CS,
    output DM_we_CS,
    input ZF
    );
    wire [5:0] opcode = IR[31:26];
    wire [5:0] func = IR[5:0];
    
    
    
     assign DM_we_CS = opcode == 'b101011;
     assign NPC_CS[0] =  (opcode == 'b000000 & func != 'b001000) 
                       | opcode == 'b001101 
                       | opcode == 'b100011 
                       | opcode == 'b101011 
                       | opcode == 'b001111 
                       | (opcode == 'b000100 & ZF == 'b0);
    assign NPC_CS[1] = opcode == 'b000100 & ZF == 'b1;
    assign NPC_CS[2] = opcode == 'b000011;
    assign NPC_CS[3] = opcode == 'b000000 & func == 'b001000;
    
    
    assign Wreg_CS[0] = opcode == 'b000000 & func != 'b001000;
    assign Wreg_CS[1] = opcode == 'b001101 | opcode == 'b100011 | opcode == 'b001111;
    assign Wreg_CS[2] = opcode == 'b000011;
    
    
    assign Wdata_CS[0] =  (opcode == 'b000000 & func != 'b001000) 
                             | opcode == 'b001101 
                             | opcode == 'b001111;
    assign Wdata_CS[1] = opcode == 'b100011;
    assign Wdata_CS[2] = opcode == 'b000011;
    
    
    assign WE_CS = (opcode == 'b000000 & func != 'b001000) 
                       | opcode == 'b001101 
                       | opcode == 'b100011 
                       | opcode == 'b000011 
                       | opcode == 'b001111;
    assign ALU_A_CS[0] = (opcode != 'b001111);
    assign ALU_A_CS[1] = opcode == 'b001111;
    
    assign ALU_B_CS[0] =  opcode == 'b000000 | opcode == 'b000100;
    assign ALU_B_CS[1] = opcode == 'b001101 | opcode == 'b100011 | opcode == 'b101011 | opcode == 'b001111;
    
    
    
    assign ALU_Op_CS[0] = (opcode == 'b000000 & func == 'b100001) 
                         | opcode == 'b100011 
                         | opcode == 'b101011;
    assign ALU_Op_CS[1] = (opcode == 'b000000 & func == 'b100011) 
                         | opcode == 'b000100;
                         
    assign ALU_Op_CS[2] = opcode == 'b001111;
    assign ALU_Op_CS[3] = opcode == 'b001101;
    
    assign EXT_CS = opcode != 'b001101;
    
endmodule
