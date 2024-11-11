module RegisterBank(
    input clk,
    input [3:0] read_reg1, read_reg2, write_reg,
    input [31:0] write_data,
    input reg_write,  // Control signal to enable writing to register
    output [31:0] read_data1, read_data2
);

    reg [31:0] registers [0:15];  // 16 registers, each 32-bits wide

    // Initialize the register bank with hardcoded values
    initial begin
        registers[0] = 32'b0;  // R0 is read-only and always 0
        registers[1] = 32'hA5A5A5A5;  // Example values
        registers[2] = 32'h5A5A5A5A;
        registers[3] = 32'h12345678;
        // Continue initializing other registers as needed
    end

    // Reading data from register bank
    assign read_data1 = registers[read_reg1];
    assign read_data2 = registers[read_reg2];

    // Writing data to register bank (if reg_write is enabled)
    always @(posedge clk) begin
        if (reg_write && write_reg != 4'b0000) begin
            registers[write_reg] <= write_data;
        end
    end
endmodule