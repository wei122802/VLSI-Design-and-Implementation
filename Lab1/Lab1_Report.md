# 2026 VLSI Design Lab 1: 8x8 Matrix Multiplication 設計分析報告

> 最終實驗成果：93.2 分 | Performance 全班排名：第 11 名

## 1. 規格概述

### 1.1 任務目標
本實驗的目標為設計一個 8x8 矩陣乘法器。
- 輸入資料：兩個 8x8 矩陣，元素為 8-bit unsigned integers。
- 輸出資料：一個 8x8 矩陣，為避免溢位並保持精確度，元素為 20-bit。

### 1.2 I/O 協定與時序約束
- Input Phase：16 Cycles。當 `in_valid` 為 High 時，每個 Clock Cycle 傳入一個 Row 的資料。前 8 個 Cycle 傳入矩陣 A，緊接著的後 8 個 Cycle 傳入矩陣 B。
- Output Phase：64 Cycles。運算完成後，將 `out_valid` 拉高，並以 Row-major 順序每個 Cycle 輸出一個 20-bit 的運算結果。
- 硬體與效能約束：
  - 合成後不得包含任何 Latch。
  - Performance Score = Latency $\times$ Cycle Time。
  - Latency 定義為 `in_valid` 下降沿至 `out_valid` 第一次上升沿之間的 Cycle 數。

## 2. 架構演進與設計探索

在 `01_RTL` 資料夾中包含了多個版本的設計，反映了在達到最終最佳化前，對於 Area、Cycle Time 與 Latency 的各種嘗試與取捨。

### 2.1 各版本差異比較

| 版本名稱 | 核心架構 | 運算策略 | Latency 表現 | 綜合評價 |
| :--- | :--- | :--- | :--- | :--- |
| **`MATRIX_LUT.v`**<br>**`MATRIX_MULT_100CC.v`** | Combinational 暴力展開 | 等待資料收齊後，試圖在單一 Cycle 內算完所有結果。 | **極差** (Cycle Time 暴增) | 消耗龐大的硬體資源，且深層的加法樹導致 Critical Path 嚴重拖慢時脈。 |
| **`MATRIX_systolic.v`**<br>**`MATRIX_MULT_100_38CC.v`** | 標準 FSM 兩階段 | 花 16 Cycles 收完矩陣 A 與 B 後，才進入 COMPUTE 狀態算 8 Cycles。 | **中等** (+8 Cycles) | 中規中矩的寫法，但未能隱藏運算時間，必須額外等待，導致 Latency 分數不佳。 |
| **`MATRIX_MULT.v`**<br>*(最終版本)* | Data Pipelining + Shift Register | 一邊讀取矩陣 B，一邊同步進行運算。 | **極佳** (趨近 Zero Latency) | 利用平移暫存器大幅減少 Mux，完美兼顧 Area 與 Latency，是獲得排名的關鍵。 |

### 2.2 演進細節說明

1. **組合邏輯暴力展開**：
   出發點是想把計算的 Cycle 數降到最低，因此實作了龐大的乘加運算樹。然而在 Synthesis 時，這會產生極長的路徑延遲，為了滿足 Setup Time，只能被迫把 Clock Period 調得非常大，反而讓總體的 Performance Score 變得很糟。

2. **標準 FSM 兩階段運算**：
   這些版本回歸到循序邏輯，將資料輸入與運算完全分開。雖然硬體面積跟 Cycle Time 有所改善，但因為必須等待矩陣 B 全部讀進來後才開始算，白白浪費了寶貴的 Latency。

3. **Data Pipelining 與平移架構**：
   這個版本結合了前兩者的教訓，做到了算完的瞬間剛好也就是資料讀完的瞬間。不僅免除了額外的等待時間，也捨棄了巨大的 Mux 選擇器，是這次實驗能拿到高分的關鍵設計。

## 3. 最終最佳化版本分析：`MATRIX_MULT.v` 

在 `MATRIX_MULT.v` 中，整個設計被精簡到不到 120 行，但卻巧妙地結合了 Pipelining 與 Shift Register 架構，達成了極低 Latency 的優異效能。

### 3.1 Input 與 Compute 的完美重疊
有別於傳統「先讀完再算」的作法，`MATRIX_MULT.v` 採用了 Data-driven 的設計：
- Cycle 1 ~ 8：讀取矩陣 A 並存入 `matrix_A` 陣列中。
- Cycle 9 ~ 16：一邊讀取矩陣 B，一邊進行乘加運算。
  當 `in_valid` 進入第 9 個 Cycle 時，此時的 `in_data` 剛好可以與矩陣 A 的第 1 個 Column 進行相乘並累加至 `mat_c` 中。

### 3.2 Shift Register 的巧妙運用
為了高效率地實現這種重疊，設計中巧妙使用了平移機制：
```verilog
always @(posedge clk) begin
    // ...
    } else if (is_mac) begin
        // 將 Matrix A 往左平移，讓下一個 Column 的資料進入運算區
        for (i = 0; i < 8; i = i + 1) begin
            for (j = 0; j < 7; j = j + 1) begin
                matrix_A[i][j] <= matrix_A[i][j+1];
            end
        end
    end
end
```
這使得每一回合提取計算資料 (`a_sel`) 的邏輯變得非常單純，永遠只取第一欄，避開了複雜的選擇電路，進一步縮短 Critical Path。

### 3.3 Output 階段的平移輸出
在輸出階段，`mat_c` 同樣採用了 Shift Register 的做法：
```verilog
    } else if (out_cond) begin
        for (i = 0; i < 8; i = i + 1) begin
            for (j = 0; j < 7; j = j + 1) begin
                mat_c[i][j] <= mat_c[i][j+1];
            end
        end
        // ...
        out_data <= mat_c[0][0]; 
    end
```
放棄使用龐大的 Mux 來選擇 64 個位置的值，改成每次都將資料像貪食蛇一樣往前推，並固定從 `mat_c[0][0]` 讀取輸出。這是縮減硬體面積與拉高時脈頻率的絕佳技巧。

## 4. 總結

`MATRIX_MULT.v` 絕對是所有嘗試中最精練的版本，因為它：
1. **最小化 Latency**：透過在輸入矩陣 B 的同時進行乘法，徹底消除了等待時間。
2. **最佳化 Critical Path 與面積**：大量利用 Shift Register 取代複雜的 Muxing，讓合成出來的 Routing 與 Timing 都非常漂亮。
3. **優異的 Performance Score**：由於 Latency 極小化且 Critical Path 短，在評分機制下拿到了相當不錯的分數。
