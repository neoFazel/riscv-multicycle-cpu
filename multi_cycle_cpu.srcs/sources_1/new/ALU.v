`timescale 1ns / 1ps

module ALU(
    input [31:0] a, b,
    input [2:0] ALUControl,
    output zero,
    output reg [31:0] ALUResult
    );

    always @(*) begin
        case(ALUControl)
            3'b000: ALUResult = a + b;
            3'b001: ALUResult = a - b;
            3'b010: ALUResult = a & b;
            3'b011: ALUResult = a | b;
            default: ALUResult = 32'b0;
        endcase
    end
    
    assign zero = (ALUResult == 32'b0) ? 1'b1 : 1'b0;
    
endmodule