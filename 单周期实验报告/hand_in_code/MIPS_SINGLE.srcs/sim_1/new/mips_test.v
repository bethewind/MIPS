`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/18 22:40:00
// Design Name: 
// Module Name: mips_test
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


module mips_test();
	reg CLK, Reset;
	wire [31:0] PC;
	reg [31:0] Instr;
	wire MemWrite;
	wire [31:0] ALUOut, WriteData;
	reg [31:0] ReadData;
	
	singleMIPS myMips(CLK, Reset, PC, Instr, MemWrite, ALUOut, WriteData, ReadData);
	
	initial
	begin
		CLK = 0;
		Reset = 0;
		ReadData[31:0] <= 32'h0;
	end
	initial
	begin
		#5 CLK = ~CLK;
		Instr[31:0] <= 32'h20022005;
		#5 CLK = ~CLK;
		Instr[31:0] <= 32'h2003000c;
		#5 CLK = ~CLK;
		Instr[31:0] <= 32'h2067fff7;
		#5 CLK = ~CLK;
		Instr[31:0] <= 32'h00e22025;
		#5 CLK = ~CLK;
		Instr[31:0] <= 32'h00642824;
	end
		
endmodule
