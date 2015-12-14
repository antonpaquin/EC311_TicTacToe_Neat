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
module controller(clk, left, right, up, down, center, buttonReset, cursor, write);
	input clk;
	input left, up, right, down, center, buttonReset;
	output[8:0] cursor;
	output write;
	reg[8:0] state, nextState;
	reg in_en;
	wire buttonLeft, buttonRight, buttonUp, buttonDown, buttonCenter;
	
	debouncer d1(clk, left, buttonLeft);
	debouncer d2(clk, right, buttonRight);
	debouncer d3(clk, up, buttonUp);
	debouncer d4(clk, down, buttonDown);
	debouncer d5(clk, center, buttonCenter);
	
	assign write = buttonCenter;
	assign cursor = state;

	always @(posedge clk) begin
		if (buttonReset) begin
			state = 8'b000010000;
		end else begin
			state = nextState;
		end
		
		if (in_en & buttonRight) begin
			case(state)
				9'b000000001: nextState = 9'b000000010;
				9'b000000010: nextState = 9'b000000100;
				9'b000000100: nextState = 9'b000000001;
				9'b000001000: nextState = 9'b000010000;
				9'b000010000: nextState = 9'b000100000;
				9'b000100000: nextState = 9'b000001000;
				9'b001000000: nextState = 9'b010000000;
				9'b010000000: nextState = 9'b100000000;
				9'b100000000: nextState = 9'b001000000;
				default: nextState = 9'b000010000;
			endcase
			//nextState = {state[6],state[8],state[7],state[3],state[5],state[4],state[0],state[2],state[1]};
			in_en = 0;
		end else if (in_en &  buttonLeft) begin
			case(state)
				9'b100000000: nextState = 9'b010000000;
				9'b010000000: nextState = 9'b001000000;
				9'b001000000: nextState = 9'b100000000;
				9'b000100000: nextState = 9'b000010000;
				9'b000010000: nextState = 9'b000001000;
				9'b000001000: nextState = 9'b000100000;
				9'b000000100: nextState = 9'b000000010;
				9'b000000010: nextState = 9'b000000001;
				9'b000000001: nextState = 9'b000000100;
				default: nextState = 9'b000010000;
			endcase
			//nextState = {state[7],state[6],state[8],state[4],state[3],state[5],state[1],state[0],state[2]};
			in_en = 0;
		end else if (in_en & buttonDown) begin
			case(state)
				9'b100000000: nextState = 9'b000000100;
				9'b010000000: nextState = 9'b000000010;
				9'b001000000: nextState = 9'b000000001;
				9'b000100000: nextState = 9'b100000000;
				9'b000010000: nextState = 9'b010000000;
				9'b000001000: nextState = 9'b001000000;
				9'b000000100: nextState = 9'b000100000;
				9'b000000010: nextState = 9'b000010000;
				9'b000000001: nextState = 9'b000001000;
				default: nextState = 9'b000010000;
			endcase
			//nextState = {state[2:0], state[8:3]};
			in_en = 0;
		end else if (in_en & buttonUp) begin
			case(state)
				9'b100000000: nextState = 9'b000100000;
				9'b010000000: nextState = 9'b000010000;
				9'b001000000: nextState = 9'b000001000;
				9'b000100000: nextState = 9'b000000100;
				9'b000010000: nextState = 9'b000000010;
				9'b000001000: nextState = 9'b000000001;
				9'b000000100: nextState = 9'b100000000;
				9'b000000010: nextState = 9'b010000000;
				9'b000000001: nextState = 9'b001000000;
				default: nextState = 9'b000010000;
			endcase
			//nextState = {state[5:0], state[8:6]};
			in_en = 0;
		end else if (~in_en & ~buttonLeft & ~buttonRight & ~buttonUp & ~buttonDown) begin
			in_en = 1;
			nextState = state;
		end else begin 
			nextState = state;
		end
	end

endmodule
