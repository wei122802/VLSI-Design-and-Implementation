module DART_COUNTER (
    input         clk,
    input         rst_n,
    input         in_valid,
    input  [1:0]  state,
    output reg  [4:0]  dart_count
);

parameter IDLE = 2'd0;
parameter PLAY = 2'd1;
parameter DONE = 2'd2;

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) dart_count <=0;
    else
        case (state)
            IDLE: begin
                case (in_valid)
                    1'b1:    dart_count <= 5'd1;
                    default: dart_count <= 5'd0;
                endcase
            end
            PLAY: begin
                case (in_valid)
                    1'b1:    dart_count <= dart_count + 5'd1;
                    default: dart_count <= dart_count;
                endcase
            end
            DONE: begin
                dart_count <= 5'd0;
            end
            default: dart_count <= 5'd0;
        endcase
end

endmodule
