`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/13 15:29:40
// Design Name: 
// Module Name: Controller
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


module Controller(CLK, Reset, op, func, Zero, PCEn, IorD, MemWrite, 
				  IRWrite, RegDst, Mem2Reg, RegWrite, ALUSrcA, ALUSrcB,
				  ALUControl, PCSrc, ExS,
				  PCWrite, ALUOp, CurState, NextState);
	input CLK, Reset;
	input [5:0] op;
	input [5:0] func;
	input Zero;
	output PCEn, IorD, MemWrite, IRWrite;
	output [1:0] RegDst;
	output Mem2Reg, RegWrite, ALUSrcA;
	output [1:0] ALUSrcB;
	output [3:0] ALUControl;
	output [1:0] PCSrc;
	output ExS;
	
	//show part
	output PCWrite;//have
	output [2:0] ALUOp;//have
	output [4:0] CurState;//maindec
	output [4:0] NextState;//maindec

	
//	wire PCWrite;
	wire Branch, BranchNE;
//	wire [2:0] ALUOp;
	
	MainDecoder myMainDec(CLK, Reset, op, func, PCWrite, MemWrite,IRWrite, RegWrite, ALUSrcA, ALUSrcB, 
					      Branch, BranchNE, IorD, Mem2Reg, RegDst, PCSrc, ALUOp, ExS,
					      CurState, NextState);
	ALUDecoder myALUDec(func, ALUOp, ALUControl);
	
	assign PCEn = (PCWrite) | (Branch & Zero) | (BranchNE & (~Zero));
	
	
endmodule
