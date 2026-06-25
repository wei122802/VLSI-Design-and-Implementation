# 2026 VLSI Design Lab 4: Synchronous Dual-Port FIFO with Latch 設計分析報告

> 🏆 **最終實驗成果：85.4 分** | **Performance (Perf) 全班排名：第 22 名** 🎉

## 1. Specification Overview
### 1.1 任務目標
設計一個支持同步讀寫 (Simultaneous Read/Write) 的 **FIFO (First-In-First-Out)**。
- **核心約束**：FIFO 的核心記憶體陣列 (Memory Array) **必須使用 D-Latches (High-Level Sensitive)** 實作，不可使用傳統的 D-Flip-Flops。
- **參數化設計**：需支援 `DATA_WIDTH` (8/16) 與 `FIFO_DEPTH` (16/32) 的動態調整。
- **特殊機制**：
  - FWFT (First-Word Fall-Through) 架構：最舊的資料會預先出現在 `r_data` 輸出。
  - Underflow (空讀) 與 Overflow (滿寫) 的硬體防護機制。

## 2. 架構演進與設計探索

Latch-based 設計是本實驗的核心挑戰。比起 DFF，Latch 體積小一半且漏電率低，但非常容易受到 Glitch 影響導致資料錯誤。

### 2.1 記憶體陣列實作策略
在 `FIFO.v` 中，使用了 `generate` block 來展開記憶體陣列，並使用了嚴謹的條件控制 Latch 的 Enable：
```verilog
always @(*) begin
    if (clk && w_en && !full && (safe_w_addr == i)) begin
        cell_q = w_data;
    end
end
```
為了避免 `w_ptr` 在 Clock 上升緣跳動時產生 Glitch，設計中特別加入了一個由 `negedge clk` 觸發的 `safe_w_addr`：
```verilog
always @(negedge clk) begin
    safe_w_addr <= w_ptr[ADDR_WIDTH-1:0];
end
```

### 2.2 效能與面積表現
- **Gate Count**: 1372 
- **Area**: 13687.83
- **Total Dynamic Power**: ~40.88 uW
由於大量使用了 Latch 取代 SRAM 或 DFF，我們在面積與功耗上獲得了極大的優勢。然而，Latch 的 Time Borrowing 特性也讓合成時的 STA 變得非常挑戰。

## 3. 結論
透過靈活運用 `negedge` 鎖定 Write Address (`safe_w_addr`)，我們完美解決了 Latch Enable 端的 Glitch 隱患。在確保功能通過各種極端邊界測試 (Empty 讀取、Full 寫入、同時讀寫) 的同時，在 Perf 評比中斬獲了全班第 22 名的佳績，充分展現了對 Latch-based 設計的掌握度。
