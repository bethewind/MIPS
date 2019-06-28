`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/26 20:48:28
// Design Name: 
// Module Name: topBench
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


module topBench(CLK, Reset, WriteData, DataAddress, MemWrite, RegToShow, RegContent, RegWrite, RegWriteData, WriteReg, MemToShow, MemContent, PC, Instr, ReadData, Jump, Branch, BranchNE);
	input CLK, Reset;
	output [31:0]WriteData, DataAddress;
	output MemWrite;
	input [4:0] RegToShow;
	output [31:0] RegContent;
	output RegWrite;
	output [31:0] RegWriteData;
	output [4:0] WriteReg;
	input [5:0] MemToShow;
	output [31:0] MemContent;
	output [31:0] PC, Instr, ReadData;
	output Jump, Branch, BranchNE;
	singleMIPS mips(CLK, Reset, PC, Instr, MemWrite, DataAddress, WriteData, ReadData,  RegToShow, RegContent, RegWrite, RegWriteData, WriteReg, Jump, Branch, BranchNE);
	iMem imem(PC[7:2], Instr);
	dMem dmem(CLK, MemWrite, DataAddress, WriteData, ReadData, MemToShow, MemContent);
endmodule
