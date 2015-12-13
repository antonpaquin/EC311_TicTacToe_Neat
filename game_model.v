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
module game_model(clk, X, O, C, writeEn, reset);
	input clk;
	input[8:0] C;
	output reg[8:0] X, O;
	input wire writeEn, reset;
	reg in_en;
	reg turn;
	
	//Logic modules
	
	always @(posedge clk) begin
		if (reset) begin
			X = 9'b000000000;
			O = 9'b000000000;
			turn = 0;
		//end else if (react to logic modules) begin
		end else if (in_en & writeEn) begin
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

endmodule
