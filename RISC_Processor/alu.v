module ALU(
    input [3:0] opcode,
    input [31:0] A, B,
    output reg [31:0] result
);
    
    always @(*) begin
        case (opcode)
            4'b0000: result = A + B;        // ADD
            4'b0001: result = A - B;        // SUB
            4'b0010: result = A & B;        // AND
            4'b0011: result = A | B;        // OR
            4'b0100: result = A ^ B;        // XOR
            4'b0101: result = ~(A | B);     // NOR
            4'b0110: result = A << 1;       // SL
            4'b0111: result = A >> 1;       // SRL
            4'b1000: result = A >>> 1;      // SRA
            4'b1001: result = (A < B) ? 1 : 0;  // SLT
            4'b1010: result = (A > B) ? 1 : 0;  // SGT
            4'b1011: result = {B[15:0], 16'b0}; // LUI (Load Upper Immediate)
            4'b1100: result = A + ^B;           // HAM (Hamming weight addition)
            default: result = 32'b0;
        endcase
    end
endmodule