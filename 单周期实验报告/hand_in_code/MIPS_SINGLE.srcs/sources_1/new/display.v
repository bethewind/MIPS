`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/26 20:59:33
// Design Name: 
// Module Name: display
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
/* SW[7:0]: choose different content to show.
 * SW[13:8]: when choosing to show memory/register, use this to determine 
 *			specific register/memory to show.
 *
 * SW[14]: reset
 * SW[15]: stop
 *
 * AN[7:0] & CN[6:0] show 32-digit chosen by SW[7:0].
 * 
 * LED[4:0] : show register write address.
 *
 * LED[10:5]: show memory write address.
 *
 * LED[11]: Jump
 * LED[12]: Branch
 * LED[13]: Branch not equal
 *
 * LED16_G: light up when register write occurs.
 * LED17_R: light up when memory write occurs.
 */

module display(CLK100MHZ, SW, AN, C, LED, LED16_G, LED17_R);
	input CLK100MHZ;
	input [15:0] SW;
	output [7:0] AN; 
	output [6:0] C;
	output [13:0] LED;
	output LED16_G; //RegWrite;
	output LED17_R; //MemWrite;
	
	
	wire [31:0] PC; //PC
	wire [31:0] Instr; //Instructions
	
	wire [31:0] WriteData; //store data written into memory;
	wire [31:0] ReadData; //store data read from memory;
	wire [31:0] DataAddress; //store data address where will be write
	wire [31:0] MemContent; // store information that memory gives back after query by SW[13:8];
	
	
	wire [31:0] RegContent; // store information that registers give back after query by SW[13:8];
	wire [31:0] RegWriteData; // store data written into registers;
	
	reg [31:0] num; // store numbers will be shown in 7-segment tube;
	wire CLK1, CLK2, CLK3;
	
	// clock division
	CLKDiv myclk(CLK100MHZ, CLK1, CLK2, CLK3);
	always @(*)
	begin
		casex(SW[7:0])
		8'b00000000: num <= PC; //PC
		8'b00000001: num <= Instr; //instructions
		8'b0000001x: num <= RegContent; // what i want know in register
		8'b000001xx: num <= MemContent; //what i want know in memory
		8'b00001xxx: num <= RegWriteData; //data to be written into register
		8'b0001xxxx: num <= WriteData; // data to be written into memory
		8'b001xxxxx: num <= DataAddress; // data address
		8'b01xxxxxx: num <= ReadData; //data read from memory;
		8'B1XXXXXXX: num <= 32'h12345678; //self design
		endcase
	end
	ShowContent myContent(CLK1, num, AN, C);
	
	// assign memory write address to LED[10:5];																																																																											
	assign LED[10:5] = LED17_R ? DataAddress[7:2] : 0;
	topBench mytop(CLK3 &~SW[15], SW[14], WriteData, DataAddress, LED17_R, SW[12:8], 
				   RegContent, LED16_G, RegWriteData, LED[4:0], SW[13:8], 
				   MemContent, PC, Instr, ReadData, LED[11], LED[12], LED[13]);

endmodule
