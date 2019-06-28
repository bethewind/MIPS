`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/02 14:43:45
// Design Name: MIPS_SINGLE
// Module Name: alucont
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


module ALU(a, b, op, sa, Zero, Result);
    input  [31:0] a;
    input  [31:0] b;
    input  [3:0] op;
    input [4:0] sa;//it should be Instr[10:6]
    output Zero;
    output reg[31:0] Result;
    always @(*) 
    begin
		case(op)
		   4'b0000: Result = a & b; //a and b
		   4'b0001: Result = a | b; //a or b
		   4'b0010: Result = a + b; //a + b
		   4'b0011: Result = a ^ b; // a xor b;
		   4'b0100: Result = a & ~b; // a and ~b
		   4'b0101: Result = a | ~b;
		   4'b0110: Result = a - b;
		   4'b0111: Result = (a[31]^b[31])? a[31]: (a < b);
		   4'b1000: Result = b << 16;// lui sepcially
		   4'b1001: Result = b >>> sa; //execute an arithmetic right-shift
		   4'b1010: Result = b >>> a[4:0]; //srav
		   4'b1011: Result = b << sa; //left shift;
		   4'b1100: Result = b << a[4:0]; //sllv
		   4'b1101: Result = b >> sa; //srl
		   4'b1110: Result = b >> a[4:0]; //srlv
		   4'b1111: Result = a;//jr
		   default: Result = 32'hxxxxxxxx;
        endcase
    end
    assign Zero = Result == 0; 
endmodule

//module top(
//	input [15:0]SW,
//	input BTNC, 
//	input BTNU, 
//	input BTNL,
//	output [8:0]LED);
	
//	alucont my(.a(SW[7:0]), .b(SW[15:8]), .op({BTNC, BTNU, BTNL}), .zero(LED[8]), .result(LED[7:0]));
//endmodule	
