`timescale 1ns / 1ps

module flopenr(
    input               clk,
                        rst,
                        en,
    input [31:0]        d,
    output reg [31:0]   q
    );
    
always@(posedge clk)
begin
    if(rst)
        q <= 32'b0;
    else if (en)
        q <= d; 
end
 
endmodule
