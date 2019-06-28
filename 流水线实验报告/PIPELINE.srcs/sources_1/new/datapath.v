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


module datapath(CLK, Reset, Mem2RegE, Mem2RegM, Mem2RegW, 
				PCSrcD, BranchD, BranchNED, ALUSrcE, RegDstE, RegWriteE, RegWriteM, RegWriteW,
				JumpD, ALUControlE, equalD, pcF, InstrF, InstrE,
				ALUOutM, WriteDataM, ReadDataM, opD, functD, flushE, ExSD, 
				StorePCNextE, StorePCNextM, StorePCNextW, 
				RegPCD, RegPCE, RegPCM, RegPCW,
				RegToShow, RegContent, ResultW, WriteReg);
	input CLK, Reset;
	input Mem2RegE, Mem2RegM, Mem2RegW;
	input PCSrcD, BranchD, BranchNED;
	input ALUSrcE;
	input [1:0] RegDstE;
	input RegWriteE, RegWriteM, RegWriteW;
	input JumpD;
	input [3:0] ALUControlE;
	output equalD;
	output [31:0] pcF;
	input [31:0] InstrF;
	output [31:0] InstrE;
	output [31:0] ALUOutM, WriteDataM;
	input [31:0] ReadDataM;
	output [5:0] opD, functD;
	input flushE, ExSD;
	input StorePCNextE, StorePCNextM, StorePCNextW;
	input RegPCD, RegPCE, RegPCM, RegPCW;
	input [4:0]RegToShow;
	output [31:0]RegContent;
	output [31:0] ResultW;
	output [4:0] WriteReg;
	
	
	wire ForwardAD, ForwardBD;
	wire [1:0] ForwardAE, ForwardBE;
	wire StallF;
	wire [4:0] rsD, rtD, rdD, rsE, rtE, rdE;
	wire [4:0] WriteRegE, WriteRegM, WriteRegW;
	wire flushD, StallD;
	wire [31:0] PCNextFD, PCNextBrFD, PCBranchD, PCFinalD;
	wire [31:0] PCPlus4F,PCPlus4D, PCPlus4E, PCPlus4M, PCPlus4W;
	wire [31:0] SignImmD, SignImmE, SignImmShD;
	wire [31:0] SrcAD, SrcA2D, SrcAE, SrcA2E, SrcA3E;
	wire [31:0] SrcBD, SrcB2D, SrcBE, SrcB2E, SrcB3E;
	wire [31:0] InstrD;
	wire [31:0] ALUOutE, ALUOutW;
	wire [31:0] ReadDataW;// ResultW;
	wire [31:0] pcD, pcE, pcM, pcW;
	
	//hazard 
	hazard hazar(rsD, rtD, rsE, rtE, WriteRegE, WriteRegM, WriteRegW, 
				  RegWriteE, RegWriteM, RegWriteW, Mem2RegE, Mem2RegM,
				  BranchD, BranchNED, ForwardAD, ForwardBD,
				  ForwardAE, ForwardBE, StallF, StallD, flushE, RegPCD);
	
	
	//next pc loic
	
	mux2 #(32) pcBrMux(PCPlus4F, PCBranchD, PCSrcD, PCNextBrFD);//choose next address 
	mux2 #(32) pcMux(PCNextBrFD, {PCPlus4D[31:28], InstrD[25:0], 2'b00}, JumpD, PCNextFD);//choose branch or jump
	// forward
	mux2 #(32) pcFinalMux(PCNextFD, SrcA2D, RegPCD, PCFinalD);
		
	
	//register file logic
	regFile regFile(CLK, RegWriteW, rsD, rtD, WriteRegW, ResultW, SrcAD, SrcBD,
					 RegToShow, RegContent);
	// FETCH
	flopenr #(32) pcReg(CLK, Reset, ~StallF, PCFinalD, pcF);
	
//	flopr #(32) pcReg(CLK, Reset, PCFinal, PC);
	adder pcAdd1(pcF, 32'b100, PCPlus4F);
	
	//DECODE
	flopenr #(32) PCPlus4F_D(CLK, Reset, ~StallD, PCPlus4F, PCPlus4D);
//	flopr #(32) pcF_D(CLK, Reset, pcF, pcD);
	flopenrc #(32) InstrF_D(CLK, Reset, ~StallD, ~StallD & flushD, InstrF, InstrD);
	signExtend sE(ExSD, InstrD[15:0], SignImmD); 
	sl2 immSh(SignImmD, SignImmShD);
	adder pcAdd2(PCPlus4D, SignImmShD, PCBranchD);//compute PCBranch Address
	//mux4 #(32) pcSelect(PCPlus4, PCBranch, {PCPlus4[31:28], Instr[25:0], 2'b00}, RegWriteData, {Jump, })
	mux2 #(32) fdMUXAD(SrcAD, ALUOutM, ForwardAD, SrcA2D);
	mux2 #(32) fdMUXBD(SrcBD, ALUOutM, ForwardBD, SrcB2D);
	

	eqcmp comp(SrcA2D, SrcB2D, equalD);
	
	assign opD = InstrD[31:26];
	assign functD = InstrD[5:0];
	assign rsD = InstrD[25:21];
	assign rtD = InstrD[20:16];
	assign rdD = InstrD[15:11];
	assign flushD = PCSrcD | JumpD | RegPCD;
	
	//EXECUTE
	floprc #(32) SrcAD_E(CLK, Reset, flushE, SrcAD, SrcAE);
	floprc #(32) SrcBD_E(CLK, Reset, flushE, SrcBD, SrcBE);
	floprc #(32) SignImmD_E(CLK, Reset, flushE, SignImmD, SignImmE);
	floprc #(5) rsD_E(CLK, Reset, flushE, rsD, rsE);
	floprc #(5) rtD_E(CLK, Reset, flushE, rtD, rtE);
	floprc #(5) rdD_E(CLK, Reset, flushE, rdD, rdE);
	floprc #(32) InstrD_E(CLK, Reset, flushE, InstrD, InstrE);
//	flopr #(32) pcD_E(CLK, Reset, pcD, pcE);
	
	floprc #(32) PCPlus4D_E(CLK, Reset, flushE, PCPlus4D, PCPlus4E);
	
	
	mux4 #(32)fdAEMUX(SrcAE, ResultW, ALUOutM, ALUOutM, ForwardAE, SrcA2E);
	//here is an error, 4 should be zero
//	mux2 #(32)SrcAMUX(SrcA2E, {32'h00000000}, StorePCNextE, SrcA3E);
	mux4 #(32)fdBEMUX(SrcBE, ResultW, ALUOutM, ALUOutM, ForwardBE, SrcB2E);
	mux2 #(32)SrcBMUX(SrcB2E, SignImmE, ALUSrcE, SrcB3E);
	//alu logic
	//mux2 #(32) srcBMux(WriteData, SignImm, ALUSrc, SrcB);
	ALU alu(SrcA2E, SrcB3E, ALUControlE, InstrE[10:6], ALUOutE);
	mux4 #(5) wrMux(rtE, rdE, {5'b11111}, {5'b11111}, RegDstE, WriteRegE);
	
	//MEMORY
	flopr #(32) WriteDataE_M(CLK, Reset, SrcB2E, WriteDataM);
	flopr #(32) ALUOutE_M(CLK, Reset, ALUOutE, ALUOutM);
	flopr #(5) WriteRegE_M(CLK, Reset, WriteRegE, WriteRegM);
	flopr #(32) PCPlus4E_M(CLK, Reset, PCPlus4E, PCPlus4M);
//	flopr #(32) pcE_M(CLK, Reset, pcE, pcM);
	
	//WRITEBACK
	flopr #(32) ALUOutM_W(CLK, Reset, ALUOutM, ALUOutW);
	flopr #(32) ReadDataM_W(CLK, Reset, ReadDataM, ReadDataW);
	flopr #(5) WriteRegM_W(CLK, Reset, WriteRegM, WriteRegW);
	flopr #(32) PCPlus4M_W(CLK, Reset, PCPlus4M, PCPlus4W);
//	flopr #(32) pcM_W(CLK, Reset, pcM, pcW);
	mux4 #(32) resMux(ALUOutW, ReadDataW, PCPlus4W, {32'h00000000},{StorePCNextW, Mem2RegW}, ResultW);
endmodule
