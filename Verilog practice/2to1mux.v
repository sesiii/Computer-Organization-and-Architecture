module _2to1mux(input wire a,b,sel,output wire y);
    assign y=sel ? b : a;
endmodule