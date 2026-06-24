// Adjugate Matrix with Error Detection (AMED) module
module AMED(
    input wire clk,
    input wire rst_n,
    input wire in_valid,
    input wire [71:0] in_data,
    output reg out_valid,
    output reg [215:0] out_data
);

    // ==========================================
    // 1. 狀態機定義 (FSM)
    // ==========================================
    localparam IDLE    = 3'd0;
    localparam MULT    = 3'd1;
    localparam CAPTURE = 3'd2;
    localparam CHECK   = 3'd3;
    
    reg [2:0] current_state, next_state;

    // ==========================================
    // 2. 內部訊號與暫存器宣告
    // ==========================================
    // 儲存輸入的 3x3 矩陣元素 (9 個 8-bit signed)
    reg signed [7:0] matrix [0:8];
    
    // 乘法器 I/O 宣告 (18 個)
    reg  signed [15:0] mult_a [0:17];
    reg  signed [15:0] mult_b [0:17];
    wire signed [31:0] mult_out [0:17];
    
    // 雙鎖存機制暫存器 (Main & Shadow)
    reg signed [31:0] main_reg   [0:17];
    reg signed [31:0] shadow_reg [0:17];
    
    // 錯誤偵測訊號
    wire error_detected;
    wire [17:0] error_flag;

    integer i;

    // ==========================================
    // 3. 乘法器 IP 實例化 (展開 18 個以達到最低 Latency)
    // ==========================================
    genvar g;
    generate
        for (g = 0; g < 18; g = g + 1) begin : MULT_INST
            MULT_err u_mult (
                .clk(clk),
                .rst_n(rst_n),
                .a(mult_a[g]),
                .b(mult_b[g]),
                .out(mult_out[g])
            );
        end
    endgenerate

    // ==========================================
    // 4. FSM 狀態轉移與控制邏輯
    // ==========================================
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) current_state <= IDLE;
        else        current_state <= next_state;
    end

    always @(*) begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in_valid) next_state = MULT;
            end
            MULT: begin
                next_state = CAPTURE; // 等待乘法運算
            end
            CAPTURE: begin
                next_state = CHECK;   // 擷取資料並準備檢查
            end
            CHECK: begin
                next_state = IDLE;    // 計算完成，回到 IDLE
            end
            default: next_state = IDLE;
        endcase
    end

    // ==========================================
    // 5. 資料路徑 (Data Path) - 輸入矩陣存儲與乘法器給值
    // ==========================================
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i=0; i<9; i=i+1) matrix[i] <= 8'd0;
        end else if (in_valid) begin
            // 根據規格，A_11 位於 [71:64]，A_33 位於 [7:0]
            matrix[0] <= in_data[71:64]; // A11
            matrix[1] <= in_data[63:56]; // A12
            matrix[2] <= in_data[55:48]; // A13
            matrix[3] <= in_data[47:40]; // A21
            matrix[4] <= in_data[39:32]; // A22
            matrix[5] <= in_data[31:24]; // A23
            matrix[6] <= in_data[23:16]; // A31
            matrix[7] <= in_data[15:8];  // A32
            matrix[8] <= in_data[7:0];   // A33
        end
    end

    // 乘法器輸入配置 (展開 Adjugate Matrix 的 18 組乘法)
    always @(*) begin
        // Adj(A)11 = A22*A33 - A23*A32
        mult_a[0] = matrix[4]; mult_b[0] = matrix[8];
        mult_a[1] = matrix[5]; mult_b[1] = matrix[7];
        // Adj(A)12 = -(A12*A33 - A13*A32) = A13*A32 - A12*A33
        mult_a[2] = matrix[2]; mult_b[2] = matrix[7];
        mult_a[3] = matrix[1]; mult_b[3] = matrix[8];
        // Adj(A)13 = A12*A23 - A13*A22
        mult_a[4] = matrix[1]; mult_b[4] = matrix[5];
        mult_a[5] = matrix[2]; mult_b[5] = matrix[4];
        
        // Adj(A)21 = -(A21*A33 - A23*A31) = A23*A31 - A21*A33
        mult_a[6] = matrix[5]; mult_b[6] = matrix[6];
        mult_a[7] = matrix[3]; mult_b[7] = matrix[8];
        // Adj(A)22 = A11*A33 - A13*A31
        mult_a[8] = matrix[0]; mult_b[8] = matrix[8];
        mult_a[9] = matrix[2]; mult_b[9] = matrix[6];
        // Adj(A)23 = -(A11*A23 - A13*A21) = A13*A21 - A11*A23
        mult_a[10] = matrix[2]; mult_b[10]= matrix[3];
        mult_a[11] = matrix[0]; mult_b[11]= matrix[5];
        
        // Adj(A)31 = A21*A32 - A22*A31
        mult_a[12] = matrix[3]; mult_b[12]= matrix[7];
        mult_a[13] = matrix[4]; mult_b[13]= matrix[6];
        // Adj(A)32 = -(A11*A32 - A12*A31) = A12*A31 - A11*A32
        mult_a[14] = matrix[1]; mult_b[14]= matrix[6];
        mult_a[15] = matrix[0]; mult_b[15]= matrix[7];
        // Adj(A)33 = A11*A22 - A12*A21
        mult_a[16] = matrix[0]; mult_b[16]= matrix[4];
        mult_a[17] = matrix[1]; mult_b[17]= matrix[3];
    end

    // ==========================================
    // 6. 錯誤偵測機制 (Dual-Latching)
    // ==========================================
    
    // Main Register: 在正緣觸發 (可能抓到 Garbage Value)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i=0; i<18; i=i+1) main_reg[i] <= 32'd0;
        end else if (current_state == CAPTURE) begin
            for (i=0; i<18; i=i+1) main_reg[i] <= mult_out[i];
        end else if (current_state == CHECK && error_detected) begin
            // Error Recovery: 從 Shadow Reg 覆寫正確資料
            for (i=0; i<18; i=i+1) begin
                if (error_flag[i]) main_reg[i] <= shadow_reg[i];
            end
        end
    end

    // Shadow Register: 在負緣觸發 (保證抓到 Correct Value)
    always @(negedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i=0; i<18; i=i+1) shadow_reg[i] <= 32'd0;
        end else if (current_state == CAPTURE) begin
            for (i=0; i<18; i=i+1) shadow_reg[i] <= mult_out[i];
        end
    end

    // 比較器: 產生 error flag
    generate
        for (g = 0; g < 18; g = g + 1) begin : ERROR_CHECK
            assign error_flag[g] = (main_reg[g] != shadow_reg[g]);
        end
    endgenerate
    
    assign error_detected = |error_flag; // 只要任一個出錯就拉起警報

    // ==========================================
    // 7. 輸出級 (Subtractions & Formatting)
    // ==========================================
    wire signed [23:0] adj_calc [0:8];
    
    // 使用三元運算子決定拿 Main 還是 Shadow 的資料來做最後的減法
    // 這樣可以避免額外浪費一個 cycle 等待 Recovery 完成
    assign adj_calc[0] = (error_flag[0] ? shadow_reg[0] : main_reg[0]) - (error_flag[1] ? shadow_reg[1] : main_reg[1]);
    assign adj_calc[1] = (error_flag[2] ? shadow_reg[2] : main_reg[2]) - (error_flag[3] ? shadow_reg[3] : main_reg[3]);
    assign adj_calc[2] = (error_flag[4] ? shadow_reg[4] : main_reg[4]) - (error_flag[5] ? shadow_reg[5] : main_reg[5]);
    assign adj_calc[3] = (error_flag[6] ? shadow_reg[6] : main_reg[6]) - (error_flag[7] ? shadow_reg[7] : main_reg[7]);
    assign adj_calc[4] = (error_flag[8] ? shadow_reg[8] : main_reg[8]) - (error_flag[9] ? shadow_reg[9] : main_reg[9]);
    assign adj_calc[5] = (error_flag[10]? shadow_reg[10]: main_reg[10])- (error_flag[11]? shadow_reg[11]: main_reg[11]);
    assign adj_calc[6] = (error_flag[12]? shadow_reg[12]: main_reg[12])- (error_flag[13]? shadow_reg[13]: main_reg[13]);
    assign adj_calc[7] = (error_flag[14]? shadow_reg[14]: main_reg[14])- (error_flag[15]? shadow_reg[15]: main_reg[15]);
    assign adj_calc[8] = (error_flag[16]? shadow_reg[16]: main_reg[16])- (error_flag[17]? shadow_reg[17]: main_reg[17]);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out_valid <= 1'b0;
            out_data  <= 216'd0;
        end else if (current_state == CHECK) begin
            out_valid <= 1'b1;
            out_data  <= {adj_calc[0], adj_calc[1], adj_calc[2], 
                          adj_calc[3], adj_calc[4], adj_calc[5], 
                          adj_calc[6], adj_calc[7], adj_calc[8]};
        end else begin
            out_valid <= 1'b0;
            out_data  <= 216'd0; // 滿足規範: out_valid 拉低後資料歸零
        end
    end

endmodule

// version 1 :
// C = 20
// Latency: 300
// Area: 169049.157913
// Total Power: 1.3863m
// Performance Score: 1406136.26

// C = 10
// Latency: 300
// Area: 200058.958194
// Total Power: 2.8583m ***
// Performance Score: 1715491.08

// C =5 not MET