`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/11 16:18:44
// Design Name: 
// Module Name: maindec_test
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


module maindec_test();
	reg [5:0] op;
	wire Mem2Reg, MemWrite;
	wire Branch, ALUSrc;
	wire RegDst, RegWrite, Jump;
	wire [2:0] ALUOp;
	
	// instance
	maindec MUT(op, Mem2Reg, MemWrite,
				Branch, ALUSrc, RegDst,
				RegWrite, Jump, ALUOp);
	initial begin
		op = 0;
		#20 op = 6'b000000;
		#20 op = 6'b100011;
		#20 op = 6'b101011;
		#20 op = 6'b000100;
		#20 op = 6'b001000;
		#20 op = 6'b000010;
		#20 op = 6'b011110;
		end
		
	
endmodule
