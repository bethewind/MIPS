`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/18 23:12:29
// Design Name: 
// Module Name: datapath_test
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


module datapath_test();
	reg CLK, Reset;
	reg Mem2Reg, PCSrc;
	reg ALUSrc, RegDst;
	reg RegWrite, Jump;
	reg [2:0] ALUControl;
	wire zero;
	wire [31:0] PC;
	reg [31:0] Instr;
	wire [31:0] ALUOut, WriteData;
	reg [31:0] ReadData;
	reg exp;
	
	datapath myDP(CLK, Reset, Mem2Reg, PCSrc, ALUSrc, RegDst, RegWrite, Jump,
					ALUControl, zero, PC, Instr, ALUOut, WriteData, ReadData, exp);
	
	initial 
	begin
		Reset = 1;
		CLK = 0;
		Mem2Reg = 0;
		PCSrc = 0;
		ALUSrc = 0;
		RegDst = 0;
		RegWrite = 0;
		Jump = 0;
		ALUControl = 3'b000;
		Instr[31:0] = 32'h20022005;
		ReadData[31:0] = 32'h12345678;
		exp = 0;
		#5 Reset = 0;
	end
	always #5 CLK = ~CLK;
endmodule
