module tb_fulladder;
    reg a,b,cin;
    wire cout,sum;

    full_adder uut(.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout));

    initial begin
    $monitor("%0t %4b %b %b |||%b %b",$time,a,b,cin,sum,cout);
    a=4'b0000;b=4'b0001;cin=4'b0000;#10;
    a=4'b0010;b=4'b0101;cin=4'b0001;#10;
    a=4'b0010;b=4'b1101;cin=4'b0000;#10;
    a=4'b0110;b=4'b0000;cin=4'b0000;#10;
    $finish;
    end
endmodule
