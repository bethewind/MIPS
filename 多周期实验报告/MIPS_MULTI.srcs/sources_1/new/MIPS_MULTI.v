`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/15 16:08:18
// Design Name: 
// Module Name: MIPS_MULTI
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


module MIPS_MULTI(CLK, Reset, ReadData, MemWrite, WriteData, WriteData2Reg, WriteMemAddress,
					Reg2Show, Mem2Show, RegWrite, PCWrite,  IRWrite, PCEn, IorD, Mem2Reg,
						PCSrc, ALUOp, RegWriteAddress, PC, Instr,
					    MemContent, RegContent, CurState, NextState);
	input CLK, Reset;
	
	output [31:0] ReadData;
	output MemWrite;
	output [31:0] WriteData;
	output [31:0] WriteData2Reg;
	output [31:0] WriteMemAddress;
	
	input [4:0] Reg2Show;//dp
	input [6:0] Mem2Show;//dp
	output RegWrite;//have
	output PCWrite;//controller
	output IRWrite;//have
	output PCEn;//have
	output IorD;//have
	output Mem2Reg;//have
	output [1:0] PCSrc;//have
	output [2:0] ALUOp;//controller
	output [4:0] RegWriteAddress;//dp
	output [31:0] PC;//have
	output [31:0] Instr;//dp
	output [31:0] MemContent;//dp
	output [31:0] RegContent;//dp
	output [4:0] CurState;//controller
	output [4:0] NextState;//controller
	
//	wire PCEn, IorD, IRWrite;
	wire Zero;
	wire [1:0] RegDst;
//	wire Mem2Reg, RegWrite, 
	wire ALUSrcA;
	wire [1:0] ALUSrcB;
	wire [3:0] ALUControl;
//	wire [1:0] PCSrc;
	wire ExS;
//	wire [31:0] PC;
	wire [5:0] op, func;
	
	Datapath mydp(CLK, Reset, PCEn, IorD, MemWrite, IRWrite,
				  RegDst, Mem2Reg, RegWrite, ALUSrcA, ALUSrcB,
				  ALUControl, PCSrc, ReadData, ExS, func, op,
				  WriteMemAddress, PC, Zero, WriteData2Reg, WriteData,
				  Reg2Show, Mem2Show, RegWriteAddress, Instr, MemContent, RegContent);
				  
	Controller myController(CLK, Reset, op, func, Zero, PCEn, 
							IorD, MemWrite, IRWrite, RegDst, 
							Mem2Reg, RegWrite, ALUSrcA, ALUSrcB,
				  			ALUControl, PCSrc, ExS, 
				  			PCWrite, ALUOp, CurState, NextState);
endmodule
