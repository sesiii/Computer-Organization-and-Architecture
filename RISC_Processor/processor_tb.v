module tb_RISC_Processor();

    reg clk;
    reg [15:0] instruction;
    wire [31:0] result;

    RISC_Processor uut (
        .clk(clk),
        .instruction(instruction),
        .result(result)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Clock period of 10 time units
    end

    initial begin
        // Test ADD instruction
        instruction = 16'b0000_0001_0010_0011;  // ADD R1, R2, R3
        #10;

        // Test SUB instruction
        instruction = 16'b0001_0001_0010_0011;  // SUB R1, R2, R3
        #10;

        // Add more test cases...

        #50 $finish;
    end
endmodule