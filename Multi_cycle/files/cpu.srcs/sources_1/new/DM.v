`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:11:54 01/11/2020
// Design Name: 
// Module Name:    DM 
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
module DM(
	 input [31:0] displayaddr,
    input [11:0] dm_A,
	 input [3:0] dm_BE,
    input [31:0] dm_WD,
    input memwrite,
    input reset,
    input clk,
    output [31:0] mem_result
    );
    
    
    
    
    		//$display("%d")
    					
    					
    					
    					
	 reg [31:0]dm_grf[0:4095];
	 integer i;
	 initial begin
		for(i=0;i<=4095;i=i+1)
			dm_grf[i]=0;
	 end
	 always @(posedge clk)begin
			if (reset)begin
				for(i=0;i<=4095;i=i+1)
					dm_grf[i]<=0;	
			end
			else if (memwrite) begin
				if (dm_BE==4'b1111) begin	
					dm_grf[dm_A]<=dm_WD;
					
				end
				if (dm_BE==4'b0001) begin
					dm_grf[dm_A][7:0]<=dm_WD[7:0];
					 
					
				end
				if (dm_BE==4'b0010) begin
					dm_grf[dm_A][15:8]<=dm_WD[7:0];
				
				end
				if (dm_BE==4'b0100) begin
					dm_grf[dm_A][23:16]<=dm_WD[7:0];
					
				end
				if (dm_BE==4'b1000) begin
					dm_grf[dm_A][31:24]<=dm_WD[7:0];
					
				end
				if (dm_BE==4'b0011) begin
					dm_grf[dm_A][15:0]<=dm_WD[15:0];

				end
				if (dm_BE==4'b1100) begin
					dm_grf[dm_A][31:16]<=dm_WD[15:0];
					
				end
			end
	 end
	 assign mem_result=dm_grf[dm_A];

endmodule
