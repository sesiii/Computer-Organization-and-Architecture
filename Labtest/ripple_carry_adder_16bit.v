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
// Create Date:    14:415:31 08/14/2024 
// Design Name: 
// Module Name:    ripple_carry_adder_16bit 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//   8-bit Ripple Carry Adder implementation using full adders.
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module ripple_carry_adder_16bit (
    input [15:0] A,
    input [15:0] B,
    input Cin,
    output [15:0] Sum,
    output Cout
);

    // Internal carry signals
    wire [15:0] carry;

    // Generate 8 full adders
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : adder_loop
            if (i == 0) begin
                // First full adder
                full_adder FA (
                    .A(A[i]),
                    .B(B[i]),
                    .Cin(Cin),
                    .Sum(Sum[i]),
                    .Cout(carry[i])
                );
            end else begin
                // Subsequent full adders
                full_adder FA (
                    .A(A[i]),
                    .B(B[i]),
                    .Cin(carry[i-1]),
                    .Sum(Sum[i]),
                    .Cout(carry[i])
                );
            end
        end
    endgenerate

    // Final carry-out
    assign Cout = carry[15];

endmodule
