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


module controller(op, Funct, Zero, Mem2Reg, MemWrite, PCSrc, ALUSrc, 
				  RegDst, RegWrite, Jump, ALUControl, ExS, StorePCNext, RegPC, Branch, BranchNE);
	input [5:0] op;
	input [5:0] Funct;
	output Zero;
	output Mem2Reg, MemWrite;
	output PCSrc;
	output [1:0] ALUSrc;
	output [1:0]RegDst;
	output RegWrite;
	output Jump;
	output [3:0] ALUControl;
	output ExS;
	output StorePCNext;
	output RegPC; 
	output Branch;
	output BranchNE;
	wire [2:0] ALUOp;
	
	
	
	maindec mainDecoder(op, Funct, Mem2Reg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, Jump, ALUOp, ExS, BranchNE, StorePCNext, RegPC);
	aludec aluDecoder(Funct, ALUOp, ALUControl);
	
	// if it's beq(branch = 1) and zero = 1 or it's bne (Jump = 1) and zero = 0
	assign PCSrc = (Branch & Zero) | (BranchNE & ~(Zero));
	
endmodule
