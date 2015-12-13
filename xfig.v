`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:27:35 12/07/2015 
// Design Name: 
// Module Name:    xfig 
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
module xfig(hmin, hcount, vmin, vcount, en, out);
	
	input wire[10:0] hcount, vcount;
	input wire[10:0] hmin, vmin;
	input wire en;
	output wire out;
	
	//assign h = ((hcount - hmin)>>1) + 53;
	wire[10:0] h, v;
	assign h = hcount - hmin;
	assign v = vcount - vmin;
	
	assign out = 
	en & (
	(h >= 101 && h <= 111 && v >= 20 && v <= 135) ||
	(v >= 73 && v <= 83 && h >= 44 && h <= 159)
	);
	
	/*assign out = 
	en && (
		h >= 0 &&
		h <= 155
	) && (
		v >= 0 &&
		v <= 155
	) && (
		(
			(h - v >= -10) && 
			1//(h - v <= 10)
		) || (
			(h + v >= 145) &&
			(h + v <= 165)
		)
	);*/


endmodule
