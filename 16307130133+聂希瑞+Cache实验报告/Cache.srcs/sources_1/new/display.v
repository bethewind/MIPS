`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/26 20:59:33
// Design Name: 
// Module Name: display
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
/* SW[7:0]: choose different content to show.
 * SW[13:8]: when choosing to show memory/register, use this to determine 
 *			specific register/memory to show.
 *
 * SW[14]: reset
 * SW[15]: stop
 *
 * AN[7:0] & CN[6:0] show 32-digit chosen by SW[7:0].
 * 
 * LED[4:0] : show register write address.
 *
 * LED[10:5]: show memory write address.
 *
 * LED[11]: Jump
 * LED[12]: Branch
 * LED[13]: Branch not equal
 *
 * LED16_G: light up when register write occurs.
 * LED17_R: light up when memory write occurs.
 */

module display(CLK100MHZ, SW, AN, C, LED, LED16_R, LED16_G, LED16_B, LED17_R, LED17_G );
	input CLK100MHZ;
	input [15:0] SW;
	output [7:0] AN; 
	output [6:0] C;
	output [14:0] LED;
	output LED16_R; //hit[1:0] = 00;
	output LED16_G; //hit[1:0] = 01;
	output LED16_B; //hit[1:0] = 11;
	output LED17_R; //ReadEnable;
	output LED17_G; //WriteEnable;
//	output LED17_B; //
	
	wire [31:0] PC; //PC
	wire [31:0] InstrF; //Instructions
	wire [31:0] InstrE;
	
	wire [31:0] WriteData; //store data written into memory;
	wire [31:0] ReadData; //store data read from memory;
	wire [31:0] DataAddress; //store data address where will be write
	wire [31:0] MemContent; // store information that memory gives back after query by SW[13:8];
	
	
	wire [31:0] RegContent; // store information that registers give back after query by SW[13:8];
	wire [31:0] RegWriteData; // store data written into registers;
	wire [31:0] CacheContent;
//	wire [4:0] CacheToShow; //use SW to choose
	wire [4:0] WriteReg;
	wire [1:0] hit;
	wire [31:0] SrcA2E, SrcB3E;
//	wire [15:0]Dirty;
		
	reg [31:0] num; // store numbers will be shown in 7-segment tube;
	wire CLK1, CLK2, CLK3;
	
	// clock division
	CLKDiv myclk(CLK100MHZ, CLK1, CLK2, CLK3);
	always @(*)
	begin
		//to show more things, you can edit code here.
		case(SW[6:0])
			7'b0000000: num <= PC; //PC
			7'b0000001: num <= InstrF; //instructions
			7'b0000010: num <= InstrE; //instructions
			7'b0000100: num <= RegContent; // what i want know in register
			7'b0000101: num <= RegWriteData; //data to be written into register
			7'b0000110: num <= {26'b0, WriteReg}; //reg write address
			7'b0001000: num <= MemContent; //what i want know in memory
			7'b0001001: num <= WriteData; // data to be written into memory
			7'b0001010: num <= DataAddress; // data address
			7'b0001011: num <= ReadData; //data read from memory;
			7'b0010000: num <= CacheContent;
			7'b0100000: num <= SrcA2E;
			7'b0100001: num <= SrcB3E;
			default: num <= 32'h12345678;
		endcase
	end
	ShowContent myContent(CLK1, num, AN, C);
	
	// assign memory write address to LED[10:5];																																																																											
//	assign LED[10:5] = LED17_R ? DataAddress[7:2] : 0;
	assign LED16_R = ~hit[0]?1:0;//red miss
	assign LED16_G = ~hit[1] & ~LED16_R ? 1: 0; //green hit
	assign LED16_B = hit[1] ? 1 : 0; // nothing
	topBench mytop(CLK3 & ~SW[15], SW[14], WriteData, DataAddress, LED17_G, LED17_R, SW[11:7], 
				   RegContent, LED[0], RegWriteData, WriteReg, SW[13:7], 
				   MemContent, PC, InstrF, InstrE, ReadData, LED[1], LED[2], LED[3], 
				   LED[4], LED[5], {LED[9], LED[8], LED[7], LED[6]}, SrcA2E, SrcB3E, 
				   LED[10], LED[11], LED[12], {LED[14], LED[13]},
				   hit, CacheContent, SW[11:7]);
//  topBench mytop(CLK, Reset, WriteData, DataAddress, MemWriteM, Mem2RegM, RegToShow, 
//				   RegContent, RegWriteE, RegWriteData, WriteReg, MemToShow, 
//				   MemContent, PC, InstrF, InstrE, ReadData, JumpD, BranchD, BranchNED, 
//				   PCSrcD, ALUSrcE, ALUControlE, SrcA2E, SrcB3E, 
//				   RegPCD, StorePCNextD, ExSD, RegDstE, 
//				   hit, CacheContent, CacheToShow);
endmodule
