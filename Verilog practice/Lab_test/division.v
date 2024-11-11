//Name: Dadi Sasank Kumar
//Rno-22CS10020
//Table no: 78
module divison(input [7:0] n, input [7:0] d, output reg [7:0] q, output reg [7:0] r);

    reg [7:0] temp_d;
    reg [7:0] temp_r;
    reg [7:0] temp_q;

    always @(*) begin
        temp_r = n;
        temp_q = 8'd0;
        temp_d = ~d + 1;

        while (temp_r >= d) begin
            temp_r = temp_r + temp_d;
            temp_q = temp_q + 1;
        end

        r = temp_r;
        q = temp_q;
    end

endmodule

