`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 14:25:35
// Design Name: 
// Module Name: singleMIPS
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


module singleMIPS(CLK, Reset, PC, Instr, MemWrite, ALUOut, WriteData, ReadData, RegToShow, RegContent, RegWrite, RegWriteData, WriteReg, Jump, Branch, BranchNE);
	input CLK, Reset;
	output [31:0] PC;
	input [31:0] Instr;
	output MemWrite;
	output [31:0] ALUOut, WriteData;
	input [31:0] ReadData;
	input [4:0] RegToShow;
	output [31:0] RegContent;
	output RegWrite;
	output [31:0] RegWriteData;
	output [4:0] WriteReg;
	output Jump;
	output Branch;
	output BranchNE;
	wire Mem2Reg, Branch, PCSrc, Zero, ALUSrc;
	wire [1:0] RegDst;
	wire Exs, StorePCNext, RegPC;
	
	
	wire [3:0] ALUControl;
	controller c(Instr[31:26], Instr[5:0], Zero,
				 Mem2Reg, MemWrite, PCSrc, ALUSrc, RegDst, RegWrite,
				 Jump, ALUControl, ExS, StorePCNext, RegPC, Branch, BranchNE);
	datapath dp(CLK, Reset, Mem2Reg, 
				PCSrc, ALUSrc, RegDst, RegWrite,
				Jump, ALUControl, 
				Zero, PC, Instr, 
				ALUOut, WriteData, ReadData, ExS, StorePCNext, RegPC,
				RegToShow, RegContent, RegWriteData, WriteReg);
	
endmodule
