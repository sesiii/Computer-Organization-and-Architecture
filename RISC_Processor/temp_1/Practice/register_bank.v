module register_bank(
    input [3:0] read_reg1,
    input [3:0] read_reg2,
    input [3:0] write_reg,
    input [31:0] write_data,
    input write_enable,
    output reg [31:0] data_out1,
    output reg [31:0] data_out2
);
    reg [31:0] registers [15:0]; // 16 registers of 32 bits each

    initial begin
        registers[1] = 32'd10; // Initialize R1
        registers[2] = 32'd20; // Initialize R2
        registers[3] = 32'd30; // Initialize R3
        registers[4] = 32'd40; // Initialize R4
        registers[5] = 32'd50; // Initialize R5
        registers[6] = 32'd60; // Initialize R6
        registers[7] = 32'd70; // Initialize R7
        registers[8] = 32'd80; // Initialize R8
        registers[9] = 32'd90; // Initialize R9
        registers[10] = 32'd100; // Initialize R10
        registers[11] = 32'd110; // Initialize R11
        registers[12] = 32'd120; // Initialize R12
        registers[13] = 32'd130; // Initialize R13
        registers[14] = 32'd140; // Initialize R14
        registers[15] = 32'd0; // Initialize R15
    end

    always @(*) begin
        data_out1 = registers[read_reg1];
        data_out2 = registers[read_reg2];
    end

    always @(posedge write_enable) begin
        if (write_enable) begin
            registers[write_reg] <= write_data; // Write data to the specified register
        end
    end
endmodule