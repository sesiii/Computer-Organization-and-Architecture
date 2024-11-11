module shift_right_arithmetic_32bit(
    input [31:0] A,
    output [31:0] Result
);
    assign Result = $signed(A) >>> 1;
endmodule