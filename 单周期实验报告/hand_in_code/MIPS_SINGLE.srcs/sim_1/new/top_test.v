`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/18 15:53:28
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


module top_test();
	reg CLK, Reset;
	wire [31:0] WriteData, DataAddress;
	wire MemWrite;
	reg [4:0]RegToShow;
	wire [31:0] RegContent;
	wire RegWrite;
	wire [31:0] RegWriteData;
	wire [4:0] WriteReg;
	reg [5:0] MemToShow;
	wire [31:0] MemContent;
	wire [31:0] PC, Instr, ReadData;
	
	topBench mytop(CLK, Reset, WriteData, DataAddress, MemWrite, RegToShow, RegContent, RegWrite, RegWriteData, WriteReg, MemToShow, MemContent, PC, Instr, ReadData);
	
	initial
	begin
		CLK = 0;
		Reset = 1;
	end
	initial
	#6 Reset = 0;
	always #5 CLK = ~CLK;
	
	
endmodule
