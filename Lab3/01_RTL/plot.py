import matplotlib.pyplot as plt
import numpy as np
# ==========================================
# 1. 設定你的 log 檔案名稱
# ==========================================
# 請根據你跑的 Jitter 種類更改檔名
file_path = 'jitter_log.txt' 

# ==========================================
# 2. 讀取數據
# ==========================================
try:
    # 讀取純文字檔，自動轉換成浮點數陣列
    data = np.loadtxt(file_path)
    print(f"成功讀取 {len(data)} 筆數據！")
except FileNotFoundError:
    print(f"找不到檔案 {file_path}，請確認路徑是否正確。")
    exit()

# ==========================================
# 3. 繪製直方圖 (Histogram)
# ==========================================
plt.figure(figsize=(10, 6), dpi=150) # 設定高解析度畫布

# bins=50 代表將數據分組畫成 50 條柱子，你可以視情況微調
# color 是柱子顏色，edgecolor 加上黑框讓圖表更清晰
plt.hist(data, bins=50, color='skyblue', edgecolor='black', alpha=0.8)

# ==========================================
# 4. 圖表美化與標籤
# ==========================================
# 注意：請記得把標題改成對應的 Uniform 或 Gaussian
plt.title('Clock Period Distribution (Gaussian Jitter)', fontsize=18, pad=15)
plt.xlabel('Clock Period (ns)', fontsize=14)
plt.ylabel('Occurrence Count', fontsize=14)

# 加上水平虛線網格，讓助教更容易看出分佈數量
plt.grid(axis='y', linestyle='--', alpha=0.7)

# 自動調整版面配置
plt.tight_layout()

# ==========================================
# 5. 顯示或存檔
# ==========================================
# 直接存成高畫質圖片，方便你貼進 Word 報告
# plt.savefig('Gaussian_Histogram.png') 
plt.show() # 在螢幕上顯示圖表