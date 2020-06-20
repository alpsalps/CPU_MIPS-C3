`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/24 12:34:47
// Design Name: 
// Module Name: IM
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
module im_4k(
    input [11:2] addr,
    output [31:0] dout
    );
    reg [31:0] im [1023:0];
    
    assign dout = im[addr];
    
    initial begin
        $readmemh("C:/Users/38473/e2/code.txt", im);
        //$readmemh("../code.txt", im);
        end
endmodule
