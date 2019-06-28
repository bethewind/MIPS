`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 16:43:42
// Design Name: 
// Module Name: iMem
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

module iMem(Address, ReadData);
	input [5:0] Address;
	output [31:0] ReadData;
	reg [31:0] ROM[63:0];// 32x64 ROM;
	// it seems to be ROM, but it should be write-able, 
	// to load new progROM into it.
	
	initial
		begin
		//initialize memory
		// read data from file
//		 $readmemh("instruction.dat",ROM);

////test code 1
//		ROM[0] <= 32'h20020005; //addi $2, $0, 5; //initialize $2 = 5
//		ROM[1] <= 32'h2003000c; //addi $3, $0, 12; //$3 = c
//		ROM[2] <= 32'h2067fff7; //addi $7, $3, -9; //$7 = 3
//		ROM[3] <= 32'h00e22025; //or $4, $7, $2; //$4 = 3 or 5 = 7
//		ROM[4] <= 32'h00642824; //and $5, $3, $4; //$5 = 12 and 7 = 4
//		ROM[5] <= 32'h00a42820; //and %5, %5, $4; //$5=4+7=11
//		ROM[6] <= 32'h10a7000a; //beq $5, $7, end; //should not branch
//		ROM[7] <= 32'h2015002c; //addi $21, $0, 44;//$21 = 44 = 0x2c
//		ROM[8] <= 32'h02a00008; //jr $21;//jump to ROM[11]
//		ROM[9] <= 32'h10a7000a; //beq, should not be taken due to jr
//		ROM[10] <= 32'h20150020;//addi $21, $0, 32; should not be taken due to jr;
//		ROM[11] <= 32'h0064202a;//slt $4, $3, $4; //$4 = 12 < 7 = 0
//		ROM[12] <= 32'h10800001;//beq $4, $0, around// should be taken
//		ROM[13] <= 32'h20050000;//addi $5, $0, 0;//should not be taken
//		ROM[14] <= 32'h00e2202a;//slt $4, $7, $2; //$4 = 3 < 5 = 1 
//		ROM[15] <= 32'h00853820;//add $7, $4, $5; //$7=1 + 11 = 12
//		ROM[16] <= 32'h00e23822;//sub $7, $7, $2; //$7 = 12 - 5 = 7
//		ROM[17] <= 32'hac670044;//sw $7, 68($3); //[($3 + 68)] = [80] = ROM[(80>>2)] = ROM[10100] = ROM[20] = 7
//		ROM[18] <= 32'h8c020050;//lw $2, 80($0); // $2 = ROM[20] = 7
//		ROM[19] <= 32'h0c000017;//jal ROM[22]; //$31 = PC + 4; should be taken
//		ROM[20] <= 32'h08000016;//j ROM[22]; //should not be taken due to jal
//		ROM[21] <= 32'h00e2202a;//slt, should not be taken
//		ROM[22] <= 32'h20020001;//addi $2, $0, 1; //should not be taken
//								//all data memory address are virtual address, real address should +64
//		ROM[23] <= 32'hac020054;//sw $2, 84($0); //ROM[(84 >> 2)] = ROM[21] = 7
//		ROM[24] <= 32'h3c0c1234;//lui $12, 0x1234;// $12 should be 12340000;
//		ROM[25] <= 32'h00a75026;//xor $10, $5, $7;// $10 = 1011 xor 0111 = 1100 = c
//		ROM[26] <= 32'h38ab0004;//xori $11, $5, 4;//$11 = f
//		ROM[27] <= 32'hac0c0010;//sw $12, 16($0);// [16] = [16>>2] = Mem[4] = 12340000;
//		ROM[28] <= 32'h00054883;//sra $9, $5, 2;; //$9 = 11 >>> 2 = 2
//		ROM[29] <= 32'h00854007;//srav $8, $4, $5;// $8 = [$5] >>> [$4][4:0] = 5
//		ROM[30] <= 32'h000469c0;//sll $13, $4, 7;; //$13 = [$4] << 7 = 00000080 = 128
//		ROM[31] <= 32'h00847004;//sllv $14, $4, $4;//$14 = [$4] << [$4][4:0] = 2;
//		ROM[32] <= 32'h00037882;//srl $15, $3, 2;; // $15 = [01100] >> 2 = 3;
//		ROM[33] <= 32'h00838006;//srlv $16, $4, $3; // $16 = [$3] >> [$4][4:0]=00000110 = 6
//		//how to test jal?
//		ROM[34] <= 32'h00000000;//nop

////code 2 fuction call
		ROM[0] <= 32'h20020005; //addi $2, $0, 5;  //$2 = 5
		ROM[1] <= 32'h2003000c; //addi $3, $0, 12; //$3 = c
		ROM[2] <= 32'h0c000008; //jal function
		ROM[3] <= 32'h00000000; //nop
		ROM[4] <= 32'h3c0c1234; //lui $12, 0x1234;// $12 = 0x12340000;
		ROM[5] <= 32'h20041234; //addi $4, $0, 0x1234;  //$4 = 0x1234
		ROM[6] <= 32'h2003000f; //addi $3, $0, f; //$3 = f
		ROM[7] <= 32'h0800000e; //j end
//function:
		ROM[8] <= 32'h2067fff7; //addi $7, $3, -9; //$7 = 3
//loop:
		ROM[9] <= 32'h10e00003; // beq $7, $0, return;
		ROM[10] <= 32'h00471020; // add $2, $2, $7;
		ROM[11] <= 32'h20e7ffff; // addi $7, $7, -1;
		ROM[12] <= 32'h08000009; // j loop;
//return:
		ROM[13] <= 32'h03e00008; //jr $31;
//end:
		ROM[14] <= 32'h00000000; //nop*/


		end
	assign ReadData = ROM[Address]; // word aligned
		
endmodule
