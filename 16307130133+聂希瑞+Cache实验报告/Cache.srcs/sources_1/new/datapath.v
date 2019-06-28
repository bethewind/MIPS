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
				RegPCD, RegToShow, RegContent, ResultW, WriteRegW, hit, SrcA2E, SrcB3E);
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
	input RegPCD;
	input [4:0]RegToShow;
	output [31:0]RegContent;
	output [31:0] ResultW;
	output [4:0] WriteRegW;
	input [1:0] hit;
	output [31:0] SrcA2E, SrcB3E;
	
	wire ForwardAD, ForwardBD;
	wire [1:0] ForwardAE, ForwardBE;
	wire StallF;
	wire [4:0] rsD, rtD, rdD, rsE, rtE, rdE;
	wire [4:0] WriteRegE, WriteRegM, WriteRegW;
	wire flushD, StallD, StallE, StallM, StallW;
	wire [31:0] PCNextFD, PCNextBrFD, PCBranchD, PCFinalD;
	wire [31:0] PCPlus4F,PCPlus4D, PCPlus4E, PCPlus4M, PCPlus4W;
	wire [31:0] SignImmD, SignImmE, SignImmShD;
	wire [31:0] SrcAD, SrcA2D, SrcAE, SrcA2E, SrcA3E;
	wire [31:0] SrcBD, SrcB2D, SrcBE, SrcB2E, SrcB3E;
	wire [31:0] InstrD;
	wire [31:0] ALUOutE, ALUOutW;
	wire [31:0] ReadDataW;// ResultW;
//	wire [31:0] pcD, pcE, pcM, pcW;

	//hazard 
	hazard hazar(rsD, rtD, rsE, rtE, WriteRegE, WriteRegM, WriteRegW, 
				  RegWriteE, RegWriteM, RegWriteW, Mem2RegE, Mem2RegM,
				  BranchD, BranchNED, ForwardAD, ForwardBD,
				  ForwardAE, ForwardBE, StallF, StallD, StallE, StallM, StallW, flushE, RegPCD, hit);
	
	
	//next pc loic
	mux2 #(32) pcBrMux(PCPlus4F, PCBranchD, PCSrcD, PCNextBrFD);//choose next address 
	mux2 #(32) pcMux(PCNextBrFD, {PCPlus4D[31:28], InstrD[25:0], 2'b00}, JumpD, PCNextFD);//choose branch or jump
	// forward
	mux2 #(32) pcFinalMux(PCNextFD, SrcA2D, RegPCD, PCFinalD);
		
	
	//register file logic
	regFile regFile(CLK, RegWriteW, rsD, rtD, WriteRegW, ResultW, SrcAD, SrcBD,
					 RegToShow, RegContent);
	// FETCH
	flopenr #(32) pcReg(CLK, Reset, ~StallF, PCFinalD, pcF, hit[0]);
	
//	flopr #(32) pcReg(CLK, Reset, PCFinal, PC);
	adder pcAdd1(pcF, 32'b100, PCPlus4F);
	
	//DECODE
	flopenr #(32) PCPlus4F_D(CLK, Reset, ~StallD, PCPlus4F, PCPlus4D, hit[0]);
//	flopr #(32) pcF_D(CLK, Reset, pcF, pcD);
	flopenrc #(32) InstrF_D(CLK, Reset, ~StallD, ~StallD & flushD, InstrF, InstrD, hit[0]);
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
	assign flushD = (PCSrcD | JumpD | RegPCD);
	
	//EXECUTE
	flopenrc #(32) SrcAD_E(CLK, Reset, ~StallE, ~StallE & flushE, SrcAD, SrcAE, hit[0]);
	flopenrc #(32) SrcBD_E(CLK, Reset, ~StallE,  ~StallE & flushE, SrcBD, SrcBE, hit[0]);
	flopenrc #(32) SignImmD_E(CLK, Reset, ~StallE,  ~StallE & flushE, SignImmD, SignImmE, hit[0]);
	flopenrc #(5) rsD_E(CLK, Reset, ~StallE,  ~StallE & flushE, rsD, rsE, hit[0]);
	flopenrc #(5) rtD_E(CLK, Reset, ~StallE,  ~StallE & flushE, rtD, rtE, hit[0]);
	flopenrc #(5) rdD_E(CLK, Reset, ~StallE,  ~StallE & flushE, rdD, rdE, hit[0]);
	flopenrc #(32) InstrD_E(CLK, Reset, ~StallE, ~StallE & flushE, InstrD, InstrE, hit[0]);
//	flopr #(32) pcD_E(CLK, Reset, pcD, pcE);
	
	flopenrc #(32) PCPlus4D_E(CLK, Reset, ~StallE, ~StallE & flushE, PCPlus4D, PCPlus4E, hit[0]);
	
	
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
	flopenr #(32) WriteDataE_M(CLK, Reset, ~StallM, SrcB2E, WriteDataM, hit[0]);
	flopenr #(32) ALUOutE_M(CLK, Reset, ~StallM, ALUOutE, ALUOutM, hit[0]);
	flopenr #(5) WriteRegE_M(CLK, Reset, ~StallM, WriteRegE, WriteRegM, hit[0]);
	flopenr #(32) PCPlus4E_M(CLK, Reset, ~StallM, PCPlus4E, PCPlus4M, hit[0]);
//	flopr #(32) pcE_M(CLK, Reset, pcE, pcM);
	
	//WRITEBACK
	flopenr #(32) ALUOutM_W(CLK, Reset, ~StallW, ALUOutM, ALUOutW, hit[0]);
	flopenr #(32) ReadDataM_W(CLK, Reset, ~StallW, ReadDataM, ReadDataW, hit[0]);
	flopenr #(5) WriteRegM_W(CLK, Reset, ~StallW, WriteRegM, WriteRegW, hit[0]);
	flopenr #(32) PCPlus4M_W(CLK, Reset, ~StallW, PCPlus4M, PCPlus4W, hit[0]);
//	flopr #(32) pcM_W(CLK, Reset, pcM, pcW);
	mux4 #(32) resMux(ALUOutW, ReadDataW, PCPlus4W, {32'h00000000},{StorePCNextW, Mem2RegW}, ResultW);
endmodule
