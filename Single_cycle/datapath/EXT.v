`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/24 12:16:05
// Design Name: 
// Module Name: EXT
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

module EXT(
    input [15:0] half,
    input signal,
    output [31:0] word
    );
    
    assign word = {{16{half[15] & signal}}, half};
endmodule
