module tb_jkflipflop();
    reg j, k, clk;
    wire q;

    // Instantiate the JK flip-flop module
    jkflipflop uut (.j(j), .k(k), .clk(clk), .q(q));

    // Generate the clock signal
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end 

    // Apply test cases
    initial begin
        $monitor("%0t | j = %b, k = %b, clk = %b || q = %b", $time, j, k, clk, q);
        
        // Initial conditions
        j = 0; k = 0;
        #10 j = 0; k = 1;
        #10 j = 1; k = 0;
        #10 j = 1; k = 1;
        #10 j = 0; k = 0;

        $finish;
        
    end
endmodule