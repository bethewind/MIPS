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
	wire MemWriteM, Mem2RegM;
	reg [4:0]RegToShow;
	wire [31:0] RegContent;
	wire RegWriteE;
	wire [31:0] RegWriteData;
	wire [4:0] WriteReg;
	reg [6:0] MemToShow;
	wire [31:0] MemContent;
	wire [31:0] PC, InstrF, InstrE, ReadData;
	wire JumpD,  BranchD, BranchNED, PCSrcD, ALUSrcE;
	wire [3:0] ALUControlE;
	wire [31:0] SrcA2E, SrcB3E;
	wire RegPCD, StorePCNextD, ExSD;
	wire [1:0] RegDstE;
	wire [1:0] hit;
	wire [31:0] CacheContent;
	reg [4:0] CacheToShow;
	
	topBench mytop(CLK, Reset, WriteData, DataAddress, MemWriteM, Mem2RegM, RegToShow, 
				   RegContent, RegWriteE, RegWriteData, WriteReg, MemToShow, 
					MemContent, PC, InstrF, InstrE, ReadData, JumpD, BranchD, BranchNED, 
					PCSrcD, ALUSrcE, ALUControlE, SrcA2E, SrcB3E, RegPCD, StorePCNextD, ExSD, RegDstE, 
					hit, CacheContent, CacheToShow);
	
	initial
	begin
		CLK = 0;
		Reset = 1;
	end
	initial
	#6 Reset = 0;
	always #5 CLK = ~CLK;
	
	
endmodule
