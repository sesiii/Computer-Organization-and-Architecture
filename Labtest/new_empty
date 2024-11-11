module shift_add_multiplier (
    input [3:0] a,            // 4-bit multiplicand
    input [3:0] b,            // 4-bit multiplier
    output reg [7:0] product  // 8-bit product result
);
    integer i;
    reg [7:0] temp_product;   // Temporary register for product and shifting operations

    always @(*) begin
        // Initialize the product register
        temp_product = {4'b0000, b};  // Concatenate 4 zeros with the multiplier `b`

        // Perform 4 steps of the shift-and-add process
        for (i = 0; i < 4; i = i + 1) begin
            // If the LSB of temp_product is 1, add multiplicand `a` to the upper half of `temp_product`
            if (temp_product[0] == 1'b1) begin
                temp_product[7:4] = temp_product[7:4] + a;
            end
            
            // Shift the `temp_product` right by 1 bit
            temp_product = temp_product >> 1;
        end

        product = temp_product;  // Final result in `product`
    end
endmodule
