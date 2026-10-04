`timescale 1ns / 1ps

module instr_decoder(
    input      [6:0] op,
    output reg [1:0] ImmSrc
);

    always @(*) begin
        case (op)
            7'b0000011: ImmSrc = 2'b00;   // lw   (I-type)
            7'b0010011: ImmSrc = 2'b00;   // addi (I-type)
            7'b0100011: ImmSrc = 2'b01;   // sw   (S-type)
            7'b1100011: ImmSrc = 2'b10;   // beq  (B-type)
            7'b1101111: ImmSrc = 2'b11;   // jal  (J-type)
            default:    ImmSrc = 2'b00;   // R-type ? ????
        endcase
    end

endmodule