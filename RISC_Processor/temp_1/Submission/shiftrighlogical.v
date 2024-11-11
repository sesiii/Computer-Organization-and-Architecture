module shift_right_logical_32bit(
    input [31:0] A,
    output [31:0] Result
);
    assign Result = A >> 1;
endmodule