`timescale 1ns / 1ps

module tb_CLA_16bit;

    reg [15:0] a;
    reg [15:0] b;
    reg cin;
    wire [15:0] sum;
    wire cout;

    // Instantiate 
    CLA_16bit uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );


    initial begin
        
        $display("Time\t\tA\t\t\tB\t\t\tCin\tSum\t\tCout");

        
        a = 16'h0000; b = 16'h0000; cin = 0;
        #10 $display("%t\t%h\t%h\t%b\t%h\t%b", $time, a, b, cin, sum, cout);

        a = 16'h0001; b = 16'h0001; cin = 0;
        #10 $display("%t\t%h\t%h\t%b\t%h\t%b", $time, a, b, cin, sum, cout);

        a = 16'hFFFF; b = 16'h0001; cin = 0;
        #10 $display("%t\t%h\t%h\t%b\t%h\t%b", $time, a, b, cin, sum, cout);

        a = 16'h1234; b = 16'h5678; cin = 0;
        #10 $display("%t\t%h\t%h\t%b\t%h\t%b", $time, a, b, cin, sum, cout);

        a = 16'hAAAA; b = 16'h5555; cin = 1;
        #10 $display("%t\t%h\t%h\t%b\t%h\t%b", $time, a, b, cin, sum, cout);

        a = 16'h0F0F; b = 16'hF0F0; cin = 1;
        #10 $display("%t\t%h\t%h\t%b\t%h\t%b", $time, a, b, cin, sum, cout);

        a = 16'h8000; b = 16'h8000; cin = 0;
        #10 $display("%t\t%h\t%h\t%b\t%h\t%b", $time, a, b, cin, sum, cout);

        #10 $finish;
    end

endmodule