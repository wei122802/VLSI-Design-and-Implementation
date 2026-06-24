module MATRIX_MULT (
    input             clk,
    input             rst_n,
    input             in_valid,
    input      [63:0] in_data,
    output reg        out_valid,
    output reg [19:0] out_data
);

// -------------------------------------------------------------------------
// FSM States
// -------------------------------------------------------------------------
localparam IDLE    = 3'd0;
localparam INPUT   = 3'd1;
localparam COMPUTE = 3'd2;
localparam LATCH   = 3'd3;
localparam OUTPUT  = 3'd4;
 
reg [2:0] state;
 
// -------------------------------------------------------------------------
// Counters
// -------------------------------------------------------------------------
reg [3:0] input_cnt;  // 0..15 (tracks which row is being received)
reg [2:0] comp_k;     // 0..7  (which k-slice we are computing)
reg [5:0] out_cnt;    // 0..63 (output element index)
 
// -------------------------------------------------------------------------
// Matrix Storage
// -------------------------------------------------------------------------
reg [7:0] mat_a [0:7][0:7];
reg [7:0] mat_b [0:7][0:7];
reg [19:0] mat_c [0:7][0:7];  // Final result, read during OUTPUT
 
// -------------------------------------------------------------------------
// Accumulator (reset at start of each COMPUTE phase)
// -------------------------------------------------------------------------
reg [19:0] acc [0:7][0:7];
 
// =========================================================================
// Combined FSM + Datapath (single always block to avoid multi-drive issues)
// =========================================================================
integer i, j;
 
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state     <= IDLE;
        input_cnt <= 4'd0;
        comp_k    <= 3'd0;
        out_cnt   <= 6'd0;
        out_valid <= 1'b0;
        out_data  <= 20'd0;
        for (i = 0; i < 8; i = i+1) begin
            for (j = 0; j < 8; j = j+1) begin
                mat_a[i][j] <= 8'd0;
                mat_b[i][j] <= 8'd0;
                mat_c[i][j] <= 20'd0;
                acc[i][j]   <= 20'd0;
            end
        end
    end else begin
        out_valid <= 1'b0;
        out_data  <= 20'd0;
 
        case (state)
 
            // ----------------------------------------------------------------
            IDLE: begin
                if (in_valid) begin
                    // Capture row 0 of Matrix A
                    mat_a[0][0] <= in_data[63:56];
                    mat_a[0][1] <= in_data[55:48];
                    mat_a[0][2] <= in_data[47:40];
                    mat_a[0][3] <= in_data[39:32];
                    mat_a[0][4] <= in_data[31:24];
                    mat_a[0][5] <= in_data[23:16];
                    mat_a[0][6] <= in_data[15: 8];
                    mat_a[0][7] <= in_data[ 7: 0];
                    input_cnt   <= 4'd1;
                    state       <= INPUT;
                end
            end
 
            // ----------------------------------------------------------------
            INPUT: begin
                if (in_valid) begin
                    if (!input_cnt[3]) begin
                        // input_cnt = 1..7 → rows 1..7 of A
                        mat_a[input_cnt[2:0]][0] <= in_data[63:56];
                        mat_a[input_cnt[2:0]][1] <= in_data[55:48];
                        mat_a[input_cnt[2:0]][2] <= in_data[47:40];
                        mat_a[input_cnt[2:0]][3] <= in_data[39:32];
                        mat_a[input_cnt[2:0]][4] <= in_data[31:24];
                        mat_a[input_cnt[2:0]][5] <= in_data[23:16];
                        mat_a[input_cnt[2:0]][6] <= in_data[15: 8];
                        mat_a[input_cnt[2:0]][7] <= in_data[ 7: 0];
                    end else begin
                        // input_cnt = 8..15 → rows 0..7 of B (index = cnt & 7)
                        mat_b[input_cnt[2:0]][0] <= in_data[63:56];
                        mat_b[input_cnt[2:0]][1] <= in_data[55:48];
                        mat_b[input_cnt[2:0]][2] <= in_data[47:40];
                        mat_b[input_cnt[2:0]][3] <= in_data[39:32];
                        mat_b[input_cnt[2:0]][4] <= in_data[31:24];
                        mat_b[input_cnt[2:0]][5] <= in_data[23:16];
                        mat_b[input_cnt[2:0]][6] <= in_data[15: 8];
                        mat_b[input_cnt[2:0]][7] <= in_data[ 7: 0];
                    end
 
                    if (input_cnt == 4'd15) begin
                        // All rows received → reset accumulators and start compute
                        for (i = 0; i < 8; i = i+1)
                            for (j = 0; j < 8; j = j+1)
                                acc[i][j] <= 20'd0;
                        comp_k    <= 3'd0;
                        state     <= COMPUTE;
                        input_cnt <= 4'd0;
                    end else begin
                        input_cnt <= input_cnt + 1'b1;
                    end
                end
            end
 
            // ----------------------------------------------------------------
            // COMPUTE: 8 cycles
            //   Cycle k: acc[i][j] += mat_a[i][k] * mat_b[k][j]  (64 MACs)
            //   On k==7, go to LATCH to capture final accumulated value
            // ----------------------------------------------------------------
            COMPUTE: begin
                for (i = 0; i < 8; i = i+1)
                    for (j = 0; j < 8; j = j+1)
                        acc[i][j] <= acc[i][j]
                            + ({12'd0, mat_a[i][comp_k]} * {12'd0, mat_b[comp_k][j]});
 
                if (comp_k == 3'd7)
                    state <= LATCH;
                else
                    comp_k <= comp_k + 1'b1;
            end
 
            // ----------------------------------------------------------------
            // LATCH: 1 cycle
            //   The final accumulation (k=7) is now settled in acc[][][].
            //   Copy to mat_c[][] and move to OUTPUT.
            // ----------------------------------------------------------------
            LATCH: begin
                for (i = 0; i < 8; i = i+1)
                    for (j = 0; j < 8; j = j+1)
                        mat_c[i][j] <= acc[i][j];
                out_cnt <= 6'd0;
                state   <= OUTPUT;
            end
 
            // ----------------------------------------------------------------
            // OUTPUT: 64 cycles, row-major order
            //   out_cnt[5:3] = row, out_cnt[2:0] = col
            // ----------------------------------------------------------------
            OUTPUT: begin
                out_valid <= 1'b1;
                out_data  <= mat_c[out_cnt[5:3]][out_cnt[2:0]];
                out_cnt   <= out_cnt + 1'b1;  // wraps to 0 after 63
                if (out_cnt == 6'd63)
                    state <= IDLE;
            end
 
            default: state <= IDLE;
        endcase
    end
end


endmodule