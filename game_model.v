`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:55:35 12/13/2015 
// Design Name: 
// Module Name:    game_model 
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
module game_model(clk, X, O, C, writeEn, reset, gameOver, hex, AN);
	input clk;
	input[8:0] C;
	output reg[8:0] X, O;
	input wire writeEn, reset;
	reg in_en;
	reg turn = 1;
	wire xwins;
	wire owins;
	reg [1:0] scorex = 0;
	reg [1:0] scoreo = 0;
	reg [15:0] big_bin = 16'b1010000010110000;
	output [6:0] hex;
	output [3:0] AN;
	output reg gameOver = 0;
	
	//Logic modules
	f3inrow fX(X, xwins);
	f3inrow fO(O, owins);
	LED_display led(big_bin, hex, AN, clk);

	always @(posedge clk) begin
		big_bin = {6'b101000, scorex, 6'b101100, scoreo};
		if (~xwins & ~owins) begin
			if (reset) begin
				X = 9'b000000000;
				O = 9'b000000000;
				turn = 1;
				in_en = 0;
				gameOver = 0;
				scorex = 0;
				scoreo = 0;
			end else if ((X | O) == 9'b111111111) begin
				X = 9'b000000000;
				O = 9'b000000000;
			end else if (in_en & writeEn & ((C & (X | O)) == 9'b000000000)) begin
				turn = ~turn;
				in_en = 0;
				if (turn == 0)
					X = X | C;
				else
					O = O | C;
			end else if (~in_en & ~writeEn) begin
				in_en = 1;
			end else begin
			end;
		end
		else begin
			if (scorex == 2'b00 & xwins)
				scorex = 2'b01;
			else if (scorex == 2'b01 & xwins) begin
				scorex = 2'b10;
				gameOver = 1;
				//Game Over
			end else if (scoreo == 2'b00 & owins)
				scoreo = 2'b01;
			else if (scoreo == 2'b01 & owins) begin
				scoreo = 2'b10;
				gameOver = 1;
			end
				
			X = 9'b000000000;
			O = 9'b000000000;
			turn = 1;
			
		end
	end

endmodule
