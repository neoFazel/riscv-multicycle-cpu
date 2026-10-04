`timescale 1ns / 1ps

module Memory (
    input               clk,
    input               we,
    input      [31:0]   addr,
    input      [31:0]   wd,
    output reg [31:0]   rd
);

    // 32 words = 128 bytes, word-addressed by addr[6:2]
    reg [31:0] RAM [0:31];
    integer k;

    // ----------------------------
    // Program + Data initialization
    // ----------------------------
    initial begin
        // 1) Clear whole memory to avoid X in simulation
        for (k = 0; k < 32; k = k + 1)
            RAM[k] = 32'h00000000;

         RAM[0] = 32'h0004A303;   // lw x6, 0(x9) lw instruction example for behavioral simulation verification
        
//        RAM[0] = 32'h0064A023;    // sw x6,0(x9)  sw instruction example for behavioral simulation verification

//        RAM[0] = 32'h009303B3;    // add x7,x6,x9 R-type instruction example for behavioral simulation verification   

//          RAM[0] = 32'h00630463;    // beq x6,x6,8 beq instruction example for behavioral simulation verification
            
    end

    // ----------------------------
    // Synchronous write (store)
    // ----------------------------
    always @(posedge clk) begin
        if (we) begin
            RAM[addr[6:2]] <= wd;
        end
    end

    // ----------------------------
    // Asynchronous read (fetch/load)
    // ----------------------------
    always @(*) begin
        rd = RAM[addr[6:2]];
    end

endmodule