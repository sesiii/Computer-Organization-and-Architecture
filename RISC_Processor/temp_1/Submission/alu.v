module alu(
    input [31:0] A,
    input [31:0] B,
    input [3:0] opcode,
    output reg [31:0] result
);
    wire [31:0] add_result, sub_result, and_result, or_result, xor_result, nor_result, not_result;
    wire [31:0] shift_left_result, shift_right_logical_result, shift_right_arithmetic_result;
    wire [31:0] increment_result, decrement_result, set_less_than_result, set_greater_than_result;
    wire [31:0] load_upper_immediate_result;
    wire [31:0] ham_result;

    add_32bit add_inst(A, B, add_result);
    sub_32bit sub_inst(A, B, sub_result);
    and_32bit and_inst(A, B, and_result);
    or_32bit or_inst(A, B, or_result);
    xor_32bit xor_inst(A, B, xor_result);
    nor_32bit nor_inst(A, B, nor_result);
    not_32bit not_inst(A, not_result);
    shift_left_32bit shift_left_inst(A, shift_left_result);
    shift_right_logical_32bit shift_right_logical_inst(A, shift_right_logical_result);
    shift_right_arithmetic_32bit shift_right_arithmetic_inst(A, shift_right_arithmetic_result);
    increment_32bit increment_inst(A, increment_result);
    decrement_32bit decrement_inst(A, decrement_result);
    set_less_than_32bit set_less_than_inst(A, B, set_less_than_result);
    set_greater_than_32bit set_greater_than_inst(A, B, set_greater_than_result);
    load_upper_immediate_32bit load_upper_immediate_inst(B, load_upper_immediate_result);
    ham ham_inst(A, ham_result);
    always @(*) begin
        case (opcode)
            4'b0000: result = add_result; // ADD
            4'b0001: result = sub_result; // SUB
            4'b0010: result = and_result; // AND
            4'b0011: result = or_result; // OR
            4'b0100: result = xor_result; // XOR
            4'b0101: result = nor_result; // NOR
            4'b0110: result = not_result; // NOT
            4'b0111: result = shift_left_result; // Shift Left
            4'b1000: result = shift_right_logical_result; // Shift Right Logical
            4'b1001: result = shift_right_arithmetic_result; // Shift Right Arithmetic
            4'b1010: result = increment_result; // Increment
            4'b1011: result = decrement_result; // Decrement
            4'b1100: result = set_less_than_result; // Set Less Than
            4'b1101: result = set_greater_than_result; // Set Greater Than
            4'b1110: result = load_upper_immediate_result; // Load Upper Immediate
            4'b1111: result = ham_result; // Hamming Distance
        endcase
    end
endmodule