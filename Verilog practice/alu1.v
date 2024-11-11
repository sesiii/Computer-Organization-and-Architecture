module full_adder(input a, b, cin, output cout, sum);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule

module and_gate(input a, b, output c);
    assign c = a & b;
endmodule

module or_gate(input a, b, output c);
    assign c = a | b;
endmodule   

module xor_gate(input a, b, output c);
    assign c = a ^ b;
endmodule

module nor_gate(input a, b, output c);
    assign c = ~(a | b);
endmodule

module not_gate(input a, output c);
    assign c = ~a;
endmodule

module alu(input [3:0] a, b, input cin, input [2:0] sel, output reg [3:0] out, output reg cout);
    wire sum[3:0];        // To hold the sum from full adders
    wire add_cout;        // Carry out from the last full adder
    wire and_out;         // AND output
    wire or_out;          // OR output
    wire xor_out;         // XOR output
    wire not_a;           // NOT a output
    wire nor_out;         // NOR output

    // Instantiate Full Adders for 4-bit addition
    full_adder uut0(.a(a[0]), .b(b[0]), .cin(cin), .cout(add_cout), .sum(sum[0]));
    full_adder uut1(.a(a[1]), .b(b[1]), .cin(add_cout), .cout(), .sum(sum[1])); // no cout needed
    full_adder uut2(.a(a[2]), .b(b[2]), .cin(add_cout), .cout(), .sum(sum[2])); // no cout needed
    full_adder uut3(.a(a[3]), .b(b[3]), .cin(add_cout), .cout(), .sum(sum[3])); // no cout needed

    and_gate uut4(.a(a[0]), .b(b[0]), .c(and_out));
    or_gate uut5(.a(a[0]), .b(b[0]), .c(or_out));
    xor_gate uut6(.a(a[0]), .b(b[0]), .c(xor_out));
    nor_gate uut7(.a(a[0]), .b(b[0]), .c(nor_out));
    not_gate uut8(.a(a[0]), .c(not_a));

    always @(*) begin
        case(sel)
            3'b000: begin // Addition
                out = {sum[3], sum[2], sum[1], sum[0]};
                cout = add_cout;
            end
            3'b001: begin // Subtraction (not implemented directly)
                out = 4'b0000; // Placeholder for subtraction
                cout = 1'b0;
            end
            3'b010: begin // OR operation
                out = {3'b000, or_out};
                cout = 1'b0;
            end
            3'b011: begin // AND operation
                out = {3'b000, and_out};
                cout = 1'b0;
            end
            3'b100: begin // XOR operation
                out = {3'b000, xor_out};
                cout = 1'b0;
            end
            3'b101: begin // NOR operation
                out = {3'b000, nor_out};
                cout = 1'b0;
            end
            3'b110: begin // NOT operation
                out = {3'b000, not_a};
                cout = 1'b0;
            end
            default: begin
                out = 4'b0000; // Default output
                cout = 1'b0;
            end
        endcase
    end
endmodule