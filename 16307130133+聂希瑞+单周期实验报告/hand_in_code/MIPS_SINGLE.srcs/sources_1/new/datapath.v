`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 14:25:35
// Design Name: 
// Module Name: datapath
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


module datapath(CLK, Reset, Mem2Reg, PCSrc, ALUSrc, RegDst, RegWrite, Jump, ALUControl,
				Zero, PC, Instr, ALUOut, WriteData, ReadData, ExS, StorePCNext, RegPC, RegToShow, RegContent, RegWriteData, WriteReg);
	input CLK, Reset;
	input Mem2Reg, PCSrc;
	input ALUSrc;
	input [1:0] RegDst;
	input RegWrite, Jump;
	input [3:0] ALUControl;
	output Zero;
	output [31:0] PC;
	input [31:0] Instr;
	output [31:0] ALUOut, WriteData;
	input [31:0] ReadData;
	input ExS;
	input StorePCNext;
	input RegPC;
	input [4:0]RegToShow;
	output [31:0]RegContent;
	output [31:0] RegWriteData;
	output [4:0] WriteReg;
	wire [31:0] PCNext, PCNextBr, PCPlus4, PCBranch, PCFinal;
	wire [31:0] SignImm, SignImmSh;
	wire [31:0] SrcA, SrcB;
	//wire [31:0] Result;
	
	//next pc loic
	flopr #(32) pcReg(CLK, Reset, PCFinal, PC);
	adder pcAdd1(PC, 32'b100, PCPlus4);
	sl2 immSh(SignImm, SignImmSh);
	adder pcAdd2(PCPlus4, SignImmSh, PCBranch);//compute PCBranch Address
	//mux4 #(32) pcSelect(PCPlus4, PCBranch, {PCPlus4[31:28], Instr[25:0], 2'b00}, RegWriteData, {Jump, })
	mux2 #(32) pcBrMux(PCPlus4, PCBranch, PCSrc, PCNextBr);//choose next address 
	mux2 #(32) pcMux(PCNextBr, {PCPlus4[31:28], Instr[25:0], 2'b00}, Jump, PCNext);//choose branch or jump
	mux2 #(32) pcFinalMux(PCNext, RegWriteData, RegPC, PCFinal);
	//register file logic
	regFile regFile(CLK, RegWrite, Instr[25:21], Instr[20:16], WriteReg, RegWriteData, SrcA, WriteData,
					 RegToShow, RegContent);
	//choose write regdst
	mux4 #(5) wrMux(Instr[20:16], Instr[15:11], {5'b11111}, {5'b11111}, RegDst, WriteReg);
	mux4 #(32) resMux(ALUOut, ReadData, PCPlus4, {32'h00000000},{StorePCNext, Mem2Reg}, RegWriteData);
	signExtend sE(ExS, Instr[15:0], SignImm);
	
	//alu logic
	mux2 #(32) srcBMux(WriteData, SignImm, ALUSrc, SrcB);
	ALU alu(SrcA, SrcB, ALUControl, Instr[10:6], Zero, ALUOut);
	
endmodule
