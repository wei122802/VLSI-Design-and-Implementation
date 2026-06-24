module DART_PLAYER_SCORE (
    input         clk,
    input         rst_n,
    input         update_en,   
    input         game_over, 
    input  [1:0]  state,      
    input  [9:0]  next_score_sub, 
    output reg  [8:0]  score   
);

parameter IDLE = 2'd0;
parameter PLAY = 2'd1;
parameter DONE = 2'd2;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        score <= 9'd301;
    end else begin
        case (state)
            IDLE: begin
                case (update_en & ~next_score_sub[9])
                    1'b1   : score <= next_score_sub[8:0];
                    default: score <= score;
                endcase
            end
            PLAY: begin
                case ({game_over, update_en})
                    2'b01: begin
                        case (next_score_sub[9])
                            1'b1:    score <= score;
                            default: score <= next_score_sub[8:0];
                        endcase
                    end
                    default: score <= score;
                endcase
            end
            DONE:    score <= 9'd301;
            default: score <= 9'd301;
        endcase
    end
end

endmodule