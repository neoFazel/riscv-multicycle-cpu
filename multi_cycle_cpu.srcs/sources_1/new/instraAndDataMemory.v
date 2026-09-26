`timescale 1ns / 1ps

module Memory(
    input               clk,
                        we,
    input [31:0]        addr,
                        wd,
    output reg [31:0]   rd
    );
    integer k;
    
    reg [31:0] RAM [0:63]; // memory is able to store 64 32-bit words
                           // note: the first 32 words store instruction, while the rest is used to store and read data
    
    //****************
    // instructions will be added here
    //***************
    
    // initializing the memory words related to memory section( from word 32th onward)
    initial 
    begin
        for(k=32;k<64;k=k+1)
        begin
            RAM[k] = 32'b0;
        end
    end 
     
        
    // writing data in to the RAM is synchronous
    always@(posedge clk)
    begin
        if(we)
            RAM[addr[31:2]] <= wd;
    end
    
    // reading data is asynchronous
    always@(*)
    begin
        rd = RAM[addr[31:2]];
    end
    
    
endmodule
