`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/08 16:00:46
// Design Name: 
// Module Name: Mux4
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


module Mux4#(parameter WIDTH = 8)
	(d0, d1, d2, d3, s, y);
	input [WIDTH - 1: 0] d0;
	input [WIDTH - 1: 0] d1;
	input [WIDTH - 1: 0] d2;
	input [WIDTH - 1: 0] d3;
	input [1:0]s;
	output reg[WIDTH - 1: 0] y;
	always @(*)
	begin
		case(s)
		2'b00: y = d0;
		2'b01: y = d1;
		2'b10: y = d2;
		2'b11: y = d3;
		default: y = 0;
		endcase
	end
endmodule

