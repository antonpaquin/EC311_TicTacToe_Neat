`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Boston University
// Engineer: Zafar M. Takhirov
// 
// Create Date:    12:59:40 04/12/2011 
// Design Name: EC311 Support Files
// Module Name:    vga_display 
// Project Name: Lab5 / Lab6 / Project
// Target Devices: xc6slx16-3csg324
// Tool versions: XILINX ISE 13.3
// Description: 
//
// Dependencies: vga_controller_640_60
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module vga_display(rst, clk, R, G, B, HS, VS, xi, oi, cr, go);
	input rst;	// global reset
	input clk;	// 100MHz clk
	
	input [8:0] xi; // X inputs
	input [8:0] oi; // O inputs
	input [8:0] cr; // Cursor
	
	input go; // game over enable
	
	// color outputs to show on display (current pixel)
	output reg [2:0] R, G;
	output reg [1:0] B;
	wire[2:0] sR, sG;
	wire[1:0] sB;
	
	// Synchronization signals
	output HS;
	output VS;
	
	// controls:
	wire [10:0] hcount, vcount;	// coordinates for the current pixel
	wire blank;	// signal to indicate the current coordinate is blank
	wire figure;	// the figure you want to display
	
	/////////////////////////////////////////////////////
	// Begin clock division
	parameter N = 2;	// parameter for clock division
	reg clk_25Mhz;
	reg [N-1:0] count;
	always @ (posedge clk) begin
		count <= count + 1'b1;
		clk_25Mhz <= count[N-1];
	end
	// End clock division
	///////////////////////////////////////////////////// 
	
	// Call driver
	vga_controller_640_60 vc(
		.rst(rst), 
		.pixel_clk(clk_25Mhz), 
		.HS(HS), 
		.VS(VS), 
		.hcounter(hcount), 
		.vcounter(vcount), 
		.blank(blank));
	
	// create a box:
	
	parameter width = 640;
	parameter height = 480;
	parameter stroke = 10;
	
	parameter h1 = width/3 - stroke/2;
	parameter h2 = width/3 + stroke/2; 
	parameter h3 = 2*width/3 - stroke/2; 
	parameter h4 = 2*width/3 + stroke/2; 
	parameter v1 = height/3 - stroke/2; 
	parameter v2 = height/3 + stroke/2;	
	parameter v3 = 2*height/3 - stroke/2; 
	parameter v4 = 2*height/3 + stroke/2; 
	parameter hm = width; 
	parameter vm = height;
	
	assign line_v1 = (hcount >= h1 && hcount <= h2);
	assign line_v2 = (hcount >= h3 && hcount <= h4);
	assign line_h1 = (vcount >= v1 && vcount <= v2);
	assign line_h2 = (vcount >= v3 && vcount <= v4);
	
	wire x,x1,x2,x3,x4,x5,x6,x7,x8,x9;
	wire o,o1,o2,o3,o4,o5,o6,o7,o8,o9;
	wire c,c1,c2,c3,c4,c5,c6,c7,c8,c9;
	
	//assign xi=9'b000000000;
	xfig xf1(0 , hcount, 0 , vcount, xi[0], x1);
	xfig xf2(h1, hcount, 0 , vcount, xi[1], x2);
	xfig xf3(h3, hcount, 0 , vcount, xi[2], x3);
	xfig xf4(0 , hcount, v1, vcount, xi[3], x4);
	xfig xf5(h1, hcount, v1, vcount, xi[4], x5);
	xfig xf6(h3, hcount, v1, vcount, xi[5], x6);
	xfig xf7(0 , hcount, v3, vcount, xi[6], x7);
	xfig xf8(h1, hcount, v3, vcount, xi[7], x8);
	xfig xf9(h3, hcount, v3, vcount, xi[8], x9);
	assign x=(x1|x2|x3|x4|x5|x6|x7|x8|x9);
	
	//assign oi=9'b000000000;
	ofig of1(0 , hcount, 0 , vcount, oi[0], o1);
	ofig of2(h1, hcount, 0 , vcount, oi[1], o2);
	ofig of3(h3, hcount, 0 , vcount, oi[2], o3);
	ofig of4(0 , hcount, v1, vcount, oi[3], o4);
	ofig of5(h1, hcount, v1, vcount, oi[4], o5);
	ofig of6(h3, hcount, v1, vcount, oi[5], o6);
	ofig of7(0 , hcount, v3, vcount, oi[6], o7);
	ofig of8(h1, hcount, v3, vcount, oi[7], o8);
	ofig of9(h3, hcount, v3, vcount, oi[8], o9);
	assign o=(o1|o2|o3|o4|o5|o6|o7|o8|o9);

	cfig cf1(0 , hcount, 0 , vcount, cr[0], c1);
	cfig cf2(h1, hcount, 0 , vcount, cr[1], c2);
	cfig cf3(h3, hcount, 0 , vcount, cr[2], c3);
	cfig cf4(0 , hcount, v1, vcount, cr[3], c4);
	cfig cf5(h1, hcount, v1, vcount, cr[4], c5);
	cfig cf6(h3, hcount, v1, vcount, cr[5], c6);
	cfig cf7(0 , hcount, v3, vcount, cr[6], c7);
	cfig cf8(h1, hcount, v3, vcount, cr[7], c8);
	cfig cf9(h3, hcount, v3, vcount, cr[8], c9);
	assign c=(c1|c2|c3|c4|c5|c6|c7|c8|c9);
	
	assign figure = ~blank & ~go &(line_v1 | line_v2 | line_h1 | line_h2 | x | o | c);
	//assign figure = ~blank & (hcount >= 300 & hcount <= 500 & vcount >= 167 & vcount <= 367);
	
	wire[14:0] addra;
	wire[7:0] douta;
	vga_bsprite sprites_mem(
		.x0(0+100), 
		.y0(0+100),
		.x1(343+100),
		.y1(47+100),
		.hc(hcount), 
		.vc(vcount), 
		.mem_value(douta), 
		.rom_addr(addra), 
		.R(sR), 
		.G(sG), 
		.B(sB), 
		.blank(blank),
		.en(go)
	);
	game_over_mem memory_1(
		.clka(clk_25Mhz),
		.addra(addra),
		.douta(douta)
	);
	// send colors:
	always @ (posedge clk) begin
		if (~go) begin	// if you are within the valid region
			if (figure) begin
				R = 3'b111;
				G = 3'b000;
				B = 2'b00;
			end else begin
				R = 3'b000;
				G = 3'b000;
				B = 2'b00;
			end
		end
		else if (go) begin	// if you are outside the valid region
			R = sR;
			G = sG;
			B = sB;
		end else begin
			R = 3'b000;
			G = 3'b000;
			B = 2'b00;
		end
	end

endmodule
