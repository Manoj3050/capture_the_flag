`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:17:22 07/26/2014 
// Design Name: 
// Module Name:    VGA_sync 
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
module VGA_sync(input wire clk, reset,
	
	output wire hsync,vsync, video_on,

	output wire[9:0] pixel_x,pixel_y,
	output wire [3:0] x,y
    );
	 localparam HD = 640; 
	 localparam HF = 48 ; 
    localparam HB = 16 ; 
	 localparam HR = 96 ; 
	 localparam VD = 480; 
	 localparam VF = 10; 
	 localparam VB = 33; 
	 localparam VR = 2;
	 
	 reg mod2_reg;
	 wire mod2_next;
	 
	 reg [9:0] h_count_reg,h_count_next,v_count_reg,v_count_next;
	 reg v_sync_reg,h_sync_reg;
	 wire v_sync_next,h_sync_next;
	 
	 wire h_end,v_end,pixel_tick;
	 
	 reg [2:0] rgb_reg;
	 
	 
	 always@(posedge clk)
	 
		 if(reset)
		 begin
			mod2_reg<=1'b0;
			h_count_reg<=0;
			v_count_reg<=0;
			h_sync_reg<=1'b0;
			v_sync_reg<=1'b0;
		 end
		 else 
		 begin
			mod2_reg<=mod2_next;
			h_count_reg<=h_count_next;
			v_count_reg<=v_count_next;
			h_sync_reg<=h_sync_next;
			v_sync_reg<=v_sync_next;
		 end
	 
	 
	 assign mod2_next=~mod2_reg;
	 assign pixel_tick=mod2_reg;
	 
	 assign h_end=(h_count_reg==(HD+HF+HB+HR-1));
	 assign v_end=(v_count_reg==(VD+VF+VB+VR-1));
	 
	 always@*
	 
	 if(pixel_tick)
		if(h_end)
			h_count_next=0;
		else 
			h_count_next=h_count_reg+1;
	 else
		h_count_next=h_count_reg;
	 
	 
	 always@*
	 
	 if(pixel_tick && h_end)
		if(v_end)
			v_count_next=0;
		else 
			v_count_next=v_count_reg+1;
	 else
		v_count_next=v_count_reg;
	 
	 
	assign h_sync_next = (h_count_reg>=(HD+HB) && h_count_reg<=(HD+HB+HR-1));
	
	assign v_sync_next = (v_count_reg>=(VD+VB) && v_count_reg<=(VD+VB+VR-1));

	
	assign video_on = (h_count_reg<HD) && (v_count_reg<VD);
	
	assign hsync = ~h_sync_reg;
	assign vsync = ~v_sync_reg;
	assign pixel_x = h_count_reg;
	assign pixel_y = v_count_reg;
	
	assign x=(h_count_reg>=160)? (h_count_reg-160)/32-1 :0;	
	assign y=(v_count_reg>=80)? (v_count_reg-80)/32-1: 0;
	//assign p_tick = pixel_tick;
	
				
	
endmodule
