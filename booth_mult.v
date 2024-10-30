module booth_multiplier #(parameter REG_WIDTH = 4, parameter OUT_WIDTH = 8)(
    input [REG_WIDTH-1:0] A, B,
    output reg [OUT_WIDTH-1:0] P
);

    reg [OUT_WIDTH-1:0] partial_sum;
    reg [REG_WIDTH:0] booth_reg; // Extended by 1 bit for Booth encoding
    integer i;

    always @(*) begin
        booth_reg = {B, 1'b0}; // Extend B by appending a zero at the LSB for Booth encoding
        partial_sum = 0;

        // Radix-4 Booth Encoding Loop
        for (i = 0; i < REG_WIDTH / 2; i = i + 1) begin
            case (booth_reg[2:0])
                3'b000, 3'b111: partial_sum = partial_sum;            // No addition
                3'b001, 3'b010: partial_sum = partial_sum + (A << (2 * i)); // Add A shifted by 2*i
                3'b011:          partial_sum = partial_sum + (A << (2 * i + 1)); // Add 2 * A shifted
                3'b100:          partial_sum = partial_sum - (A << (2 * i + 1)); // Subtract 2 * A shifted
                3'b101, 3'b110:  partial_sum = partial_sum - (A << (2 * i)); // Subtract A shifted
            endcase
            booth_reg = booth_reg >> 2; // Shift booth_reg by 2 for next pair
        end
        
        // Assign the final product
        P = partial_sum;
    end

endmodule
