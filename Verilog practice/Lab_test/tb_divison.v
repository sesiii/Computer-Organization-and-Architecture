//Name: Dadi Sasank Kumar
//Rno-22CS10020
//Table no: 78
module tb_divison();
reg [7:0] n;
reg [7:0] d;
wire [7:0] q;
wire [7:0] r;

divison uut (.n(n), .d(d), .q(q), .r(r));

initial begin
    #10;
    n = 8'd100;
    d = 8'd30;
    $monitor("Time: %0t | N= %d | D= %d | ==>> | Q=%d | R=%d |", $time, n, d, q, r);

    #10;
    n = 8'd12;
    d = 8'd13;
    $monitor("Time: %0t | N= %d | D= %d | ==>> | Q=%d | R=%d |", $time, n, d, q, r);

    $finish;
end

endmodule
