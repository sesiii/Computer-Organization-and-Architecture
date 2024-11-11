module alu(input [3:0]a,b,input cin,input [2:0]sel, output reg [3:0]result,output reg cout);
wire [3:0]sum,and_out,or_out,xor_out,not_out,nor_out;
wire add_cout;

full_adder uut1(.a(a),.b(b),.cin(cin),.sum(sum),.cout(add_cout));
and_gate uut2(.a(a),.b(b),.result(and_out));
or_gate uut3(.a(a),.b(b),.result(or_out));
not_gate uut4(.a(a),.result(not_out));
nor_gate uut5(.a(a),.b(b),.result(nor_out));
xor_gate uut6(.a(a),.b(b),.result(xor_out));

    always @(*) begin
        case(sel)
            3'b000:begin
                result=sum;
                cout=add_cout;
            end
            3'b001:result=and_out;
            3'b010:result=nor_out;
            3'b011:result=or_out;
            3'b100:result=not_out;
            3'b101:result=xor_out;
            default:result=4'b0000;
        endcase
            if(sel!=3'b000)
                cout=1'b0;
        end
endmodule
