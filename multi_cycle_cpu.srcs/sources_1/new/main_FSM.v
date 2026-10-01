`timescale 1ns / 1ps

module main_FSM(
    input               clk,
                        rst,
    input               [6:0] op,
    output reg          Branch,
                        PCUpdate,
                        RegWrite,
                        MemWrite,
                        IRWrite,
                        AdrSrc,         // address taking from pc to memory
    output reg [1:0]    ResultSrc,
                        ALUSrcB,
                        ALUSrcA,
                        ALUOp
    );  
    
// parameter of differentr types of instructions
parameter op_lw     = 7'b0000011;
parameter op_sw     = 7'b0100011;
parameter op_R_type = 7'b0110011;
parameter op_beq    = 7'b1100011;
    
// parameter for FSM states
parameter S_FETCH       = 4'd0;
parameter S_DECODE      = 4'd1;
parameter S_MEM_ADDR    = 4'd2;
parameter S_MEM_READ    = 4'd3;
parameter S_MEM_WB      = 4'd4;
parameter S_MEM_WRITE   = 4'd5;
parameter S_EXECUTE_R   = 4'd6;
parameter S_ALU_WB      = 4'd7;
parameter S_BEQ         = 4'd10;
    
reg [3:0] current_state, next_state;
    
// reset logic
always @(posedge clk, posedge rst)
begin
    if(rst)
        current_state <= S_FETCH;
    else 
        current_state <= next_state;
end
   
// Next State Logic
always @(*)
begin 
    
    case(current_state)
            
        S_FETCH: next_state = S_DECODE; 
        S_DECODE: begin
            case(op)
                op_lw:      next_state = S_MEM_ADDR;
                op_sw:      next_state = S_MEM_ADDR; 
                op_R_type:  next_state = S_EXECUTE_R;
                op_beq:     next_state = S_BEQ;         
            endcase
        end
        S_MEM_ADDR: begin
            case(op)
                op_lw: next_state = S_MEM_READ;
                op_sw: next_state = S_MEM_WRITE;
            endcase
        end 
        S_MEM_READ: next_state   = S_MEM_WB;
        S_MEM_WB: next_state     = S_FETCH;
        S_MEM_WRITE: next_state  = S_FETCH;
        S_EXECUTE_R: next_state  = S_ALU_WB; 
        S_ALU_WB: next_state     = S_FETCH; 
        S_BEQ: next_state        = S_FETCH;
                
    endcase
    
end
    
// output control logic
always @(*)
begin

    Branch      = 1'b0;
    PCUpdate    = 1'b0;
    RegWrite    = 1'b0;
    MemWrite    = 1'b0;
    IRWrite     = 1'b0;
    AdrSrc      = 1'b0;         
    ResultSrc   = 2'b00;
    ALUSrcB     = 2'b00;
    ALUSrcA     = 2'b00;
    ALUOp       = 2'b00;
        
    case(current_state)
    
        // s0: fetch
        S_FETCH: begin
            AdrSrc      = 1'b0; 
            IRWrite     = 1'b1; 
            ALUSrcA     = 2'b00;
            ALUSrcB     = 2'b10;
            ALUOp       = 2'b00;
            ResultSrc   = 2'b10;
            PCUpdate    = 1'b1;
        end
          
        // s1: DECODE    
        S_DECODE: begin
            ALUSrcA = 2'b01;
            ALUSrcB = 2'b01;
            ALUOp   = 2'b00;
        end
        
        // s2: MEM_ADDR            
        S_MEM_ADDR: begin
            ALUSrcA = 2'b10;
            ALUSrcB = 2'b01;
            ALUOp   = 2'b00;
        end  
         
        // s3: MEM_READ        
        S_MEM_READ: begin
            ResultSrc   = 2'b00;
            AdrSrc      = 1'b1;
        end   
        
        //s4: MEM_WB        
        S_MEM_WB: begin
            ResultSrc   = 2'b01;
            RegWrite    = 1'b1;
        end
        
        // s5: MEM_WRITE
        S_MEM_WRITE: begin
            ResultSrc = 2'b00;
            AdrSrc = 1'b1;
            MemWrite = 1'b1;
        end
        
        // s6: EXECUTE_R
        S_EXECUTE_R: begin
            ALUSrcA = 2'b10;
            ALUSrcB = 2'b00;
            ALUOp   = 2'b10;
        end
        
        // s7: ALU_WB
        S_ALU_WB: begin
            ResultSrc = 2'b00; 
            RegWrite  = 1'b1;
        end
        
        // s10 : BEQ
        S_BEQ: begin
            ALUSrcA     = 2'b10;
            ALUSrcB     = 2'b00;
            ALUOp       = 2'b01;
            ResultSrc   = 2'b00;
            Branch      = 1'b1;
        end
                        
   endcase
    
end
    
    
    
endmodule


