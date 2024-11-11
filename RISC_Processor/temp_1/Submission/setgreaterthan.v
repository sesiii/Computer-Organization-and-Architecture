module set_greater_than_32bit(
    input [31:0] A,
    input [31:0] B,
    output [31:0] Result
);
    assign Result = (A > B) ? 32'b1 : 32'b0;
endmodule