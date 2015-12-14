`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:35:17 12/07/2015 
// Design Name: 
// Module Name:    f3inrow 
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
module f3inrow(x, d);

	input[8:0] x;
	output d;
	
	assign d = (
	(x[0]&&x[1]&&x[2]) |
	(x[3]&&x[4]&&x[5]) |
	(x[6]&&x[7]&&x[8]) |
	(x[0]&&x[3]&&x[6]) |
	(x[1]&&x[4]&&x[7]) |
	(x[2]&&x[5]&&x[8]) |
	(x[0]&&x[4]&&x[8]) |
	(x[2]&&x[4]&&x[6])
	);


endmodule
