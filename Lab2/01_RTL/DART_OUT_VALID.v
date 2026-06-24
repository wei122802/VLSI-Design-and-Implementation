module DART_OUT_VALID (
    input          clk,
    input          rst_n,
    input   [1:0]  state,
    output reg     out_valid
);

parameter DONE = 2'd2;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        out_valid <= 1'b0;
    end else begin
        case (state)
            DONE:    out_valid <= 1'b1;
            default: out_valid <= 1'b0;
        endcase
    end
end

endmodule