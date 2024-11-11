module tb_RCA;
    reg [3:0] a, b;           // Declare a and b as 4-bit registers
    reg cin;                  // Declare cin as a single-bit register
    wire [3:0] sum;          // Declare sum as a 4-bit wire
    wire cout;               // Declare cout as a single-bit wire

    // Instantiate the RCA module
    RCA uut (
        .a(a),
        .b(b),
        .cin(cin),
        .cout(cout),
        .sum(sum)
    );

    initial begin
        // Monitor the signals
        $monitor("%0t | a = %b, b = %b, cin = %b || sum = %b, cout = %b", $time, a, b, cin, sum, cout);

        // Test cases
        a = 4'b0000; b = 4'b0000; cin = 0; #10;
        a = 4'b0001; b = 4'b0001; cin = 0; #10;
        a = 4'b0010; b = 4'b0011; cin = 0; #10;
        a = 4'b1111; b = 4'b0001; cin = 0; #10; // Edge case for overflow
        a = 4'b1001; b = 4'b0110; cin = 1; #10;

        // Finish the simulation
        $finish;
    end
endmodule