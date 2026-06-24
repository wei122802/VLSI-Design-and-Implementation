verdiSetActWin -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 {/home/VLSILAB45/Lab1/01_RTL/MATRIX_MULT.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/u_MATRIX_MULT"
wvSetPosition -win $_nWave1 {("G1" 16)}
wvSetPosition -win $_nWave1 {("G1" 16)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/u_MATRIX_MULT/acc\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/clk} \
{/TESTBED/u_MATRIX_MULT/comp_k\[2:0\]} \
{/TESTBED/u_MATRIX_MULT/i\[31:0\]} \
{/TESTBED/u_MATRIX_MULT/in_data\[63:0\]} \
{/TESTBED/u_MATRIX_MULT/in_valid} \
{/TESTBED/u_MATRIX_MULT/input_cnt\[3:0\]} \
{/TESTBED/u_MATRIX_MULT/j\[31:0\]} \
{/TESTBED/u_MATRIX_MULT/mat_a\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_b\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
{/TESTBED/u_MATRIX_MULT/out_data\[19:0\]} \
{/TESTBED/u_MATRIX_MULT/out_valid} \
{/TESTBED/u_MATRIX_MULT/rst_n} \
{/TESTBED/u_MATRIX_MULT/state\[2:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 )} \
           
wvSetPosition -win $_nWave1 {("G1" 16)}
wvSetPosition -win $_nWave1 {("G1" 16)}
wvSetPosition -win $_nWave1 {("G1" 16)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/u_MATRIX_MULT/acc\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/clk} \
{/TESTBED/u_MATRIX_MULT/comp_k\[2:0\]} \
{/TESTBED/u_MATRIX_MULT/i\[31:0\]} \
{/TESTBED/u_MATRIX_MULT/in_data\[63:0\]} \
{/TESTBED/u_MATRIX_MULT/in_valid} \
{/TESTBED/u_MATRIX_MULT/input_cnt\[3:0\]} \
{/TESTBED/u_MATRIX_MULT/j\[31:0\]} \
{/TESTBED/u_MATRIX_MULT/mat_a\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_b\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
{/TESTBED/u_MATRIX_MULT/out_data\[19:0\]} \
{/TESTBED/u_MATRIX_MULT/out_valid} \
{/TESTBED/u_MATRIX_MULT/rst_n} \
{/TESTBED/u_MATRIX_MULT/state\[2:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 )} \
           
wvSetPosition -win $_nWave1 {("G1" 16)}
wvGetSignalClose -win $_nWave1
wvResizeWindow -win $_nWave1 0 23 1920 1017
wvZoom -win $_nWave1 0.000000 127720.862985
wvResizeWindow -win $_nWave1 0 23 1920 1017
wvSelectSignal -win $_nWave1 {( "G1" 5 )} 
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvSetPosition -win $_nWave1 {("G1" 6)}
wvSetPosition -win $_nWave1 {("G1" 3)}
wvSetPosition -win $_nWave1 {("G1" 1)}
wvSetPosition -win $_nWave1 {("G1" 0)}
wvMoveSelected -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 0)}
wvSetPosition -win $_nWave1 {("G1" 1)}
wvSelectSignal -win $_nWave1 {( "G1" 3 )} 
wvSetPosition -win $_nWave1 {("G1" 3)}
wvSetPosition -win $_nWave1 {("G1" 1)}
wvMoveSelected -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 1)}
wvSetPosition -win $_nWave1 {("G1" 2)}
wvSelectSignal -win $_nWave1 {( "G1" 14 )} 
wvSelectSignal -win $_nWave1 {( "G1" 14 15 )} 
wvSelectSignal -win $_nWave1 {( "G1" 13 14 15 )} 
wvSelectSignal -win $_nWave1 {( "G1" 2 13 14 15 )} 
wvSelectSignal -win $_nWave1 {( "G1" 1 2 13 14 15 )} 
wvSelectSignal -win $_nWave1 {( "G1" 1 2 6 13 14 15 )} 
wvSetPosition -win $_nWave1 {("G1" 13)}
wvSetPosition -win $_nWave1 {("G1" 15)}
wvSetPosition -win $_nWave1 {("G2" 0)}
wvMoveSelected -win $_nWave1
wvSetPosition -win $_nWave1 {("G2" 6)}
wvSetPosition -win $_nWave1 {("G2" 6)}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 7 8 9 10 )} 
wvSelectGroup -win $_nWave1 {G1}
wvSetPosition -win $_nWave1 {("G1" 0)}
wvSetPosition -win $_nWave1 {("G2" 4)}
wvSetPosition -win $_nWave1 {("G3" 0)}
wvMoveSelected -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 10)}
wvSetPosition -win $_nWave1 {("G1" 10)}
wvSetCursor -win $_nWave1 48077.881791
wvSetCursor -win $_nWave1 47560.119987
wvSaveSignal -win $_nWave1 "/home/VLSILAB45/Lab1/01_RTL/signal.rc"
wvSetCursor -win $_nWave1 15902.683977
wvZoomOut -win $_nWave1
wvSetCursor -win $_nWave1 18343.561052
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G2" 5 )} 
wvSelectSignal -win $_nWave1 {( "G2" 4 )} 
wvSetCursor -win $_nWave1 18343.561052
wvSetCursor -win $_nWave1 174873.428005
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 149722.826948
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSetPosition -win $_nWave1 {("G4" 1)}
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
{/TESTBED/u_MATRIX_MULT/i\[31:0\]} \
{/TESTBED/u_MATRIX_MULT/input_cnt\[3:0\]} \
{/TESTBED/u_MATRIX_MULT/j\[31:0\]} \
{/TESTBED/u_MATRIX_MULT/mat_a\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_b\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 1 )} 
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSetPosition -win $_nWave1 {("G4" 1)}
wvSetPosition -win $_nWave1 {("G4" 1)}
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
{/TESTBED/u_MATRIX_MULT/i\[31:0\]} \
{/TESTBED/u_MATRIX_MULT/input_cnt\[3:0\]} \
{/TESTBED/u_MATRIX_MULT/j\[31:0\]} \
{/TESTBED/u_MATRIX_MULT/mat_a\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_b\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 1 )} 
wvSetPosition -win $_nWave1 {("G4" 1)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G4" 1 )} 
wvSetRadix -win $_nWave1 -format UDec
wvSetCursor -win $_nWave1 174637.272127
wvSetCursor -win $_nWave1 174991.505945
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/u_MATRIX_MULT"
wvSetPosition -win $_nWave1 {("G4" 2)}
wvSetPosition -win $_nWave1 {("G4" 2)}
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
{/TESTBED/u_MATRIX_MULT/i\[31:0\]} \
{/TESTBED/u_MATRIX_MULT/input_cnt\[3:0\]} \
{/TESTBED/u_MATRIX_MULT/j\[31:0\]} \
{/TESTBED/u_MATRIX_MULT/mat_a\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_b\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
{/TESTBED/u_MATRIX_MULT/p1_valid} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 2 )} 
wvSetPosition -win $_nWave1 {("G4" 2)}
wvSetPosition -win $_nWave1 {("G4" 2)}
wvSetPosition -win $_nWave1 {("G4" 2)}
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
{/TESTBED/u_MATRIX_MULT/i\[31:0\]} \
{/TESTBED/u_MATRIX_MULT/input_cnt\[3:0\]} \
{/TESTBED/u_MATRIX_MULT/j\[31:0\]} \
{/TESTBED/u_MATRIX_MULT/mat_a\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_b\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
{/TESTBED/u_MATRIX_MULT/p1_valid} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 2 )} 
wvSetPosition -win $_nWave1 {("G4" 2)}
wvGetSignalClose -win $_nWave1
wvSetCursor -win $_nWave1 48057.721268
wvSetCursor -win $_nWave1 166489.894320
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 176054.207398
wvSetCursor -win $_nWave1 175936.129458
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 178664.597094
wvSetCursor -win $_nWave1 178074.207398
wvSetCursor -win $_nWave1 177483.817701
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvSetCursor -win $_nWave1 175122.258917
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvSetCursor -win $_nWave1 175594.570674
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 48896.941876
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvZoom -win $_nWave1 44646.136063 58343.177015
wvZoomOut -win $_nWave1
wvSetCursor -win $_nWave1 46953.101349
wvSetCursor -win $_nWave1 47984.450536
wvSetCursor -win $_nWave1 47731.136700
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 47819.796543
wvSetCursor -win $_nWave1 47946.453460
wvSetCursor -win $_nWave1 47023.667346
wvSetCursor -win $_nWave1 47258.887336
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 49828.213380
wvSetCursor -win $_nWave1 48199.767296
wvSetCursor -win $_nWave1 48036.922688
wvGetSignalOpen -win $_nWave1
wvSetPosition -win $_nWave1 {("G4" 6)}
wvSetPosition -win $_nWave1 {("G4" 6)}
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
{/TESTBED/u_MATRIX_MULT/i\[31:0\]} \
{/TESTBED/u_MATRIX_MULT/input_cnt\[3:0\]} \
{/TESTBED/u_MATRIX_MULT/j\[31:0\]} \
{/TESTBED/u_MATRIX_MULT/mat_a\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_b\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
{/TESTBED/u_MATRIX_MULT/p1_valid} \
{/TESTBED/u_MATRIX_MULT/done} \
{/TESTBED/u_MATRIX_MULT/in_done} \
{/TESTBED/u_MATRIX_MULT/out_cnt_pipe\[5:0\]} \
{/TESTBED/u_MATRIX_MULT/p2_valid} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 3 4 5 6 )} 
wvSetPosition -win $_nWave1 {("G4" 6)}
wvSetPosition -win $_nWave1 {("G4" 6)}
wvSetPosition -win $_nWave1 {("G4" 6)}
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
{/TESTBED/u_MATRIX_MULT/i\[31:0\]} \
{/TESTBED/u_MATRIX_MULT/input_cnt\[3:0\]} \
{/TESTBED/u_MATRIX_MULT/j\[31:0\]} \
{/TESTBED/u_MATRIX_MULT/mat_a\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_b\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
{/TESTBED/u_MATRIX_MULT/p1_valid} \
{/TESTBED/u_MATRIX_MULT/done} \
{/TESTBED/u_MATRIX_MULT/in_done} \
{/TESTBED/u_MATRIX_MULT/out_cnt_pipe\[5:0\]} \
{/TESTBED/u_MATRIX_MULT/p2_valid} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 3 4 5 6 )} 
wvSetPosition -win $_nWave1 {("G4" 6)}
wvGetSignalClose -win $_nWave1
wvSetCursor -win $_nWave1 46498.945830
wvSetCursor -win $_nWave1 46679.884284 -snap {("G4" 3)}
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvSetCursor -win $_nWave1 49721.887098
wvSetCursor -win $_nWave1 47695.376416
wvSetCursor -win $_nWave1 46899.247219
wvSetCursor -win $_nWave1 46175.493404
wvSetCursor -win $_nWave1 46103.118023
wvSetCursor -win $_nWave1 49360.010191
wvSetCursor -win $_nWave1 49866.637861
wvSetCursor -win $_nWave1 49866.637861
wvSetCursor -win $_nWave1 50011.388624
wvSetCursor -win $_nWave1 49577.136335
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvSetCursor -win $_nWave1 48563.880994
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvUnknownSaveResult -win $_nWave1 -clear
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvGetSignalOpen -win $_nWave1
wvSetPosition -win $_nWave1 {("G5" 2)}
wvSetPosition -win $_nWave1 {("G5" 2)}
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
{/TESTBED/u_MATRIX_MULT/i\[31:0\]} \
{/TESTBED/u_MATRIX_MULT/input_cnt\[3:0\]} \
{/TESTBED/u_MATRIX_MULT/j\[31:0\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
{/TESTBED/u_MATRIX_MULT/p1_valid} \
{/TESTBED/u_MATRIX_MULT/done} \
{/TESTBED/u_MATRIX_MULT/in_done} \
{/TESTBED/u_MATRIX_MULT/out_cnt_pipe\[5:0\]} \
{/TESTBED/u_MATRIX_MULT/p2_valid} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/u_MATRIX_MULT/matrix_A\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/matrix_B\[0:7\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
}
wvSelectSignal -win $_nWave1 {( "G5" 1 2 )} 
wvSetPosition -win $_nWave1 {("G5" 2)}
wvSetPosition -win $_nWave1 {("G5" 2)}
wvSetPosition -win $_nWave1 {("G5" 2)}
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
{/TESTBED/u_MATRIX_MULT/i\[31:0\]} \
{/TESTBED/u_MATRIX_MULT/input_cnt\[3:0\]} \
{/TESTBED/u_MATRIX_MULT/j\[31:0\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
{/TESTBED/u_MATRIX_MULT/p1_valid} \
{/TESTBED/u_MATRIX_MULT/done} \
{/TESTBED/u_MATRIX_MULT/in_done} \
{/TESTBED/u_MATRIX_MULT/out_cnt_pipe\[5:0\]} \
{/TESTBED/u_MATRIX_MULT/p2_valid} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/u_MATRIX_MULT/matrix_A\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/matrix_B\[0:7\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
}
wvSelectSignal -win $_nWave1 {( "G5" 1 2 )} 
wvSetPosition -win $_nWave1 {("G5" 2)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvSetPosition -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G4" 5)}
wvSetPosition -win $_nWave1 {("G5" 1)}
wvSetPosition -win $_nWave1 {("G5" 2)}
wvMoveSelected -win $_nWave1
wvSetPosition -win $_nWave1 {("G5" 3)}
wvSetCursor -win $_nWave1 47333.499508
wvSetCursor -win $_nWave1 45958.367260
wvSetCursor -win $_nWave1 47623.001034
wvSetCursor -win $_nWave1 48129.628705
wvSetCursor -win $_nWave1 48129.628705
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvSetPosition -win $_nWave1 {("G5" 4)}
wvSetPosition -win $_nWave1 {("G5" 4)}
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
{/TESTBED/u_MATRIX_MULT/i\[31:0\]} \
{/TESTBED/u_MATRIX_MULT/input_cnt\[3:0\]} \
{/TESTBED/u_MATRIX_MULT/j\[31:0\]} \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
{/TESTBED/u_MATRIX_MULT/p1_valid} \
{/TESTBED/u_MATRIX_MULT/done} \
{/TESTBED/u_MATRIX_MULT/in_done} \
{/TESTBED/u_MATRIX_MULT/out_cnt_pipe\[5:0\]} \
{/TESTBED/u_MATRIX_MULT/p2_valid} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/u_MATRIX_MULT/matrix_A\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/matrix_B\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/p1_prod\[0:7\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
}
wvSelectSignal -win $_nWave1 {( "G5" 4 )} 
wvSetPosition -win $_nWave1 {("G5" 4)}
wvSetPosition -win $_nWave1 {("G5" 4)}
wvSetPosition -win $_nWave1 {("G5" 4)}
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
{/TESTBED/u_MATRIX_MULT/i\[31:0\]} \
{/TESTBED/u_MATRIX_MULT/input_cnt\[3:0\]} \
{/TESTBED/u_MATRIX_MULT/j\[31:0\]} \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/u_MATRIX_MULT/out_cnt\[5:0\]} \
{/TESTBED/u_MATRIX_MULT/p1_valid} \
{/TESTBED/u_MATRIX_MULT/done} \
{/TESTBED/u_MATRIX_MULT/in_done} \
{/TESTBED/u_MATRIX_MULT/out_cnt_pipe\[5:0\]} \
{/TESTBED/u_MATRIX_MULT/p2_valid} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/u_MATRIX_MULT/matrix_A\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/matrix_B\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/mat_c\[0:7\]} \
{/TESTBED/u_MATRIX_MULT/p1_prod\[0:7\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
}
wvSelectSignal -win $_nWave1 {( "G5" 4 )} 
wvSetPosition -win $_nWave1 {("G5" 4)}
wvGetSignalClose -win $_nWave1
wvSetCursor -win $_nWave1 48057.253323
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 47984.877942
wvSelectSignal -win $_nWave1 {( "G4" 4 )} 
wvGetSignalOpen -win $_nWave1
wvSetCursor -win $_nWave1 48636.256376
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 48636.256376
wvSetCursor -win $_nWave1 48530.033025
wvSetCursor -win $_nWave1 48097.080581
wvSetCursor -win $_nWave1 47703.487450
wvSetCursor -win $_nWave1 47860.924703
wvSetCursor -win $_nWave1 47979.002642
wvSetCursor -win $_nWave1 47979.002642
wvSetCursor -win $_nWave1 47979.002642
wvResizeWindow -win $_nWave1 0 23 1920 1017
wvSelectSignal -win $_nWave1 {( "G5" 2 )} 
wvSetPosition -win $_nWave1 {("G5" 2)}
wvExpandBus -win $_nWave1
wvSetPosition -win $_nWave1 {("G5" 12)}
wvSetCursor -win $_nWave1 47979.002642
wvSetCursor -win $_nWave1 32326.887162
wvResizeWindow -win $_nWave1 0 23 1920 1017
wvResizeWindow -win $_nWave1 0 23 1920 1017
wvResizeWindow -win $_nWave1 0 23 1920 1017
wvSetCursor -win $_nWave1 47920.939948
wvSetCursor -win $_nWave1 48271.011749
wvSetCursor -win $_nWave1 47687.558747
wvSetCursor -win $_nWave1 48076.527415
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 47920.939948
wvSetCursor -win $_nWave1 47920.939948
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G5" 12 )} 
wvSelectSignal -win $_nWave1 {( "G4" 2 )} 
wvSelectSignal -win $_nWave1 {( "G4" 3 )} 
wvSelectSignal -win $_nWave1 {( "G5" 2 )} 
wvSetPosition -win $_nWave1 {("G5" 2)}
wvCollapseBus -win $_nWave1
wvSetPosition -win $_nWave1 {("G5" 2)}
wvSetPosition -win $_nWave1 {("G5" 4)}
wvSelectSignal -win $_nWave1 {( "G5" 3 )} 
wvSelectSignal -win $_nWave1 {( "G5" 4 )} 
wvSetCursor -win $_nWave1 46909.621410
wvSetCursor -win $_nWave1 46326.168407
wvSetCursor -win $_nWave1 46131.684073
wvSetCursor -win $_nWave1 46287.271540
wvSetCursor -win $_nWave1 45937.199739
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvUnknownSaveResult -win $_nWave1 -clear
wvSetCursor -win $_nWave1 46520.652742
wvSetCursor -win $_nWave1 46248.374674
wvSetCursor -win $_nWave1 45703.818538
wvSetCursor -win $_nWave1 46170.580940
wvSetCursor -win $_nWave1 48076.527415
wvSetCursor -win $_nWave1 47920.939948
wvSaveSignal -win $_nWave1 "/home/VLSILAB45/Lab1/01_RTL/signal.rc"
wvExit
