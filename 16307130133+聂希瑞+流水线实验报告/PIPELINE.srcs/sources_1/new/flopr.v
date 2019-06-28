`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 16:25:01
// Design Name: 
// Module Name: ProgramCounter
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
//flip flop with synchronous reset
module flopr#(parameter WIDTH = 8) (CLK, Reset, d, q);
	input CLK; //clock
	input Reset; //reset
	input [WIDTH - 1: 0] d; //
	output reg [WIDTH - 1: 0] q;
	
	always @(posedge CLK, posedge Reset)
	begin
		if (Reset) q <= 0;
		else q <= d;// d fist, q second
	end
endmodule
