`timescale 1ns / 1ps

module instr_decoder(   // instr_decoder recieve's op and only generate ImmSrc control bits
    input [6:0] op, 
    output reg [1:0] ImmSrc
    );
    
initial begin

case(op)

    7'b0000011: ImmSrc = 2'b00;    // lw instruction
    7'b0100011: ImmSrc = 2'b01;    // sw intruction
    7'b0110011: ImmSrc = 2'bxx;    // R-type instructions
    7'b1100011: ImmSrc = 2'b10;    // beq intruction
    7'b0010011: ImmSrc = 2'b00;    // I-type ALU instruction
    7'b1101111: ImmSrc = 2'b11;    // jal instruction
    
endcase
    
end
    
endmodule
