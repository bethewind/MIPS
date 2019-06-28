`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2019 01:40:29 PM
// Design Name: 
// Module Name: CLKDiv
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


module CLKDiv(MCLK, CLK190, CLK48, CLK1_4HZ);
	input MCLK;
    // input clr,
	output CLK190;
	output CLK48;
	output CLK1_4HZ;
	
	reg [27:0]q;
	initial
		q <= 0;
	always@(posedge MCLK)
		 q <= q+1;
	assign CLK190 = q[16];//0.005s
	assign CLK48 = q[20];//0.02s
	assign CLK1_4HZ = q[26];//0.33s      
    
endmodule