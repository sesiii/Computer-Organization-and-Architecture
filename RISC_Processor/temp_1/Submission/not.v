module not_32bit(
    input [31:0] A,
    output [31:0] Result
);
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : not_gates
            not_gate not_inst (.A(A[i]), .Y(Result[i]));
        end
    endgenerate
endmodule