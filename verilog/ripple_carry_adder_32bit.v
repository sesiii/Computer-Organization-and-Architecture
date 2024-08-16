`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:36:32 08/14/2024 
// Design Name: 
// Module Name:    ripple_carry_adder_32bit 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ripple_carry_adder_32bit(
    input [31:0] a,
    input [31:0] b,
    input cin,
    output [31:0] sum,
    output cout
    );
	 
	 wire [31:0] carry;
	 
	 genvar i;
	 generate
		for(i = 0; i < 32; i = i + 1) begin : adder_loop
			if(i == 0) begin
				// First full adder
				full_adder FA(
					.a(a[i]),
					.b(b[i]),
					.cin(cin),
					.sum(sum[i]),
					.cout(carry[i])
				);
			end else begin
				// Subsequent full adders
				full_adder FA(
					.a(a[i]),
					.b(b[i]),
					.cin(carry[i-1]),
					.sum(sum[i]),
					.cout(carry[i])
				);
			end
		end
	 endgenerate

	// Final carry-out
	assign cout = carry[31];

endmodule
