module shift_left(input [3:0] a, input [1:0] b, output [3:0] result);
    assign result = a << b; // Shift left 'a' by 'b' positions, new bits are filled with zeros
endmodule