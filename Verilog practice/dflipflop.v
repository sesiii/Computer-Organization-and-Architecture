module dflipflop(input d,clk,output reg q);

    always @(posedge clk)
    case(d)
        1'b0: q<=0;
        1'b1: q<=1;
    endcase

endmodule
