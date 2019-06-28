`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/19 09:45:00
// Design Name: 
// Module Name: ALU_test
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


module ALU_test();
	reg [31:0] a, b;
	reg [2:0] op;
	wire zero;
	wire [31:0] Result;
	
	ALU myALU(a, b, op, zero, Result);
	
	initial
	begin
		a = 32'h1;
		b = 32'h2;
		op = 3'b000;
	end
endmodule
