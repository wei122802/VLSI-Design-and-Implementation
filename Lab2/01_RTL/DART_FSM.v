module DART_FSM (
    input          clk,
    input          rst_n,
    input          in_valid,
    input   [4:0]  dart_count,  
    output reg  [1:0]  state,
    output reg  [1:0]  next_state
);

parameter IDLE  = 2'd0;
parameter PLAY  = 2'd1;
parameter DONE  = 2'd2;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        IDLE: begin
            case (in_valid)
                1'b1:    next_state = PLAY;
                default: next_state = IDLE;
            endcase
        end
        PLAY: begin
            case (dart_count)
                5'd19:   next_state = DONE;
                default: next_state = PLAY;
            endcase
        end
        DONE: begin
            next_state = IDLE;
        end
        default: next_state = IDLE;
    endcase
end

endmodule