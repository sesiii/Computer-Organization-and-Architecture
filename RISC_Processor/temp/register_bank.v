module register_bank (
    input wire [3:0] read_reg1,
    input wire [3:0] read_reg2,
    input wire [3:0] write_reg,
    input wire [31:0] write_data,
    input wire write_enable,
    output reg [31:0] data_out1,
    output reg [31:0] data_out2
);

reg [31:0] registers [0:15]; // 16 registers of 32 bits each

initial begin
    // Hardcoding initial values for registers R0 to R15
    registers[0] = 32'd0; // R0 is always 0
    registers[1] = 32'd10;
    registers[2] = 32'd20;
    registers[3] = 32'd30;
    registers[4] = 32'd40;
    registers[5] = 32'd50;
    registers[6] = 32'd60;
    registers[7] = 32'd70;
    registers[8] = 32'd80;
    registers[9] = 32'd90;
    registers[10] = 32'd100;
    registers[11] = 32'd110;
    registers[12] = 32'd120;
    registers[13] = 32'd130;
    registers[14] = 32'd140;
    registers[15] = 32'd150;
end

always @(*) begin
    data_out1 = registers[read_reg1];
    data_out2 = registers[read_reg2];
end

always @(posedge write_enable) begin
    registers[write_reg] <= write_data;
end

endmodule