`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 14:08:58
// Design Name: 
// Module Name: signExtend
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

// input unsigned int
// output signed int
// b[15:0] = a[15:0]
// b[31:16] = a[15] * 16;
module signExtend(ExS, a, b);
	input ExS;
	input [15:0] a;
	output [31:0] b;
	assign b = {{16{a[15] & ~ExS}}, a};
endmodule
