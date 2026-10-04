`timescale 1ns / 1ps

module control_unit(
    // input
    input           clk,
                    rst,

                    funct7, //bit 5th of funct7(30th bit of the instruction)
                    Zero,
          [6:0]     op,
          [2:0]     funct3,
    // outputs
    output          RegWrite,
                    PCWrite,
                    AdrSrc,
                    MemWrite,
                    IRWrite,
          [1:0]     ResultSrc,
                    ALUSrcA,
                    ALUSrcB,
                    ALUOp,
                    ImmSrc,
          [2:0]     ALUControl       
    );
    
    
    wire Branch, 
         PCUpdate;
    // wire [1:0] ALUOp;
    
    // *************************************         
    // instantiating required modules:
    //**************************************
    
    // instruction decoder
    instr_decoder instrDecoder(
        // input
        .op(op),
        // output
        .ImmSrc(ImmSrc)
    );
    
    // ALU decoder
    ALU_decoder ALUDecoder(
        // input
        .op5(op[5]),
        .ALUOp(ALUOp),
        .funct3(funct3),
        .funct7(funct7),
        // output
        .ALUControl(ALUControl)
    );
    
    // main FSM
    main_FSM mainFsm(
        // inputs
        .clk(clk), 
        .rst(rst),
        .op(op),
        // outputs
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
    
    // PCWrite description
    assign PCWrite = ((Zero & Branch) | PCUpdate);
    
    
endmodule















