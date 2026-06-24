module MATRIX_MULT(
    input             clk,
    input             rst_n,
    input             in_valid,
    input      [63:0] in_data,
    output reg        out_valid,
    output reg [19:0] out_data
);

reg [4:0] in_cnt;
reg [6:0] out_cnt;
reg [7:0]  matrix_A [0:7][0:7];
reg [19:0] mat_c    [0:7][0:7];
reg [7:0]  a_sel    [0:7];

wire [7:0] b_row [0:7];
assign b_row[0] = in_data[63:56];
assign b_row[1] = in_data[55:48];
assign b_row[2] = in_data[47:40];
assign b_row[3] = in_data[39:32];
assign b_row[4] = in_data[31:24];
assign b_row[5] = in_data[23:16];
assign b_row[6] = in_data[15: 8];
assign b_row[7] = in_data[ 7: 0];

wire [15:0] prod [0:7][0:7];
genvar gi, gj;
generate
    for (gi = 0; gi < 8; gi = gi + 1) begin : GI
        for (gj = 0; gj < 8; gj = gj + 1) begin : GJ
            assign prod[gi][gj] = a_sel[gi] * b_row[gj];
        end
    end
endgenerate

integer i, j;

// =========================================================================
// 1. in_cnt 控制邏輯
// =========================================================================
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        in_cnt <= 5'd0;
    end else begin
        if (in_valid) begin
            in_cnt <= in_cnt + 1'b1;
        end else begin
            in_cnt <= 5'd0;
        end
    end
end

// =========================================================================
// 2. out_cnt 控制邏輯
// =========================================================================
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) 
        out_cnt <= 7'd0;
    else if ((in_cnt == 5'd16 || out_cnt > 0) && (out_cnt < 7'd64) ) 
        out_cnt <= out_cnt + 1'b1;
    else
        out_cnt <= 7'd0;
end

// =========================================================================
// 3. out_valid 輸出邏輯
// =========================================================================
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) 
        out_valid <= 1'b0;
    else if ((in_cnt == 5'd16 || out_cnt > 0) && (out_cnt < 7'd64)) 
        out_valid <= 1'b1;
    else 
        out_valid <= 1'b0; 
end

// =========================================================================
// 4. out_data 輸出邏輯
// =========================================================================
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        out_data <= 20'd0;
    end else begin
        if ((in_cnt == 5'd16 || out_cnt > 0) && (out_cnt < 7'd64)) begin
            out_data <= mat_c[out_cnt[5:3]][out_cnt[2:0]];
        end else begin
            out_data <= 20'd0; // 包含原先寫在前面的預設 out_data <= 0
        end
    end
end

// =========================================================================
// 5. matrix_A 暫存器陣列
// =========================================================================
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (i = 0; i < 8; i = i + 1) begin
            for (j = 0; j < 8; j = j + 1) begin
                matrix_A[i][j] <= 8'd0;
            end
        end
    end else begin
        if (in_cnt < 5'd8) begin
            for (j = 0; j < 8; j = j + 1) begin
                matrix_A[in_cnt[2:0]][j] <= b_row[j];
            end
        end
    end
end

// =========================================================================
// 6. mat_c 累加器陣列
// =========================================================================
always @(posedge clk) begin
    if (in_cnt == 5'd7) begin // 準備開始計算前先清零
        for (i = 0; i < 8; i = i + 1) begin
            for (j = 0; j < 8; j = j + 1) begin
                mat_c[i][j] <= 20'd0;
            end
        end
    end else if (in_cnt >= 5'd8 && in_cnt < 5'd16) begin // 執行 MAC 累加
        for (i = 0; i < 8; i = i + 1) begin
            for (j = 0; j < 8; j = j + 1) begin
                mat_c[i][j] <= mat_c[i][j] + prod[i][j];
            end
        end
    end
end

// =========================================================================
// 7. a_sel 選擇器陣列
// =========================================================================
always @(posedge clk) begin
    // if (!rst_n) begin
    //     for (i = 0; i < 8; i = i + 1) begin
    //         a_sel[i] <= 8'd0;
    //     end
    // end else begin
        // if (in_valid) begin
            if (in_cnt == 5'd7) begin
                a_sel[0] <= matrix_A[0][0];
                a_sel[1] <= matrix_A[1][0];
                a_sel[2] <= matrix_A[2][0];
                a_sel[3] <= matrix_A[3][0];
                a_sel[4] <= matrix_A[4][0];
                a_sel[5] <= matrix_A[5][0];
                a_sel[6] <= matrix_A[6][0];
                a_sel[7] <= b_row[0];
            end else if (in_cnt >= 5'd8 && in_cnt < 5'd15) begin
                a_sel[0] <= matrix_A[0][in_cnt[2:0] + 1'b1];
                a_sel[1] <= matrix_A[1][in_cnt[2:0] + 1'b1];
                a_sel[2] <= matrix_A[2][in_cnt[2:0] + 1'b1];
                a_sel[3] <= matrix_A[3][in_cnt[2:0] + 1'b1];
                a_sel[4] <= matrix_A[4][in_cnt[2:0] + 1'b1];
                a_sel[5] <= matrix_A[5][in_cnt[2:0] + 1'b1];
                a_sel[6] <= matrix_A[6][in_cnt[2:0] + 1'b1];
                a_sel[7] <= matrix_A[7][in_cnt[2:0] + 1'b1];
            end
        // end
    // end
end

endmodule

//3.3cc = -0.50