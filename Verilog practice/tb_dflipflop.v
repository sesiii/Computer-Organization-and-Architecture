module tb_dflipflop();
    reg d;
    reg clk;
    wire q;
    // Instantiate the dflipflop module
    dflipflop uut(.d(d), .clk(clk), .q(q));

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end

    // Test stimulus
    initial begin
        d = 1'b0; // Assert d
        #10;
        d = 1'b1; // Deassert d

        // Monitor output
        $monitor("%0t: clk=%b, d=%b | q=%b", $time, clk, d, q);

        // Let the dflipflop run for a while
        #100; // Run simulation for 100 time units
        $finish; // End simulation
end
endmodule