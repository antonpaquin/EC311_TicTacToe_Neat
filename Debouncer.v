`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
// 
// Create Date:    11:08:07 11/09/2015 
// Design Name:
// Module Name:    clockWithBouncer 
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
module Debouncer(clk, trigger, PB_down);
    input clk, trigger;
    output PB_down;
    //output PB_up;
     reg PB_state;
    
    // First use two flip-flops to synchronize the PB signal the "clk" clock domain
    reg PB_sync_0;  always @(posedge clk) PB_sync_0 <= ~trigger;  // invert PB to make PB_sync_0 active high
    reg PB_sync_1;  always @(posedge clk) PB_sync_1 <= PB_sync_0;

    // Next declare a 16-bits counter
    reg [15:0] PB_cnt;

    // When the push-button is pushed or released, we increment the counter
    // The counter has to be maxed out before we decide that the push-button state has changed

    wire PB_idle = (PB_state==PB_sync_1);
    wire PB_cnt_max = &PB_cnt;  // true when all bits of PB_cnt are 1's

    always @(posedge clk)
    if(PB_idle)
         PB_cnt <= 0;  // nothing's going on
    else
    begin
         PB_cnt <= PB_cnt + 16'd1;  // something's going on, increment the counter
         if(PB_cnt_max) PB_state <= ~PB_state;  // if the counter is maxed out, PB changed!
    end
    
    
    assign PB_down = ~PB_idle & PB_cnt_max & ~PB_state;
    //assign PB_up   = ~PB_idle & PB_cnt_max &  PB_state;
    
    //always @ (posedge PB_up)
        //Y = Y + 1'b1;
    //counter c(PB_down, Y);

endmodule
