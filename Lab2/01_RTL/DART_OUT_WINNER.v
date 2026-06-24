module DART_OUT_WINNER (
    input          clk,
    input          rst_n,
    input   [1:0]  state,
    input          winner,
    output reg     out_winner
);

parameter DONE = 2'd2;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        out_winner <= 1'b0;
    end else begin
        case (state)
            DONE:    out_winner <= winner;
            default: out_winner <= 1'b0;
        endcase
    end
end

endmodule
