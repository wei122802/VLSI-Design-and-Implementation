#!/bin/bash

# ==========================================
# 參數設定區 (請確認這裡的路徑與檔名符合你的環境)
# ==========================================
Design="AMED"
CSV_FILE="performance_sweep.csv"
CHECK_SCRIPT="./08_check"  # 請替換成你實際「跑08」的腳本檔名

# 顏色設定
NO_COLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'

# 初始化 CSV 標頭
echo "Cycle_Time,Area,Dynamic_Power,Leakage_Power,Total_Power,Latency,Performance" > $CSV_FILE

# 設定起始 Cycle Time
ct=20

echo -e "${CYAN}🚀 Starting Performance Sweep from Cycle Time: $ct${NO_COLOR}"

while true; do
    echo -e "\n${YELLOW}========================================${NO_COLOR}"
    echo -e "${YELLOW} Testing Cycle Time: $ct ${NO_COLOR}"
    echo -e "${YELLOW}========================================${NO_COLOR}"

    # 1. 設定環境變數，讓 syn.tcl 可以讀取
    export CYCLE_TIME=$ct

    # 2. 執行合成 (根據你的 Lab5 Spec，包含執行 dc_shell 與移除 mult)
    rm -f Report/${Design}.timing Report/${Design}.area Report/${Design}.power
    rm -f eval_temp.log clean_temp.log syn_sweep_temp.log

    # 2. 執行合成
    echo "Running Synthesis (01_run_dc_shell & 02_remove_mult)..."
    ./01_run_dc_shell > syn_sweep_temp.log 2>&1
    ./02_remove_mult >> syn_sweep_temp.log 2>&1

    if [ ! -f "Report/${Design}.area" ]; then
        # [新增] 檢查 Log 中是否包含 license 或 DCSH-1 字眼
        if grep -i -q -E 'license|DCSH-1' syn_sweep_temp.log; then
            echo -e "${YELLOW}--> ⚠️ License 滿線中 (DCSH-1)！其他人正在佔用資源。${NO_COLOR}"
            echo -e "${YELLOW}--> 腳本將休眠 30 秒後重新嘗試 Cycle Time = $ct...${NO_COLOR}"
            sleep 30
            # 使用 continue 直接跳回 while 迴圈開頭，不會扣減 $ct，達到原數值重試的效果！
            continue 
        else
            # 如果不是 License 問題，是真的發生語法錯誤，才徹底中斷
            echo -e "${RED}--> 💥 FATAL ERROR: Report files were not generated due to a Syntax/TCL error!${NO_COLOR}"
            echo -e "${RED}--> Check syn_sweep_temp.log for details.${NO_COLOR}"
            break
        fi
    fi

    # [新增防禦機制 2]：檢查 DC 是否崩潰沒有生出檔案
    if [ ! -f "Report/${Design}.timing" ]; then
        echo -e "${RED}--> 💥 FATAL ERROR: Report files were not generated!${NO_COLOR}"
        echo -e "${RED}--> Design Compiler crashed. Check syn_sweep_temp.log for TCL errors.${NO_COLOR}"
        break
    fi

    # 3. 檢查是否發生 Timing Violation
    if grep -i -q 'violated' "Report/${Design}.timing"; then
        echo -e "${RED}--> ❌ Timing (violated) at Cycle Time = $ct !${NO_COLOR}"
        echo -e "${RED}--> Sweep stopped. Synthesis reached its limit.${NO_COLOR}"
        break
    else
        echo -e "${GREEN}--> ✅ Timing (MET)${NO_COLOR}"
    fi

    # 4. 執行你的 08_check 腳本，並將輸出存入暫存檔
    echo "Running Evaluation Script ($CHECK_SCRIPT)..."
    $CHECK_SCRIPT > eval_temp.log

    # 5. 從 eval_temp.log 中抓取我們需要的數值 (確保 08_check 印出的字眼能對應上)
    # 這裡利用 grep -Eo 抓取浮點數
    cat eval_temp.log | sed $'s/\033\\[[0-9;]*m//g' > clean_temp.log

    # 從乾淨的 clean_temp.log 中抓取數字
    Area=$(grep 'Area:' clean_temp.log | grep -Eo '[+-]?[0-9]+([.][0-9]+)?' | head -n 1)
    Dynamic=$(grep 'Dynamic:' clean_temp.log | grep -Eo '[+-]?[0-9]+([.][0-9]+)?' | head -n 1)
    Leakage=$(grep 'Leakage:' clean_temp.log | grep -Eo '[+-]?[0-9]+([.][0-9]+)?' | head -n 1)
    TotalPower=$(grep 'Total Power:' clean_temp.log | grep -Eo '[+-]?[0-9]+([.][0-9]+)?' | head -n 1)
    Latency=$(grep 'Latency:' clean_temp.log | grep -Eo '[0-9]+' | head -n 1)
    Perf=$(grep 'Performance Score:' clean_temp.log | grep -Eo '[+-]?[0-9]+([.][0-9]+)?' | head -n 1)

    # 防呆機制：如果腳本沒抓到東西，補 0 避免 CSV 格式跑掉
    Area=${Area:-0}
    Dynamic=${Dynamic:-0}
    Leakage=${Leakage:-0}
    TotalPower=${TotalPower:-0}
    Latency=${Latency:-0}
    Perf=${Perf:-0}

    # 6. 將結果寫入 CSV 檔案
    echo "$ct,$Area,$Dynamic,$Leakage,$TotalPower,$Latency,$Perf" >> $CSV_FILE
    echo -e "${CYAN}💾 Data saved: Perf = $Perf (Area=$Area, Power=$TotalPower)${NO_COLOR}"

    # 7. Cycle Time 遞減 0.1
    ct=$(echo "$ct - 0.1" | bc -l)
    
    # 避免 bc 計算後產生 19.90000 這種多餘小數，使用 printf 格式化保留一位小數
    ct=$(printf "%.1f" $ct)
done

echo -e "\n${GREEN}🎉 Sweep finished successfully! Check out [$CSV_FILE] for your data.${NO_COLOR}"