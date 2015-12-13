`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:01:06 12/07/2015 
// Design Name: 
// Module Name:    ofig 
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
module ofig(hmin, hcount, vmin, vcount, en, out);
	
	input wire[10:0] hcount, vcount;
	input wire[10:0] hmin, vmin;
	input wire en;
	output wire out;
	
	wire[10:0] h, v;
	
	assign h = hcount - hmin;
	assign v = vcount - vmin;
	
	/*
	parameter hs = 208;
	parameter vs = 155;
	
	assign out = 
		en &&
		(vcount >= vmin && vcount <= vmin + 200) &&
		(hcount >= hmin && hcount <= hmin + 100) &&
		(
			(
				(hcount>(hmin +hs)>>1 ? hcount-((hmin +hs)>>1) : ((hmin +hs)>>1)-hcount) + 
				(vcount>(vmin +vs)>>1 ? vcount-((vmin +vs)>>1) : ((vmin +vs)>>1)-vcount) 
				>= (vs>>1)-30
			) && (
				(hcount>(hmin +hs)>>1 ? hcount-((hmin +hs)>>1) : ((hmin +hs)>>1)-hcount) + 
				(vcount>(vmin +vs)>>1 ? vcount-((vmin +vs)>>1) : ((vmin +vs)>>1)-vcount) 
				<= (vs>>1)-20
			)
		);*/
	assign out = en &&
	(
	(h >= 59  && h <= 69  && v >= 20  && v <= 135) ||
	(h >= 59  && h <= 159 && v >= 20  && v <= 30 ) ||
	(h >= 149 && h <= 159 && v >= 20  && v <= 135) ||
	(h >= 59  && h <= 159 && v >= 125 && v <= 135)
	);


endmodule
