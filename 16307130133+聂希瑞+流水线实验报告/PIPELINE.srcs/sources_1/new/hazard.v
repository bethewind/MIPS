`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/20 17:31:23
// Design Name: 
// Module Name: hazard
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


module hazard(rsD, rtD, rsE, rtE, WriteRegE, WriteRegM, WriteRegW, 
			  RegWriteE, RegWriteM, RegWriteW, Mem2RegE, Mem2RegM,
			  BranchD, BranchNED, ForwardAD, ForwardBD,
			  ForwardAE, ForwardBE, StallF, StallD, flushE, RegPCD);
	input [4:0] rsD, rtD, rsE, rtE;
	input [4:0] WriteRegE, WriteRegM, WriteRegW;
	input RegWriteE, RegWriteM, RegWriteW;
	input Mem2RegE, Mem2RegM, BranchD, BranchNED;
	output ForwardAD, ForwardBD;
	output reg [1:0] ForwardAE, ForwardBE;
	output StallF, StallD, flushE;
	input RegPCD;
	
	wire LWStallD, BranchStallD;
	
	
	assign ForwardAD = (rsD != 0 & rsD == WriteRegM & RegWriteM);
	assign ForwardBD = (rtD != 0 & rtD == WriteRegM & RegWriteM);
	 // forward sources to Execute
	 always @(*)
	 	begin
	 		ForwardAE = 2'b00;
	 		ForwardBE = 2'b00;
	 		if (rsE != 0)
	 			if (rsE == WriteRegM & RegWriteM)
	 				ForwardAE = 2'b10;
	 			else if (rsE == WriteRegW & RegWriteW)
	 				ForwardAE = 2'b01;
	 		if (rsE != 0)
	 			if (rtE == WriteRegM & RegWriteM)
					ForwardBE = 2'b10;
				else if (rtE == WriteRegW & RegWriteW)
					ForwardBE = 2'b01;
		end
		
	//Stall
	assign LWStallD =  Mem2RegE & (rtE == rsD | rtE == rtD);
	assign BranchStallD = (BranchD | BranchNED | RegPCD) & (RegWriteE & (WriteRegE == rsD | WriteRegE == rtD) |
							(BranchD | BranchNED | RegPCD) & Mem2RegM & (WriteRegM == rsD | WriteRegM == rtD));
	assign StallD = LWStallD | BranchStallD;
	assign StallF = StallD;
	
	// StallD stalls all previous stages
	assign flushE = StallD;

endmodule
