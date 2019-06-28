`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/15 16:34:11
// Design Name: 
// Module Name: TopBench
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


module TopBench(CLK, Reset, ReadData, WriteData, WriteData2Reg, 
				Reg2Show, Mem2Show, MemWrite, RegWrite, PCWrite, 
				IRWrite, PCEn, IorD, Mem2Reg, PCSrc, ALUOp, RegWriteAddress, 
				MemWriteAddress, PC, Instr, MemContent, RegContent, CurState, NextState);
	input CLK, Reset;
	output [31:0] ReadData;
	output [31:0] WriteData;
	output [31:0] WriteData2Reg;
	input [4:0] Reg2Show;
	input [6:0] Mem2Show;
	output MemWrite;
	output RegWrite;
	output PCWrite;
	output IRWrite;
	output PCEn;
	output IorD;
	output Mem2Reg;
	output [1:0] PCSrc;
	output [2:0] ALUOp;
	output [4:0] RegWriteAddress;
	output [6:0] MemWriteAddress;
	output [31:0] PC;
	output [31:0] Instr;
	output [31:0] MemContent;
	output [31:0] RegContent;
	output [4:0] CurState;
	output [4:0] NextState;
	
	
	//wire MemWrite;
	wire [31:0] WriteMemAddress;
	assign MemWriteAddress[6:0] = MemWrite ? WriteMemAddress[8:2] : 0;
	MIPS_MULTI myMIPS(CLK, Reset, ReadData, MemWrite, WriteData, WriteData2Reg, WriteMemAddress,
						Reg2Show, Mem2Show, RegWrite, PCWrite,  IRWrite, PCEn, IorD, Mem2Reg,
						PCSrc, ALUOp, RegWriteAddress, PC, Instr,
					    MemContent, RegContent, CurState, NextState);
	//IDMem myMem(CLK, MemWrite, WriteMemAddress, WriteData, ReadData);
	
	
endmodule
