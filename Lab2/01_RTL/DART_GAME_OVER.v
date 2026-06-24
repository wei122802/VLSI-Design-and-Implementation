module DART_GAME_OVER (
    input   [8:0]  score_p0,
    input   [8:0]  score_p1,
    output         game_over
);

assign game_over = (score_p0 == 9'd0) | (score_p1 == 9'd0);

endmodule
