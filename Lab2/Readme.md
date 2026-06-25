# 2026 VLSI Design Lab 2: Dart Game 設計分析報告

> 🏆 **最終實驗成果：87.1 分** | **Performance (Perf) 全班排名：第 28 名** 🎉

## 1. Specification Overview
### 1.1 任務目標
設計一個硬體控制器來模擬「301 飛鏢遊戲」(Dart Game)。
- **遊戲規則**：兩位玩家 (Player 0 / Player 1) 各有 301 分，輪流擲飛鏢，每人擲 10 次。
- **計分方式**：每支飛鏢有基礎分數 (0~20, 或紅心 25)，若擊中 Double 區則分數乘 2，Triple 區則乘 3。
- **Bust (爆鏢) 規則**：若該回合得分導致剩餘分數小於 0，則該次得分無效。若剛好為 0，則提早獲勝 (Early Win)。
### 1.2 設計約束 (Coding Style Constraints)
本實驗重點在於**嚴格的 Coding Style**：
1. 一個 Module 一個檔案。
2. 頂層模組 (DART.v) 只能做 instantiation，不可有 procedural 程式碼。
3. 單一 Module 內，只能有一個 always block 驅動同一組訊號 (FSM 除外)。
4. 禁止在同一個 Module 中混用 `assign` 與 `always`。
5. 禁止使用 `if-else` (除了 reset 之外)，全部條件邏輯必須使用 `case`。

## 2. 架構演進與設計探索 (Lab2/01_RTL)

在遵守嚴格 Coding Style 的前提下，設計被完美切分為多個子模組 (FSM, COUNTER, SCORE_CALC, PLAYER_SCORE 等)。
為了在 `Area * Cycle Time` 的評分中獲得好成績，進行了多次微調：

### 2.1 最佳化歷程

| 版本特徵 | Cycle Time | Area (面積) | 最佳化手段與效益 |
| :--- | :--- | :--- | :--- |
| **Initial Version** | 2.90 | 4803 | 遵守 Coding Style 完成初步串接。 |
| **Remove Data Path Rst** | 2.90 | 4077 | 移除不必要的重置訊號 (如 `DART_COUNTER` 的 `rst_n`)，大幅縮小面積。 |
| **Strict Case Statements** | 2.90 | 4384 | 為了完全符合無 `if-else` 的嚴格規定，將所有判斷改寫為 `case`。 |
| **Final Optimized** | 3.00 | 4207 | 權衡 Critical Path 與面積，雖然 CT 微升，但確保了功能正確性與面積的極大化縮減。 |

## 3. 結論
本實驗展示了如何在嚴格的 Coding Style 規範下完成具備複雜遊戲規則的控制電路。雖然因為使用大量 `case` 展開導致面積與延遲微幅增加，但在後期的最佳化中，透過**移除資料路徑 (Data path) 的 Reset**，成功拉回了不少分數，最終取得 Perf 全班第 28 名的佳績。
