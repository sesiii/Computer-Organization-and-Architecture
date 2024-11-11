module tb_counter_till15;
    reg clk;
    reg reset;
    wire [3:0] count;

    // Instantiate the counter module
    counter_till15 uut(.clk(clk), .reset(reset), .count(count));

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end

    // Test stimulus
    initial begin
        reset = 1; // Assert reset
        #10;
        reset = 0; // Deassert reset

        // Monitor output
        $monitor("%0t: clk=%b, reset=%b | count=%b", $time, clk, reset, count);

        // Let the counter run for a while
        #100; // Run simulation for 100 time units
        $finish; // End simulation
    end
endmodule