`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/19 10:19:34
// Design Name: 
// Module Name: signExtend_test
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


module signExtend_test();
	reg exp;
	reg [15:0] a;
	wire [31:0]b;
	
	signExtend mySE(exp, a, b);
	
	initial
	begin
		exp = 0;
		a = 16'hffff;
	end
	always
		#5 exp = ~exp;

endmodule
