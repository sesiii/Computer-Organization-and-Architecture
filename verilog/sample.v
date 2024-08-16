module counter_4bit (
    input clk,        // Clock input
    input reset,      // Asynchronous reset input
    output [3:0] q    // 4-bit counter output
);

reg [3:0] count;      // Register to hold the count value

// Always block triggered on clock edge or reset
always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 4'b0000;  // Reset the counter to 0
    end else begin
        count <= count + 1; // Increment the counter
    end
end

assign q = count; // Assign the counter value to the output

endmodule
