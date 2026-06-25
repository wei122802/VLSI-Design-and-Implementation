# 2026 VLSI Design Lab 3: Clock Jitter 分析報告

> 🏆 **最終實驗成果：98 分** 🎉

## 1. Specification Overview
### 1.1 任務目標
本實驗不需要修改 RTL 程式碼（沿用 Lab 1 設計），而是專注於**時脈抖動 (Clock Jitter)** 的產生與分析。
- 學生需修改 `PATTERN.v`，利用 Verilog 系統函數來模擬現實 IC 中 Clock Jitter 對電路的影響。
- **Jitter 類型**：
  1. **Uniform Jitter**：Clock Period 隨機且均勻地在 `[0.8 * CT, 1.2 * CT]` 之間跳動。
  2. **Gaussian Jitter**：Clock Period 呈現常態分佈 (Bell-shaped)，極值同樣限制在理想 Clock Period 的 +-20%。

### 1.2 評估指標
- **Limit Cycle Time Search**：使用 Gate-Level Simulation (合成後模擬)，找出系統在理想時脈下，不發生 Timing Violation 的「絕對最小週期時間 (Limit CT)」。
- **Failure Point Analysis**：將該極限 CT 加上 Jitter 後，捕捉並分析 Setup Time 或 Hold Time 發生的確切波形。

## 2. 實驗挑戰與分析

### 2.1 抖動生成 (Jitter Generation)
利用 Verilog 內建的 random function 產生亂數，並依據數學轉換（例如 Box-Muller 轉換或內建常態分佈函數）生成符合 Gaussian 曲線的時脈變化。這是硬體設計中驗證 Setup/Hold margin 是否足夠的關鍵技術。

### 2.2 極限時脈與錯誤分析
當電路的 Clock Period 逼近 Limit CT 時，Timing Margin 幾乎為 0。此時：
- **遇到負向 Jitter (Period 變短)**：Data Arrival Time 來不及滿足 Data Required Time，引發 **Setup Time Violation**，使得暫存器抓到紅色的 `X` (Unknown) 態。
- 透過本次實驗，我們成功地從 Gate-Level 的波形圖中，擷取了 Jitter 發生瞬間的精確週期，並印證了 STA (Static Timing Analysis) 報告中的時序餘裕。

## 3. 結論
這是一個至關重要的驗證 (Verification) 實驗。它展示了現實世界中晶片時脈的不可靠性。高達 98 分的成績證明了我們對 Clock Jitter 的統計特性、Gate-Level 波形除錯以及 Timing Violation 分析有著深刻且精確的掌握。
