`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:04:28 12/12/2015 
// Design Name: 
// Module Name:    dotfig 
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
module cfig(hmin, hcount, vmin, vcount, en, out);
	input[10:0] hcount, vcount;
	input[10:0]	hmin, vmin;
	input en;
	output out;
	
	wire[10:0] h, v;
	
	assign h=hcount-hmin;
	assign v=vcount-vmin;
	
	assign out = en && (h >= 101 && h <= 111 && v >= 78 && v <= 88);

endmodule
