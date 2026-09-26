`timescale 1ns / 1ps

module program_counter(
    input               clk,
                        rst,
                        en,
    input [31:0]        nextPc,
    output reg [31:0]   pc
    );
    
always@(posedge clk)
begin
    if(rst)
        pc <= 32'b0;
    else if (en)
        pc <= nextPc;
end    
    
endmodule
