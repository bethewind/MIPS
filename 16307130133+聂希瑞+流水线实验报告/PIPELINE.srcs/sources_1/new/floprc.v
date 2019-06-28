`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/24 17:06:51
// Design Name: 
// Module Name: floprc
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


module floprc#(parameter WIDTH = 8) (CLK, Reset, Clear, d, q);
	input CLK; //clock
	input Reset; //reset
	input Clear;//clear
	input [WIDTH - 1: 0] d; //
	output reg [WIDTH - 1: 0] q;
	
	always @(posedge CLK, posedge Reset)
	begin
		if (Reset) q <= 0;
		else if(Clear) q <= 0;
		else q <= d;// d fist, q second
	end
endmodule
