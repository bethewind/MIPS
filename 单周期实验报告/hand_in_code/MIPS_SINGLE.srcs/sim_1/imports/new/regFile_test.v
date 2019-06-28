`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/12 17:40:35
// Design Name: 
// Module Name: regFile_test
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


module regFile_test();
	reg CLK;
	reg RegWriteEn; //write enable
	reg [4:0]RegWriteAddress; //32 registers
	reg [31:0] RegWriteData;
	reg [4:0] RsAddress;
	reg [4:0] RtAddress;
	wire [31:0] RsData;
	wire [31:0] RtData;
	
	regFile MUT(CLK, RegWriteEn, RegWriteAddress, RegWriteData,
				RsAddress, RtAddress, RsData, RtData);
	initial begin
		CLK = 0;
		RegWriteEn = 0;
		RegWriteAddress = 0;
		RegWriteData = 0;
		RsAddress = 0;
		RtAddress = 0;
		#100
		RegWriteEn = 1;
		RegWriteData = 32'h1234abcd;
		end
	parameter PERIOD = 20;
	always begin
		CLK = 1'b0;
		#(PERIOD/2) CLK = 1'b1;
		#(PERIOD/2);
		end
	always begin
		RegWriteAddress = 8;
		RsAddress = 8;
		#PERIOD;
		end
endmodule
