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
        read_reg2 = 4'b1001; // R9
        write_reg = 4'b0011; // R3
        write_enable = 0; // Disable write initially

        // Display initial values
        #10;
        $display("Initial Values: R1 = %032b, R9 = %032b", data_out1, data_out2);

        // Test writing to R3
        write_data = 32'd100; // Write value 100 to R3
        write_enable = 1; // Enable write
        #10; // Wait for write operation to take effect
        write_enable = 0; // Disable write again
        $display("Wrote 100 to R3. R3 now = %032b", reg_bank.registers[write_reg]); // Check R3

        // Test ALU operations
        // Test addition
        opcode = 4'b0000; // ADD
        #10;
        $display("ADD: R1 (%032b) + R9 (%032b) = R3 (%032b)", data_out1, data_out2, alu_result);
        reg_bank.registers[write_reg] = alu_result; // Store result in R3
        $display("After ADD: R3 = %032b", reg_bank.registers[write_reg]);

        // Test subtraction
        opcode = 4'b0001; // SUB
        #10;
        $display("SUB: R1 (%032b) - R9 (%032b) = R3 (%032b)", data_out1, data_out2, alu_result);
        reg_bank.registers[write_reg] = alu_result; // Store result in R3
        $display("After SUB: R3 = %032b", reg_bank.registers[write_reg]);
    
        // Test AND
        opcode = 4'b0010; // AND
        #10;
        $display("AND: R1 (%032b) & R9 (%032b) = R3 (%032b)", data_out1, data_out2, alu_result);
        reg_bank.registers[write_reg] = alu_result; // Store result in R3
        $display("After AND: R3 = %032b", reg_bank.registers[write_reg]);

        // Test OR
        opcode = 4'b0011; // OR
        #10;
        $display("OR: R1 (%032b) | R9 (%032b) = R3 (%032b)", data_out1, data_out2, alu_result);
        reg_bank.registers[write_reg] = alu_result; // Store result in R3
        $display("After OR: R3 = %032b", reg_bank.registers[write_reg]);

        // Test XOR
        opcode = 4'b0100; // XOR
        #10;
        $display("XOR: R1 (%032b) ^ R9 (%032b) = R3 (%032b)", data_out1, data_out2, alu_result);
        reg_bank.registers[write_reg] = alu_result; // Store result in R3
        $display("After XOR: R3 = %032b", reg_bank.registers[write_reg]);

        // Test SL (Shift Left)
        opcode = 4'b0101; // SL
        #10;
        $display("SL: R1 (%032b) << 1 = R3 (%032b)", data_out1, alu_result);
        reg_bank.registers[write_reg] = alu_result; // Store result in R3
        $display("After SL: R3 = %032b", reg_bank.registers[write_reg]);

        // Test SRL (Shift Right Logical)
        opcode = 4'b0110; // SRL
        #10;
        $display("SRL: R1 (%032b) >> 1 = R3 (%032b)", data_out1, alu_result);
        reg_bank.registers[write_reg] = alu_result; // Store result in R3
        $display("After SRL: R3 = %032b", reg_bank.registers[write_reg]);

        // Test SRA (Shift Right Arithmetic)
        opcode = 4'b0111; // SRA
        #10;
        $display("SRA: R1 (%032b) >>> 1 = R3 (%032b)", data_out1, alu_result);
        reg_bank.registers[write_reg] = alu_result; // Store result in R3
        $display("After SRA: R3 = %032b", reg_bank.registers[write_reg]);

        // Finish simulation
        $finish;
    end
endmodule