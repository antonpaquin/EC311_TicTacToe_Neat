`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:47:25 12/13/2015 
// Design Name: 
// Module Name:    controller 
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
module controller(clk, buttonLeft, buttonRight, buttonUp, buttonDown, buttonCenter, buttonReset, cursor, write);
	input clk;
	input buttonLeft, buttonRight, buttonUp, buttonDown, buttonCenter, buttonReset;
	output[8:0] cursor;
	output write;
	reg[8:0] state, nextState;
	reg in_en;
	
	assign write = buttonCenter;
	assign cursor = state;

	always @(posedge clk) begin
		if (buttonReset) begin
			state = 8'b000010000;
		end else begin
			state = nextState;
		end
		
		if (in_en & buttonLeft) begin
			nextState = {state[6],state[8],state[7],state[3],state[5],state[4],state[0],state[2],state[1]};
			in_en = 0;
		end else if (in_en &  buttonRight) begin
			nextState = {state[7],state[6],state[8],state[4],state[3],state[5],state[1],state[0],state[2]};
			in_en = 0;
		end else if (in_en & buttonUp) begin
			nextState = {state[2:0], state[8:3]};
			in_en = 0;
		end else if (in_en & buttonDown) begin
			nextState = {state[5:0], state[8:6]};
			in_en = 0;
		end else if (~in_en & ~buttonLeft & ~buttonRight & ~buttonUp & ~buttonDown) begin
			in_en = 1;
			nextState = state;
		end else begin 
			nextState = state;
		end
	end

endmodule
