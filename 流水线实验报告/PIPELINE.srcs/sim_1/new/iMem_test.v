`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/18 18:07:26
// Design Name: 
// Module Name: iMem_test
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


module iMem_test();
	reg [5:0] Address;
	wire [31:0] ReadData;
	
	iMem myIMem(Address, ReadData);
	initial
	begin
		Address[5:0] = 5'b00000;
	end
	always@(*)
	#5 Address[5:0] <= Address[5:0] + 1'b1;
	
	
	
endmodule
