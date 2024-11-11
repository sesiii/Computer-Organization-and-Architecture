module tb_alu;
    reg [3:0]a, b;
    reg cin;
    reg [2:0] sel;
    wire [3:0] out;
    wire cout;

    alu uut (.a(a), .b(b), .cin(cin), .sel(sel), .out(out), .cout(cout));

    initial begin
        // Test addition
        a = 1011; b = 1; cin = 0; sel = 3'b000; #10; // a + b
        // Test subtraction
        a = 1; b = 1; cin = 0; sel = 3'b001; #10; // a - b
        // Test AND
        a = 1; b = 1; sel = 3'b011; #10; // a AND b
        // Test OR
        a = 0; b = 1; sel = 3'b010; #10; // a OR b
        // Test XOR
        a = 1; b = 0; sel = 3'b100; #10; // a XOR b
        // Test NOR
        a = 1; b = 1; sel = 3'b101; #10; // a NOR b
        // Test NOT
        a = 1; sel = 3'b110; #10; // NOT a
        // Test clear
        sel = 3'b111; #10; // Default case

        $finish;
    end

    initial begin
        $monitor("Time: %0t | a: %4b | b: %b | cin: %b | sel: %b | out: %b | cout: %b", 
                  $time, a, b, cin, sel, out, cout);
    end
endmodule