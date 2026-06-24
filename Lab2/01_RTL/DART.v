// ==========================================
// include your module here
// e.g. `include "DART_FSM.v"
// ==========================================
`include "DART_FSM.v"
`include "DART_COUNTER.v"
`include "DART_UPDATE_EN.v"
`include "DART_SCORE_CALC.v"
`include "DART_PLAYER_SCORE.v"
`include "DART_GAME_OVER.v"
`include "DART_WINNER.v"
`include "DART_OUT_VALID.v"
`include "DART_OUT_WINNER.v"
`include "DART_NEXT_SCORE.v"

module DART (
    input        clk,
    input        rst_n,
    input        in_valid,
    input        player,
    input        is_double,
    input        is_triple,
    input  [4:0] points,
    output       out_valid,
    output       out_winner
);

    // ==========================================
    // Internal Wires
    // ==========================================

wire [1:0]  state;
wire [1:0]  next_state;
wire [4:0]  dart_count;
wire        update_en_p0;
wire        update_en_p1;
wire [5:0]  throw_score;
wire [8:0]  score_p0;
wire [8:0]  score_p1;
wire [9:0]  next_score_sub1,next_score_sub2;
wire        game_over;
wire        winner;
 
DART_FSM u_fsm (
    .clk        (clk),
    .rst_n      (rst_n),
    .in_valid   (in_valid),
    .dart_count (dart_count),
    .state      (state),
    .next_state (next_state)
);
 
DART_COUNTER u_counter (
    .clk        (clk),
    .rst_n      (rst_n),
    .in_valid   (in_valid),
    .state      (state),
    .dart_count (dart_count)
);

DART_UPDATE_EN u_update_en (
    .in_valid      (in_valid),
    .player        (player),
    .update_en_p0  (update_en_p0),
    .update_en_p1  (update_en_p1)
);

DART_SCORE_CALC u_score_calc (
    .is_double  (is_double),
    .is_triple  (is_triple),
    .points     (points),
    .score      (throw_score)
);


DART_NEXT_SCORE u_next_score1(
    .score  (score_p0) ,
    .throw_score (throw_score),
    .next_score (next_score_sub1)
);

DART_NEXT_SCORE u_next_score2(
    .score  (score_p1) ,
    .throw_score (throw_score),
    .next_score (next_score_sub2)
);

DART_PLAYER_SCORE u_p0_score (
    .clk         (clk),
    .rst_n       (rst_n),
    .update_en   (update_en_p0),
    .game_over   (game_over),
    .state       (state),
    .next_score_sub (next_score_sub1),
    .score       (score_p0)
);
 
DART_PLAYER_SCORE u_p1_score (
    .clk         (clk),
    .rst_n       (rst_n),
    .update_en   (update_en_p1),
    .game_over   (game_over),
    .state       (state),
    .next_score_sub (next_score_sub2),
    .score       (score_p1)
);
 
DART_GAME_OVER u_game_over (
    .score_p0   (score_p0),
    .score_p1   (score_p1),
    .game_over  (game_over)
);
 
DART_WINNER u_winner (
    .score_p0   (score_p0),
    .score_p1   (score_p1),
    .winner     (winner)
);
 
DART_OUT_VALID u_out_valid (
    .clk       (clk),
    .rst_n     (rst_n),
    .state     (state),
    .out_valid (out_valid)
);
 
DART_OUT_WINNER u_out_winner (
    .clk        (clk),
    .rst_n      (rst_n),
    .state      (state),
    .winner     (winner),
    .out_winner (out_winner)
);

//=============================
// original
// CYCLE 2.9 
// Area: 4803.642008
//=============================
// DART_PLAYER_SCORE.v case state -> if state
// Cycle: 2.90
// Area: 4114.497625
//=============================
// DART_COUNTER.v remove rst_n but 03 will problem
// Cycle: 2.90
// Area: 4077.154830
//=============================
// using case statements
// Cycle: 2.90
// Area: 4235.012999

// DART_PLAYER_SCORE using case statements 
// Cycle: 2.90
// Area: 4384.384211
//=============================
//final :
// Cycle: 3.00
// Area: 4207.854600




//=============================
endmodule