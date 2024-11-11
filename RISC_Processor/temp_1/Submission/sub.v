module sub_32bit(
    input [31:0] A,
    input [31:0] B,
    output [31:0] Result
);
    wire [31:0] b_temp;
    assign b_temp = ~B + 1;
    assign Result = A + b_temp;
endmodule