 
****************************************
Report : resources
Design : DART
Version: U-2022.12
Date   : Fri Apr 24 02:41:45 2026
****************************************


Resource Report for this hierarchy in file ../01_RTL/DART_FSM.v
=============================================================================
| Cell           | Module         | Parameters | Contained Operations       |
=============================================================================
| add_x_2        | DW01_inc       | width=5    | u_counter/add_25 (DART_COUNTER.v:25) |
| add_x_4        | DW01_add       | width=6    | u_score_calc/add_23 (DART_SCORE_CALC.v:23) |
| sub_x_6        | DW01_sub       | width=10   | u_next_score1/sub_7 (DART_NEXT_SCORE.v:7) |
| lt_x_8         | DW_cmp         | width=9    | u_winner/lt_8 (DART_WINNER.v:8) |
| sub_x_10       | DW01_sub       | width=10   | u_next_score2/sub_7 (DART_NEXT_SCORE.v:7) |
=============================================================================


Datapath Extraction Report

Information: Operator associated with resources 'u_score_calc/add_23 (DART_SCORE_CALC.v:23)' in design 'DART' breaks the datapath extraction because there is leakage due to truncation on its fanout to operator of resources 'u_score_calc/C28 (DART_SCORE_CALC.v:22)'.  (HDL-120)


Implementation Report
===============================================================================
|                    |                  | Current            | Set            |
| Cell               | Module           | Implementation     | Implementation |
===============================================================================
| add_x_2            | DW01_inc         | apparch (area)     |                |
| add_x_4            | DW01_add         | apparch (area)     |                |
| sub_x_6            | DW01_sub         | apparch (area)     |                |
| lt_x_8             | DW_cmp           | apparch (area)     |                |
| sub_x_10           | DW01_sub         | apparch (area)     |                |
===============================================================================

1
