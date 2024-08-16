module CLA_4bit (
    input [3:0] A, B,   // 4-bit inputs
    input C0,           // Carry input
    output [3:0] Sum,   // 4-bit sum output
    output C4           // Carry output
);

wire [3:0] G, P;
wire C1, C2, C3;

// Generate and Propagate signals
assign G = A & B;
assign P = A ^ B;

// Carry signals
assign C1 = G[0] | (P[0] & C0);
assign C2 = G[1] | (P[1] & C1);
assign C3 = G[2] | (P[2] & C2);
assign C4 = G[3] | (P[3] & C3);

// Sum calculation
assign Sum = P ^ {C3, C2, C1, C0};

endmodule

module testbench;
    reg [3:0] A, B;
    reg C0;
    wire [3:0] Sum;
    wire C4;

    // Instantiate the CLA_4bit module
    CLA_4bit uut (
        .A(A),
        .B(B),
        .C0(C0),
        .Sum(Sum),
        .C4(C4)
    );

    initial begin
        // Test cases
        $monitor("A = %b, B = %b, C0 = %b -> Sum = %b, C4 = %b", A, B, C0, Sum, C4);

        A = 4'b0001; B = 4'b0010; C0 = 1'b0; #10;
        A = 4'b0101; B = 4'b0110; C0 = 1'b1; #10;
        A = 4'b1100; B = 4'b1010; C0 = 1'b0; #10;
        A = 4'b1111; B = 4'b1111; C0 = 1'b1; #10;

        $finish;
    end
endmodule