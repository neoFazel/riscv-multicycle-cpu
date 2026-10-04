`timescale 1ns / 1ps

module tb;

    reg clk;
    reg rst;

    top uut (
        .rst(rst),
        .clk(clk)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        #25;          
        rst = 0;      

        #250;         
       $finish;
    end

endmodule