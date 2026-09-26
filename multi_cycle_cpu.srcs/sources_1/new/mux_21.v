module mux_21(
    input [31:0] a, b,
    input ctrl,
    output [31:0] out
    );
    
    assign out = (ctrl) ? b : a;
    
endmodule