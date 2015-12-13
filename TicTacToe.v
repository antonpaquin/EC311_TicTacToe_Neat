`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:01:16 12/02/2015 
// Design Name: 
// Module Name:    TicTacToe 
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
module TicTacToe(clk,
upButton, downButton, leftButton, rightButton, centerButton, resetButton,
vgaReset, R, G, B, HS, VS
);

	//Board signals
	input clk;
	
	//Control buttons
	input upButton, downButton, leftButton, rightButton, centerButton, resetButton;
	
	//VGA signals
	input vgaReset;
	output [2:0] R, G;
	output [1:0] B;
	output HS, VS;
	
	//Game variables
	wire[8:0] X, O, C;
	wire writeEn;
	
	//Main modules
	//(module for debouncing inputs here)
	vga_display disp(vgaReset, clk, R, G, B, HS, VS, X, O, C);
	controller cont(clk, leftButton, rightButton, upButton, downButton, centerButton, resetButton, C, writeEn);
	game_model(X, O, C, writeEn, resetButton);
	
endmodule