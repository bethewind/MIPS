`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 14:25:35
// Design Name: 
// Module Name: maindec
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

//main decoder
module maindec(op, Funct, Mem2Reg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, Jump, ALUOp, ExS, BranchNE, StorePCNext, RegPC);
	input [5:0] op;
	input [5:0] Funct;
	output Mem2Reg, MemWrite;
	output Branch;
	output ALUSrc;
	output [1:0]RegDst;
	output RegWrite;
	output Jump;
	output [2:0] ALUOp;
	output ExS;
	output BranchNE;
	output StorePCNext;
	output RegPC;
	//now we change ALUOp code:
		/* 000 addi
		 * 001 sub (beq)
		 * 010 andi
		 * 011 ori
		 * 100 slti
		 * 111 depend on function code (R type)
		 */
	reg [14:0] Controls;
	
	assign {RegWrite, RegDst, ALUSrc, Branch, MemWrite, Mem2Reg, ALUOp, Jump, ExS, BranchNE, StorePCNext, RegPC} = Controls;
	
	always @(*)
		case(op)
		6'b000000: 
			case(Funct)
				6'b001000: Controls <= 15'b000000011100001; //jr
				default: Controls <= 15'b101000011101000; //R type
			endcase
		6'b100011: Controls <= 15'b100100100001000; //lw
		6'b101011: Controls <= 15'b000101000001000; //sw
		6'b001000: Controls <= 15'b100100000001000; //addi
		6'b001100: Controls <= 15'b100100001000000; //andi
		6'b001101: Controls <= 15'b100100001100000; //ori
		6'b001110: Controls <= 15'b100100010100000; //xori
		6'b001010: Controls <= 15'b100100010001000; //slti
		6'b000010: Controls <= 15'b000000000011000; //j
		6'b000011: Controls <= 15'b110000000010010; //jal
		6'b000100: Controls <= 15'b000010000101000; //beq
		6'b000101: Controls <= 15'b000010000101100; //bne
		6'b001111: Controls <= 15'b100100011000000; //lui
		/* remark: here use Branch and Jump signal to seperate bne and beq:
		 * if Jump = 1 and Branch = 1, means bne;
		 * if Jump = 0 and Branch = 0, means beq;
		 */
		default: Controls <= 15'bxxxxxxxxxxxxxxx; //self design
		endcase
endmodule
