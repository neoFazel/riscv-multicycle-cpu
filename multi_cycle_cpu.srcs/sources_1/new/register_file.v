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

// random values for register file
initial
begin
    regFile[0] = 0;
    regFile[1] = 14;
    regFile[2] = 5;
    regFile[3] = 11;
    regFile[4] = 5;
    regFile[5] = 15;
    regFile[6] = 7;
    regFile[7] = 10;
    regFile[8] = 12;
    regFile[9] = 5;
    regFile[10] = 6;
    regFile[11] = 6;
    regFile[12] = 4;
    regFile[13] = 35;
    regFile[14] = 74;
    regFile[15] = 32;
    regFile[16] = 45;
    regFile[17] = 42;
    regFile[18] = 55;
    regFile[19] = 42;
    regFile[20] = 45;
    regFile[21] = 42;
    regFile[22] = 24;
    regFile[23] = 16;
    regFile[24] = 25;
    regFile[25] = 24;
    regFile[26] = 7;
    regFile[27] = 19;
    regFile[28] = 1;
    regFile[29] = 7;
    regFile[30] = 19;
    regFile[31] = 10;
 end

endmodule
