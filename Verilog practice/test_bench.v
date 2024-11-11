module test_bench;
    reg a, b;
    wire v1, v2, v3, v4, v5, v6;

    // Instantiating each gate module
    and_gate and1(.a(a), .b(b), .v(v1));
    or_gate or1(.a(a), .b(b), .v(v2));
    not_gate not1(.a(a), .v(v3));
    xor_gate xor1(.a(a), .b(b), .v(v4));
    nand_gate nand1(.a(a), .b(b), .v(v5));
    nor_gate nor1(.a(a), .b(b), .v(v6));

    // Stimulus block
    initial begin
        // Display header for readability
        $display("Time   a b | AND OR NOT XOR NAND NOR");
        $display("----------------------------------");

        // Monitor output values
        $monitor("%0t    %b %b |  %b   %b   %b    %b    %b    %b", 
                 $time, a, b, v1, v2, v3, v4, v5, v6);

        // Apply test cases
        a = 1'b0; b = 1'b0; #10;
        a = 1'b0; b = 1'b1; #10;
        a = 1'b1; b = 1'b0; #10;
        a = 1'b1; b = 1'b1; #10;
        $finish;
    end

    // Waveform dump for visualization
    initial begin
        $dumpfile("waveform.vcd");  // Output file for waveform
        $dumpvars(0, test_bench);   // Dump all signals in test_bench
    end
endmodule