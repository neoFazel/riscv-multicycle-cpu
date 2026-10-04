`timescale 1ns / 1ps

module top(
    input       rst,
                clk
    );
    
// requied wires for the design
wire            MemWrite,
                RegWrite,
                PCWrite,
                AdrSrc,
                zero,
                IRWrite;
            
wire [1:0]      ALUSrcA,
                ALUSrcB,
                ALUOp,
                ImmSrc,
                ResultSrc;

wire [2:0]      ALUControl;

wire [31:0]     PC,
                addr,
                ReadData,
                Result,
                rd1,
                rd2,
                OldPC,
                Data,
                A,
                WriteData,
                ALUResult,
                ALUOut,
                SrcA,
                SrcB,
                ImmExt,
                instr;
                
    
// ============================================
// ************sequential elements************
// ============================================

// program counter
program_counter programCounter(
            // inputs
            .clk(clk),
            .rst(rst),
            .en(PCWrite),
            .nextPc(Result),
            // output 
            .pc(PC)
);

// memory
Memory memory(
            // input
            .clk(clk),
            .addr(addr),
            .we(MemWrite),
            .wd(WriteData),
            // output
            .rd(ReadData)
);

// register_file
register_file registerFile(
            // inputs
            .clk(clk),
            .we3(RegWrite),
            .a1(instr[19:15]), // Rs1
            .a2(instr[24:20]), // Rs2
            .a3(instr[11:7]),  // Rd
            .wd3(Result), 
            // outputs   
            .rd1(rd1),
            .rd2(rd2)    
);

// ==============================================
// ********** non-architectural elements ******
// ==============================================    

// instruction register
flopenr instrRegister(
    .clk(clk),
    .rst(rst),
    .en(IRWrite),
    .d(ReadData),
    .q(instr)
);

// old PC container register
flopenr oldPcRegister(
    .clk(clk),
    .rst(rst),
    .en(IRWrite),
    .d(PC),
    .q(OldPC)  
); 

// data register
flopr dataRegister(
    .clk(clk),
    .rst(rst),
    .d(ReadData),
    .q(Data)
);

// rd1 register
flopr RegFileRegister1(
    .clk(clk),
    .rst(rst),
    .d(rd1),
    .q(A)  
);

// rd2 register
flopr RegFileRegister2(
    .clk(clk),
    .rst(rst),
    .d(rd2),
    .q(WriteData)  
);

// ALU register
flopr ALURegister(
    .clk(clk),
    .rst(rst),
    .d(ALUResult),
    .q(ALUOut)  
);

// ==========================================
// *********** combinational elements *******
// ==========================================

// pc, oldPc and rd1 register as inputs and SrcA as output
mux_31 mux31SrcA(
    // inputs
    .a(PC),
    .b(OldPC),
    .c(A),
    .ctrl(ALUSrcA),
    // output
    .out(SrcA)
);  

// rd2 register, ImmExt and thr value 4 as inputs and SrcB as output
mux_31 mux31SrcB(
    // inputs
    .a(WriteData),
    .b(ImmExt),
    .c(32'h00000004),
    .ctrl(ALUSrcB),
    //output
    .out(SrcB)
);

// ALUOut, Data, ALUResult as inputs and result as output
mux_31 mux31Result(
    // inputs
    .a(ALUOut),
    .b(Data),
    .c(ALUResult),
    .ctrl(ResultSrc),
    // outputs
    .out(Result)
);

// PC and Result as inputs and addr as output
mux_21 muxAddr(
    // inputs
    .a(PC),
    .b(Result),
    .ctrl(AdrSrc),
    // outputs
    .out(addr)    
);

// ALU 
ALU ALU(
    // inputs
    .a(SrcA),
    .b(SrcB),
    .ALUControl(ALUControl),
    .zero(zero),
    // outputs
    .ALUResult(ALUResult)
);

// sign extender
immediate_generator Extend(
    // inputs
    .ImmSrc(ImmSrc),
    .ImmInput(instr),
    // outputs
    .ImmExt(ImmExt)
);

// =============================================
// **************** cotrol unit ************
// =============================================  
// main controller
control_unit controller (
    .clk(clk),
    .rst(rst),
    .PCWrite(PCWrite),
    .AdrSrc(AdrSrc),
    .MemWrite(MemWrite),
    .IRWrite(IRWrite),
    .funct7(instr[30]), //bit 5th of funct7(30th bit of the instruction)
    .Zero(zero),
    .op(instr[6:0]),
    .funct3(instr[14:12]),
    .RegWrite(RegWrite),
    .ResultSrc(ResultSrc),
    .ALUSrcA(ALUSrcA),
    .ALUSrcB(ALUSrcB),
    .ALUOp(ALUOp),
    .ImmSrc(ImmSrc),
    .ALUControl(ALUControl)
);
   
    
endmodule
