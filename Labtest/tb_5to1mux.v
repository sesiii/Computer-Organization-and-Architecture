module tb_5to1mux();
 reg [4:0]in;
 reg [2:0]sel;
 wire out;

    mux_5to1 uut(.in(in),.sel(sel),.out(out));

    initial begin
        $monitor("%0t, %b,%b || %b ", $time,in,sel,out);
        in=5'd2;sel=3'b000; #10;
        in=5'd4;sel=3'b001; #10;
        in=5'd5;sel=3'b010; #10;
        in=5'd10;sel=3'b011; #10;

        $finish;

    end
endmodule
