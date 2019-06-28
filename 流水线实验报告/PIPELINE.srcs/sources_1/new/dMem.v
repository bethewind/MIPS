`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 17:04:46
// Design Name: 
// Module Name: dMem
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


module dMem(CLK, WriteEnable, Address, WriteData, ReadData, MemToShow, MemContent);
	input CLK, WriteEnable;
	input [31: 0] Address, WriteData;
	output [31: 0] ReadData;
	input [5:0] MemToShow;
	output [31:0] MemContent;
	
	reg [31:0]RAM[63: 0];
	assign ReadData = RAM[Address[31:2]];
	assign MemContent = RAM[MemToShow[5:0]];
	reg [6:0] j;
	initial
	begin
	    for (j = 0; j < 32; j = j + 1) 
	        RAM[j] <= 0;
	end
	always @(posedge CLK)
		if(WriteEnable)
			RAM[Address[31:2]] <= WriteData;

endmodule
