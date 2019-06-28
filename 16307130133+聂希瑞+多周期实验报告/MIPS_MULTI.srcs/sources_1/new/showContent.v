`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2019 01:39:00 PM
// Design Name: 
// Module Name: showContent
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module showContent(CLK, Content, AN, C);
	input CLK;
	input [31:0]Content; // to be displayed
	output reg [7:0]AN;
	output reg [6:0]C;
	
	wire [6:0]seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7;
	reg [3:0]cnt;
	
	showNumbers mySeg7(Content[31:28], seg7[6:0]);
	showNumbers mySeg6(Content[27:24], seg6[6:0]);
	showNumbers mySeg5(Content[23:20], seg5[6:0]);
	showNumbers mySeg4(Content[19:16], seg4[6:0]);
	showNumbers mySeg3(Content[15:12], seg3[6:0]);
	showNumbers mySeg2(Content[11:8], seg2[6:0]);
	showNumbers mySeg1(Content[7:4], seg1[6:0]);
	showNumbers mySeg0(Content[3:0], seg0[6:0]);
	
	initial
		begin
			cnt = 0;
		end
	always@(posedge CLK)
	begin
		case(cnt)
			4'b0000: begin 
						AN = 8'b01111111;
						C = seg7;
					 end
			4'b0001: begin 
						AN = 8'b10111111;
						C = seg6;
					 end
			4'b0010: begin 
					 	AN = 8'b11011111;
					 	C = seg5;
					 end
			4'b0011: begin 
						AN = 8'b11101111;
						C = seg4;
					 end
			4'b0100: begin 
						AN = 8'b11110111;
						C = seg3;
					 end
			4'b0110: begin 
						AN = 8'b11111011;
						C =seg2;
					 end
			4'b0111: begin 
						AN = 8'b11111101;
						C = seg1;
					 end
			4'b1000: begin 
						AN = 8'b11111110;
						C = seg0;
					 end
		endcase
		if(cnt == 4'b1000)
			cnt = 4'b0000;
		else  cnt = cnt + 1;
	end
endmodule
