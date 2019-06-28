`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/15 16:46:20
// Design Name: 
// Module Name: top_test
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


module top_test( );
	reg CLK, Reset;
	wire [31:0] ReadData, WriteData, WriteData2Reg;
	
	TopBench myTop(CLK, Reset, ReadData, WriteData, WriteData2Reg);
	initial
	begin
		CLK = 0;
		Reset = 1;
	end
	initial
	#6 Reset = 0;
	always #5 CLK = ~CLK;
	
endmodule
