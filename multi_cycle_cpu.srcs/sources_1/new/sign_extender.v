`timescale 1ns / 1ps

module immediate_generator(
    input [1:0] ImmSrc,
    input [31:0] ImmInput,
    output reg [31:0] ImmExt
    );
    
always @(*) begin
    ImmExt = 32'b0;

    case (ImmSrc)
        2'b00:    ImmExt = {{20{ImmInput[31]}}, ImmInput[31:20]};          
        2'b01:    ImmExt = {{20{ImmInput[31]}}, ImmInput[31:25], ImmInput[11:7]}; 
        3'b10:    ImmExt = {{20{ImmInput[31]}}, ImmInput[7], ImmInput[30:25], ImmInput[11:8], 1'b0};
        default: ImmExt = 32'b0; 
    endcase
end  
    
endmodule
