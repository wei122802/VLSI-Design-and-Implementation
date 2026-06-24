# 2026 VLSI Design and Implementation 課程總結

> 🎓 **最終學期總成績：A+ (92 分)** 🎉

## 實驗成績總覽 (Lab Results Overview)

在這一學期的課程中，每個實驗都帶來了不同的硬體設計挑戰，從基礎的矩陣運算到複雜的 Latch 記憶體與除錯機制，以下為各個 Lab 的成績與排名總結：

| 實驗單元 | 實驗名稱 (Topic) | 實驗分數 | Performance 全班排名 |
| :---: | :--- | :--- | :--- |
| **Lab 1** | 8x8 Matrix Multiplication (矩陣乘法) | 93.2 分 | 第 11 名 |
| **Lab 2** | Dart Game (飛鏢遊戲控制器) | 87.1 分 | 第 28 名 |
| **Lab 3** | Clock Jitter (時脈抖動分析) | 98.0 分 | - (無排名) |
| **Lab 4** | Synchronous Dual-Port FIFO with Latch | 85.4 分 | 第 22 名 |
| **Lab 5** | Error Detection (AMED 錯誤偵測與修復) | 97.2 分 | 第 5 名 |

---

## 學習心得與反思 (Course Reflections)

這堂 VLSI 課程是一趟從「寫出會動的 Code」到「刻出極致效能架構」的蛻變之旅。回顧這五個實驗，每一個都精準地打中了數位 IC 設計中的核心痛點：

1. **架構思維的轉變 (Lab 1 & Lab 5)**：
   從 Lab 1 利用平移暫存器 (Shift Register) 完美隱藏矩陣乘法的延遲時間，到 Lab 5 徹底實踐「減法哲學」——拔掉非必要的 Reset 訊號、捨棄笨重的 FSM 改用 Counter-driven 控制。我們學會了如何在功能正確的前提下，將 PPA (Power, Performance, Area) 的效能榨取到極限。Lab 5 拿下的全班第 5 名，就是對這種「極致優化思維」最好的肯定。

2. **嚴謹的設計規範 (Lab 2)**：
   Lab 2 的飛鏢遊戲雖然邏輯不難，但極度嚴苛的 Coding Style (One always block, No if-else 等) 強迫我們摒棄了過去寫軟體的隨性，培養出了容易合成、易於除錯且對 EDA Tools 友善的 RTL 撰寫習慣。

3. **直面現實世界的物理限制 (Lab 3 & Lab 4)**：
   硬體設計從來不是完美的。Lab 3 讓我們直面了 Clock Jitter 所帶來的 Setup/Hold Time Violation；而 Lab 4 則逼著我們用極其敏感的 Latch 來實作 FIFO 陣列。這些訓練讓我們跳脫了理想的模擬環境，學會了如何看懂 Timing Report、如何用 `negedge` 去防止 Glitch，以及如何處理複雜的 Time Borrowing。

**總結來說：**
最終能夠拿下 **A+ (92 分)** 的亮眼總成績，是對無數個熬夜抓 Bug、看波形 (Waveform)、修 Timing Violation 最大的回報。這不僅僅是一門學分，更是一場扎實的工程師訓練，讓我們深刻體會到了「Hardware is Hard, but it's worth it.」的真諦。這段充實的設計旅程，必將成為未來 IC 設計道路上最堅固的基石！
