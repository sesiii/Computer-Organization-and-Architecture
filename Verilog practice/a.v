module and_gate(input wire a,b, output wire v);
    assign v=a&b;
endmodule

module or_gate(input wire a,b, output wire v);
    assign v=a|b;
endmodule

module not_gate(input wire a, output wire v);
    assign v=~a;
endmodule

module xor_gate(input wire a,b, output wire v);
    assign v=a^b;
endmodule

module nand_gate(input wire a,b, output wire v);
    assign v=~(a&b);
endmodule

module nor_gate(input wire a,b, output wire v);
    assign v=~(a|b);
endmodule

