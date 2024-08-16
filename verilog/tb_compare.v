`timescale 1ns / 1ps

module RCA_16bit (
    input [15:0] a,
    input [15:0] b,
    input cin,
    output [15:0] sum,
    output cout
);

    wire [15:0] carry;
    
    
    full_adder fa0 (.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(carry[0]));
    full_adder fa1 (.a(a[1]), .b(b[1]), .cin(carry[0]), .sum(sum[1]), .cout(carry[1]));
    full_adder fa2 (.a(a[2]), .b(b[2]), .cin(carry[1]), .sum(sum[2]), .cout(carry[2]));
    full_adder fa3 (.a(a[3]), .b(b[3]), .cin(carry[2]), .sum(sum[3]), .cout(carry[3]));
    full_adder fa4 (.a(a[4]), .b(b[4]), .cin(carry[3]), .sum(sum[4]), .cout(carry[4]));
    full_adder fa5 (.a(a[5]), .b(b[5]), .cin(carry[4]), .sum(sum[5]), .cout(carry[5]));
    full_adder fa6 (.a(a[6]), .b(b[6]), .cin(carry[5]), .sum(sum[6]), .cout(carry[6]));
    full_adder fa7 (.a(a[7]), .b(b[7]), .cin(carry[6]), .sum(sum[7]), .cout(carry[7]));
    full_adder fa8 (.a(a[8]), .b(b[8]), .cin(carry[7]), .sum(sum[8]), .cout(carry[8]));
    full_adder fa9 (.a(a[9]), .b(b[9]), .cin(carry[8]), .sum(sum[9]), .cout(carry[9]));
    full_adder fa10 (.a(a[10]), .b(b[10]), .cin(carry[9]), .sum(sum[10]), .cout(carry[10]));
    full_adder fa11 (.a(a[11]), .b(b[11]), .cin(carry[10]), .sum(sum[11]), .cout(carry[11]));
    full_adder fa12 (.a(a[12]), .b(b[12]), .cin(carry[11]), .sum(sum[12]), .cout(carry[12]));
    full_adder fa13 (.a(a[13]), .b(b[13]), .cin(carry[12]), .sum(sum[13]), .cout(carry[13]));
    full_adder fa14 (.a(a[14]), .b(b[14]), .cin(carry[13]), .sum(sum[14]), .cout(carry[14]));
    full_adder fa15 (.a(a[15]), .b(b[15]), .cin(carry[14]), .sum(sum[15]), .cout(cout));

endmodule
`timescale 1ns / 1ps

module CLA_16bit (
    input [15:0] a,
    input [15:0] b,
    input cin,
    output [15:0] sum,
    output cout
);

    wire [3:0] carry;
    wire [3:0] P;
    wire [3:0] G;

    // Instantiate 4-bit CLA 
    CLA_4bit cla0 (
        .a(a[3:0]),
        .b(b[3:0]),
        .cin(cin),
        .sum(sum[3:0]),
        .cout(carry[0]),
        .P(P[0]),
        .G(G[0])
    );

    CLA_4bit cla1 (
        .a(a[7:4]),
        .b(b[7:4]),
        .cin(carry[0]),
        .sum(sum[7:4]),
        .cout(carry[1]),
        .P(P[1]),
        .G(G[1])
    );

    CLA_4bit cla2 (
        .a(a[11:8]),
        .b(b[11:8]),
        .cin(carry[1]),
        .sum(sum[11:8]),
        .cout(carry[2]),
        .P(P[2]),
        .G(G[2])
    );

    CLA_4bit cla3 (
        .a(a[15:12]),
        .b(b[15:12]),
        .cin(carry[2]),
        .sum(sum[15:12]),
        .cout(cout),
        .P(P[3]),
        .G(G[3])
    );

   
    wire P_block;
    wire G_block;
    
    assign P_block = &P;
    assign G_block = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);

endmodule
module CLA_4bit (
    input [3:0] A, B,   
    input C0,           
    output [3:0] Sum,   
    output C4           
);

wire [3:0] G, P;
wire C1, C2, C3;


assign G = A & B;
assign P = A ^ B;


assign C1 = G[0] | (P[0] & C0);
assign C2 = G[1] | (P[1] & C1);
assign C3 = G[2] | (P[2] & C2);
assign C4 = G[3] | (P[3] & C3);


assign Sum = P ^ {C3, C2, C1, C0};

endmodule
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

module tb_compare;

    reg [15:0] a, b;
    reg cin;
    wire [15:0] sum_RCA, sum_CLA;
    wire cout_RCA, cout_CLA;
    
    // Instantiate the RCA and CLA
    RCA_16bit rca (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum_RCA),
        .cout(cout_RCA)
    );

    CLA_16bit cla (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum_CLA),
        .cout(cout_CLA)
    );

    initial begin
        // Apply test vectors and measure delays
        $display("Time\tRCA Sum\t\t\tCLA Sum\t\t\tRCA Cout\tCLA Cout");

        a = 16'h0000; b = 16'h0000; cin = 0;
        #10 $display("%t\t%h\t%h\t%b\t%b", $time, sum_RCA, sum_CLA, cout_RCA, cout_CLA);

        a = 16'h1234; b = 16'h5678; cin = 0;
        #10 $display("%t\t%h\t%h\t%b\t%b", $time, sum_RCA, sum_CLA, cout_RCA, cout_CLA);

        a = 16'hFFFF; b = 16'hFFFF; cin = 0;
        #10 $display("%t\t%h\t%h\t%b\t%b", $time, sum_RCA, sum_CLA, cout_RCA, cout_CLA);

        a = 16'h1234; b = 16'h5678; cin = 1;
        #10 $display("%t\t%h\t%h\t%b\t%b", $time, sum_RCA, sum_CLA, cout_RCA, cout_CLA);

        #20 $finish;
    end

endmodule