module RISC_Processor(
    input clk,
    input [15:0] instruction,
    output [31:0] result
);
    wire [3:0] opcode = instruction[15:12];
    wire [3:0] read_reg1 = instruction[11:8];
    wire [3:0] read_reg2 = instruction[7:4];
    wire [3:0] write_reg = instruction[3:0];

    wire [31:0] read_data1, read_data2, alu_result;
    wire reg_write;

    // Instantiate the Register Bank
    RegisterBank reg_bank(
        .clk(clk),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(alu_result),
        .reg_write(reg_write),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Instantiate the ALU
    ALU alu(
        .opcode(opcode),
        .A(read_data1),
        .B(read_data2),
        .result(alu_result)
    );

    // Instantiate the Control Unit
    ControlUnit ctrl_unit(
        .opcode(opcode),
        .reg_write(reg_write)
    );

    // Output result
    assign result = alu_result;

endmodule