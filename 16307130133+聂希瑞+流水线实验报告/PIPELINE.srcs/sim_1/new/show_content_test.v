`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/26 20:12:54
// Design Name: 
// Module Name: show_content_test
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


module show_content_test();
	reg CLK;
	reg [31:0] Content;
	wire [7:0] AN;
	wire [6:0] C;
	
	ShowContent myShow(CLK, Content[31:0], AN[87:0], C[6:0]);
	initial
	begin
		CLK = 1;
		#5 Content=32'h11111111;
		#5 Content=32'h22222222;
		#5 Content=32'h33333333;
		#5 Content=32'h44444444;
		#5 Content=32'h55555555;
		#5 Content=32'h66666666;
		#5 Content=32'h77777777;
		#5 Content=32'h88888888;
	end
endmodule
