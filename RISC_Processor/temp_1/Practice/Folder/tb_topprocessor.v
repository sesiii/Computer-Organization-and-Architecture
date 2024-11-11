module a (
    input wire clk,           // Clock signal
    output reg [15:0] display // Output to FPGA display
);
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

    // Output display register
    reg [31:0] output_display;
    reg display_lower_half;   // Control signal to switch between lower and upper 16 bits

    // Counter for delay
    reg [31:0] counter;

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

    // Counter and display control logic
    always @(posedge clk) begin
        counter <= counter + 1;
        if (counter == 32'd50000000) begin // Adjust the delay as needed
            display_lower_half <= ~display_lower_half;
            counter <= 0;
        end
    end

    // Assign the appropriate part of the output_display register to the display output
    always @(posedge clk) begin
        if (display_lower_half) begin
            display <= output_display[15:0];
        end else begin
            display <= output_display[31:16];
        end
    end

    // Test sequence
    initial begin
        // Initialize test configuration
        read_reg1 = 4'b0001;    // Select R1 as first source
        read_reg2 = 4'b1001;    // Select R9 as second source
        write_reg = 4'b0011;    // Select R3 as destination
        write_enable = 0;       // Initially disable writing
        display_lower_half = 0; // Initially display lower 16 bits
        counter = 0;            // Initialize counter
        
        // Wait and display initial values
        #10;
        $display("Initial Values: R1 = %b, R9 = %b", data_out1, data_out2);
        
        // Test write operation to R3
        write_data = 32'd100;
        write_enable = 1;
        #10;
        write_enable = 0;
        $display("Wrote 100 to R3. R3 now = %b", reg_bank.registers[write_reg]);

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
        output_display = alu_result;
        $display("ADD: R1 (%b) + R9 (%b) = R3 (%b)", 
                 data_out1, data_out2, alu_result);
        reg_bank.registers[write_reg] = alu_result;
        $display("After ADD: R3 = %b", reg_bank.registers[write_reg]);
        display_output();

        // Generate waveform file
        $dumpfile("register_bank.vcd");
        $dumpvars(0, a);
        
        read_reg1 = 4'b0001;    // Select R1 as first source
        read_reg2 = 4'b0011;    // Select R3 as second source
        write_reg = 4'b0010;    // Select R2 as destination
        write_enable = 0;       // Initially disable writing

        // ADD (0000)
        opcode = 4'b0000;
        #10;
        output_display = alu_result;
        $display("ADD: R1 (%b) + R3 (%b) = R2 (%b)", 
                 data_out1, data_out2, alu_result);
        reg_bank.registers[write_reg] = alu_result;
        $display("After ADD: R2 = %b", reg_bank.registers[write_reg]);
        display_output();

        read_reg1 = 4'b0010;    // Select R2 as first source
        read_reg2 = 4'b1001;    // Select R9 as second source
        write_reg = 4'b0010;    // Select R2 as destination
        write_enable = 0;       // Initially disable writing

        // ADD (0000)
        opcode = 4'b0000;
        #10;
        output_display = alu_result;
        $display("ADD: R2 (%b) + R9 (%b) = R2 (%b)", 
                 data_out1, data_out2, alu_result);
        reg_bank.registers[write_reg] = alu_result;
        $display("After ADD: R2 = %b", reg_bank.registers[write_reg]);
        display_output();

        // Additional test cases

        // SUB (0001)
        opcode = 4'b0001;
        #10;
        output_display = alu_result;
        $display("SUB: R2 (%b) - R9 (%b) = R2 (%b)", 
                 data_out1, data_out2, alu_result);
        reg_bank.registers[write_reg] = alu_result;
        $display("After SUB: R2 = %b", reg_bank.registers[write_reg]);
        display_output();

        // AND (0010)
        opcode = 4'b0010;
        #10;
        output_display = alu_result;
        $display("AND: R2 (%b) & R9 (%b) = R2 (%b)", 
                 data_out1, data_out2, alu_result);
        reg_bank.registers[write_reg] = alu_result;
        $display("After AND: R2 = %b", reg_bank.registers[write_reg]);
        display_output();

        // OR (0011)
        opcode = 4'b0011;
        #10;
        output_display = alu_result;
        $display("OR: R2 (%b) | R9 (%b) = R2 (%b)", 
                 data_out1, data_out2, alu_result);
        reg_bank.registers[write_reg] = alu_result;
        $display("After OR: R2 = %b", reg_bank.registers[write_reg]);
        display_output();

        // XOR (0100)
        opcode = 4'b0100;
        #10;
        output_display = alu_result;
        $display("XOR: R2 (%b) ^ R9 (%b) = R2 (%b)", 
                 data_out1, data_out2, alu_result);
        reg_bank.registers[write_reg] = alu_result;
        $display("After XOR: R2 = %b", reg_bank.registers[write_reg]);
        display_output();

        // SL (0101)
        opcode = 4'b0101;
        #10;
        output_display = alu_result;
        $display("SL: R2 (%b) << 1 = R2 (%b)", 
                 data_out1, alu_result);
        reg_bank.registers[write_reg] = alu_result;
        $display("After SL: R2 = %b", reg_bank.registers[write_reg]);
        display_output();

        // SRL (0110)
        opcode = 4'b0110;
        #10;
        output_display = alu_result;
        $display("SRL: R2 (%b) >> 1 = R2 (%b)", 
                 data_out1, alu_result);
        reg_bank.registers[write_reg] = alu_result;
        $display("After SRL: R2 = %b", reg_bank.registers[write_reg]);
        display_output();

        // SRA (0111)
        opcode = 4'b0111;
        #10;
        output_display = alu_result;
        $display("SRA: R2 (%b) >>> 1 = R2 (%b)", 
                 data_out1, alu_result);
        reg_bank.registers[write_reg] = alu_result;
        $display("After SRA: R2 = %b", reg_bank.registers[write_reg]);
        display_output();

        $finish;
    end

    // Task to display the lower or upper 16 bits of the output_display register
    task display_output;
        begin
            if (display_lower_half) begin
                $display("Output Display (Lower 16 bits): %b", output_display[15:0]);
            end else begin
                $display("Output Display (Upper 16 bits): %b", output_display[31:16]);
            end
        end
    endtask
endmodule