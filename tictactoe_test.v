`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:17:13 12/14/2015
// Design Name:   TicTacToe
// Module Name:   X:/EC311/EC311_TicTacToe_Neat-master/EC311_TicTacToe_Neat-master/tictactoe_test.v
// Project Name:  TTT_clean
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: TicTacToe
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tictactoe_test;

	// Inputs
	reg clk;
	reg upButton;
	reg downButton;
	reg leftButton;
	reg rightButton;
	reg centerButton;
	reg resetButton;
	reg vgaReset;

	// Outputs
	wire [2:0] R;
	wire [2:0] G;
	wire [1:0] B;
	wire HS;
	wire VS;
	wire [6:0] hex;
	wire [3:0] AN;

	// Instantiate the Unit Under Test (UUT)
	TicTacToe uut (
		.clk(clk), 
		.upButton(upButton), 
		.downButton(downButton), 
		.leftButton(leftButton), 
		.rightButton(rightButton), 
		.centerButton(centerButton), 
		.resetButton(resetButton), 
		.vgaReset(vgaReset), 
		.R(R), 
		.G(G), 
		.B(B), 
		.HS(HS), 
		.VS(VS), 
		.hex(hex), 
		.AN(AN)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		upButton = 0;
		downButton = 0;
		leftButton = 0;
		rightButton = 0;
		centerButton = 0;
		resetButton = 0;
		vgaReset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#10 resetButton = 1;
		#10 resetButton = 0;
		#100
		#10 centerButton = 1;
		#50 centerButton = 0;
		#50 centerButton = 1;
		#50 centerButton = 0;
		

	end
	
	always
		#10 clk = ~clk;
      
endmodule

