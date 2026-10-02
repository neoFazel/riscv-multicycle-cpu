`timescale 1ns / 1ps

module tb();

// inputs
reg         clk,
            rst;
reg [6:0]   op;
// outputs
wire        Branch,
            PCUpdate,
            RegWrite,
            MemWrite,
            IRWrite,
            AdrSrc;
wire [1:0]  ResultSrc, 
            ALUSrcB,
            ALUSrcA, 
            ALUOp;
              

// instantiating main_FSM            
main_FSM uut(
        .clk(clk),
        .rst(rst),
        .op(op),
        .Branch(Branch),
        .PCUpdate(PCUpdate),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .IRWrite(IRWrite),
        .AdrSrc(AdrSrc),
        .ResultSrc(ResultSrc),
        .ALUSrcB(ALUSrcB),
        .ALUSrcA(ALUSrcA),
        .ALUOp(ALUOp)
);           
                                     
always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1'b1;
    
    // lw instruction 
    op = 7'b0000011;
    
    #15;
    rst = 1'b0;
    
    repeat(5) @(posedge clk);
    
    
    // sw instruction
    op = 7'b0100011;
    repeat(4) @(posedge clk);
    
    // R-type instruction
    op = 7'b0110011;
    repeat(4) @(posedge clk);
    
    // beq instruction
    op = 7'b1100011;
    repeat(3) @(posedge clk);
    
    
    #20;
    $finish;
end

endmodule
