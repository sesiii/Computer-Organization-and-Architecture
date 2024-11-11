module for_loop_example;
    reg [3:0] data[0:7]; // 8 elements of 4 bits each
    integer i;

    initial begin
        // Assign values to each element of the array
        for (i = 0; i < 8; i = i + 1) begin
            data[i] = i; // Assign the value of i to data[i]
        end

        // Display the values
        for (i = 0; i < 8; i = i + 1) begin
            $display("data[%0d] = %b", i, data[i]);
        end
    end
endmodule

