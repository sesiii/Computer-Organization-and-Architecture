module load_upper_immediate_32bit(
    input [31:0] B,
    output [31:0] Result
);
    assign Result = {B[15:0], 16'b0};
endmodule