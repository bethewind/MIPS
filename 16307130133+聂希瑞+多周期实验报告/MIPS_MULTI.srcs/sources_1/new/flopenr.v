`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/08 15:15:52
// Design Name: 
// Module Name: flopenr
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


module flopenr #(parameter 	WIDTH = 8)
	(CLK, Reset, Enable, d, q);
	input CLK, Reset;
	input Enable;
	input [WIDTH - 1: 0] d;
	output reg [WIDTH - 1: 0] q;
	//remark: here differs from given code
	// always ->always_ff
	always @(posedge CLK or posedge Reset)
		if(Reset) q <= 0;
		else if(Enable) q <= d;

endmodule
