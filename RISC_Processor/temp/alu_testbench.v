module alu_testbench;
    reg [3:0] read_reg1;
    reg [3:0] read_reg2;
    reg [3:0] write_reg;
    reg [31:0] write_data;
    reg write_enable;
    reg [3:0] opcode;
    wire [31:0] data_out1;
    wire [31:0] data_out2;
    wire [31:0] alu_result;

    // Instantiate the register bank
    register_bank reg_bank (
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(write_data),
        .write_enable(write_enable),
        .data_out1(data_out1),
        .data_out2(data_out2)
    );

    // Instantiate the ALU
    alu alu_unit (
        .A(data_out1),
        .B(data_out2),
        .opcode(opcode),
        .result(alu_result)
    );

    initial begin
        // Test setup
        read_reg1 = 4'b0001; // R1
        read_reg2 = 4'b0010; // R2
        write_reg = 4'b0011; // R3
        write_enable = 0; // Disable write initially

        // Display initial values
        #10;
        $display("Initial Values: R1 = %d, R2 = %d", data_out1, data_out2);

        // Test writing to R3
        write_data = 32'd3; // Write value 100 to R3
        write_enable = 1; // Enable write
        #10; // Wait for write operation to take effect
        write_enable = 0; // Disable write again
        $display("Wrote 100 to R3. R3 now = %d", reg_bank.registers[write_reg]); // Check R3

        // Test addition
        opcode = 4'b0000; // ADD
        #10;
        $display("ADD: R1 (%d) + R2 (%d) = R3 (%d)", data_out1, data_out2, alu_result);
        
        // Test subtraction
        opcode = 4'b0001; // SUB
        #10;
        $display("SUB: R1 (%d) - R2 (%d) = R3 (%d)", data_out1, data_out2, alu_result);
        
        // Test AND
        opcode = 4'b0010; // AND
        #10;
        $display("AND: R1 (%d) & R2 (%d) = R3 (%d)", data_out1, data_out2, alu_result);
        
        // Verify R3 after addition operation
        #10;
        $display("After ADD: R3 = %d", reg_bank.registers[write_reg]);
$display("After AND operation: R3 = %d", reg_bank.registers[3]);
        // Finish simulation
        $finish;
    end
endmodule