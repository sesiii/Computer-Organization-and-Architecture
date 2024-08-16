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