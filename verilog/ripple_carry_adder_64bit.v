`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:47:31 08/14/2024 
// Design Name: 
// Module Name:    full_adder 
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

module full_adder (
    input wire A,
    input wire B,
    input wire Cin,
    output wire Sum,
    output wire Cout
);

    wire sum_ab;
    wire carry_ab;
    wire carry_acin;
    
    
    assign sum_ab = A ^ B;
    
    assign Sum = sum_ab ^ Cin;
   
    assign carry_ab = A & B;
    assign carry_acin = sum_ab & Cin;
    assign Cout = carry_ab | carry_acin;

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:36:32 08/14/2024 
// Design Name: 
// Module Name:    ripple_carry_adder_64bit 
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
module ripple_carry_adder_64bit(
    input [63:0] a,
    input [63:0] b,
    input cin,
    output [63:0] sum,
    output cout
    );
	 
	 wire [63:0] carry;
	 
	 genvar i;
	 generate
		for(i = 0; i < 64; i = i + 1) begin : adder_loop
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
	assign cout = carry[63];

endmodule