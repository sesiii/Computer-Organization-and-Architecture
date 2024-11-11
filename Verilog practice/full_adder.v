module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

    assign sum = a ^ b ^ cin;        // Sum is the XOR of a, b, and carry-in
    assign cout = (a & b) | (b & cin) | (a & cin); // Carry-out logic

endmodule