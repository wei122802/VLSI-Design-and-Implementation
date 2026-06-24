#!/bin/bash
# Auto-search script for minimum synthesis cycle time

START_CT=4.5
END_CT=1.0
STEP=0.1
DESIGN="MATRIX_MULT"

for ct in $(awk "BEGIN{for(i=$START_CT; i>=$END_CT; i-=$STEP) print i}"); do
    echo "========================================"
    echo "Testing Synthesis with CYCLE = $ct ns"
    echo "========================================"

    sed -i "s/set CYCLE .*/set CYCLE $ct/g" syn.tcl

    if [ -f "Report/${DESIGN}.timing" ]; then
        rm "Report/${DESIGN}.timing"
    fi

    dc_shell -f syn.tcl > syn_run.log

    if grep -q "slack (MET)" "Report/${DESIGN}.timing"; then
        echo "Result: MET at $ct ns. Continue searching..."
    else
        echo "Result: VIOLATED at $ct ns."
        LIMIT_CT=$(echo "$ct + $STEP" | bc)
        echo ">>> The Limit Ideal Cycle Time is: $LIMIT_CT ns <<<"
        break
    fi
done
