# 2026 VLSI Design Lab 5: Error Detection (AMED) 設計分析報告

> 最終實驗成果：97.2 分 | Performance 全班排名：第 5 名

## 1. 規格概述

### 1.1 任務目標
實作一個 3x3 的伴隨矩陣 (Adjugate Matrix) 計算器 `AMED`。
- **錯誤注入環境**：這是一場障礙賽，強制規定乘法只能用一個名為 `MULT_err` 的雷包 IP。這顆 IP 偶爾會發生 Setup Time Violation，在 `posedge clk` 時噴出亂碼，但在半個 Clock 後的 `negedge clk` 就會恢復正常。
- **錯誤偵測與修復**：我們必須自己設計一套糾錯機制，硬生生把錯誤的資料救回來，確保最終輸出的矩陣完全正確。
- **評分標準**：`Power * Area * Cycle Time * Latency`，簡單來說就是要把電路壓榨到極限。

## 2. 架構演進與設計探索

這個 Lab 的優化過程堪稱是一門「減法藝術」。為了在 Perf 評分中極限壓縮分數，我們瘋狂地精簡架構。

### 2.1 雙重鎖存的除錯架構
為了解決那個雷包 IP，我們架構了 Main / Shadow 雙暫存器防線：
- **Main Register**：在 `posedge clk` 觸發，負責衝鋒陷陣，但也可能抓到爛資料。
- **Shadow Register**：在 `negedge clk` 觸發，晚半步動作，但保證抓到的絕對是穩定的好資料。
最後比對兩者，只要有出入，就無條件用 Shadow 的好資料覆蓋回去。

### 2.2 效能極限榨取過程

分數從最初的 35.4 萬一路優化到驚人的 23.1 萬，過程相當熱血：

| 最佳化階段 | Latency | Area | Total Power | Perf Score | 關鍵大招 |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Initial (V3)** | 1000 | 34640 | 1022.9 uW | 354,354 | 先求有，把雙鎖存與 FSM 控制穩穩做出來。 |
| **Remove Matrix Rst** | 1000 | 34290 | 990.4 uW | 339,622 | 狠心拔掉輸入暫存器的 Reset 訊號。 |
| **Remove Shadow Rst** | 1000 | 33927 | 961.5 uW | 326,239 | 連所有除錯 Pipeline 的 Reset 也一併拔掉。 |
| **Remove Shift Rst** | 1000 | 29726 | 540.3 uW | 255,408 | 拔除 Shift Buffer 的 Reset 後，面積與功耗迎來斷崖式下降。 |
| **Remove State (FSM)** | **900** | **29388** | **507.7 uW** | **231,005** | **終極大招：直接把傳統笨重的 FSM 揚了，改用 Counter 驅動，Latency 一口氣削了 10%！** |

## 3. 總結

這絕對是一個把硬體效能逼到死角的瘋狂設計。透過完全捨棄 Data Path 的 Reset，加上大膽放生傳統 FSM 改走極簡 Counter 路線，我們硬是把 Latency 從 1000 壓到 900，面積與功耗更是幾乎對半砍。這完美驗證了「設計越單純，效能越狂暴」的道理，能以此拿下全班第 5 名真的是實至名歸。
