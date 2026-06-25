# 2026 VLSI Design Lab 5: Error Detection (AMED) 設計分析報告

> 🏆 **最終實驗成果：97.2 分** | **Performance (Perf) 全班排名：第 5 名** 🎉

## 1. Specification Overview
### 1.1 任務目標
設計一個 3x3 伴隨矩陣 (Adjugate Matrix) 計算器 `AMED`。
- **錯誤注入環境**：實驗中強制規定乘法必須使用一個有 Bug 的 IP `MULT_err`。該 IP 有一定機率會發生 Setup Time Violation，導致在 `posedge clk` 時輸出錯誤的亂碼，但在半個 Clock 後的 `negedge clk` 會穩定成正確數值。
- **錯誤偵測與修復 (Error Detection & Recovery)**：設計必須具備糾錯機制，保證最終輸出的 24-bit 矩陣元素完全正確。
- **評分標準**：`Performance Score = Power * Area * CYCLE_TIME * Latency` (越低越好)。

## 2. 架構演進與設計探索 (Lab5/01_RTL)

本實驗的 FSM 與除錯機制經過了深度的「減法最佳化」，為了在 Perf 評分中極限壓縮分數，我們進行了大量的架構精簡。

### 2.1 雙重鎖存除錯架構 (Dual-Latching Mechanism)
為了捕捉 `MULT_err` 的隨機錯誤，我們實作了 Main / Shadow 暫存器機制：
- **Main Register (`main1`, `main2`)**：在 `posedge clk` 觸發，可能抓到錯誤。
- **Shadow Register (`shadow1`, `shadow2`)**：在 `negedge clk` 觸發，必定抓到正確資料。
- 接著，將 Shadow 延遲到下一個 `posedge` 與 Main 比對，若不同則切換為 Shadow 的正確值。

### 2.2 效能極限榨取 (Performance Optimization)

這份設計的 Perf 演進堪稱典範，分數從最初的 35.4 萬一路優化到 23.1 萬，優化幅度驚人：

| 最佳化階段 | Latency | Area | Total Power | Perf Score | 關鍵優化手段 |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Initial (V3)** | 1000 | 34640 | 1022.9 uW | 354,354 | 實作基礎的雙鎖存與 FSM 控制。 |
| **Remove Matrix Rst** | 1000 | 34290 | 990.4 uW | 339,622 | 移除輸入暫存器的 `rst_n`。 |
| **Remove Shadow Rst** | 1000 | 33927 | 961.5 uW | 326,239 | 移除所有除錯 Pipeline 的 `rst_n`。 |
| **Remove Shift Rst** | 1000 | 29726 | 540.3 uW | 255,408 | 移除 Shift Buffer 的 `rst_n`，Area 與 Power 大幅下降。 |
| **Remove State (FSM)** | **900** | **29388** | **507.7 uW** | **231,005** | **移除冗餘的 FSM 狀態跳轉，直接使用 `cnt` 計數驅動，Latency 一舉下降 10%！** |

*(註：移除不必要的 Reset 可以有效減少繞線與觸發器的面積，同時降低動態功耗)*

## 3. 結論
這是一個將硬體極限優化發揮到極致的設計！透過 **完全捨棄 Data Path 的 Reset** 以及 **捨棄傳統 FSM，改用精簡的 Counter Driven**，我們成功將 `Latency` 從 1000 壓低到 900，並把面積與功耗砍了近一半。這完美詮釋了「越簡單的設計效能越好」的硬體哲學，並實至名歸地拿下了 **全班第 5 名** 的神級表現。
