`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:47:31 08/14/2024 
// Design Name: 
// Module Name:    full_adder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module full_adder (
    input wire A,
    input wire B,
    input wire Cin,
    output wire Sum,
    output wire Cout
);

    wire sum_ab;
    wire carry_ab;
    wire carry_acin;
    
    
    assign sum_ab = A ^ B;
    
    assign Sum = sum_ab ^ Cin;
   
    assign carry_ab = A & B;
    assign carry_acin = sum_ab & Cin;
    assign Cout = carry_ab | carry_acin;

endmodule
