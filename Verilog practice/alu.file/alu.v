module alu(
    input [3:0] a, b,
    input [2:0] sel,
    input cin,
    output reg [3:0] result,
    output reg cout
);
    wire [3:0] sum, and_out, or_out, xor_out, nor_out, not_out, shift_out;
    wire add_cout;

    // Instantiate the functional modules
    full_adder add_inst(.a(a), .b(b), .cin(cin), .sum(sum), .cout(add_cout));
    and_gate and_inst(.a(a), .b(b), .result(and_out));
    or_gate or_inst(.a(a), .b(b), .result(or_out));
    xor_gate xor_inst(.a(a), .b(b), .result(xor_out));
    nor_gate nor_inst(.a(a), .b(b), .result(nor_out));
    not_gate not_inst(.a(a), .result(not_out));
    shift_left shift_inst(.a(a), .result(shift_out));

    // Select the operation based on `sel`
    always @(*) begin
        case (sel)
            3'b000: begin
                result = sum;
                cout = add_cout;
            end
            3'b001: result = and_out;
            3'b010: result = or_out;
            3'b011: result = xor_out;
            3'b100: result = nor_out;
            3'b101: result = not_out;
            3'b110: result = shift_out;
            default: result = 4'b0000;
        endcase
        // Clear carry output for non-addition operations
        if (sel != 3'b000)
            cout = 1'b0;
    end
endmodule