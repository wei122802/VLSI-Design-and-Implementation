module MULT_err (
    input         clk,
    input         rst_n,
    input  signed [15:0] a,
    input  signed [15:0] b,
    output signed [31:0] out
);
    assign out = a * b; // only for synthesis, no error injection
endmodule