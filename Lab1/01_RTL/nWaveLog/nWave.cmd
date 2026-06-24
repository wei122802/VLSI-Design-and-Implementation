verdiSetActWin -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 {/home/VLSILAB45/Lab1/01_RTL/MATRIX_MULT.fsdb}
wvResizeWindow -win $_nWave1 1920 23 1680 987
wvRestoreSignal -win $_nWave1 "/home/VLSILAB45/Lab1/01_RTL/signal.rc" \
           -overWriteAutoAlias on -appendSignals on
wvResizeWindow -win $_nWave1 0 23 1920 1017
wvUnknownSaveResult -win $_nWave1 -clear
wvResizeWindow -win $_nWave1 1920 23 1680 987
wvSelectSignal -win $_nWave1 {( "G1" 1 )} 
wvSelectSignal -win $_nWave1 {( "G1" 1 2 )} 
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G6" 0)}
wvGetSignalOpen -win $_nWave1
wvSetPosition -win $_nWave1 {("G6" 2)}
wvSetPosition -win $_nWave1 {("G6" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/u_MATRIX_MULT/in_valid} \
{/TESTBED/u_MATRIX_MULT/clk} \
{/TESTBED/u_MATRIX_MULT/in_data\[63:0\]} \
{/TESTBED/u_MATRIX_MULT/out_data\[19:0\]} \
{/TESTBED/u_MATRIX_MULT/out_valid} \
{/TESTBED/u_MATRIX_MULT/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvAddSignal -win $_nWave1 -group {"G1" \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/u_MATRIX_MULT/matrix_A\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
{/TESTBED/u_MATRIX_MULT/a_sel\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/b_row\[0:7\]} \
}
wvAddSignal -win $_nWave1 -group {"G7" \
}
wvSelectSignal -win $_nWave1 {( "G6" 1 2 )} 
wvSetPosition -win $_nWave1 {("G6" 2)}
wvSetPosition -win $_nWave1 {("G6" 2)}
wvSetPosition -win $_nWave1 {("G6" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/u_MATRIX_MULT/in_valid} \
{/TESTBED/u_MATRIX_MULT/clk} \
{/TESTBED/u_MATRIX_MULT/in_data\[63:0\]} \
{/TESTBED/u_MATRIX_MULT/out_data\[19:0\]} \
{/TESTBED/u_MATRIX_MULT/out_valid} \
{/TESTBED/u_MATRIX_MULT/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvAddSignal -win $_nWave1 -group {"G1" \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/u_MATRIX_MULT/matrix_A\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
{/TESTBED/u_MATRIX_MULT/a_sel\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/b_row\[0:7\]} \
}
wvAddSignal -win $_nWave1 -group {"G7" \
}
wvSelectSignal -win $_nWave1 {( "G6" 1 2 )} 
wvSetPosition -win $_nWave1 {("G6" 2)}
wvGetSignalClose -win $_nWave1
wvSetCursor -win $_nWave1 19546.820455
wvZoom -win $_nWave1 11671.842430 44085.814480
wvResizeWindow -win $_nWave1 1920 23 1680 987
wvSetCursor -win $_nWave1 16411.317566
wvSetCursor -win $_nWave1 16688.627282
wvSetCursor -win $_nWave1 16915.517049
wvSetCursor -win $_nWave1 16789.467178
wvSetCursor -win $_nWave1 16991.146971
wvSetCursor -win $_nWave1 16789.467178
wvSetCursor -win $_nWave1 16940.727023
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/u_MATRIX_MULT"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/u_MATRIX_MULT"
wvSetPosition -win $_nWave1 {("G6" 4)}
wvSetPosition -win $_nWave1 {("G6" 4)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/u_MATRIX_MULT/in_valid} \
{/TESTBED/u_MATRIX_MULT/clk} \
{/TESTBED/u_MATRIX_MULT/in_data\[63:0\]} \
{/TESTBED/u_MATRIX_MULT/out_data\[19:0\]} \
{/TESTBED/u_MATRIX_MULT/out_valid} \
{/TESTBED/u_MATRIX_MULT/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvAddSignal -win $_nWave1 -group {"G1" \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/u_MATRIX_MULT/matrix_A\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
{/TESTBED/u_MATRIX_MULT/a_sel\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/b_row\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/matrix_A\[0:7\]} \
}
wvAddSignal -win $_nWave1 -group {"G7" \
}
wvSelectSignal -win $_nWave1 {( "G6" 3 4 )} 
wvSetPosition -win $_nWave1 {("G6" 4)}
wvSetPosition -win $_nWave1 {("G6" 4)}
wvSetPosition -win $_nWave1 {("G6" 4)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/u_MATRIX_MULT/in_valid} \
{/TESTBED/u_MATRIX_MULT/clk} \
{/TESTBED/u_MATRIX_MULT/in_data\[63:0\]} \
{/TESTBED/u_MATRIX_MULT/out_data\[19:0\]} \
{/TESTBED/u_MATRIX_MULT/out_valid} \
{/TESTBED/u_MATRIX_MULT/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvAddSignal -win $_nWave1 -group {"G1" \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/u_MATRIX_MULT/matrix_A\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
{/TESTBED/u_MATRIX_MULT/a_sel\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/b_row\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/matrix_A\[0:7\]} \
}
wvAddSignal -win $_nWave1 -group {"G7" \
}
wvSelectSignal -win $_nWave1 {( "G6" 3 4 )} 
wvSetPosition -win $_nWave1 {("G6" 4)}
wvGetSignalClose -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/u_MATRIX_MULT"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/u_MATRIX_MULT"
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvSetPosition -win $_nWave1 {("G6" 7)}
wvSetPosition -win $_nWave1 {("G6" 7)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/u_MATRIX_MULT/in_valid} \
{/TESTBED/u_MATRIX_MULT/clk} \
{/TESTBED/u_MATRIX_MULT/in_data\[63:0\]} \
{/TESTBED/u_MATRIX_MULT/out_data\[19:0\]} \
{/TESTBED/u_MATRIX_MULT/out_valid} \
{/TESTBED/u_MATRIX_MULT/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvAddSignal -win $_nWave1 -group {"G1" \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/u_MATRIX_MULT/matrix_A\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
{/TESTBED/u_MATRIX_MULT/a_sel\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/b_row\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/matrix_A\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/is_load_A} \
{/TESTBED/u_MATRIX_MULT/is_mac} \
{/TESTBED/u_MATRIX_MULT/is_setup} \
}
wvAddSignal -win $_nWave1 -group {"G7" \
}
wvSelectSignal -win $_nWave1 {( "G6" 5 6 7 )} 
wvSetPosition -win $_nWave1 {("G6" 7)}
wvSetPosition -win $_nWave1 {("G6" 7)}
wvSetPosition -win $_nWave1 {("G6" 7)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/u_MATRIX_MULT/in_valid} \
{/TESTBED/u_MATRIX_MULT/clk} \
{/TESTBED/u_MATRIX_MULT/in_data\[63:0\]} \
{/TESTBED/u_MATRIX_MULT/out_data\[19:0\]} \
{/TESTBED/u_MATRIX_MULT/out_valid} \
{/TESTBED/u_MATRIX_MULT/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvAddSignal -win $_nWave1 -group {"G1" \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/u_MATRIX_MULT/matrix_A\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
{/TESTBED/u_MATRIX_MULT/a_sel\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/b_row\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/matrix_A\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/is_load_A} \
{/TESTBED/u_MATRIX_MULT/is_mac} \
{/TESTBED/u_MATRIX_MULT/is_setup} \
}
wvAddSignal -win $_nWave1 -group {"G7" \
}
wvSelectSignal -win $_nWave1 {( "G6" 5 6 7 )} 
wvSetPosition -win $_nWave1 {("G6" 7)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G6" 4 )} 
wvSetPosition -win $_nWave1 {("G6" 4)}
wvExpandBus -win $_nWave1
wvSetPosition -win $_nWave1 {("G6" 15)}
wvSetCursor -win $_nWave1 16713.837256
wvSetCursor -win $_nWave1 16739.047230
wvSetCursor -win $_nWave1 16839.887126
wvZoom -win $_nWave1 12705.451369 22688.601124
wvSelectSignal -win $_nWave1 {( "G5" 1 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G7" 0)}
wvSetPosition -win $_nWave1 {("G6" 15)}
wvSelectSignal -win $_nWave1 {( "G6" 3 )} 
wvSetPosition -win $_nWave1 {("G6" 3)}
wvSetPosition -win $_nWave1 {("G6" 11)}
wvSetPosition -win $_nWave1 {("G6" 13)}
wvSetPosition -win $_nWave1 {("G6" 12)}
wvMoveSelected -win $_nWave1
wvSetPosition -win $_nWave1 {("G6" 12)}
wvSelectSignal -win $_nWave1 {( "G6" 12 )} 
wvExpandBus -win $_nWave1
wvSetCursor -win $_nWave1 21393.489805
wvSetCursor -win $_nWave1 21393.489805
wvSetCursor -win $_nWave1 16698.711271
wvSetCursor -win $_nWave1 13525.688538
wvSetCursor -win $_nWave1 13773.918208
wvSetCursor -win $_nWave1 13881.844151
wvSetCursor -win $_nWave1 13612.029293
wvSetCursor -win $_nWave1 13536.481133
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 13741.540425
wvSetCursor -win $_nWave1 13881.844151
wvSetCursor -win $_nWave1 14119.281226
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G6" 1 )} 
wvSetCursor -win $_nWave1 16914.563158
wvSetCursor -win $_nWave1 16633.955705
wvSetCursor -win $_nWave1 16579.992733
wvSetCursor -win $_nWave1 16806.637214
wvSetCursor -win $_nWave1 19936.489570
wvSetCursor -win $_nWave1 19839.356221
wvSetCursor -win $_nWave1 19763.808061
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G6" 3 )} 
wvSetPosition -win $_nWave1 {("G6" 3)}
wvCollapseBus -win $_nWave1
wvSetPosition -win $_nWave1 {("G6" 3)}
wvSetPosition -win $_nWave1 {("G6" 12)}
wvSelectSignal -win $_nWave1 {( "G6" 4 )} 
wvSetCursor -win $_nWave1 16839.014997
wvSetCursor -win $_nWave1 17152.000233
wvSetCursor -win $_nWave1 20055.208108
wvSetCursor -win $_nWave1 20163.134051
wvSetCursor -win $_nWave1 20206.304428
wvSetCursor -win $_nWave1 20400.571126
wvGetSignalOpen -win $_nWave1
wvSetPosition -win $_nWave1 {("G6" 13)}
wvSetPosition -win $_nWave1 {("G6" 13)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/u_MATRIX_MULT/in_valid} \
{/TESTBED/u_MATRIX_MULT/clk} \
{/TESTBED/u_MATRIX_MULT/in_data\[63:0\]} \
{/TESTBED/u_MATRIX_MULT/out_data\[19:0\]} \
{/TESTBED/u_MATRIX_MULT/out_valid} \
{/TESTBED/u_MATRIX_MULT/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvAddSignal -win $_nWave1 -group {"G1" \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
{/TESTBED/u_MATRIX_MULT/a_sel\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/b_row\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/matrix_A\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0\]\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[1\]\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[2\]\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[3\]\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[4\]\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[5\]\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[6\]\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[7\]\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/out_cond} \
{/TESTBED/u_MATRIX_MULT/is_load_A} \
{/TESTBED/u_MATRIX_MULT/is_mac} \
{/TESTBED/u_MATRIX_MULT/is_setup} \
}
wvAddSignal -win $_nWave1 -group {"G7" \
}
wvSelectSignal -win $_nWave1 {( "G6" 13 )} 
wvSetPosition -win $_nWave1 {("G6" 13)}
wvSetPosition -win $_nWave1 {("G6" 13)}
wvSetPosition -win $_nWave1 {("G6" 13)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/u_MATRIX_MULT/in_valid} \
{/TESTBED/u_MATRIX_MULT/clk} \
{/TESTBED/u_MATRIX_MULT/in_data\[63:0\]} \
{/TESTBED/u_MATRIX_MULT/out_data\[19:0\]} \
{/TESTBED/u_MATRIX_MULT/out_valid} \
{/TESTBED/u_MATRIX_MULT/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvAddSignal -win $_nWave1 -group {"G1" \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
{/TESTBED/u_MATRIX_MULT/a_sel\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/b_row\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/matrix_A\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0\]\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[1\]\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[2\]\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[3\]\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[4\]\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[5\]\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[6\]\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[7\]\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/out_cond} \
{/TESTBED/u_MATRIX_MULT/is_load_A} \
{/TESTBED/u_MATRIX_MULT/is_mac} \
{/TESTBED/u_MATRIX_MULT/is_setup} \
}
wvAddSignal -win $_nWave1 -group {"G7" \
}
wvSelectSignal -win $_nWave1 {( "G6" 13 )} 
wvSetPosition -win $_nWave1 {("G6" 13)}
wvGetSignalClose -win $_nWave1
wvSetCursor -win $_nWave1 20281.852588
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectGroup -win $_nWave1 {G7}
wvUnknownSaveResult -win $_nWave1 -clear
wvSelectSignal -win $_nWave1 {( "G6" 1 )} 
wvSetCursor -win $_nWave1 13622.821887
wvSetCursor -win $_nWave1 13925.014528
wvSetCursor -win $_nWave1 14119.281226
wvSetCursor -win $_nWave1 14216.414575
wvSelectSignal -win $_nWave1 {( "G6" 2 )} 
wvSetPosition -win $_nWave1 {("G6" 2)}
wvExpandBus -win $_nWave1
wvSetPosition -win $_nWave1 {("G6" 21)}
wvSetCursor -win $_nWave1 16752.674243
wvSetCursor -win $_nWave1 16569.200139
wvSetCursor -win $_nWave1 16461.274196
wvSetCursor -win $_nWave1 16439.689007
wvSetCursor -win $_nWave1 16655.540894
