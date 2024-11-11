module ControlUnit(
    input [3:0] opcode,
    output reg reg_write, alu_src
);

    always @(*) begin
        case (opcode)
            4'b0000: reg_write = 1; // ADD
            4'b0001: reg_write = 1; // SUB
            // Define control signals for other operations
            default: reg_write = 0;
        endcase
    end
endmodule