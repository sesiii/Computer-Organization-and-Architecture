module hamming_code_4bit (
  input  wire [3:0] data_in,
  output wire [6:0] encoded_data,
  input  wire [6:0] received_data,
  output wire [3:0] corrected_data,
  output wire error_detected
);

  // Calculate parity bits for encoding
  assign encoded_data[0] = data_in[0] ^ data_in[1] ^ data_in[3]; // Parity bit P1
  assign encoded_data[1] = data_in[0] ^ data_in[2] ^ data_in[3]; // Parity bit P2
  assign encoded_data[2] = data_in[0];                     // Data bit D1
  assign encoded_data[3] = data_in[1] ^ data_in[2] ^ data_in[3]; // Parity bit P4
  assign encoded_data[4] = data_in[1];                     // Data bit D2
  assign encoded_data[5] = data_in[2];                     // Data bit D3
  assign encoded_data[6] = data_in[3];                     // Data bit D4

  // Calculate syndrome bits for error detection
  wire s1 = received_data[0] ^ received_data[2] ^ received_data[4] ^ received_data[6];
  wire s2 = received_data[1] ^ received_data[2] ^ received_data[5] ^ received_data[6];
  wire s4 = received_data[3] ^ received_data[4] ^ received_data[5] ^ received_data[6];

  // Error detection
  assign error_detected = s1 | s2 | s4; 

  // Error correction (single-bit error) using a case statement
  reg [6:0] corrected_received_data;
  always @(*) begin
    corrected_received_data = received_data; // Default: no correction
    case ({s4, s2, s1})
      3'b001 : corrected_received_data[0] = ~received_data[0]; // Error in bit 0
      3'b010 : corrected_received_data[1] = ~received_data[1]; // Error in bit 1
      3'b011 : corrected_received_data[2] = ~received_data[2]; // Error in bit 2
      3'b100 : corrected_received_data[3] = ~received_data[3]; // Error in bit 3
      3'b101 : corrected_received_data[4] = ~received_data[4]; // Error in bit 4
      3'b110 : corrected_received_data[5] = ~received_data[5]; // Error in bit 5
      3'b111 : corrected_received_data[6] = ~received_data[6]; // Error in bit 6
      default: ; // No correction needed
    endcase
  end

  // Extract corrected data
  assign corrected_data[0] = corrected_received_data[2];
  assign corrected_data[1] = corrected_received_data[4];
  assign corrected_data[2] = corrected_received_data[5];
  assign corrected_data[3] = corrected_received_data[6];

endmodule

module hamming_code_4bit_tb;

  reg [3:0] data_in;
  wire [6:0] encoded_data;
  wire [3:0] corrected_data;
  wire error_detected;

  // Use a reg to drive received_data
  reg [6:0] received_data;

  // Instantiate the Hamming code module
  hamming_code_4bit hamming_code_inst (
    .data_in(data_in),
    .encoded_data(encoded_data),
    .received_data(received_data), // Connect to the reg
    .corrected_data(corrected_data),
    .error_detected(error_detected)
  );

  // Use a reg to modify encoded_data for error injection
  reg [6:0] encoded_data_with_error; 

  initial begin
    // Test case 1: No errors
    data_in = 4'b1011;
    #10;
    received_data = encoded_data; // Assign encoded data to received_data
    $display("Test Case 1: No errors");
    $display("Input Data: %b", data_in);
    $display("Encoded Data: %b", encoded_data);
    $display("Corrected Data: %b", corrected_data);
    $display("Error Detected: %b", error_detected);

    // Test case 2: Single-bit error (bit 0 flipped)
    data_in = 4'b1011;
    #10;
    encoded_data_with_error = encoded_data; // Copy to avoid modifying the original wire
    encoded_data_with_error[0] = ~encoded_data_with_error[0]; // Introduce an error
    received_data = encoded_data_with_error; // Assign to received_data
    #10; // Allow for correction
    $display("Test Case 2: Single-bit error (bit 0 flipped)");
    $display("Input Data: %b", data_in);
    $display("Encoded Data (with error): %b", encoded_data_with_error);
    $display("Corrected Data: %b", corrected_data);
    $display("Error Detected: %b", error_detected);

    // Test case 3: Single-bit error (bit 3 flipped)
    data_in = 4'b1011;
    #10;
    encoded_data_with_error = encoded_data; // Copy to avoid modifying the original wire
    encoded_data_with_error[3] = ~encoded_data_with_error[3]; // Introduce an error
    received_data = encoded_data_with_error; // Assign to received_data
    #10; // Allow for correction
    $display("Test Case 3: Single-bit error (bit 3 flipped)");
    $display("Input Data: %b", data_in);
    $display("Encoded Data (with error): %b", encoded_data_with_error);
    $display("Corrected Data: %b", corrected_data);
    $display("Error Detected: %b", error_detected);

    // ... Add more test cases as needed ...

    $finish;
  end

endmodule