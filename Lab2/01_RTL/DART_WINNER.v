module DART_WINNER (
    input  [8:0]  score_p0,
    input  [8:0]  score_p1,
    output reg    winner  
);

always @(*) begin
    case (score_p1 < score_p0)
        1       :  winner = 1;
        default :  winner = 0;
    endcase
end

// assign winner = (score_p1 < score_p0) ? 1'b1 : 1'b0;

endmodule