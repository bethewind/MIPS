`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/19 09:53:50
// Design Name: 
// Module Name: mux2_test
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


module mux2_test();
	reg [7:0] d0, d1;
	reg s;
	wire [7:0] y;
	
	mux2 myMux(d0, d1, s, y);
	
	initial
	begin
		d0 = 8'b01010101;
		d1 = 8'b10101010;
		s = 0;
	end
	always 
		#5 s = ~s;
	
endmodule
