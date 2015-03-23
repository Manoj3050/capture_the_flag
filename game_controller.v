`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:42:06 07/10/2014 
// Design Name: 
// Module Name:    game_controller 
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
/////x/////////////////////////////////////////////////////////////////////////////
module game_controller#(parameter N=10)(
	input [7:0] in,
	input clk,reset,
	
	output [3:0] ball_x1_o, ball_y1_o,ball_x2_o,ball_y2_o,
	output [N-1:0] out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,
	output key_en
    );
	 reg [N-1:0] maze [N-1:0];
	 reg [3:0] ball_x1=0;
	 reg [3:0] ball_y1=0;
	 reg [3:0] ball_x2=9;
	 reg [3:0] ball_y2=9;
	 
	 reg [25:0] clk_count;
	 wire c_end;
	 wire led1,led2,led3,led4;
	 assign c_end=(clk_count==26'd6_750_000);
	 
	 
	 assign led1 = (ball_x1<4'd9) ? maze[ball_y1][ball_x1+4'b1]:1;
	 assign led2 =(ball_x1>4'd0)? maze[ball_y1][ball_x1-4'b1]:1;
	 assign led3 = (ball_y1<4'd9) ? maze[ball_y1+4'b1][ball_x1]:1;
	 assign led4 = (ball_y1>4'd0) ? maze[ball_y1-4'b1][ball_x1]:1;
	 wire right,left,down,up;
	 assign right = (ball_x2<4'd9) ? maze[ball_y2][ball_x2+4'b1]:1;
	 assign left =(ball_x2>4'd0)? maze[ball_y2][ball_x2-4'b1]:1;
	 assign down = (ball_y2<4'd9) ? maze[ball_y2+4'b1][ball_x2]:1;
	 assign up = (ball_y2>4'd0) ? maze[ball_y2-4'b1][ball_x2]:1;
	 
	 assign out1=maze[0];
	 assign out2=maze[1];
	 assign out3=maze[2];
	 assign out4=maze[3];
	 assign out5=maze[4];
	 assign out6=maze[5];
	 assign out7=maze[6];
	 assign out8=maze[7];
	 assign out9=maze[8];
	 assign out10=maze[9];
	 
	 
	 always@(posedge clk)
	 begin
		
		
		begin
			clk_count<=clk_count+1;
			if(c_end)
			begin
				clk_count<=0;
			end
		end
	end 
	 
	 assign ball_x1_o[3:0]=ball_x1[3:0];
	 assign ball_y1_o[3:0]=ball_y1[3:0];
	 assign ball_x2_o[3:0]=ball_x2[3:0];
	 assign ball_y2_o[3:0]=ball_y2[3:0];
	 
	 initial begin
		 maze[0]=10'b0010101010;
		 maze[1]=10'b0000100010;
		 maze[2]=10'b1110101010;
		 maze[3]=10'b1000101110;
		 maze[4]=10'b0011101000;
		 maze[5]=10'b0000000010;
		 maze[6]=10'b1111110010;
		 maze[7]=10'b0001000110;
		 maze[8]=10'b0101010010;
		 maze[9]=10'b0100010000;
	 end
	 
	assign key_en=c_end;	
	
	 always@(posedge clk)
	 begin
		if(reset)
			begin
				ball_x1=0;
				ball_y1=0;
				ball_x2=9;
				ball_y2=9;
			end
		else //if(c_end )
			begin
			//First player
			if(in==8'h72)begin
				if(!led3)
				begin
					ball_y1=ball_y1+4'b0001;	//down
				end
			end
			else if(in==8'h75)begin
					if(!led4) begin
						ball_y1=ball_y1-4'b0001;//up
						
					end
			end
			else if(in==8'h74)begin
					if(!led1) begin
						ball_x1=ball_x1+4'b0001;//right
						
						
					end
			end
			else if(in==8'h6B)begin
					if(!led2) begin
						ball_x1=ball_x1-4'b0001;	//left
					end
			
			end
			//2nd player
			
			else if(in==8'h1B)begin
				if(!down)
				begin
					ball_y2=ball_y2+4'b0001;	//down
				end
			end
			else if(in==8'h1D)begin
					if(!up) begin
						ball_y2=ball_y2-4'b0001;//up
					end
			end
			else if(in==8'h23)begin
					if(!right) begin
						ball_x2=ball_x2+4'b0001;//right
					end
			end
			else if(in==8'h1C)begin
					if(!left) begin
						ball_x2=ball_x2-4'b0001;	//left
					end
			
			end
			else begin ball_x1=ball_x1;
						  ball_y1=ball_y1;
							ball_x2=ball_x2;
						  ball_y2=ball_y2;
			end
		
		end
	end

endmodule
