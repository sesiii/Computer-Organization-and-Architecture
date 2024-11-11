module add_op(input [31:0] A, input [31:0] B, output [31:0] result);
    assign result = A + B;
endmodule

module sub_op(input [31:0] A, input [31:0] B, output [31:0] result);
    assign result = A - B;
endmodule

module and_op(input [31:0] A, input [31:0] B, output [31:0] result);
    assign result = A & B;
endmodule

module or_op(input [31:0] A, input [31:0] B, output [31:0] result);
    assign result = A | B;
endmodule

module xor_op(input [31:0] A, input [31:0] B, output [31:0] result);
    assign result = A ^ B;
endmodule

module nor_op(input [31:0] A, input [31:0] B, output [31:0] result);
    assign result = ~(A | B);
endmodule

module not_op(input [31:0] A, output [31:0] result);
    assign result = ~A;
endmodule

module sll_op(input [31:0] A, input [31:0] B, output [31:0] result);
    assign result = A << B;
endmodule

module srl_op(input [31:0] A, input [31:0] B, output [31:0] result);
    assign result = A >> B;
endmodule

module sra_op(input [31:0] A, input [31:0] B, output [31:0] result);
    assign result = A >> B;
endmodule

module inc_op(input [31:0] A, output [31:0] result);
    assign result = A + 4;
endmodule

module dec_op(input [31:0] A, output [31:0] result);
    assign result = A - 4;
endmodule

module slt_op(input [31:0] A, input [31:0] B, output [31:0] result);
    assign result = (A < B) ? 32'b1 : 32'b0;
endmodule

module sgt_op(input [31:0] A, input [31:0] B, output [31:0] result);
    assign result = (A > B) ? 32'b1 : 32'b0;
endmodule

module lui_op(input [31:0] B, output [31:0] result);
    assign result = {B[15:0], 16'b0};
endmodule

module alu(
    input [31:0] A,
    input [31:0] B,
    input [3:0] opcode,
    output [31:0] result
);
    wire [31:0] add_result;
    wire [31:0] sub_result;
    wire [31:0] and_result;
    wire [31:0] or_result;
    wire [31:0] xor_result;
    wire [31:0] nor_result;
    wire [31:0] not_result;
    wire [31:0] sll_result;
    wire [31:0] srl_result;
    wire [31:0] sra_result;
    wire [31:0] inc_result;
    wire [31:0] dec_result;
    wire [31:0] slt_result;
    wire [31:0] sgt_result;
    wire [31:0] lui_result;
    
    add_op add(A, B, add_result);
    sub_op sub(A, B, sub_result);
    and_op and_gate(A, B, and_result);
    or_op or_gate(A, B, or_result);
    xor_op xor_gate(A, B, xor_result);
    nor_op nor_gate(A, B, nor_result);
    not_op not_gate(A, not_result);
    sll_op sll(A, B,sll_result);
    srl_op srl(A, B,srl_result);
    sra_op sra(A, B,sra_result);
    inc_op inc(A,  inc_result);
    dec_op dec(A, dec_result);
    slt_op slt(A, B, slt_result);
    sgt_op sgt(A, B, sgt_result);
    lui_op lui(B, lui_result);
    
    assign result = (opcode == 4'b0000) ? add_result : 
                    (opcode == 4'b0001) ? sub_result :
                    (opcode == 4'b0010) ? and_result :
                    (opcode == 4'b0011) ? or_result :
                    (opcode == 4'b0100) ? xor_result :
                    (opcode == 4'b0101) ? nor_result :
                    (opcode == 4'b0110) ? not_result :
                    (opcode == 4'b0111) ? sll_result :
                    (opcode == 4'b1000) ? srl_result :
                    (opcode == 4'b1001) ? sra_result :
                    (opcode == 4'b1010) ? inc_result :
                    (opcode == 4'b1011) ? dec_result :
                    (opcode == 4'b1100) ? slt_result :
                    (opcode == 4'b1101) ? sgt_result :
                    (opcode == 4'b1110) ? lui_result : 32'b0;
endmodule
