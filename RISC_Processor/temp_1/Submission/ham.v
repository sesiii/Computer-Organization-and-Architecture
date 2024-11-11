module ham_32bit(
    input [31:0] A,
    output [5:0] H
);
    // Level 1: 16 2-bit sums
    wire [15:0] sum_l1;
    wire [15:0] cout_l1;

    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : level1
            FullAdder fa_l1 (
                .A(A[2*i]), 
                .B(A[2*i+1]), 
                .Cin(1'b0), 
                .Sum(sum_l1[i]), 
                .Cout(cout_l1[i])
            );
        end
    endgenerate

    // Level 2: 8 3-bit sums
    wire [7:0] sum_l2;
    wire [7:0] cout_l2;

    generate
        for (i = 0; i < 8; i = i + 1) begin : level2
            FullAdder fa_l2_0 (
                .A(sum_l1[2*i]), 
                .B(sum_l1[2*i+1]), 
                .Cin(cout_l1[2*i]), 
                .Sum(sum_l2[i]), 
                .Cout(cout_l2[i])
            );
        end
    endgenerate

    // Level 3: 4 4-bit sums
    wire [3:0] sum_l3;
    wire [3:0] cout_l3;

    generate
        for (i = 0; i < 4; i = i + 1) begin : level3
            FullAdder fa_l3_0 (
                .A(sum_l2[2*i]), 
                .B(sum_l2[2*i+1]), 
                .Cin(cout_l2[2*i]), 
                .Sum(sum_l3[i]), 
                .Cout(cout_l3[i])
            );
        end
    endgenerate

    // Level 4: 2 5-bit sums
    wire [1:0] sum_l4;
    wire [1:0] cout_l4;

    generate
        for (i = 0; i < 2; i = i + 1) begin : level4
            FullAdder fa_l4_0 (
                .A(sum_l3[2*i]), 
                .B(sum_l3[2*i+1]), 
                .Cin(cout_l3[2*i]), 
                .Sum(sum_l4[i]), 
                .Cout(cout_l4[i])
            );
        end
    endgenerate

    // Final level: 6-bit Sum
    wire sum_final;
    wire cout_final;

   FullAdder fa_final_0 (
        .A(sum_l4[0]), 
        .B(sum_l4[1]), 
        .Cin(cout_l4[0]), 
        .Sum(sum_final), 
        .Cout(cout_final)
    );

    assign H = {cout_final, sum_final, cout_l4[1], sum_l3[3], sum_l2[7], sum_l1[15]};

endmodule