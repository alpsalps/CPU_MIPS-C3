`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:33:25 01/13/2020 
// Design Name: 
// Module Name:    IM 
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
module IM(
    input [31:0] addr,
    output [31:0] IR
    );
	 reg [31:0] im_reg[0:4095];
	 wire [31:0]t_addr;
	 initial begin
			$readmemh("C:/Users/38473/Documents/WeChat Files/LPS365042020/Files/code42.txt",im_reg);
	 end
	assign t_addr=addr-32'h3000;
	assign IR=im_reg[t_addr[13:2]];
	

endmodule
