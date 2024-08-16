`timescale 1ns / 1ps

module tb_4bit_adders;

    // Inputs
    reg [3:0] A;
    reg [3:0] B;
    reg Cin;

    // Outputs
    wire [3:0] Sum_CLA;
    wire Cout_CLA;
    wire [3:0] Sum_RCA;
    wire Cout_RCA;

    // Instantiate the Unit Under Test (UUT)
    cla_4bit cla (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum_CLA),
        .Cout(Cout_CLA)
    );

    ripple_carry_adder_4bit rca (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum_RCA),
        .Cout(Cout_RCA)
    );

    // Initialize Inputs and apply test cases
    initial begin
        // Monitor the inputs and outputs
        $monitor("Time = %0t: A = %b, B = %b, Cin = %b | CLA: Sum = %b, Cout = %b | RCA: Sum = %b, Cout = %b", 
                  $time, A, B, Cin, Sum_CLA, Cout_CLA, Sum_RCA, Cout_RCA);

        // Test case 1
        A = 4'b0000; B = 4'b0000; Cin = 0;
        #10;

        // Test case 2
        A = 4'b0001; B = 4'b0001; Cin = 0;
        #10;

        // Test case 3
        A = 4'b0010; B = 4'b0010; Cin = 1;
        #10;

        // Test case 4
        A = 4'b1111; B = 4'b1111; Cin = 0;
        #10;

        // Test case 5
        A = 4'b1010; B = 4'b0101; Cin = 1;
        #10;

        // End of simulation
        $finish;
    end

endmodule
