module MATRIX_MULT (
    input             clk,
    input             rst_n,
    input             in_valid,
    input      [63:0] in_data,
    output reg        out_valid,
    output reg [19:0] out_data
);

// =========================================================================
// Input matrix storage
// =========================================================================
reg [7:0] mat_a [0:7][0:7];
reg [7:0] mat_b [0:7][0:7];

// =========================================================================
// Stage 1 pipeline: 512 registered products (8 per output element, 64 elements)
// =========================================================================
reg [15:0] p1_prod [0:7][0:7][0:7];  // [row_i][col_j][k]
reg        p1_valid;

// =========================================================================
// Stage 2 output: 64 registered final sums
// =========================================================================
reg [19:0] mat_c [0:7][0:7];
reg        p2_valid;

// =========================================================================
// Output counter
// =========================================================================
reg [5:0]  out_cnt;

// =========================================================================
// Input FSM
// =========================================================================
reg [3:0] input_cnt;
reg       in_done;

integer i, j, k;

// -------------------------------------------------------------------------
// Input capture
// -------------------------------------------------------------------------
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        input_cnt <= 4'd0;
        in_done   <= 1'b0;
        for (i = 0; i < 8; i = i+1)
            for (j = 0; j < 8; j = j+1) begin
                mat_a[i][j] <= 8'd0;
                mat_b[i][j] <= 8'd0;
            end
    end else begin
        in_done <= 1'b0;
        if (in_valid) begin
            if (!input_cnt[3]) begin
                mat_a[input_cnt[2:0]][0] <= in_data[63:56];
                mat_a[input_cnt[2:0]][1] <= in_data[55:48];
                mat_a[input_cnt[2:0]][2] <= in_data[47:40];
                mat_a[input_cnt[2:0]][3] <= in_data[39:32];
                mat_a[input_cnt[2:0]][4] <= in_data[31:24];
                mat_a[input_cnt[2:0]][5] <= in_data[23:16];
                mat_a[input_cnt[2:0]][6] <= in_data[15: 8];
                mat_a[input_cnt[2:0]][7] <= in_data[ 7: 0];
            end else begin
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
                input_cnt <= 4'd0;
                in_done   <= 1'b1;
            end else begin
                input_cnt <= input_cnt + 1'b1;
            end
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        p1_valid <= 1'b0;
        for (i = 0; i < 8; i = i+1)
            for (j = 0; j < 8; j = j+1)
                for (k = 0; k < 8; k = k+1)
                    p1_prod[i][j][k] <= 16'd0;
    end else begin
        // Propagate valid
        p1_valid <= in_done;
        // Compute all products combinationally, register on clock edge
        if (in_done) begin
            for (i = 0; i < 8; i = i+1)
                for (j = 0; j < 8; j = j+1)
                    for (k = 0; k < 8; k = k+1)
                        p1_prod[i][j][k] <=
                            ({8'd0, mat_a[i][k]} * {8'd0, mat_b[k][j]});
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        p2_valid <= 1'b0;
        for (i = 0; i < 8; i = i+1)
            for (j = 0; j < 8; j = j+1)
                mat_c[i][j] <= 20'd0;
    end else begin
        p2_valid <= p1_valid;
        if (p1_valid) begin
            // Fully unrolled balanced adder tree for all 64 elements
            for (i = 0; i < 8; i = i+1) begin
                for (j = 0; j < 8; j = j+1) begin
                    mat_c[i][j] <=
                        // Level 3: add two 18-bit sums → 20-bit
                        (
                          // Level 2 left: add two 17-bit sums → 18-bit
                          (
                            // Level 1: p[0]+p[1] → 17-bit
                            ({1'b0, p1_prod[i][j][0]} + {1'b0, p1_prod[i][j][1]})
                            // Level 1: p[2]+p[3] → 17-bit
                          + ({1'b0, p1_prod[i][j][2]} + {1'b0, p1_prod[i][j][3]})
                          )
                        +
                          // Level 2 right: add two 17-bit sums → 18-bit
                          (
                            // Level 1: p[4]+p[5] → 17-bit
                            ({1'b0, p1_prod[i][j][4]} + {1'b0, p1_prod[i][j][5]})
                            // Level 1: p[6]+p[7] → 17-bit
                          + ({1'b0, p1_prod[i][j][6]} + {1'b0, p1_prod[i][j][7]})
                          )
                        );
                end
            end
        end
    end
end

// Combinational Stage 2 adder tree output (wire, not reg)
// Allows output to be registered directly in one step (no mat_c intermediate)
wire [19:0] c_wire [0:7][0:7];
genvar gi, gj;
generate
    for (gi = 0; gi < 8; gi = gi + 1) begin : rloop
        for (gj = 0; gj < 8; gj = gj + 1) begin : cloop
            assign c_wire[gi][gj] =
                (({1'b0,p1_prod[gi][gj][0]}+{1'b0,p1_prod[gi][gj][1]})
                +({1'b0,p1_prod[gi][gj][2]}+{1'b0,p1_prod[gi][gj][3]}))
               +(({1'b0,p1_prod[gi][gj][4]}+{1'b0,p1_prod[gi][gj][5]})
                +({1'b0,p1_prod[gi][gj][6]}+{1'b0,p1_prod[gi][gj][7]}));
        end
    end
endgenerate

// Output FSM: uses c_wire directly (combinational adder tree reads p1_prod regs)
// Stage 1 reg (p1_prod) → combinational adder (c_wire) → output reg (out_data)
// Latency = 2 cycles: in_done(N) → p1_valid(N+1) → out_valid(N+2)
reg [5:0] out_cnt_pipe;
reg done;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) out_cnt_pipe<=0;
    else out_cnt_pipe <=out_cnt ;
end

always @(*) begin
    done = out_cnt_pipe==6'd63;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        out_valid <= 1'b0;
        out_cnt   <= 6'd0;
    end else begin
        if (p1_valid) begin
            out_valid <= 1'b1;
            out_cnt   <= 6'd1;
        end else if (out_valid) begin
            out_cnt  <= out_cnt + 1'b1;
            if (out_cnt_pipe == 6'd63)
                out_valid <= 1'b0;
        end else begin
            out_cnt  <= 6'd0;
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        out_data  <= 20'd0;
    end else if (p1_valid) begin
        out_data <= c_wire[0][0];   
    end else if (out_valid && !done) begin
        out_data <= mat_c[out_cnt[5:3]][out_cnt[2:0]];
    end else begin
        out_data <= 20'd0;
    end
end

endmodule
//Cycle: 3.00 * lantency = 200 cycles
//Performance: 600