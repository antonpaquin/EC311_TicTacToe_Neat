`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:02:27 11/23/2015 
// Design Name: 
// Module Name:    LED_display 
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
module LED_display(big_bin, hex, AN, clk);
	input[15:0] big_bin;
	output[6:0] hex;
	output[3:0] AN;
	input clk;
	wire [3:0] small_bin;
	wire clock_out;

	
	clock_divider_4 c1 (clock_out, clk);
	seven_alternate s1 (big_bin, small_bin, AN, clock_out);
	binary_to_segment b1 (small_bin, hex);
	
endmodule
