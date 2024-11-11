module xor_32bit(
    input [31:0] A,
    input [31:0] B,
    output [31:0] Result
);
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : xor_gates
            xor_gate xor_inst (.A(A[i]), .B(B[i]), .Y(Result[i]));
        end
    endgenerate
endmodule