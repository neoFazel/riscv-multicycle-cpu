`timescale 1ns / 1ps

module register_file(
    input           clk,
                    we3,
    input [4:0]     a1,
                    a2,
                    a3,
    input [31:0]    wd3,    
    
    output [31:0]   rd1,
                    rd2              
    );
    
reg [31:0] regFile [31:0];    

// reading form rd1 and rd2 asynchronously        
assign rd1 = (a1 != 0) ? regFile[a1] : 32'b0;
assign rd2 = (a2 != 0) ? regFile[a2] : 32'b0;

// writing to wd3 synchronously
always @(posedge clk)
begin
    if(we3 && (a3 != 0))
    begin
        regFile[a3] <=  wd3;
    end
end

//*************
//initizalize register file values later
//*************

endmodule
