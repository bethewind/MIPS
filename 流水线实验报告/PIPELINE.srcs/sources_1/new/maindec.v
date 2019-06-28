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
module maindec(opD, functD, Mem2RegD, MemWriteD, BranchD, ALUSrcD, RegDstD, 
			   RegWriteD, JumpD, ALUOpD, ExSD, BranchNED, StorePCNextD, RegPCD);
	input [5:0] opD;
	input [5:0] functD;
	output Mem2RegD, MemWriteD;
	output BranchD;
	output ALUSrcD;
	output [1:0]RegDstD;
	output RegWriteD;
	output JumpD;
	output [2:0] ALUOpD;
	output ExSD;
	output BranchNED;
	output StorePCNextD;
	output RegPCD;
	//now we change ALUOp code:
		/* 000 addi
		 * 001 sub (beq)
		 * 010 andi
		 * 011 ori
		 * 100 slti
		 * 111 depend on function code (R type)
		 */
	reg [14:0] Controls;
	
	assign {RegWriteD, RegDstD, ALUSrcD, BranchD, MemWriteD, Mem2RegD, ALUOpD, JumpD, ExSD, BranchNED, StorePCNextD, RegPCD} = Controls;
	
	always @(*)
		case(opD)
		6'b000000: 
			case(functD)
				6'b001000: Controls <= 15'b000000011100001; //jr
				default: Controls <= 15'b101000011100000; //R type
			endcase
		6'b100011: Controls <= 15'b100100100000000; //lw
		6'b101011: Controls <= 15'b000101000000000; //sw
		6'b001000: Controls <= 15'b100100000000000; //addi
		6'b001100: Controls <= 15'b100100001001000; //andi
		6'b001101: Controls <= 15'b100100001101000; //ori
		6'b001110: Controls <= 15'b100100010101000; //xori
		6'b001010: Controls <= 15'b100100010000000; //slti
		6'b000010: Controls <= 15'b000000000010000; //j
		6'b000011: Controls <= 15'b110000000010010; //jal
		6'b000100: Controls <= 15'b000010000100000; //beq
		6'b000101: Controls <= 15'b000010000100100; //bne
		6'b001111: Controls <= 15'b100100011001000; //lui
		/* remark: here use Branch and Jump signal to seperate bne and beq:
		 * if Jump = 1 and Branch = 1, means bne;
		 * if Jump = 0 and Branch = 0, means beq;
		 */
		default: Controls <= 15'bxxxxxxxxxxxxxxx; //self design
		endcase
endmodule
