`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/08 15:23:35
// Design Name: 
// Module Name: IDMem
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


module IDMem(CLK, IorD, WriteEnable, Address, WriteData, ReadData, Mem2Show, MemContent);
	input CLK, IorD, WriteEnable;
	input [31: 0] Address;
	input [31:0] WriteData;
	output [31: 0] ReadData;
	input [6:0] Mem2Show;//mem file
	output [31:0] MemContent;//mem file
	
	reg [31:0]RAM[127: 0];
	
	assign ReadData = IorD ? RAM[Address[31:2]+64] : RAM[Address[31:2]];
	assign MemContent = RAM[Mem2Show[6:0]];
	reg [6:0] j;
	initial
	begin
//RAM[0] <= 32'h20010001;
//	RAM[1] <= 32'h200b0000;
//	RAM[2] <= 32'h200c0000;
//	RAM[3] <= 32'h200a0000;
//	RAM[4] <= 32'h20090000;
//	RAM[5] <= 32'h205c007e;
//	RAM[6] <= 32'h205d0082;
//	RAM[7] <= 32'h0c00000b;
//	RAM[8] <= 32'h20141234;
//	RAM[9] <= 32'h00000000;
//	RAM[10] <= 32'h00000000;
//	RAM[11] <= 32'hafbc0000;
//	RAM[12] <= 32'hafac0020;
//	RAM[13] <= 32'hafaa0040;
//	RAM[14] <= 32'hafa90060;
//	RAM[15] <= 32'hafbf0080;
//	RAM[16] <= 32'h23bd00a0;
//	RAM[17] <= 32'h23bcffe0;
//	RAM[18] <= 32'h100c0009;
//	RAM[19] <= 32'h102c0008;
//	RAM[20] <= 32'h218cffff;
//	RAM[21] <= 32'h0c00000b;
//	RAM[22] <= 32'h216a0000;
//	RAM[23] <= 32'h218cffff;
//	RAM[24] <= 32'h0c00000b;
//	RAM[25] <= 32'h21690000;
//	RAM[26] <= 32'h01495820;
//	RAM[27] <= 32'h0800001d;
//	RAM[28] <= 32'h00015820;
//	RAM[29] <= 32'h8fbfffe0;
//	RAM[30] <= 32'h8fa9ffc0;
//	RAM[31] <= 32'h8faaffa0;
//	RAM[32] <= 32'h8facff80;
//	RAM[33] <= 32'h8fbc0000;
//	RAM[34] <= 32'h23bdff60;
//	RAM[35] <= 32'h03e00008;
//RAM[0] <= 32'h0800002d;
//RAM[1] <= 32'h201d0100;
//RAM[2] <= 32'h23bd0010;
//RAM[3] <= 32'h8faafff0;
//RAM[4] <= 32'h8fabfff4;
//RAM[5] <= 32'hafb0fff8;
//RAM[6] <= 32'hafbffffc;
//RAM[7] <= 32'h8d480000;
//RAM[8] <= 32'h000a8020;
//RAM[9] <= 32'h000b4820;
//RAM[10] <= 32'h000a7820;
//RAM[11] <= 32'h014bc82a;
//RAM[12] <= 32'h1320001c;
//RAM[13] <= 32'h21ef0004;
//RAM[14] <= 32'h016fc82a;
//RAM[15] <= 32'h17200009;
//RAM[16] <= 32'h8dee0000;
//RAM[17] <= 32'h01c8c82a;
//RAM[18] <= 32'h17200003;
//RAM[19] <= 32'had2e0300;
//RAM[20] <= 32'h0800000d;
//RAM[21] <= 32'h2129fffc;
//RAM[22] <= 32'hae0e0300;
//RAM[23] <= 32'h0800000d;
//RAM[24] <= 32'h22100004;
//RAM[25] <= 32'hae080300;
//RAM[26] <= 32'h000a7820;
//RAM[27] <= 32'h8dee0300;
//RAM[28] <= 32'hadee0000;
//RAM[29] <= 32'h21ef0004;
//RAM[30] <= 32'h016fc82a;
//RAM[31] <= 32'h1320fffb;
//RAM[32] <= 32'h2210fffc;
//RAM[33] <= 32'hafaa0000;
//RAM[34] <= 32'h0c000002;
//RAM[35] <= 32'hafb00004;
//RAM[36] <= 32'h8fabfff4;
//RAM[37] <= 32'h22100008;
//RAM[38] <= 32'hafab0004;
//RAM[39] <= 32'h0c000002;
//RAM[40] <= 32'hafb00000;
//RAM[41] <= 32'h8fbffffc;
//RAM[42] <= 32'h8fb0fff8;
//RAM[43] <= 32'h03e00008;
//RAM[44] <= 32'h23bdfff0;
//RAM[45] <= 32'h20040000;
//RAM[46] <= 32'h2005007c;
//RAM[47] <= 32'hafa40000;
//RAM[48] <= 32'h0c000002;
//RAM[49] <= 32'hafa50004;
//RAM[50] <= 32'h20020001;
//RAM[51] <= 32'h00000000;
//RAM[52] <= 32'h00000000;
//RAM[53] <= 32'h00000000;
//RAM[54] <= 32'h00000000;
//RAM[55] <= 32'h00000000;
//RAM[56] <= 32'h00000000;
//RAM[57] <= 32'h00000000;
//RAM[58] <= 32'h00000000;
//RAM[59] <= 32'h00000000;
//RAM[60] <= 32'h00000000;
//RAM[61] <= 32'h00000000;
//RAM[62] <= 32'h00000000;
//RAM[63] <= 32'h00000000;

	    RAM[0] <= 32'h20020005;; //addi $2, $0, 5; //initialize $2 = 5
		RAM[1] <= 32'h2003000c;; //addi $3, $0, 12; //$3 = c
		RAM[2] <= 32'h2067fff7;; //addi $7, $3, -9; //$7 = 3
		RAM[3] <= 32'h00e22025;; //or $4, $7, $2; //$4 = 3 or 5 = 7
		RAM[4] <= 32'h00642824;; //and $5, $3, $4; //$5 = 12 and 7 = 4
		RAM[5] <= 32'h00a42820;; //and %5, %5, $4; //$5=4+7=11
		RAM[6] <= 32'h10a7000a;; //beq $5, $7, end; //should not branch
		RAM[7] <= 32'h20150028;; //addi $21, $0, 40;//$21 = 40 = 0x28
		RAM[8] <= 32'h02a00008;; //jr $21;//jump to RAM[10]
		RAM[9] <= 32'h00000000;; //nop
		RAM[10] <= 32'h0064202a;//slt $4, $3, $4; //$4 = 12 < 7 = 0//should not be taken due to jr
		RAM[11] <= 32'h10800001;//beq $4, $0, around// should be taken
		RAM[12] <= 32'h20050000;//addi $5, $0, 0;//should not be taken
		RAM[13] <= 32'h00e2202a;//slt $4, $7, $2; //$4 = 3 < 5 = 1 
		RAM[14] <= 32'h00853820;//add $7, $4, $5; //$7=1 + 11 = 12
		RAM[15] <= 32'h00e23822;//sub $7, $7, $2; //$7 = 12 - 5 = 7
		RAM[16] <= 32'hac670044;//sw $7, 68($3); //[($3 + 68)] = [80] = [ROM[(80>>2) + 64]] = [ROM[10100]] = ROM[20+64] = 7
		RAM[17] <= 32'h8c020050;//lw $2, 80($0); // $2 = ROM[20] = 7
		RAM[18] <= 32'h0c000015;//jal RAM[21];; //$31 = PC + 4; should be taken
		RAM[19] <= 32'h08000015;//j RAM[21];; //should not be taken due to jal
		RAM[20] <= 32'h20020001;//addi $2, $0, 1; //should not be taken
								//all data memory address are virtual address, real address should +64
		RAM[21] <= 32'hac020054;//sw $2, 84($0); //ROM[(84 >> 2)+64] = ROM[21+64] = 7
		RAM[22] <= 32'h3c0c1234;//lui $12, 0x1234;// $12 should be 12340000;
		RAM[23] <= 32'h00a75026;//xor $10, $5, $7;// $10 = 1011 xor 0111 = 1100 = c
		RAM[24] <= 32'h38ab0004;//xori $11, $5, 4;//$11 = f
		RAM[25] <= 32'hac0c0010;//sw $12, 16($0);// [16] = [16>>2] = Mem[4] = 12340000;
		RAM[26] <= 32'h00054883;//sra $9, $5, 2;; //$9 = 11 >>> 2 = 2
		RAM[27] <= 32'h00854007;//srav $8, $4, $5;// $8 = [$5] >>> [$4][4:0] = 5
		RAM[28] <= 32'h000469c0;//sll $13, $4, 7;; //$13 = [$4] << 7 = 00000080 = 128
		RAM[29] <= 32'h00847004;//sllv $14, $4, $4;//$14 = [$4] << [$4][4:0] = 2;
		RAM[30] <= 32'h00037882;//srl $15, $3, 2;; // $15 = [01100] >> 2 = 3;
		RAM[31] <= 32'h00838006;//srlv $16, $4, $3; // $16 = [$3] >> [$4][4:0]=00000110 = 6
		//how to test jal?
		RAM[32] <= 32'h00000000;//nop
		for (j = 5; j < 32; j = j + 1) 
			        RAM[j+32] <= 0;
		for (j = 0; j < 64; j = j + 1) 
					RAM[j+64] <= 0;
		end
	always @(posedge CLK)
		if(WriteEnable)//default belive all write is data operations
			RAM[Address[31:2] + 64] <= WriteData;

endmodule
