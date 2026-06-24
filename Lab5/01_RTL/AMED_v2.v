// Adjugate Matrix with Error Detection (AMED) module
// Architecture: 2-Multiplier Resource Sharing with 10-Cycle Pipeline (Timing Fixed)
module AMED(
    input wire clk,
    input wire rst_n,
    input wire in_valid,
    input wire [71:0] in_data,
    output reg out_valid,
    output reg [215:0] out_data
);

    // ==========================================
    // 1. 狀態機與計數器
    // ==========================================
    localparam IDLE = 1'b0;
    localparam CALC = 1'b1;
    
    reg state;
    reg [3:0] cnt; // 0 to 9

    // ==========================================
    // 2. 內部暫存器宣告
    // ==========================================
    reg signed [7:0] matrix [0:8];
    
    reg  signed [15:0] mult1_a, mult1_b;
    reg  signed [15:0] mult2_a, mult2_b;
    wire signed [31:0] mult1_out, mult2_out;
    
    reg signed [31:0] main1, main2;
    reg signed [31:0] shadow1, shadow2;
    
    // [新增] 用於對齊 Posedge 的同步暫存器，防止 negedge 提前污染運算
    reg signed [31:0] shadow1_sync, shadow2_sync;

    // ==========================================
    // 3. 實例化 2 顆 MULT_err IP
    // ==========================================
    MULT_err u_mult1 (
        .clk(clk),
        .rst_n(rst_n),
        .a(mult1_a),
        .b(mult1_b),
        .out(mult1_out)
    );

    MULT_err u_mult2 (
        .clk(clk),
        .rst_n(rst_n),
        .a(mult2_a),
        .b(mult2_b),
        .out(mult2_out)
    );

    // ==========================================
    // 4. FSM 與 計數器邏輯
    // ==========================================
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            cnt   <= 4'd0;
        end else begin
            case (state)
                IDLE: begin
                    if (in_valid) begin
                        state <= CALC;
                        cnt   <= 4'd0;
                    end
                end
                CALC: begin
                    if (cnt == 4'd9) begin
                        state <= IDLE; // 10th cycle (cnt 9), 計算完成
                        cnt   <= 4'd0;
                    end else begin
                        cnt <= cnt + 1'b1;
                    end
                end
            endcase
        end
    end

    // ==========================================
    // 5. 載入 Input Data
    // ==========================================
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            matrix[0] <= 8'd0; matrix[1] <= 8'd0; matrix[2] <= 8'd0;
            matrix[3] <= 8'd0; matrix[4] <= 8'd0; matrix[5] <= 8'd0;
            matrix[6] <= 8'd0; matrix[7] <= 8'd0; matrix[8] <= 8'd0;
        end else if (state == IDLE && in_valid) begin
            matrix[0] <= in_data[71:64];
            matrix[1] <= in_data[63:56];
            matrix[2] <= in_data[55:48];
            matrix[3] <= in_data[47:40];
            matrix[4] <= in_data[39:32];
            matrix[5] <= in_data[31:24];
            matrix[6] <= in_data[23:16];
            matrix[7] <= in_data[15:8];
            matrix[8] <= in_data[7:0];
        end
    end

    // ==========================================
    // 6. Multiplexer: 動態分配乘法器輸入
    // ==========================================
    always @(*) begin
        case (cnt)
            4'd0: begin // Adj11
                mult1_a = matrix[4]; mult1_b = matrix[8];
                mult2_a = matrix[5]; mult2_b = matrix[7];
            end
            4'd1: begin // Adj12
                mult1_a = matrix[2]; mult1_b = matrix[7];
                mult2_a = matrix[1]; mult2_b = matrix[8];
            end
            4'd2: begin // Adj13
                mult1_a = matrix[1]; mult1_b = matrix[5];
                mult2_a = matrix[2]; mult2_b = matrix[4];
            end
            4'd3: begin // Adj21
                mult1_a = matrix[5]; mult1_b = matrix[6];
                mult2_a = matrix[3]; mult2_b = matrix[8];
            end
            4'd4: begin // Adj22
                mult1_a = matrix[0]; mult1_b = matrix[8];
                mult2_a = matrix[2]; mult2_b = matrix[6];
            end
            4'd5: begin // Adj23
                mult1_a = matrix[2]; mult1_b = matrix[3];
                mult2_a = matrix[0]; mult2_b = matrix[5];
            end
            4'd6: begin // Adj31
                mult1_a = matrix[3]; mult1_b = matrix[7];
                mult2_a = matrix[4]; mult2_b = matrix[6];
            end
            4'd7: begin // Adj32
                mult1_a = matrix[1]; mult1_b = matrix[6];
                mult2_a = matrix[0]; mult2_b = matrix[7];
            end
            4'd8: begin // Adj33
                mult1_a = matrix[0]; mult1_b = matrix[4];
                mult2_a = matrix[1]; mult2_b = matrix[3];
            end
            default: begin
                mult1_a = 16'd0; mult1_b = 16'd0;
                mult2_a = 16'd0; mult2_b = 16'd0;
            end
        endcase
    end

    // ==========================================
    // 7. 雙鎖存錯誤偵測機制 (Main & Shadow)
    // ==========================================
    // Main Register (posedge 觸發)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            main1 <= 32'd0;
            main2 <= 32'd0;
        end else if (state == CALC && cnt <= 4'd8) begin
            main1 <= mult1_out;
            main2 <= mult2_out;
        end
    end

    // Shadow Register (negedge 觸發)
    always @(negedge clk or negedge rst_n) begin
        if (!rst_n) begin
            shadow1 <= 32'd0;
            shadow2 <= 32'd0;
        end else if (state == CALC && cnt <= 4'd8) begin
            shadow1 <= mult1_out;
            shadow2 <= mult2_out;
        end
    end

    // [新增] Shadow Sync Register (posedge 觸發)
    // 把 negedge 抓到的正確值，延遲對齊到 posedge，確保算術運算時資料不跳動
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            shadow1_sync <= 32'd0;
            shadow2_sync <= 32'd0;
        end else begin
            shadow1_sync <= shadow1;
            shadow2_sync <= shadow2;
        end
    end

    // 錯誤比對與資料修復 (現在比較 main 和對齊後的 shadow_sync)
    wire mult1_err = (main1 != shadow1_sync);
    wire mult2_err = (main2 != shadow2_sync);
    
    wire signed [31:0] val1 = mult1_err ? shadow1_sync : main1;
    wire signed [31:0] val2 = mult2_err ? shadow2_sync : main2;
    
    // 進行減法，並截斷為 24-bit 預防 Overflow
    wire signed [31:0] sub_32 = val1 - val2;
    wire signed [23:0] sub_result = sub_32[23:0];

    // ==========================================
    // 8. 輸出級 (精確 Shift Buffer 架構)
    // ==========================================
    reg [191:0] shift_buffer;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out_valid    <= 1'b0;
            out_data     <= 216'd0;
            shift_buffer <= 192'd0;
        end else begin
            if (state == CALC) begin
                if (cnt >= 4'd1 && cnt <= 4'd8) begin
                    shift_buffer <= {shift_buffer[167:0], sub_result};
                    out_valid    <= 1'b0;
                    out_data     <= 216'd0;
                end else if (cnt == 4'd9) begin
                    out_valid <= 1'b1;
                    out_data  <= {shift_buffer, sub_result};
                end else begin
                    out_valid <= 1'b0;
                    out_data  <= 216'd0;
                end
            end else begin
                out_valid <= 1'b0;
                out_data  <= 216'd0;
            end
        end
    end

endmodule

// version 2 :
// C = 10
// Latency: 1000
// Area: 43455.136846
// Total Power: 1.5856m
// Performance Score: 689042.94

// C = 8
// Latency: 1000
// Area: 54910.889017
// Total Power: 2.2028m
// Performance Score: 967663.63
