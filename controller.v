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
	end

	always @(buttonLeft or buttonRight or buttonUp or buttonDown) begin
		if (in_en & buttonLeft) begin
			nextState = {cursor[6],cursor[8],cursor[7],cursor[3],cursor[5],cursor[4],cursor[0],cursor[2],cursor[1]};
			in_en = 0;
		end else if (in_en & buttonRight) begin
			nextState = {cursor[7],cursor[6],cursor[8],cursor[4],cursor[3],cursor[5],cursor[1],cursor[0],cursor[2]};
			in_en = 0;
		end else if (in_en & buttonUp) begin
			nextState = {cursor[2:0], cursor[8:6], cursor[5:3]};
			in_en = 0;
		end else if (in_en & buttonDown) begin
			nextState = {cursor[5:3], cursor[2:0], cursor[8:6]};
			in_en = 0;
		end else if (~in_en & ~buttonDown & ~buttonUp & ~buttonRight & ~buttonLeft) begin
			in_en = 1;
		end else begin 
			nextState = state;
		end
	end

endmodule
