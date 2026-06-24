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
reg [7:0]  matrix_B [0:7][0:7];
reg [19:0] mat_c    [0:7][0:7];

wire [7:0] b_row [0:7];
assign b_row[0] = in_data[63:56];
assign b_row[1] = in_data[55:48];
assign b_row[2] = in_data[47:40];
assign b_row[3] = in_data[39:32];
assign b_row[4] = in_data[31:24];
assign b_row[5] = in_data[23:16];
assign b_row[6] = in_data[15: 8];
assign b_row[7] = in_data[ 7: 0];

integer i, j;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) 
        in_cnt <= 5'd0;
     else if (in_valid) 
        in_cnt <= in_cnt + 1'b1;
    else 
        in_cnt <= 5'd0;
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
        if ((in_cnt < 5'd8)&&in_valid) begin
            for (j = 0; j < 8; j = j + 1) begin
                matrix_A[in_cnt[2:0]][j] <= b_row[j];
            end
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (i = 0; i < 8; i = i + 1) begin
            for (j = 0; j < 8; j = j + 1) begin
                matrix_B[i][j] <= 8'd0;
            end
        end
    end else begin
        if ((in_cnt >= 5'd8 )&& in_valid) begin
            for (j = 0; j < 8; j = j + 1) begin
                matrix_B[in_cnt[2:0]][j] <= b_row[j];
            end
        end
    end
end

// =========================================================================
// 6. mat_c 累加器陣列
// =========================================================================
always @(*) begin
    for (i = 0; i < 8; i = i + 1) begin
        mat_c[i][0] = matrix_A[i][0] * matrix_B[0][0] + matrix_A[i][1] * matrix_B[1][0] + matrix_A[i][2] * matrix_B[2][0] + matrix_A[i][3] * matrix_B[3][0] + 
                       matrix_A[i][4] * matrix_B[4][0] + matrix_A[i][5] * matrix_B[5][0] + matrix_A[i][6] * matrix_B[6][0] + matrix_A[i][7] * matrix_B[7][0];
        mat_c[i][1] = matrix_A[i][0] * matrix_B[0][1] + matrix_A[i][1] * matrix_B[1][1] + matrix_A[i][2] * matrix_B[2][1] + matrix_A[i][3] * matrix_B[3][1] + 
                       matrix_A[i][4] * matrix_B[4][1] + matrix_A[i][5] * matrix_B[5][1] + matrix_A[i][6] * matrix_B[6][1] + matrix_A[i][7] * matrix_B[7][1];
        mat_c[i][2] = matrix_A[i][0] * matrix_B[0][2] + matrix_A[i][1] * matrix_B[1][2] + matrix_A[i][2] * matrix_B[2][2] + matrix_A[i][3] * matrix_B[3][2] + 
                       matrix_A[i][4] * matrix_B[4][2] + matrix_A[i][5] * matrix_B[5][2] + matrix_A[i][6] * matrix_B[6][2] + matrix_A[i][7] * matrix_B[7][2];
        mat_c[i][3] = matrix_A[i][0] * matrix_B[0][3] + matrix_A[i][1] * matrix_B[1][3] + matrix_A[i][2] * matrix_B[2][3] + matrix_A[i][3] * matrix_B[3][3] + 
                       matrix_A[i][4] * matrix_B[4][3] + matrix_A[i][5] * matrix_B[5][3] + matrix_A[i][6] * matrix_B[6][3] + matrix_A[i][7] * matrix_B[7][3];
        mat_c[i][4] = matrix_A[i][0] * matrix_B[0][4] + matrix_A[i][1] * matrix_B[1][4] + matrix_A[i][2] * matrix_B[2][4] + matrix_A[i][3] * matrix_B[3][4] + 
                       matrix_A[i][4] * matrix_B[4][4] + matrix_A[i][5] * matrix_B[5][4] + matrix_A[i][6] * matrix_B[6][4] + matrix_A[i][7] * matrix_B[7][4];
        mat_c[i][5] = matrix_A[i][0] * matrix_B[0][5] + matrix_A[i][1] * matrix_B[1][5] + matrix_A[i][2] * matrix_B[2][5] + matrix_A[i][3] * matrix_B[3][5] +
                          matrix_A[i][4] * matrix_B[4][5] + matrix_A[i][5] * matrix_B[5][5] + matrix_A[i][6] * matrix_B[6][5] + matrix_A[i][7] * matrix_B[7][5];
        mat_c[i][6] = matrix_A[i][0] * matrix_B[0][6] + matrix_A[i][1] * matrix_B[1][6] + matrix_A[i][2] * matrix_B[2][6] + matrix_A[i][3] * matrix_B[3][6] +
                          matrix_A[i][4] * matrix_B[4][6] + matrix_A[i][5] * matrix_B[5][6] + matrix_A[i][6] * matrix_B[6][6] + matrix_A[i][7] * matrix_B[7][6];
        mat_c[i][7] = matrix_A[i][0] * matrix_B[0][7] + matrix_A[i][1] * matrix_B[1][7] + matrix_A[i][2] * matrix_B[2][7] + matrix_A[i][3] * matrix_B[3][7] +
                          matrix_A[i][4] * matrix_B[4][7] + matrix_A[i][5] * matrix_B[5][7] + matrix_A[i][6] * matrix_B[6][7] + matrix_A[i][7] * matrix_B[7][7];
    end
end


endmodule