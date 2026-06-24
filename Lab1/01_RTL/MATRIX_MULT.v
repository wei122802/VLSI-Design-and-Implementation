module MATRIX_MULT(
    input             clk,
    input             rst_n,
    input             in_valid,
    input      [63:0] in_data,
    output reg        out_valid,
    output reg [19:0] out_data
);

reg [4:0]  in_cnt;
reg [6:0]  out_cnt;
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

wire is_load_A = (in_cnt[4:3] == 2'b00); 
wire is_setup  = (in_cnt == 5'd7);
wire is_mac    = (in_cnt[4:3] == 2'b01); 

wire out_active = (in_cnt == 5'd16) | (|out_cnt);
wire out_cond   = out_active & (~out_cnt[6]); 

wire [2:0] in_idx = in_cnt[2:0];
integer i, j;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) 
        in_cnt <= 5'd0;
    else if (in_valid) 
        in_cnt <= in_cnt + 1'b1;
    else 
        in_cnt <= 5'd0;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) 
        out_cnt <= 7'd0;
    else if (out_cond) 
        out_cnt <= out_cnt + 1'b1;
    else
        out_cnt <= 7'd0;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) 
        out_valid <= 1'b0;
    else 
        out_valid <= out_cond; 
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) 
        out_data <= 20'd0;
    else if (out_cond) 
        out_data <= mat_c[0][0]; 
    else 
        out_data <= 20'd0; 
end

always @(posedge clk) begin
    if (is_load_A & in_valid) begin
        for (j = 0; j < 8; j = j + 1) begin
            matrix_A[in_idx][j] <= b_row[j];
        end
    end else if (is_mac) begin
        for (i = 0; i < 8; i = i + 1) begin
            for (j = 0; j < 7; j = j + 1) begin
                matrix_A[i][j] <= matrix_A[i][j+1];
            end
        end
    end
end

always @(posedge clk) begin
    if (is_setup) begin
        for (i = 0; i < 7; i = i + 1) a_sel[i] <= matrix_A[i][0];
        a_sel[7] <= b_row[0];
    end else if (is_mac) begin
        for (i = 0; i < 8; i = i + 1) a_sel[i] <= matrix_A[i][1];
    end
end

always @(posedge clk) begin
    if (is_setup) begin
        for (i = 0; i < 8; i = i + 1) begin
            for (j = 0; j < 8; j = j + 1) mat_c[i][j] <= 20'd0;
        end
    end else if (is_mac) begin
        for (i = 0; i < 8; i = i + 1) begin
            for (j = 0; j < 8; j = j + 1) begin
                mat_c[i][j] <= mat_c[i][j] + (a_sel[i] * b_row[j]);
            end
        end
    end else if (out_cond) begin
        for (i = 0; i < 8; i = i + 1) begin
            for (j = 0; j < 7; j = j + 1) begin
                mat_c[i][j] <= mat_c[i][j+1];
            end
        end
        for (i = 0; i < 7; i = i + 1) begin
            mat_c[i][7] <= mat_c[i+1][0];
        end
        mat_c[7][7] <= 20'd0; 
    end
end

endmodule