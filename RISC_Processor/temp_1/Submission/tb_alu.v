module test_alu;
    reg [31:0] A, B;
    reg [3:0] opcode;
    wire [31:0] result;

    // Instantiate the ALU
    alu uut (
        .A(A),
        .B(B),
        .opcode(opcode),
        .result(result)
    );

    initial begin
        // Test ADD
        A = 32'h00000001; B = 32'h00000001; opcode = 4'b0000;
        #10;
        $display("ADD: %h + %h = %h", A, B, result);

        // Test SUB
        A = 32'h00000002; B = 32'h00000001; opcode = 4'b0001;
        #10;
        $display("SUB: %h - %h = %h", A, B, result);

        // Test AND
        A = 32'h00000003; B = 32'h00000001; opcode = 4'b0010;
        #10;
        $display("AND: %h & %h = %h", A, B, result);

        // Test OR
        A = 32'h00000002; B = 32'h00000001; opcode = 4'b0011;
        #10;
        $display("OR: %h | %h = %h", A, B, result);

        // Test XOR
        A = 32'h00000003; B = 32'h00000001; opcode = 4'b0100;
        #10;
        $display("XOR: %h ^ %h = %h", A, B, result);

        // Test NOR
        A = 32'h00000002; B = 32'h00000001; opcode = 4'b0101;
        #10;
        $display("NOR: ~(%h | %h) = %h", A, B, result);

        // Test NOT
        A = 32'h00000001; opcode = 4'b0110;
        #10;
        $display("NOT: ~%h = %h", A, result);

        // Test Shift Left
        A = 32'h00000001; opcode = 4'b0111;
        #10;
        $display("Shift Left: %h << 1 = %h", A, result);

        // Test Shift Right Logical
        A = 32'h00000002; opcode = 4'b1000;
        #10;
        $display("Shift Right Logical: %h >> 1 = %h", A, result);

        // Test Shift Right Arithmetic
        A = 32'h80000000; opcode = 4'b1001;
        #10;
        $display("Shift Right Arithmetic: %h >>> 1 = %h", A, result);

        // Test Increment
        A = 32'h00000001; opcode = 4'b1010;
        #10;
        $display("Increment: %h + 1 = %h", A, result);

        // Test Decrement
        A = 32'h00000002; opcode = 4'b1011;
        #10;
        $display("Decrement: %h - 1 = %h", A, result);

        // Test Set Less Than
        A = 32'h00000001; B = 32'h00000002; opcode = 4'b1100;
        #10;
        $display("Set Less Than: %h < %h = %h", A, B, result);

        // Test Set Greater Than
        A = 32'h00000002; B = 32'h00000001; opcode = 4'b1101;
        #10;
        $display("Set Greater Than: %h > %h = %h", A, B, result);

        // Test Load Upper Immediate
        B = 32'h0000FFFF; opcode = 4'b1110;
        #10;
        $display("Load Upper Immediate: %h = %h", B, result);

        // Test Hamming Distance
        A = 32'h00000003; opcode = 4'b1111;
        #10;
        $display("Hamming Distance: %h = %h", A, result);

        $finish;
    end
endmodule