`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:46:38 07/27/2014 
// Design Name: 
// Module Name:    vga_test 
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
module vga_RGB#(parameter N=10)(
	input clk,reset,
	input wire [9:0] pix_x,pix_y,
	input wire [3:0] pos_x,pos_y,
	input wire [3:0] b_x1, b_y1,b_x2,b_y2,
	input wire [N:0] row1,row2,row3,row4,row5,row6,row7,row8,row9,row10,
	output wire [3:0] RGB
	
	
    );
	 
	 
	 
	 reg [3:0] rgb_reg;
	 wire R_WON,B_WON;
	 
	 assign R_WON= ((b_x1==9) && (b_y1==9));
	 assign B_WON= ((b_x2==0) && (b_y2==0));
	 
	 
	
		
		always@(posedge clk)
		if(reset)
		begin
			rgb_reg<=0;
			
		end
		else
		begin
			if(pix_x>=192 && pix_x<=512 && pix_y>=80 && pix_y<=432)
			begin
				if(pos_x==0 && pos_y==0)
					if(pos_x==b_x2 && pos_y==b_y2)
						rgb_reg<=3'b100;
					else
						rgb_reg<=3'b001;
				else if(pos_x==9 && pos_y==9)
					if(pos_x==b_x1 && pos_y==b_y1)
						rgb_reg<=3'b001;
					else
						rgb_reg<=3'b100; 
				else if(R_WON)
						rgb_reg<=3'b001;
				else if(B_WON)
						rgb_reg<=3'b100;
				else begin
					case(pos_y)
						4'b0000:
							begin
							if( pos_y==b_y1 && pos_x==b_x1)
								rgb_reg<=3'b001;
							else if( pos_y==b_y2 && pos_x==b_x2)
								rgb_reg<=3'b100;
							else
							begin
								if(row1[pos_x]==0 )
									rgb_reg<=3'b101;
								else
									rgb_reg<=3'b011;
								
							end
								
							end
						4'b0001:
							begin
							if( pos_y==b_y1 && pos_x==b_x1)
								rgb_reg<=3'b001;
							else if( pos_y==b_y2 && pos_x==b_x2)
								rgb_reg<=3'b100;
							else
							begin
								if(row2[pos_x]==0 )
									rgb_reg<=3'b101;
								else
									rgb_reg<=3'b011;
								
							end
								
							end
						4'b0010:
							begin
							if( pos_y==b_y1 && pos_x==b_x1)
								rgb_reg<=3'b001;
							else if( pos_y==b_y2 && pos_x==b_x2)
								rgb_reg<=3'b100;
							else
							begin
								if(row3[pos_x]==0 )
									rgb_reg<=3'b101;
								else
									rgb_reg<=3'b011;
								
							end
								
							end
						4'b0011:
							begin
							if( pos_y==b_y1 && pos_x==b_x1)
								rgb_reg<=3'b001;
							else if( pos_y==b_y2 && pos_x==b_x2)
								rgb_reg<=3'b100;
							else
							begin
								if(row4[pos_x]==0 )
									rgb_reg<=3'b101;
								else
									rgb_reg<=3'b011;
								
							end
								
							end
						4'b0100:
							begin
							if( pos_y==b_y1 && pos_x==b_x1)
								rgb_reg<=3'b001;
							else if( pos_y==b_y2 && pos_x==b_x2)
								rgb_reg<=3'b100;
							else
							begin
								if(row5[pos_x]==0 )
									rgb_reg<=3'b101;
								else
									rgb_reg<=3'b011;
								
							end
								
							end
						4'b0101:
							begin
							if( pos_y==b_y1 && pos_x==b_x1)
								rgb_reg<=3'b001;
							else if( pos_y==b_y2 && pos_x==b_x2)
								rgb_reg<=3'b100;
							else
							begin
								if(row6[pos_x]==0 )
									rgb_reg<=3'b101;
								else
									rgb_reg<=3'b011;
								
							end
								
							end
						4'b0110:
							begin
							if( pos_y==b_y1 && pos_x==b_x1)
								rgb_reg<=3'b001;
							else if( pos_y==b_y2 && pos_x==b_x2)
								rgb_reg<=3'b100;
							else
							begin
								if(row7[pos_x]==0 )
									rgb_reg<=3'b101;
								else
									rgb_reg<=3'b011;
								
							end
								
							end
						4'b0111:
							begin
							if( pos_y==b_y1 && pos_x==b_x1)
								rgb_reg<=3'b001;
							else if( pos_y==b_y2 && pos_x==b_x2)
								rgb_reg<=3'b100;
							else
							begin
								if(row8[pos_x]==0 )
									rgb_reg<=3'b101;
								else
									rgb_reg<=3'b011;
								
							end
								
							end
						4'b1000:
							begin
							if( pos_y==b_y1 && pos_x==b_x1)
								rgb_reg<=3'b001;
							else if( pos_y==b_y2 && pos_x==b_x2)
								rgb_reg<=3'b100;
							else
							begin
								if(row9[pos_x]==0 )
									rgb_reg<=3'b101;
								else
									rgb_reg<=3'b011;
								
							end
								
							end
						4'b1001:
							begin
							if( pos_y==b_y1 && pos_x==b_x1)
								rgb_reg<=3'b001;
							else if( pos_y==b_y2 && pos_x==b_x2)
								rgb_reg<=3'b100;
							else
							begin
								if(row10[pos_x]==0 )
									rgb_reg<=3'b101;
								else
									rgb_reg<=3'b011;
								
							end
								
							end
						endcase
					end
			end
			else
				rgb_reg<=0;
		end
		
		
		
	
	assign RGB=rgb_reg;
	
endmodule
