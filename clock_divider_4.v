
/* Basic clock divider
 *
 * To change the division factor, change the COUNTER_DIV
 * @param COUNTER_DIV The division factor (number of bits in the counter)
 * @param clk_in Input clock
 * @param clk_out Output clock
 */
module clock_divider_4 (clk_out, clk_in);
   parameter COUNTER_DIV = 50000;
   
   input clk_in;
   output clk_out;

   reg [24:0] counter;

   initial begin
      counter = 0;
      // clk_out = 0;
   end

   always @ (posedge clk_in) begin
      counter = counter + 1'b1;
		counter = (counter >= COUNTER_DIV + 1) ? 24'b0 : counter;
   end

   assign clk_out = (counter >= COUNTER_DIV) ? ~clk_out : clk_out;

endmodule // clock_divider_4
