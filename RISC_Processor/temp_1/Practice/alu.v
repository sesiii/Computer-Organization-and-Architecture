module alu(
    input [31:0] A,
    input [31:0] B,
    input [3:0] opcode,
    output reg [31:0] result
);
    always @(*) begin
        case (opcode)
            4'b0000: result = A + B; // ADD
            4'b0001: result = A - B; // SUB
            4'b0010: result = A & B; // AND
            4'b0011: result = A | B; // OR
            4'b0100: result = A ^ B; // XOR
            4'b0101: result = ~(A | B); // NOR
            4'b0110: result = ~A; // NOT
            4'b0111: result = A << 1; // Shift Left
            4'b1000: result = A >> 1; // Shift Right Logical
            4'b1001: result = $signed(A) >>> 1; // Shift Right Arithmetic
            4'b1010: result = A + 1; // Increment
            4'b1011: result = A - 1; // Decrement
            4'b1100: result = (A < B) ? 32'b1 : 32'b0; // Set Less Than
            4'b1101: result = (A > B) ? 32'b1 : 32'b0; // Set Greater Than
            4'b1110: result = {B[15:0], 16'b0}; // Load Upper Immediate
            4'b1111: result = A ^ B; // Hamming Distance (XOR)
            default: result = 32'b0; // Default case
        endcase
    end
endmodule