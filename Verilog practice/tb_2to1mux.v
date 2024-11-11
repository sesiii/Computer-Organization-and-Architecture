module tb_2to1mux;
reg a,b;
reg sel;
wire y;

_2to1mux uut(.a(a),.b(b),.sel(sel),.y(y));

initial begin
    $monitor("%0t, %b,%b,%b || %b", $time,a,b,sel,y);
    a=1'd0;b=1'd0;sel=1'd0; #10;
    a=1'd0;b=1'd1;sel=1'd0; #10;
    a=1'd1;b=1'd0;sel=1'd0; #10;
    a=1'd1;b=1'd1;sel=1'd0; #10;
    a=1'd0;b=1'd0;sel=1'd1; #10;
    a=1'd0;b=1'd1;sel=1'd1; #10;
    a=1'd1;b=1'd0;sel=1'd1; #10;
    a=1'd1;b=1'd1;sel=1'd1; #10;
    $finish;

    end
endmodule


    


