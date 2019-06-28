`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 14:25:35
// Design Name: 
// Module Name: aludec
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

//ALU Decoder
module aludec(Funct, ALUOp, ALUControl);
	input [5:0] Funct;//function code
	input [2:0] ALUOp;
	output reg [3:0] ALUControl;
	//now we change ALUOp code:
	/* 000 addi
	 * 001 subi
	 * 010 andi
	 * 011 ori
	 * 100 slti
	 * 111 depend on function code (R type)
	 */
	always @(*)
		case(ALUOp)
		  3'b010: ALUControl <= 4'b0000; //andi
		  3'b011: ALUControl <= 4'b0001; //ori
		  3'b000: ALUControl <= 4'b0010; //addi
		  3'b101: ALUControl <= 4'b0011; //xori
		  3'b001: ALUControl <= 4'b0110; //subi(if exist)
		  3'b100: ALUControl <= 4'b0111; //slti
		  3'b110: ALUControl <= 4'b1000; //lui
		  // to implement slti and ori, we develop ALUOp from [1:0] to [2:0];
		  default:case(Funct)//R-type and shift-type
			   6'b100100: ALUControl <= 4'b0000; //and
			   6'b100101: ALUControl <= 4'b0001; //or
			   6'b100000: ALUControl <= 4'b0010; //add
			   6'b100110: ALUControl <= 4'b0011; //xor
			   6'b100010: ALUControl <= 4'b0110; //sub
			   6'b101010: ALUControl <= 4'b0111; //slt
			   6'b000011: ALUControl <= 4'b1001; //sra
			   6'b000111: ALUControl <= 4'b1010; //srav
			   6'b000000: ALUControl <= 4'b1011; //sll
			   6'b000100: ALUControl <= 4'b1100; //sllv
			   6'b000010: ALUControl <= 4'b1101; //srl
			   6'b000110: ALUControl <= 4'b1110; //srlv
			   6'b001000: ALUControl <= 4'b1111; //jr
			   default:  ALUControl <= 4'bxxxx; //design
			 endcase
		 endcase
endmodule
