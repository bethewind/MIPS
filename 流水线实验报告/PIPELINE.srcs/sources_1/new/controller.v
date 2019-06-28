`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 14:25:35
// Design Name: 
// Module Name: controller
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


module controller(CLK, Reset, opD, functD, flushE, equalD, 
				 Mem2RegE, Mem2RegM, Mem2RegW, MemWriteM, PCSrcD, ALUSrcE, RegDstE, 
				 RegWriteE, RegWriteM, RegWriteW,
				 JumpD, ALUControlE, ExSD, 
				 StorePCNextE, StorePCNextM, StorePCNextW, 
				 RegPCD, RegPCE, RegPCM, RegPCW, 
				 BranchD, BranchNED);

	input CLK, Reset;
	input [5:0] opD;
	input [5:0] functD;
	input flushE, equalD;
	output Mem2RegE, Mem2RegM, Mem2RegW;
	output MemWriteM;
	output PCSrcD;
	output ALUSrcE;
	output [1:0]RegDstE;
	output RegWriteE, RegWriteM, RegWriteW;
	output JumpD;
	output [3:0]ALUControlE;
	output ExSD;
	output StorePCNextE, StorePCNextM, StorePCNextW;
	output RegPCD, RegPCE, RegPCM, RegPCW;
	output BranchD, BranchNED;
	
	//	wire [2:0] ALUOp;
	wire [2:0] ALUOpD;
	wire Mem2RegD, MemWriteD;
	wire ALUSrcD;
	wire [1:0] RegDstD;
	wire RegWriteD;
	wire [3:0] ALUControlD;
	wire MemWriteF;
//	wire RegPCD;
	wire StorePCNextD;
	
	
	maindec mainDecoder(opD, functD, Mem2RegD, MemWriteD, BranchD, ALUSrcD, RegDstD, 
						RegWriteD, JumpD, ALUOpD, ExSD, BranchNED, StorePCNextD, RegPCD);
	aludec aluDecoder(functD, ALUOpD, ALUControlD);
	
	// if it's beq(branch = 1) and zero = 1 or it's bne (Jump = 1) and zero = 0
	assign PCSrcD = (BranchD & equalD) | (BranchNED & ~(equalD));
	
	floprc #(12) RegD_E(CLK, Reset, flushE,
	        {Mem2RegD, MemWriteD, ALUSrcD,
	        RegDstD, RegWriteD, ALUControlD, StorePCNextD, RegPCD},
	        {Mem2RegE, MemWriteE, ALUSrcE,
	        RegDstE, RegWriteE, ALUControlE, StorePCNextE, RegPCE});
	flopr #(5) RegE_M(CLK, Reset,
	        {Mem2RegE, MemWriteE, RegWriteE, StorePCNextE, RegPCE},
	        {Mem2RegM, MemWriteM, RegWriteM, StorePCNextM, RegPCM});
	flopr #(4) RegM_W(CLK, Reset,
	        {Mem2RegM, RegWriteM, StorePCNextM, RegPCM},
	        {Mem2RegW, RegWriteW, StorePCNextW, RegPCW});
	
endmodule
