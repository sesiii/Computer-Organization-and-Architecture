module decrement_32bit(
    input [31:0] A,
    output [31:0] Result
);
    assign Result = A - 4;
endmodule