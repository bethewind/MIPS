`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/05 11:03:09
// Design Name: 
// Module Name: Cache2
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


module Cache2(CLK, WriteEnable, ReadEnable, Address, WriteData, ReadData, MemToShow, 
			  MemContent, hit, CacheContent, CacheToShow);
	input CLK, WriteEnable, ReadEnable;
	input [31: 0] Address, WriteData;
	output reg [31: 0] ReadData;
	input [5:0] MemToShow;
	output [31:0] MemContent;
	output reg [1:0]hit;
	output [31:0]CacheContent;
	input [4:0] CacheToShow;
		

	// Note: though we have a 32-bit Address varable, we have only 64 * 32 Memory.
	// So we need 8 bits address only;
	reg [31:0]RAM[127: 0];
	// 4 groups, 2 line per group, 4*4bytes per line
	reg [31:0]CACHE[3:0][1:0][3:0];
	reg [1:0]Dirty[3:0][1:0]; //store used+modified 
	reg [2:0]Info[3:0][1:0];// store address[6:4]
//	reg [1:0]hit;
	reg [7:0] j;
	reg [3:0]last;
//	reg [3:0]lineNum;
//	reg [1:0] hit;
	
	initial
		begin
		    for (j = 0; j < 128; j = j + 1) 
		        RAM[j] = 0;
		    for (j = 0; j < 128; j = j + 1)
		    begin
		       	CACHE[j/32][(j/8)%2][j%4] = 0;//initialization
		       	Info[j/32][(j/8)%2] = 0;
		    end
			for (j = 0; j < 8; j = j + 1)
				Dirty[j/2][j%2] = 2'b00;
			hit = 2'b11; last = 4'b1111;
		end
	always @(negedge CLK)
	begin
		//read
		if (ReadEnable)
		begin
			//not hit
			if(Info[Address[8:7]][0][2:0] != Address[6:4] & Info[Address[8:7]][1][2:0] != Address[6:4])
			begin
				hit = 2'b00;
				//if Dirty[line1] < Dirty[line0], replace line 1
				if(Dirty[Address[8:7]][1][1:0] < Dirty[Address[8:7]][0][1:0])
				begin
					// have been modified, write back to Memory
					if(Dirty[Address[8:7]][1][0] == 1'b1)
					begin
						RAM[{Address[8:7], Info[Address[8:7]][1], 2'b00}] = CACHE[Address[8:7]][1][2'b00];
						RAM[{Address[8:7], Info[Address[8:7]][1], 2'b01}] = CACHE[Address[8:7]][1][2'b01];
						RAM[{Address[8:7], Info[Address[8:7]][1], 2'b10}] = CACHE[Address[8:7]][1][2'b10];
						RAM[{Address[8:7], Info[Address[8:7]][1], 2'b11}] = CACHE[Address[8:7]][1][2'b11];
					end
					// load from memory
					CACHE[Address[8:7]][1][2'b00] = RAM[{Address[8:4], 2'b00}];
					CACHE[Address[8:7]][1][2'b01] = RAM[{Address[8:4], 2'b01}];
					CACHE[Address[8:7]][1][2'b10] = RAM[{Address[8:4], 2'b10}];
					CACHE[Address[8:7]][1][2'b11] = RAM[{Address[8:4], 2'b11}];
					//reresh Info
					Info[Address[8:7]][1][2:0] = Address[6:4];
					Dirty[Address[8:7]][1][1:0] = 2'b10;
					ReadData = CACHE[Address[8:7]][1][Address[3:2]];
//					lineNum[Address[8:7]] = 1'b1;
				end
				//if Dirty[line0] < Dirty[line1], replace line 0
				else if(Dirty[Address[8:7]][0][1:0] < Dirty[Address[8:7]][1][1:0])
				begin
					// have been modified, write back to Memory
					if(Dirty[Address[8:7]][0][0] == 1'b1)
					begin
						RAM[{Address[8:7], Info[Address[8:7]][0], 2'b00}] = CACHE[Address[8:7]][0][2'b00];
						RAM[{Address[8:7], Info[Address[8:7]][0], 2'b01}] = CACHE[Address[8:7]][0][2'b01];
						RAM[{Address[8:7], Info[Address[8:7]][0], 2'b10}] = CACHE[Address[8:7]][0][2'b10];
						RAM[{Address[8:7], Info[Address[8:7]][0], 2'b11}] = CACHE[Address[8:7]][0][2'b11];
					end
					// load from memory
					CACHE[Address[8:7]][0][2'b00] = RAM[{Address[8:4], 2'b00}];
					CACHE[Address[8:7]][0][2'b01] = RAM[{Address[8:4], 2'b01}];
					CACHE[Address[8:7]][0][2'b10] = RAM[{Address[8:4], 2'b10}];
					CACHE[Address[8:7]][0][2'b11] = RAM[{Address[8:4], 2'b11}];
					//reresh Info
					Info[Address[8:7]][0][2:0] = Address[6:4];
					Dirty[Address[8:7]][0][1:0] = 2'b10; //10 means it has been read but not modified;
					ReadData = CACHE[Address[8:7]][0][Address[3:2]];
//					lineNum[Address[8:7]] = 1'b0;
				end
				//  Dirty[line0] == Dirty[line1], check last replaced line, if last = 1, replace 0;
				else if(Dirty[Address[8:7]][0][1:0] == Dirty[Address[8:7]][1][1:0])
				begin
					// have been modified, write back to Memory
					if(Dirty[Address[8:7]][~last[Address[8:7]]][0] == 1'b1)
					begin
						RAM[{Address[8:7], Info[Address[8:7]][~last[Address[8:7]]], 2'b00}] = CACHE[Address[8:7]][~last[Address[8:7]]][2'b00];
						RAM[{Address[8:7], Info[Address[8:7]][~last[Address[8:7]]], 2'b01}] = CACHE[Address[8:7]][~last[Address[8:7]]][2'b01];
						RAM[{Address[8:7], Info[Address[8:7]][~last[Address[8:7]]], 2'b10}] = CACHE[Address[8:7]][~last[Address[8:7]]][2'b10];
						RAM[{Address[8:7], Info[Address[8:7]][~last[Address[8:7]]], 2'b11}] = CACHE[Address[8:7]][~last[Address[8:7]]][2'b11];
					end
					// load from memory
					CACHE[Address[8:7]][~last[Address[8:7]]][2'b00] = RAM[{Address[8:4], 2'b00}];
					CACHE[Address[8:7]][~last[Address[8:7]]][2'b01] = RAM[{Address[8:4], 2'b01}];
					CACHE[Address[8:7]][~last[Address[8:7]]][2'b10] = RAM[{Address[8:4], 2'b10}];
					CACHE[Address[8:7]][~last[Address[8:7]]][2'b11] = RAM[{Address[8:4], 2'b11}];
					//reresh Info
					Info[Address[8:7]][~last[Address[8:7]]][2:0] = Address[6:4];
					Dirty[Address[8:7]][~last[Address[8:7]]][1:0] = 2'b10; //10 means it has been read but not modified;
					ReadData = CACHE[Address[8:7]][~last[Address[8:7]]][Address[3:2]];
					last[Address[8:7]] = ~last[Address[8:7]];//record new last
				end
			end
			// hit in line 0
			else if(Info[Address[8:7]][0][2:0] == Address[6:4])
			begin
				hit = 2'b01;
//				lineNum[Address[8:7]] = 1'b0;
				Dirty[Address[8:7]][0][1] = 1'b1;
				ReadData = CACHE[Address[8:7]][0][Address[3:2]];
			end
			// hit in line 1
			else if(Info[Address[8:7]][1][2:0] == Address[6:4])
			begin 
				hit = 2'b01;
//				lineNum[Address[8:7]] = 1'b1;
				Dirty[Address[8:7]][1][1] = 1'b1;
				ReadData =  CACHE[Address[8:7]][1][Address[3:2]];
			end
		end
		else if (WriteEnable)
		begin
			//not hit
			if(Info[Address[8:7]][0][2:0] != Address[6:4] & Info[Address[8:7]][1][2:0] != Address[6:4])
			begin
				hit = 2'b00;
				//if Dirty[line1] < Dirty[line0], replace line 1
				if(Dirty[Address[8:7]][1][1:0] < Dirty[Address[8:7]][0][1:0])
				begin
					// have been modified, write back to Memory
					if(Dirty[Address[8:7]][1][0] == 1'b1)
					begin
						RAM[{Address[8:7], Info[Address[8:7]][1], 2'b00}] = CACHE[Address[8:7]][1][2'b00];
						RAM[{Address[8:7], Info[Address[8:7]][1], 2'b01}] = CACHE[Address[8:7]][1][2'b01];
						RAM[{Address[8:7], Info[Address[8:7]][1], 2'b10}] = CACHE[Address[8:7]][1][2'b10];
						RAM[{Address[8:7], Info[Address[8:7]][1], 2'b11}] = CACHE[Address[8:7]][1][2'b11];
					end
					// load from memory
					CACHE[Address[8:7]][1][2'b00] = RAM[{Address[8:4], 2'b00}];
					CACHE[Address[8:7]][1][2'b01] = RAM[{Address[8:4], 2'b01}];
					CACHE[Address[8:7]][1][2'b10] = RAM[{Address[8:4], 2'b10}];
					CACHE[Address[8:7]][1][2'b11] = RAM[{Address[8:4], 2'b11}];
					//reresh Info
					Info[Address[8:7]][1][2:0] = Address[6:4];
					// modify cache
					CACHE[Address[8:7]][1][Address[3:2]] = WriteData;
					Dirty[Address[8:7]][1][1:0] = 2'b01;
				end 
				//if Dirty[line0] < Dirty[line1], replace line 0;
				else if(Dirty[Address[8:7]][0][1:0] < Dirty[Address[8:7]][1][1:0]) // replace line 0
				begin
					// have been modified, write back to Memory first;
					if(Dirty[Address[8:7]][0][0] == 1'b1)
					begin
						RAM[{Address[8:7], Info[Address[8:7]][0][2:0], 2'b00}] = CACHE[Address[8:7]][0][2'b00];
						RAM[{Address[8:7], Info[Address[8:7]][0][2:0], 2'b01}] = CACHE[Address[8:7]][0][2'b01];
						RAM[{Address[8:7], Info[Address[8:7]][0][2:0], 2'b10}] = CACHE[Address[8:7]][0][2'b10];
						RAM[{Address[8:7], Info[Address[8:7]][0][2:0], 2'b11}] = CACHE[Address[8:7]][0][2'b11];
					end
					// load from memory
					CACHE[Address[8:7]][0][2'b00] = RAM[{Address[8:4], 2'b00}];
					CACHE[Address[8:7]][0][2'b01] = RAM[{Address[8:4], 2'b01}];
					CACHE[Address[8:7]][0][2'b10] = RAM[{Address[8:4], 2'b10}];
					CACHE[Address[8:7]][0][2'b11] = RAM[{Address[8:4], 2'b11}];
					//reresh Info
					Info[Address[8:7]][0][2:0] = Address[6:4];
					// modify cache
					CACHE[Address[8:7]][0][Address[3:2]] = WriteData;
					Dirty[Address[8:7]][0][1:0] = 2'b01;
				end 
				//// if Dirty[line0] == Dirty[line1], check last replaced line, if last = 1, replace 0;
				else if(Dirty[Address[8:7]][0][1:0] == Dirty[Address[8:7]][1][1:0])
				begin
					// have been modified, write back to Memory first;
					if(Dirty[Address[8:7]][~last[Address[8:7]]][0] == 1'b1)
					begin
						RAM[{Address[8:7], Info[Address[8:7]][~last[Address[8:7]]][2:0], 2'b00}] = CACHE[Address[8:7]][~last[Address[8:7]]][2'b00];
						RAM[{Address[8:7], Info[Address[8:7]][~last[Address[8:7]]][2:0], 2'b01}] = CACHE[Address[8:7]][~last[Address[8:7]]][2'b01];
						RAM[{Address[8:7], Info[Address[8:7]][~last[Address[8:7]]][2:0], 2'b10}] = CACHE[Address[8:7]][~last[Address[8:7]]][2'b10];
						RAM[{Address[8:7], Info[Address[8:7]][~last[Address[8:7]]][2:0], 2'b11}] = CACHE[Address[8:7]][~last[Address[8:7]]][2'b11];
					end
					// load from memory
					CACHE[Address[8:7]][~last[Address[8:7]]][2'b00] = RAM[{Address[8:4], 2'b00}];
					CACHE[Address[8:7]][~last[Address[8:7]]][2'b01] = RAM[{Address[8:4], 2'b01}];
					CACHE[Address[8:7]][~last[Address[8:7]]][2'b10] = RAM[{Address[8:4], 2'b10}];
					CACHE[Address[8:7]][~last[Address[8:7]]][2'b11] = RAM[{Address[8:4], 2'b11}];
					//reresh Info
					Info[Address[8:7]][~last[Address[8:7]]][2:0] = Address[6:4];
					// modify cache
					CACHE[Address[8:7]][~last[Address[8:7]]][Address[3:2]] = WriteData;
					Dirty[Address[8:7]][~last[Address[8:7]]][1:0] = 2'b01;
					last[Address[8:7]] = ~last[Address[8:7]];
				end 
			end
			// hit in line 0
			else if(Info[Address[8:7]][0][2:0] == Address[6:4])
			begin
				hit = 2'b01;
				//modify cache and refresh Dirty
				CACHE[Address[8:7]][0][Address[3:2]] = WriteData;
				Dirty[Address[8:7]][0][0] = 1'b1;
			end
			// hit in line 1
			else if(Info[Address[8:7]][1][2:0] == Address[6:4])
			begin
				hit = 2'b01;
				//modify cache and refresh Dirty
				CACHE[Address[8:7]][1][Address[3:2]] = WriteData;
				Dirty[Address[8:7]][1][0] = 1'b1;
			end
		end
		else
		begin
			hit = 2'b11;
//			lineNum[Address[8:7]] = 1'b0;
		end
	end
//	always @(*)
//	begin
//		if (~hit[0])
//		begin
//			#100 hit = 2'b11;
//		end
//	end
//	assign hitInfo = hit[1:0];
//	assign ReadData = Info[Address[8:7]][0][2:0] == Address[6:4] ? CACHE[Address[8:7]][0][Address[3:2]] : CACHE[Address[8:7]][1][Address[3:2]];
	assign MemContent = RAM[MemToShow[5:0]];
	assign CacheContent = CACHE[CacheToShow[4:3]][CacheToShow[2]][CacheToShow[1:0]];
endmodule
