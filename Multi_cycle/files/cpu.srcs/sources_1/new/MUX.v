`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:44:49 01/13/2020 
// Design Name: 
// Module Name:    MUX 
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


module mux2#(parameter width=32)(
    input [width-1:0] data0,
    input [width-1:0] data1,
    input sel,
    output [width-1:0] result
    );
	assign result=(sel==0)?data0:data1;
	
endmodule


module mux3#(parameter width=32)(
    input [width-1:0] data_00,
    input [width-1:0] data_01,
    input [width-1:0] data_10,
    input [1:0]sel,
    output [width-1:0] result
    );
	assign result=(sel==2'b00)?data_00:
					  (sel==2'b01)?data_01:
					  (sel==2'b10)?data_10:0;
endmodule 

module mux4#(parameter width=32)(
    input [width-1:0] data_00,
    input [width-1:0] data_01,
    input [width-1:0] data_10,
	 input [width-1:0] data_11,
    input [1:0]sel,
    output [width-1:0] result
    );
	assign result=(sel==2'b00)?data_00:
					  (sel==2'b01)?data_01:
					  (sel==2'b10)?data_10:
					  (sel==2'b11)?data_11:0;
endmodule 