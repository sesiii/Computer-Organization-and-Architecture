`timescale 1ns / 1ps


module CLA_4bit (
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] sum,
    output cout,
    output P,  
    output G   
);

    wire [3:0] p, g;  
    wire [3:0] c;    

    
    full_adder fa0 (.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(c[0]));
    full_adder fa1 (.a(a[1]), .b(b[1]), .cin(c[0]), .sum(sum[1]), .cout(c[1]));
    full_adder fa2 (.a(a[2]), .b(b[2]), .cin(c[1]), .sum(sum[2]), .cout(c[2]));
    full_adder fa3 (.a(a[3]), .b(b[3]), .cin(c[2]), .sum(sum[3]), .cout(cout));

    
    assign p = a ^ b;
    assign g = a & b;
    assign P = &p;
    assign G = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);

endmodule


module full_adder (
    input a, b, cin,
    output sum, cout
);

    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (cin & a);

endmodule


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

module tb_compare;

    reg [15:0] a, b;
    reg cin;
    wire [15:0] sum_RCA, sum_CLA;
    wire cout_RCA, cout_CLA;
    
    
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
        
        a = 16'h0000; b = 16'h0000; cin = 0;

        #10;
        $display("Time: %t | RCA Sum: %h | CLA Sum: %h | RCA Cout: %b | CLA Cout: %b", $time, sum_RCA, sum_CLA, cout_RCA, cout_CLA);

        a = 16'h1234; b = 16'h5678; cin = 0;

        // Measure delay for RCA
        #10;
        $display("Time: %t | RCA Sum: %h | CLA Sum: %h | RCA Cout: %b | CLA Cout: %b", $time, sum_RCA, sum_CLA, cout_RCA, cout_CLA);

        // Measure delay for CLA
        a = 16'hFFFF; b = 16'hFFFF; cin = 0;
        #10;
        $display("Time: %t | RCA Sum: %h | CLA Sum: %h | RCA Cout: %b | CLA Cout: %b", $time, sum_RCA, sum_CLA, cout_RCA, cout_CLA);

        a = 16'h1234; b = 16'h5678; cin = 1;
        #10;
        $display("Time: %t | RCA Sum: %h | CLA Sum: %h | RCA Cout: %b | CLA Cout: %b", $time, sum_RCA, sum_CLA, cout_RCA, cout_CLA);


        #20 $finish;
    end

endmodule