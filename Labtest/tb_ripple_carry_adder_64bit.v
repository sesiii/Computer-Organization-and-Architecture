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
// Module Name:    ripple_carry_adder_64bit 
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

module ripple_carry_adder_64bit (
    input [63:0] A,
    input [63:0] B,
    input Cin,
    output [63:0] Sum,
    output Cout
);

    
    wire [63:0] carry;

    
    genvar i;
    generate
        for (i = 0; i < 64; i = i + 1) begin : adder_loop
            if (i == 0) begin
                // First 
                full_adder FA (
                    .A(A[i]),
                    .B(B[i]),
                    .Cin(Cin),
                    .Sum(Sum[i]),
                    .Cout(carry[i])
                );
            end else begin
                // Subsequent 
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

    
    assign Cout = carry[15];

endmodule
`timescale 1ns / 1ps

module tb_ripple_carry_adder_664bit;

    
    reg [63:0] A;
    reg [63:0] B;
    reg Cin;

    
    wire [63:0] Sum;
    wire Cout;

    
    ripple_carry_adder_64bit uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    
    initial begin
        
        $monitor("Time = %0t: A = %h, B = %h, Cin = %b | Sum = %h, Cout = %b", 
                  $time, A, B, Cin, Sum, Cout);

        
        A = 16'h0000; B = 16'h0000; Cin = 0;
        #10;

        
        A = 16'h0001; B = 16'h0001; Cin = 0;
        #10;

        
        A = 16'h0002; B = 16'h0001; Cin = 0;
        #10;

        
        $finish;
    end

endmodule