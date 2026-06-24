import matplotlib.pyplot as plt
import numpy as np

file_path = 'jitter_log.txt' 

try:
    data = np.loadtxt(file_path)
    print(f" 讀出 {len(data)} 筆數據")
except FileNotFoundError:
    print(f"找不到檔案 {file_path}")
    exit()

plt.figure(figsize=(10, 6), dpi=150) 

plt.hist(data, bins=50, color='skyblue', edgecolor='black', alpha=0.8)

plt.title('Clock Period Distribution (Gaussian Jitter)', fontsize=18, pad=15)
plt.xlabel('Clock Period (ns)', fontsize=14)
plt.ylabel('Occurrence Count', fontsize=14)

plt.grid(axis='y', linestyle='--', alpha=0.7)

plt.tight_layout()

plt.show()
