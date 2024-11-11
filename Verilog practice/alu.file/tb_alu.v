module tb_alu;
    reg [3:0] a, b;         // 4-bit inputs for the ALU
    reg [2:0] sel;         // 3-bit selection input
    reg cin;               // Carry input
    wire [3:0] result;     // Output of the ALU
    wire cout;             // Carry output

    // Instantiate the ALU module
    alu uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sel(sel),
        .result(result),
        .cout(cout)
    );

    // Test sequence
    initial begin
        // Test Addition
        a = 4'b0011;   // 3
        b = 4'b0001;   // 1
        cin = 0;       // No carry-in
        sel = 3'b000;  // Select addition
        #10;           // Wait for 10 time units
        
        // Test Subtraction
        a = 4'b0101;   // 5
        b = 4'b0010;   // 2
        cin = 0;       // No carry-in
        sel = 3'b001;  // Select subtraction
        #10;           // Wait for 10 time units
        
        // Test AND operation
        a = 4'b1100;   // 12
        b = 4'b1010;   // 10
        cin = 0;       // No carry-in
        sel = 3'b011;  // Select AND
        #10;           // Wait for 10 time units
        
        // Test OR operation
        a = 4'b1100;   // 12
        b = 4'b0011;   // 3
        cin = 0;       // No carry-in
        sel = 3'b010;  // Select OR
        #10;           // Wait for 10 time units
        
        // Test XOR operation
        a = 4'b1100;   // 12
        b = 4'b1010;   // 10
        cin = 0;       // No carry-in
        sel = 3'b100;  // Select XOR
        #10;           // Wait for 10 time units
        
        // Test NOR operation
        a = 4'b1100;   // 12
        b = 4'b0011;   // 3
        cin = 0;       // No carry-in
        sel = 3'b101;  // Select NOR
        #10;           // Wait for 10 time units
        
        // Test NOT operation
        a = 4'b1100;   // 12
        cin = 0;       // No carry-in
        sel = 3'b110;  // Select NOT
        #10;           // Wait for 10 time units
        
        
        // Test clear (default case)
        sel = 3'b111;  // Default case
        #10;           // Wait for 10 time units

        // Finish the simulation
        $finish;
    end

    // Monitor output
    initial begin
        $monitor("Time: %0t | A: %4b | B: %4b | Cin: %b | Sel: %3b | Result: %4b | Cout: %b", 
                  $time, a, b, cin, sel, result, cout);
    end
endmodule