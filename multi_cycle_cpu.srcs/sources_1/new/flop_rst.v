`timescale 1ns / 1ps

module flopr(
input               clk,
                    rst,
input  [31:0]       d,
output reg [31:0]   q             
    );
    
always@(posedge clk)
begin
    if(rst)
        q <= 32'b0;
    else 
        q <= d; 
end    
    
endmodule
