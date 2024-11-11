module a;
    // Input registers
    reg [3:0] read_reg1;      // First source register address
    reg [3:0] read_reg2;      // Second source register address
    reg [3:0] write_reg;      // Destination register address
    reg [31:0] write_data;    // Data to write to register
    reg write_enable;         // Register write enable signal
    reg [3:0] opcode;         // ALU operation code
    
    // Output wires
    wire [31:0] data_out1;    // First operand from register bank
    wire [31:0] data_out2;    // Second operand from register bank
    wire [31:0] alu_result;   // Result from ALU operation

    // Instantiate register bank
    register_bank reg_bank (
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .write_reg(write_reg),
        .write_data(write_data),
        .write_enable(write_enable),
        .data_out1(data_out1),
        .data_out2(data_out2)
    );

    // Instantiate ALU
    alu alu_unit (
        .A(data_out1),
        .B(data_out2),
        .opcode(opcode),
        .result(alu_result)
    );

    // Test sequence
    initial begin
        // Initialize test configuration
        read_reg1 = 4'b0001;    // Select R1 as first source
        read_reg2 = 4'b1001;    // Select R9 as second source
        write_reg = 4'b0011;    // Select R3 as destination
        write_enable = 0;        // Initially disable writing
        
        // Wait and display initial values
        #10;
        $display("Initial Values: R1 = %d, R9 = %d", data_out1, data_out2);
        
        // Test write operation to R3
        write_data = 32'd100;
        write_enable = 1;
        #10;
        write_enable = 0;
        $display("Wrote 100 to R3. R3 now = %d", reg_bank.registers[write_reg]);

        // Test all ALU operations
        // Operation sequence: ADD, SUB, AND, OR, XOR, SL, SRL, SRA
        // For each operation:
        // 1. Set opcode
        // 2. Wait for computation
        // 3. Display result
        // 4. Store in R3
        // 5. Display updated R3 value

        // ADD (0000)
        opcode = 4'b0000;
        #10;
        $display("ADD: R1 (%d) + R9 (%d) = R3 (%d)", 
                 data_out1, data_out2, alu_result);
        reg_bank.registers[write_reg] = alu_result;
        $display("After ADD: R3 = %b", reg_bank.registers[write_reg]);

        read_reg1 = 4'b0001;    // Select R1 as first source
        read_reg2 = 4'b0011;   // Select R3 as second source
        write_reg = 4'b0010;    // Select R2 as destination
        write_enable = 0;        // Initially disable writing

        // ADD (0000)
        opcode = 4'b0000;
        #10;
        $display("ADD: R1 (%d) + R3 (%d) = R2 (%d)", 
                 data_out1, data_out2, alu_result);
        reg_bank.registers[write_reg] = alu_result;
        $display("After ADD: R2 = %b", reg_bank.registers[write_reg]);

        read_reg1 = 4'b0010;    // Select R2 as first source
        read_reg2 = 4'b1001;   // Select R9 as second source
        write_reg = 4'b0010;    // Select R2 as destination
        write_enable = 0;        // Initially disable writing

        // ADD (0000)
        opcode = 4'b0000;
        #10;
        $display("ADD: R2 (%d) + R9 (%d) = R2 (%d)", 
                 data_out1, data_out2, alu_result);
        reg_bank.registers[write_reg] = alu_result;
        $display("After ADD: R2 = %b", reg_bank.registers[write_reg]);
        
        $finish;
    end
endmodule