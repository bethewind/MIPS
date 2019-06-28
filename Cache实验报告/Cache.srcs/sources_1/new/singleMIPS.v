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


module singleMIPS(CLK, Reset, pcF, InstrF, InstrE, MemWriteM, ALUOutM, WriteDataM, ReadDataM, 
				  RegToShow, RegContent, RegWriteE, RegWriteData, WriteReg, JumpD, BranchD, BranchNED,
				  Mem2RegM, hit, PCSrcD, ALUSrcE, ALUControlE, SrcA2E, SrcB3E, RegPCD, StorePCNextD, ExSD, RegDstE);
	input CLK, Reset;
	output [31:0] pcF;
	input [31:0] InstrF;
	output [31:0] InstrE;
	output MemWriteM;
	output [31:0] ALUOutM, WriteDataM;
	input [31:0] ReadDataM;
	input [4:0] RegToShow;
	output [31:0] RegContent;
	output RegWriteE;
	output [31:0] RegWriteData;
	output [4:0] WriteReg;
	output JumpD;
	output BranchD;
	output BranchNED;
	output Mem2RegM;
	input [1:0]hit;
	output PCSrcD, ALUSrcE;
	output [3:0] ALUControlE;
	output [31:0] SrcA2E, SrcB3E;
	output RegPCD, StorePCNextD, ExSD;
	output [1:0]RegDstE;
	
	
//	wire Mem2Reg, Branch, PCSrc, Zero, ALUSrc;
//	wire [1:0] RegDst;
//	wire Exs, StorePCNext, RegPC;
	
	
//	wire [3:0] ALUControl;
	wire [5:0] opD, functD;
//	wire [1:0] RegDstE;
//	wire ALUSrcE, PCSrcD;
	wire Mem2RegE, Mem2RegW;
//	wire RegWriteE,
    wire RegWritM, RegWriteW;
//	wire [3:0] ALUControlE;
	wire flashE, equalD;
//	wire ExSD;
	wire  RegPCE, RegPCM, RegPCW;
	wire StorePCNextE, StorePCNextM, StorePCNextW;
	
	
	controller c(CLK, Reset, opD, functD, flushE, equalD, 
				 Mem2RegE, Mem2RegM, Mem2RegW, MemWriteM, PCSrcD, ALUSrcE, RegDstE, 
				 RegWriteE, RegWritM, RegWriteW,
				 JumpD, ALUControlE, ExSD, 
				 StorePCNextD, StorePCNextE, StorePCNextM, StorePCNextW, 
				 RegPCD, BranchD, BranchNED, hit);
	datapath dp(CLK, Reset, Mem2RegE, Mem2RegM, Mem2RegW, 
				PCSrcD, BranchD, BranchNED, ALUSrcE, RegDstE, RegWriteE, RegWritM, RegWriteW,
				JumpD, ALUControlE, equalD, pcF, InstrF, InstrE,
				ALUOutM, WriteDataM, ReadDataM, opD, functD, flushE, ExSD, 
				StorePCNextE, StorePCNextM, StorePCNextW, 
				RegPCD, 
				RegToShow, RegContent, RegWriteData, WriteReg, hit, SrcA2E, SrcB3E);
	
endmodule
