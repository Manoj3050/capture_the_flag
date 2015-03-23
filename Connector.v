module Connector#(parameter N=10)(
	input clk,reset,
	input ps2d,ps2c,
	output HSYNC,VSYNC,
	output [3:0]RGB

);
	 wire [7:0] in; // keyboard input
	 wire key_en; //enable signal for keyboard
	 reg [3:0] rgb_reg; 
	 wire [9:0] pix_x,pix_y;
	 wire video_on;
	 wire [3:0] pos_x,pos_y;
	 wire [3:0] b_x1, b_y1,b_x2,b_y2;
	 wire [N:0] row1,row2,row3,row4,row5,row6,row7,row8,row9,row10;
	 

	VGA_sync vgasync(.clk(clk),.reset(reset),.hsync(HSYNC),.vsync(VSYNC),
		.pixel_x(pix_x), .pixel_y(pix_y),.video_on(video_on),.x(pos_x),.y(pos_y));

	game_controller game(.clk(clk),.reset(reset),.in(in),.ball_x1_o(b_x1),.ball_y1_o(b_y1),
			.ball_x2_o(b_x2),.ball_y2_o(b_y2),
			.out1(row1),
			.out2(row2),
			.out3(row3),
			.out4(row4),
			.out5(row5),
			.out6(row6),
			.out7(row7),
			.out8(row8),
			.out9(row9),
			.out10(row10),
			.key_en(key_en)
			);

	ps2_keyboard ps2(.clk(clk),.reset(reset),.ps2d(ps2d),.ps2c(ps2c),.rx_en(key_en),
		.dout(in));

	vga_RGB vga_rgb(.clk(clk),.reset(reset),.pix_x(pix_x), .pix_y(pix_y), .pos_x(pos_x), .pos_y(pos_y), .b_x1(b_x1), .b_y1(b_y1), 
			.b_x2(b_x2), .b_y2(b_y2), 
			.row1(row1),
			.row2(row2),
			.row3(row3),
			.row4(row4),
			.row5(row5),
			.row6(row6),
			.row7(row7),
			.row8(row8),
			.row9(row9),
			.row10(row10),
			.RGB(RGB) );
			
endmodule
