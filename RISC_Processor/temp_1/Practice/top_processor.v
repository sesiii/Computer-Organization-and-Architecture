// Top module integrating ALU and Register Bank
module top_processor(
    input clk,
    input rst,
    input [3:0] rx,     // Destination register address
    input [3:0] ry,     // First source register address
    input [3:0] rz,     // Second source register address
    input [3:0] op,     // Operation code
    input write_en,     // Write enable signal
    output [31:0] result_out  // Output result
);

    // Internal wires
    wire [31:0] operand1;
    wire [31:0] operand2;
    wire [31:0] alu_result;
    reg [31:0] result_reg;
    
    // Register for output
    always @(posedge clk or posedge rst) begin
        if (rst)
            result_reg <= 32'b0;
        else
            result_reg <= alu_result;
    end

    // Instantiate register bank
    register_bank reg_bank(
        .read_reg1(ry),
        .read_reg2(rz),
        .write_reg(rx),
        .write_data(alu_result),
        .write_enable(write_en),
        .data_out1(operand1),
        .data_out2(operand2)
    );

    // Instantiate ALU
    alu alu_unit(
        .A(operand1),
        .B(operand2),
        .opcode(op),
        .result(alu_result)
    );

    // Output assignment
    assign result_out = result_reg;

endmodule

