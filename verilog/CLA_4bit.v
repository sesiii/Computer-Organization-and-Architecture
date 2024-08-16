module CLA_4bit (
    input [3:0] A, B,   
    input C0,           
    output [3:0] Sum,   
    output C4           
);

wire [3:0] G, P;
wire C1, C2, C3;


assign G = A & B;
assign P = A ^ B;


assign C1 = G[0] | (P[0] & C0);
assign C2 = G[1] | (P[1] & C1);
assign C3 = G[2] | (P[2] & C2);
assign C4 = G[3] | (P[3] & C3);


assign Sum = P ^ {C3, C2, C1, C0};

endmodule