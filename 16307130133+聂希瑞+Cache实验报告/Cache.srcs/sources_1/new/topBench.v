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


module topBench(CLK, Reset, WriteData, DataAddress, MemWriteM, Mem2RegM, RegToShow, 
				   RegContent, RegWriteE, RegWriteData, WriteReg, MemToShow, 
				   MemContent, PC, InstrF, InstrE, ReadData, JumpD, BranchD, BranchNED, 
				   PCSrcD, ALUSrcE, ALUControlE, SrcA2E, SrcB3E, RegPCD, StorePCNextD, ExSD, RegDstE, 
				   hit, CacheContent, CacheToShow);
	input CLK, Reset;
	output [31:0]WriteData, DataAddress;
	output MemWriteM, Mem2RegM;
	input [4:0] RegToShow;
	output [31:0] RegContent;
	output RegWriteE;
	output [31:0] RegWriteData;
	output [4:0] WriteReg;
	input [6:0] MemToShow;
	output [31:0] MemContent;
	output [31:0] PC, InstrF, InstrE, ReadData;
	output JumpD, BranchD, BranchNED, PCSrcD, ALUSrcE;
	output [3:0] ALUControlE;
	output [31:0] SrcA2E, SrcB3E;
	output RegPCD, StorePCNextD, ExSD;
	output [1:0]RegDstE;
	output [1:0] hit;
	output [31:0]CacheContent;
	input [4:0] CacheToShow;
	
	singleMIPS mips(CLK, Reset, PC, InstrF, InstrE, MemWriteM, DataAddress, WriteData, ReadData,  RegToShow, RegContent, RegWriteE, RegWriteData, WriteReg,
				    JumpD, BranchD, BranchNED, Mem2RegM, hit, PCSrcD, ALUSrcE, ALUControlE, SrcA2E, SrcB3E, RegPCD, StorePCNextD, ExSD, RegDstE);
		    				  
				    				  
	iMem imem(PC[7:2], InstrF);
  	Cache2 Cache2(CLK, MemWriteM, Mem2RegM, DataAddress, WriteData, ReadData, MemToShow, MemContent, hit, CacheContent, CacheToShow);
endmodule
