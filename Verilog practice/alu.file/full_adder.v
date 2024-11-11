module full_adder(
    input [3:0] a, b,
    input cin,
    output [3:0] sum,
    output cout
);
    wire [3:0] carry;

    // Calculate each bit's sum and carry
    assign sum[0] = a[0] ^ b[0] ^ cin;
    assign carry[0] = (a[0] & b[0]) | (b[0] & cin) | (cin & a[0]);

    assign sum[1] = a[1] ^ b[1] ^ carry[0];
    assign carry[1] = (a[1] & b[1]) | (b[1] & carry[0]) | (carry[0] & a[1]);

    assign sum[2] = a[2] ^ b[2] ^ carry[1];
    assign carry[2] = (a[2] & b[2]) | (b[2] & carry[1]) | (carry[1] & a[2]);

    assign sum[3] = a[3] ^ b[3] ^ carry[2];
    assign cout = (a[3] & b[3]) | (b[3] & carry[2]) | (carry[2] & a[3]);
endmodule