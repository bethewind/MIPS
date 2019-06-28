`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2019 01:41:25 PM
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


module display(CLK100MHZ, SW, AN, C, LED, LED16_G, LED17_R);
	input CLK100MHZ;
	input [15:0]SW;
	output [7:0]AN;
	output [6:0]C;
	output [15:0] LED;
	output LED16_G;
	output LED17_R;
	
	
	wire [31:0] PC;
	wire [31:0] Instr;
	wire [31:0] MemContent;
	wire [31:0] RegContent;
	wire [31:0] MemWriteData;
	wire [31:0] RegWriteData;
	wire [31:0] MemReadData;
	
	wire [4:0] CurState;
	wire [4:0] NextState;
	
	reg[31:0] num;
	wire CLK1, CLK2, CLK3;

//	wire MemWrite;//LED17_R
//	wire RegWrite;//LED16_G

//	wire PCWrite;//LED[9]
//	wire IRWrite;//LED[8]
//	wire PCEn;//LED[7]
//  wire IorD;//LED[6]
//  wire Mem2Reg; //LED[5]
//	wire [1:0] PCSrc; //LED[4:3];
//	wire [2:0] ALUOp; // LED[2:0];
	wire [4:0] RegWriteAddress;
	wire [6:0] MemWriteAddress;
	
	CLKDiv myclk(CLK100MHZ, CLK1, CLK2, CLK3);
	always @(*)
		begin
			casex(SW[6:0])
			7'b0000000: num <= PC; //PC
			7'b0000001: num <= Instr; //instructions
			7'b000001x: num <= {{3'b000}, CurState[4:0], {3'b000}, NextState[4:0],{3'b000}, RegWriteAddress[4:0], {1'b0}, MemWriteAddress[6:0]};
			7'b00001xx: num <= MemContent; //what i want know in memory
			7'b0001xxx: num <= RegContent; // what i want know in register
			7'b001xxxx: num <= MemWriteData; //data to be written into register
			7'b01xxxxx: num <= RegWriteData; // data to be written into memory
			7'b1xxxxxx: num <= MemWriteAddress; //Mem write Address
			endcase
		end
		showContent myContent(CLK1, num, AN, C);
					
		TopBench mytop(CLK3 & ~SW[15], SW[14], MemReadData, MemWriteData, RegWriteData, 
						SW[11:7], SW[13:7],LED17_R, LED16_G, LED[9], LED[8], LED[7], LED[6],
						LED[5], LED[4:3], LED[2:0], RegWriteAddress, MemWriteAddress, PC, 
						Instr, MemContent, RegContent, CurState, NextState);
	
		endmodule

