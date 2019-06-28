`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/18 18:18:35
// Design Name: 
// Module Name: dMem_test
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


module dMem_test();
	reg CLK, WriteEnable;
	reg [31:0] Address, WriteData;
	wire [31:0]ReadData;
	
	dMem myDMem(CLK, WriteEnable, Address, WriteData, ReadData);
	
	initial
	begin
	CLK = 0;
	WriteEnable = 0;
	Address[31:0] = 0;
	WriteData[31:0] = 32'h1234abcd;
	end
	
	always
	begin
		#5 
		WriteEnable = ~WriteEnable;
		CLK = ~CLK;
		#5 
		WriteData[31:0] = WriteData[31:0] + 32'h11111111;
		Address[31:0] = Address[31:0] + 32'h1;
	end
    // to be done.
endmodule
