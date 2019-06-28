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
module aludec(functD, ALUOpD, ALUControlD);
	input [5:0] functD;//function code
	input [2:0] ALUOpD;
	output reg [3:0] ALUControlD;
	//now we change ALUOp code:
	/* 000 addi
	 * 001 subi
	 * 010 andi
	 * 011 ori
	 * 100 slti
	 * 111 depend on function code (R type)
	 */
	always @(*)
		case(ALUOpD)
		  3'b010: ALUControlD <= 4'b0000; //andi
		  3'b011: ALUControlD <= 4'b0001; //ori
		  3'b000: ALUControlD <= 4'b0010; //addi
		  3'b101: ALUControlD <= 4'b0011; //xori
		  3'b001: ALUControlD <= 4'b0110; //subi(if exist)
		  3'b100: ALUControlD <= 4'b0111; //slti
		  3'b110: ALUControlD <= 4'b1000; //lui
		  // to implement slti and ori, we develop ALUOp from [1:0] to [2:0];
		  default:case(functD)//R-type and shift-type
			   6'b100100: ALUControlD <= 4'b0000; //and
			   6'b100101: ALUControlD <= 4'b0001; //or
			   6'b100000: ALUControlD <= 4'b0010; //add
			   6'b100110: ALUControlD <= 4'b0011; //xor
			   6'b100010: ALUControlD <= 4'b0110; //sub
			   6'b101010: ALUControlD <= 4'b0111; //slt
			   6'b000011: ALUControlD <= 4'b1001; //sra
			   6'b000111: ALUControlD <= 4'b1010; //srav
			   6'b000000: ALUControlD <= 4'b1011; //sll
			   6'b000100: ALUControlD <= 4'b1100; //sllv
			   6'b000010: ALUControlD <= 4'b1101; //srl
			   6'b000110: ALUControlD <= 4'b1110; //srlv
			   6'b001000: ALUControlD <= 4'b1111; //jr
			   default:  ALUControlD <= 4'bxxxx; //design
			 endcase
		 endcase
endmodule
