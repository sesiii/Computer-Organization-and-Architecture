module alu (
    input wire [31:0] A,
    input wire [31:0] B,
    input wire [3:0] opcode, // Opcode to determine the operation
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
        4'b0111: result = A << 1; // SL
        4'b1000: result = A >> 1; // SRL
        4'b1001: result = A >>> 1; // SRA
        4'b1010: result = A + 32'd1; // INC
        4'b1011: result = A - 32'd1; // DEC
        4'b1100: result = (A < B) ? 32'd1 : 32'd0; // SLT
        4'b1101: result = (A > B) ? 32'd1 : 32'd0; // SGT
        4'b1110: result = {B[15:0], 16'b0}; // LUI
        4'b1111: result = A & ~B; // HAM
        default: result = 32'b0; // Default case
    endcase
end

endmodule