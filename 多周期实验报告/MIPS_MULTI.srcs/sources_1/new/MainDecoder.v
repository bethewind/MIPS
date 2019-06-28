`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/08 16:04:38
// Design Name: 
// Module Name: MainDecoder
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




module MainDecoder(CLK, Reset, op, func, PCWrite, MemWrite,IRWrite, RegWrite, ALUSrcA, ALUSrcB, 
				   Branch, BranchNE, IorD, Mem2Reg, RegDst, PCSrc, ALUOp, ExS,
				   curState, nextState);
	input CLK, Reset;
	input [5:0] op;
	input [5:0] func;
	output PCWrite, MemWrite, IRWrite, RegWrite, ALUSrcA;
	output [1:0] ALUSrcB;
	output Branch, BranchNE, IorD, Mem2Reg;
	output [1:0] RegDst;
	output [1:0]PCSrc;
	output [2:0] ALUOp;
	output ExS;
	output [4:0] curState;//have
	output [4:0] nextState;//have
	

	//define states
	parameter fetch = 5'b00000;
	parameter decode = 5'b00001;
	parameter mem_adr = 5'b00010;
	parameter mem_read = 5'b00011;
	parameter mem_writeback = 5'b00100;
	parameter mem_write = 5'b00101;
	parameter r_type_execute = 5'b00110;
	parameter r_type_writeback = 5'b00111;
	parameter beq_execute = 5'b01000;
	parameter bne_execute = 5'b01001;
	parameter addi_execute = 5'b01010;	
	parameter slti_execute = 5'b01011;
	parameter ori_execute = 5'b01100;
	parameter andi_execute = 5'b01101;
	parameter xori_execute = 5'b01110;
	parameter i_type_writeback = 5'b01111;
	parameter j_execute = 5'b10000;
	parameter jr_execute = 5'b10001;
	parameter jal_execute = 5'b10010;
	parameter jal_writeback = 5'b10011;
	parameter lui_execute = 5'b10100;
	parameter lui_writeback = 5'b10101;
	
	
	//define some parameter to represent opcode 
	parameter r_type_op = 6'b000000; // r-type, shift-type, jr
	parameter lw_op = 6'b100011;
	parameter sw_op = 6'b101011;
	parameter addi_op = 6'b001000;
	parameter andi_op = 6'b001100;
	parameter ori_op = 6'b001101;
	parameter xori_op = 6'b001110;
	parameter slti_op = 6'b001010;
	parameter beq_op = 6'b000100;
	parameter bne_op = 6'b000101;
	parameter j_op = 6'b000010;
	parameter jal_op = 6'b000011;
	parameter lui_op = 6'b001111;
	
	//define some parameters to represent function code for r_type_op
	parameter add_func = 6'b100000;
	parameter sub_func = 6'b100010;
	parameter and_func = 6'b100100;
	parameter or_func = 6'b100101;
	parameter slt_func = 6'b101010;
	parameter xor_func = 6'b100110;
	parameter sra_func = 6'b000011;
	parameter srav_func = 6'b000111;
	parameter sll_func = 6'b000000;
	parameter sllv_func = 6'b000100;
	parameter srl_func = 6'b000100;
	parameter srlv_func = 6'b000110;
	parameter jr_func = 6'b001000;
	
	
	reg [4:0] CurState, NextState;
	assign curState = CurState;
	assign nextState = NextState;
	reg [18:0] Controls;
	
	// state 
	always @(posedge CLK or posedge Reset)
		if(Reset) CurState <= fetch;
		else CurState <= NextState;
	
	//next stage
	always@(*)
		case(CurState)
			fetch: NextState = decode;
			decode: case(op)
						lw_op: NextState = mem_adr;
						sw_op: NextState = mem_adr;
						r_type_op: case(func)
										jr_func: NextState = jr_execute;
										default: NextState = r_type_execute;
								   endcase
						addi_op: NextState = addi_execute;
						andi_op: NextState = andi_execute;
						ori_op: NextState = ori_execute;
						xori_op: NextState = xori_execute;
						slti_op: NextState = slti_execute;
						beq_op: NextState = beq_execute;
						bne_op: NextState = bne_execute;
						j_op: NextState = j_execute;
						jal_op: NextState = jal_execute;
						lui_op: NextState = lui_execute;
						default: NextState = 5'bxxxxx;
					endcase
			mem_adr: case(op)
						lw_op: NextState = mem_read;
						sw_op: NextState = mem_write;
						default: NextState = 5'bxxxxx;
					 endcase
			mem_read: NextState = mem_writeback;
			mem_writeback: NextState = fetch;
			mem_write: NextState = fetch;
			r_type_execute: NextState = r_type_writeback;
			r_type_writeback: NextState = fetch;
			beq_execute: NextState = fetch;
			bne_execute: NextState = fetch;
			addi_execute: NextState = i_type_writeback;
			slti_execute: NextState = i_type_writeback;
			ori_execute: NextState = i_type_writeback;
			andi_execute: NextState = i_type_writeback;
			xori_execute: NextState = i_type_writeback;
			i_type_writeback: NextState = fetch;
			j_execute: NextState = fetch;
			jr_execute: NextState = fetch;
			jal_execute: NextState = jal_writeback;
			jal_writeback: NextState = fetch;
			lui_execute: NextState = lui_writeback;
			lui_writeback: NextState = fetch;
			default: NextState = 5'bxxxxx;//error??
		endcase
	
	//control sigal 
//	output PCWrite, MemWrite, IRWrite, RegWrite, ALUSrcA;
//	output [1:0] ALUSrcB;
//	output Branch, BranchNE, IorD, Mem2Reg;
//	output [1:0] RegDst, PCSrc;
//	output [2:0] ALUOp;
//	output ExS, StorePCNext, RegPC;
	
	assign {PCWrite, MemWrite, IRWrite, RegWrite, ALUSrcA, ALUSrcB[1:0], Branch, BranchNE, IorD, 
			Mem2Reg, RegDst[1:0], PCSrc[1:0], ALUOp[2:0],ExS} = Controls;
	always @(*)
		case(CurState)
			//note: here StorePCNext is unnecessary, cause PC + 4 will out from ALUOut, so when Mem2Reg = 0, means PC + 4 will be write in.
			//note: here RegPC is also not used.
			fetch: Controls <= 19'b1010001000000000000;
			decode: Controls <= 19'b0000011000000000000;
			mem_adr: Controls <= 19'b0000110000000000000;
			mem_read: Controls <= 19'b0000000001000000000;
			mem_writeback: Controls <= 19'b0001000000100000000;
			mem_write: Controls <= 19'b0100000001000000000;
			r_type_execute: Controls <= 19'b0000100000000001110;
			r_type_writeback: Controls <= 19'b0001000000001000000;
			beq_execute: Controls <= 19'b0000100100000010010;
			bne_execute: Controls <= 19'b0000100010000010010;
			addi_execute: Controls <= 19'b0000110000000000000;
			slti_execute: Controls <= 19'b0000110000000001000;
			ori_execute: Controls <= 19'b0000110000000000111;
			andi_execute: Controls <= 19'b0000110000000000101;
			xori_execute: Controls <= 19'b0000110000000001011;
			i_type_writeback: Controls <= 19'b0001000000000000000;
			j_execute: Controls <= 19'b1000000000000100000;
			jr_execute: Controls <= 19'b1000100000000001110;
			jal_execute: Controls <= 19'b1000001000000100000;
			jal_writeback: Controls <= 19'b0001000000010100000;
			lui_execute: Controls <= 19'b0000010000000001101;
			lui_writeback: Controls <= 19'b0001000001000000000;
		    default: Controls <= 19'bxxxxxxxxxxxxxxxxxxx;//errors??
		endcase
endmodule
