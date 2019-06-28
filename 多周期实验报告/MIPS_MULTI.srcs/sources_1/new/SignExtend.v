`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/08 15:38:58
// Design Name: 
// Module Name: SignExtend
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


module SignExtend(ExS, a, b);
	input ExS;
	input [15:0] a;
	output [31:0] b;
	assign b = {{16{a[15] & ~ExS}}, a};
	// ExS = 1 means zero extend, else sign extend
endmodule
