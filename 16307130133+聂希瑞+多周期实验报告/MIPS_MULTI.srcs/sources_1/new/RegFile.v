`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/08 15:36:50
// Design Name: 
// Module Name: RegFile
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


module RegFile(CLK, WriteEn3, ReadAddress1, ReadAddress2, WriteAddress3, WriteData3, 
				ReadData1, ReadData2, 
				Reg2Show, RegContent);
	input CLK; //clock
	input WriteEn3; //write enable 
	input [4:0] ReadAddress1; //readAddress1
	input [4:0] ReadAddress2; //readAddress2
	input [4:0] WriteAddress3; // writeAddress3
	input [31:0] WriteData3; // writeData3
	output [31:0] ReadData1; //readData1
	output [31:0] ReadData2; //readData2
	input [4:0] Reg2Show;//regfile
	output [31:0] RegContent;//reg file
	
	reg [31:0] REG[31:0];//32 32-bit registers;
	reg [6:0] j;
	initial
	begin
	    for (j = 0; j < 32; j = j + 1) 
	        REG[j] <= 0;
	end
	always @(posedge CLK)
		if(WriteEn3) REG[WriteAddress3] <= WriteData3;
	
	/* tips: $t0 always zero here, so if ReadAddress = 0, just return 0;
	 */
	assign ReadData1 = (ReadAddress1 != 0) ? REG[ReadAddress1] : 0;
	assign ReadData2 = (ReadAddress2 != 0) ? REG[ReadAddress2] : 0;
	assign RegContent = (Reg2Show != 0) ? REG[Reg2Show] : 0;
endmodule
