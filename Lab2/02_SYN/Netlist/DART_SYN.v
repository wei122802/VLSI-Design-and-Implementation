/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : U-2022.12
// Date      : Fri Apr 24 02:41:45 2026
/////////////////////////////////////////////////////////////


module DART ( clk, rst_n, in_valid, player, is_double, is_triple, points, 
        out_valid, out_winner );
  input [4:0] points;
  input clk, rst_n, in_valid, player, is_double, is_triple;
  output out_valid, out_winner;
  wire   u_fsm_n1, u_out_winner_N6, n119, n120, n121, n122, n123, n124, n125,
         n126, n127, n128, n129, n130, n131, n132, n133, n134, n135, n136,
         n137, n138, n139, n140, n141, n142, n144, n145, n146, n147, n148,
         n149, n150, n151, n152, n153, n154, n155, n156, n157, n158, n159,
         n160, n161, n162, n163, n164, n165, n166, n167, n168, n169, n170,
         n171, n172, n173, n174, n175, n176, n177, n178, n179, n180, n181,
         n182, n183, n184, n185, n186, n187, n188, n189, n190, n191, n192,
         n193, n194, n195, n196, n197, n198, n199, n200, n201, n202, n203,
         n204, n205, n206, n207, n208, n209, n210, n211, n212, n213, n214,
         n215, n216, n217, n218, n219, n220, n221, n222, n223, n224, n225,
         n226, n227, n228, n229, n230, n231, n232, n233, n234, n235, n236,
         n237, n238, n239, n240, n241, n242, n243, n244, n245, n246, n247,
         n248, n249, n250, n251, n252, n253, n254, n255, n256, n257, n258,
         n259, n260, n261, n262, n263, n264, n265, n266, n267, n268, n269,
         n270, n271, n272, n273, n274, n275, n276, n277, n278, n279, n280,
         n281, n282, n283, n284, n285, n286, n287, n288, n289, n290, n291,
         n292, n293, n294, n295, n296, n297, n298, n299, n300, n301, n302,
         n303, n304, n305, n306, n307, n308, n309, n310, n311, n312, n313,
         n314, n315, n316, n317, n318, n319, n320, n321, n322, n323, n324,
         n325, n326, n327, n328, n329, n330, n331, n332, n333, n334, n335,
         n336, n337, n338, n339, n340, n341, n342, n343, n344, n345, n346,
         n347, n348, n349, n350, n351, n352, n353, n354, n355, n356, n357,
         n358, n359, n360, n361, n362, n363, n364, n365, n366, n367, n368,
         n369, n370, n371, n372, n373, n374, n375, n376, n377, n378, n379,
         n380, n381, n382, n383, n384, n385, n386, n387, n388, n389, n390,
         n391, n392, n393, n394, n395, n396, n397, n398, n399, n400, n401,
         n402, n403, n404, n405, n406, n407, n408, n409, n410, n411, n412,
         n413, n414, n415, n416, n417, n418, n419, n420, n421, n422, n423,
         n424, n425, n426, n427, n428, n429, n430, n431, n432, n433, n434,
         n435, n436, n437, n438, n439, n440, n441, n442, n443, n444, n445,
         n446, n447;
  wire   [4:0] dart_count;
  wire   [1:0] state;
  wire   [8:0] score_p0;
  wire   [8:0] score_p1;

  DFFRX1 u_counter_dart_count_reg_4_ ( .D(n141), .CK(clk), .RN(rst_n), .Q(
        dart_count[4]), .QN(n445) );
  DFFRX1 u_fsm_state_reg_0_ ( .D(n142), .CK(clk), .RN(rst_n), .Q(state[0]), 
        .QN(n436) );
  DFFRX1 u_counter_dart_count_reg_0_ ( .D(n140), .CK(clk), .RN(rst_n), .Q(
        dart_count[0]), .QN(n444) );
  DFFRX1 u_counter_dart_count_reg_1_ ( .D(n139), .CK(clk), .RN(rst_n), .Q(
        dart_count[1]), .QN(n432) );
  DFFRX1 u_counter_dart_count_reg_2_ ( .D(n138), .CK(clk), .RN(n447), .Q(
        dart_count[2]) );
  DFFRX1 u_counter_dart_count_reg_3_ ( .D(n137), .CK(clk), .RN(n447), .Q(
        dart_count[3]), .QN(n443) );
  DFFRX2 u_p1_score_score_reg_6_ ( .D(n134), .CK(clk), .RN(n447), .Q(
        score_p1[6]), .QN(n441) );
  DFFRX2 u_p0_score_score_reg_1_ ( .D(n126), .CK(clk), .RN(n447), .Q(
        score_p0[1]), .QN(n437) );
  DFFSX1 u_p1_score_score_reg_0_ ( .D(n128), .CK(clk), .SN(rst_n), .Q(
        score_p1[0]), .QN(n434) );
  DFFRX1 u_out_winner_out_winner_reg ( .D(u_out_winner_N6), .CK(clk), .RN(n447), .Q(out_winner) );
  DFFRX2 u_p0_score_score_reg_7_ ( .D(n120), .CK(clk), .RN(n447), .Q(n426), 
        .QN(n431) );
  DFFSX4 u_p0_score_score_reg_5_ ( .D(n122), .CK(clk), .SN(n447), .Q(
        score_p0[5]), .QN(n438) );
  DFFRX2 u_p1_score_score_reg_7_ ( .D(n135), .CK(clk), .RN(n447), .Q(
        score_p1[7]), .QN(n442) );
  DFFSX2 u_p1_score_score_reg_5_ ( .D(n133), .CK(clk), .SN(n447), .Q(
        score_p1[5]), .QN(n430) );
  DFFSX2 u_p1_score_score_reg_3_ ( .D(n131), .CK(clk), .SN(n447), .Q(
        score_p1[3]), .QN(n440) );
  DFFSX2 u_p1_score_score_reg_2_ ( .D(n130), .CK(clk), .SN(n447), .Q(
        score_p1[2]), .QN(n446) );
  DFFRX4 u_p1_score_score_reg_4_ ( .D(n132), .CK(clk), .RN(n447), .Q(
        score_p1[4]), .QN(n433) );
  DFFRX4 u_p1_score_score_reg_1_ ( .D(n129), .CK(clk), .RN(n447), .Q(
        score_p1[1]), .QN(n427) );
  DFFSX1 u_out_valid_out_valid_reg ( .D(n425), .CK(clk), .SN(n447), .QN(
        out_valid) );
  DFFSX2 u_p0_score_score_reg_0_ ( .D(n127), .CK(clk), .SN(n447), .Q(
        score_p0[0]), .QN(n435) );
  DFFSX2 u_p1_score_score_reg_8_ ( .D(n136), .CK(clk), .SN(rst_n), .Q(
        score_p1[8]) );
  DFFSX2 u_p0_score_score_reg_3_ ( .D(n124), .CK(clk), .SN(n447), .Q(
        score_p0[3]), .QN(n439) );
  DFFSX2 u_p0_score_score_reg_8_ ( .D(n119), .CK(clk), .SN(rst_n), .Q(
        score_p0[8]) );
  DFFRX4 u_fsm_state_reg_1_ ( .D(u_fsm_n1), .CK(clk), .RN(rst_n), .Q(state[1]), 
        .QN(n428) );
  DFFRHQX2 u_p0_score_score_reg_4_ ( .D(n123), .CK(clk), .RN(n447), .Q(n146)
         );
  DFFSX1 u_p0_score_score_reg_2_ ( .D(n125), .CK(clk), .SN(rst_n), .Q(
        score_p0[2]), .QN(n429) );
  DFFRHQX4 u_p0_score_score_reg_6_ ( .D(n121), .CK(clk), .RN(n447), .Q(
        score_p0[6]) );
  OAI22XL U133 ( .A0(n323), .A1(n432), .B0(n444), .B1(n322), .Y(n139) );
  OAI22XL U134 ( .A0(n424), .A1(n443), .B0(n423), .B1(n422), .Y(n137) );
  OAI21X1 U135 ( .A0(n160), .A1(n344), .B0(n158), .Y(n126) );
  OAI21XL U136 ( .A0(n410), .A1(n409), .B0(score_p1[8]), .Y(n411) );
  OAI21XL U137 ( .A0(n413), .A1(n422), .B0(n414), .Y(n424) );
  OAI2BB1X1 U138 ( .A0N(score_p1[7]), .A1N(score_p1[6]), .B0(n410), .Y(n359)
         );
  NAND2X1 U139 ( .A(n371), .B(n428), .Y(n270) );
  OAI21X1 U140 ( .A0(n369), .A1(n268), .B0(n426), .Y(n269) );
  XOR2X2 U141 ( .A(n293), .B(n440), .Y(n294) );
  NAND2X1 U142 ( .A(n386), .B(n387), .Y(n388) );
  NAND2X1 U143 ( .A(n387), .B(n383), .Y(n177) );
  NAND2X1 U144 ( .A(n372), .B(n267), .Y(n367) );
  NOR2BX1 U145 ( .AN(n357), .B(n164), .Y(n163) );
  NAND2BX1 U146 ( .AN(n342), .B(n162), .Y(n161) );
  NAND2BX1 U147 ( .AN(n165), .B(n358), .Y(n164) );
  INVX1 U148 ( .A(in_valid), .Y(n413) );
  NAND2X4 U149 ( .A(n193), .B(n200), .Y(n192) );
  OA21XL U150 ( .A0(n317), .A1(n146), .B0(n301), .Y(n300) );
  INVX1 U151 ( .A(n354), .Y(n291) );
  NAND2X6 U152 ( .A(n194), .B(n166), .Y(n200) );
  NOR2X6 U153 ( .A(n314), .B(n157), .Y(n352) );
  CLKINVX2 U154 ( .A(n315), .Y(n194) );
  CLKINVX6 U155 ( .A(n302), .Y(n301) );
  NAND2X6 U156 ( .A(n281), .B(n151), .Y(n315) );
  INVX3 U157 ( .A(n390), .Y(n157) );
  NOR2X2 U158 ( .A(n405), .B(n261), .Y(n305) );
  NOR2XL U159 ( .A(n145), .B(n430), .Y(n290) );
  NAND2X6 U160 ( .A(n155), .B(n173), .Y(n302) );
  NAND2X1 U161 ( .A(n378), .B(n427), .Y(n273) );
  NAND2X4 U162 ( .A(n402), .B(score_p1[2]), .Y(n281) );
  INVX2 U163 ( .A(player), .Y(n145) );
  NOR2X1 U164 ( .A(n436), .B(state[1]), .Y(n414) );
  NAND3X1 U165 ( .A(n375), .B(points[0]), .C(n435), .Y(n338) );
  NAND2XL U166 ( .A(points[0]), .B(n434), .Y(n272) );
  NOR2X4 U167 ( .A(n286), .B(n176), .Y(n207) );
  BUFX2 U168 ( .A(n239), .Y(n167) );
  NAND2X2 U169 ( .A(n182), .B(n375), .Y(n180) );
  CLKINVX1 U170 ( .A(n146), .Y(n147) );
  NAND2X4 U171 ( .A(n234), .B(points[1]), .Y(n228) );
  BUFX3 U172 ( .A(n375), .Y(n153) );
  INVX4 U173 ( .A(points[1]), .Y(n213) );
  INVXL U174 ( .A(n187), .Y(n179) );
  INVX1 U175 ( .A(points[4]), .Y(n187) );
  INVX16 U176 ( .A(is_triple), .Y(n223) );
  NAND2X4 U177 ( .A(points[1]), .B(points[2]), .Y(n243) );
  NAND4BX1 U178 ( .AN(score_p1[5]), .B(n356), .C(n433), .D(n427), .Y(n256) );
  INVXL U179 ( .A(n319), .Y(n210) );
  NOR2X4 U180 ( .A(n353), .B(n352), .Y(n195) );
  NAND3XL U181 ( .A(n348), .B(n146), .C(n428), .Y(n349) );
  CLKINVX1 U182 ( .A(n169), .Y(n122) );
  NOR2X2 U183 ( .A(n372), .B(state[1]), .Y(n369) );
  OAI211X1 U184 ( .A0(n147), .A1(n371), .B0(n350), .C0(n349), .Y(n123) );
  NAND3XL U185 ( .A(n371), .B(n156), .C(n372), .Y(n373) );
  NAND2X4 U186 ( .A(n371), .B(n161), .Y(n160) );
  INVX4 U187 ( .A(n377), .Y(n371) );
  NAND2X6 U188 ( .A(n203), .B(points[3]), .Y(n230) );
  NAND3X1 U189 ( .A(n309), .B(n308), .C(score_p0[5]), .Y(n310) );
  AOI21X1 U190 ( .A0(n308), .A1(n309), .B0(n149), .Y(n312) );
  INVX12 U191 ( .A(points[2]), .Y(n203) );
  NAND2X2 U192 ( .A(n283), .B(n147), .Y(n249) );
  NAND2X2 U193 ( .A(n284), .B(n147), .Y(n250) );
  NAND2X4 U194 ( .A(points[1]), .B(points[0]), .Y(n244) );
  INVX3 U195 ( .A(n352), .Y(n193) );
  AOI32X1 U196 ( .A0(n424), .A1(dart_count[4]), .A2(n423), .B0(n320), .B1(n445), .Y(n141) );
  NAND2X2 U197 ( .A(n186), .B(n184), .Y(n285) );
  NAND2X1 U198 ( .A(n421), .B(n443), .Y(n423) );
  NAND2X2 U199 ( .A(n180), .B(n179), .Y(n186) );
  INVX1 U200 ( .A(n343), .Y(n159) );
  NOR2XL U201 ( .A(state[0]), .B(n428), .Y(n211) );
  XOR2X1 U202 ( .A(n177), .B(score_p0[2]), .Y(n384) );
  CLKINVX1 U203 ( .A(n355), .Y(n190) );
  INVX3 U204 ( .A(n305), .Y(n144) );
  NAND3BXL U205 ( .AN(n422), .B(dart_count[3]), .C(n421), .Y(n320) );
  INVX3 U206 ( .A(n414), .Y(n418) );
  NAND3BX1 U207 ( .AN(score_p0[8]), .B(n267), .C(n428), .Y(n253) );
  NOR2BXL U208 ( .AN(score_p1[3]), .B(score_p0[3]), .Y(n327) );
  NOR2X1 U209 ( .A(n145), .B(state[1]), .Y(n261) );
  NAND2X1 U210 ( .A(n411), .B(n428), .Y(n136) );
  NAND2X1 U211 ( .A(n389), .B(n428), .Y(n124) );
  NAND2X2 U212 ( .A(n160), .B(n159), .Y(n158) );
  OAI21X1 U213 ( .A0(n270), .A1(n367), .B0(n269), .Y(n120) );
  XOR2X1 U214 ( .A(n388), .B(score_p0[3]), .Y(n389) );
  OAI21X2 U215 ( .A0(n360), .A1(n351), .B0(n210), .Y(n209) );
  INVX3 U216 ( .A(n347), .Y(n348) );
  AOI211XL U217 ( .A0(score_p1[8]), .A1(n337), .B0(n336), .C0(n425), .Y(
        u_out_winner_N6) );
  AO21X1 U218 ( .A0(n428), .A1(score_p0[6]), .B0(n144), .Y(n268) );
  NAND3X2 U219 ( .A(n278), .B(n146), .C(n277), .Y(n152) );
  AOI21XL U220 ( .A0(n333), .A1(n332), .B0(n331), .Y(n335) );
  BUFX8 U221 ( .A(n285), .Y(n155) );
  NAND2XL U222 ( .A(n339), .B(n338), .Y(n341) );
  OAI22X4 U223 ( .A0(in_valid), .A1(state[1]), .B0(n260), .B1(n418), .Y(n405)
         );
  NAND2X6 U224 ( .A(n154), .B(n242), .Y(n283) );
  NAND2X1 U225 ( .A(n288), .B(n428), .Y(n289) );
  AND3X2 U226 ( .A(n443), .B(dart_count[4]), .C(n420), .Y(n412) );
  INVX1 U227 ( .A(n211), .Y(n425) );
  NAND4BXL U228 ( .AN(score_p0[5]), .B(n267), .C(n147), .D(n343), .Y(n255) );
  AND2X1 U229 ( .A(n428), .B(n370), .Y(n156) );
  AOI21XL U230 ( .A0(score_p1[4]), .A1(n147), .B0(n327), .Y(n328) );
  INVXL U231 ( .A(n428), .Y(n165) );
  INVXL U232 ( .A(n428), .Y(n171) );
  NAND3X1 U233 ( .A(dart_count[1]), .B(dart_count[0]), .C(dart_count[2]), .Y(
        n422) );
  INVX1 U234 ( .A(score_p0[6]), .Y(n370) );
  INVX1 U235 ( .A(state[1]), .Y(n162) );
  NAND2BX2 U236 ( .AN(n185), .B(n247), .Y(n184) );
  NAND2BX2 U237 ( .AN(n203), .B(n237), .Y(n202) );
  INVX3 U238 ( .A(n237), .Y(n286) );
  AND3X2 U239 ( .A(n375), .B(points[0]), .C(n435), .Y(n219) );
  INVX4 U240 ( .A(n375), .Y(n271) );
  NAND3X2 U241 ( .A(n172), .B(is_double), .C(points[1]), .Y(n225) );
  NAND2X4 U242 ( .A(n222), .B(n239), .Y(n204) );
  NAND2X2 U243 ( .A(n212), .B(n239), .Y(n216) );
  INVX16 U244 ( .A(is_triple), .Y(n224) );
  NAND3X2 U245 ( .A(n246), .B(points[3]), .C(is_triple), .Y(n185) );
  INVX16 U246 ( .A(points[2]), .Y(n231) );
  OAI21XL U247 ( .A0(n377), .A1(n379), .B0(score_p0[0]), .Y(n376) );
  NAND4BBX2 U248 ( .AN(n377), .BN(n171), .C(n347), .D(n147), .Y(n350) );
  NOR2X4 U249 ( .A(n263), .B(n253), .Y(n183) );
  NOR2X2 U250 ( .A(n188), .B(n429), .Y(n226) );
  NAND2X2 U251 ( .A(n188), .B(n429), .Y(n227) );
  NAND2X2 U252 ( .A(n188), .B(n446), .Y(n274) );
  INVX3 U253 ( .A(n188), .Y(n402) );
  XOR2X4 U254 ( .A(n174), .B(score_p1[5]), .Y(n208) );
  NAND2X4 U255 ( .A(n201), .B(points[1]), .Y(n221) );
  INVX4 U256 ( .A(n238), .Y(n241) );
  NAND3X2 U257 ( .A(n235), .B(n239), .C(n238), .Y(n236) );
  NAND3X6 U258 ( .A(n234), .B(n233), .C(points[1]), .Y(n238) );
  BUFX6 U259 ( .A(n286), .Y(n173) );
  NOR2X1 U260 ( .A(n426), .B(score_p0[6]), .Y(n267) );
  NAND2X6 U261 ( .A(n282), .B(n439), .Y(n297) );
  NAND2X6 U262 ( .A(n440), .B(n282), .Y(n314) );
  INVX4 U263 ( .A(n313), .Y(n316) );
  INVX8 U264 ( .A(n301), .Y(n351) );
  BUFX8 U265 ( .A(n245), .Y(n150) );
  NAND2X4 U266 ( .A(n148), .B(n252), .Y(n263) );
  OAI2BB1X4 U267 ( .A0N(n438), .A1N(n152), .B0(n302), .Y(n148) );
  NAND2BX2 U268 ( .AN(score_p0[5]), .B(n387), .Y(n149) );
  OAI21X4 U269 ( .A0(n183), .A1(n144), .B0(n178), .Y(n387) );
  NAND3X6 U270 ( .A(n241), .B(n239), .C(n240), .Y(n154) );
  NAND3X6 U271 ( .A(n280), .B(n279), .C(score_p1[3]), .Y(n151) );
  NAND2X4 U272 ( .A(n390), .B(n393), .Y(n360) );
  NAND2X2 U273 ( .A(n338), .B(score_p0[1]), .Y(n220) );
  NOR2X1 U274 ( .A(n312), .B(n311), .Y(n169) );
  NAND2X4 U275 ( .A(n217), .B(n218), .Y(n395) );
  NAND2X2 U276 ( .A(n150), .B(n244), .Y(n247) );
  OAI21X1 U277 ( .A0(n401), .A1(n400), .B0(n399), .Y(n403) );
  XOR2X2 U278 ( .A(n407), .B(n446), .Y(n408) );
  NAND3X2 U279 ( .A(n317), .B(n146), .C(score_p0[5]), .Y(n252) );
  NAND2X8 U280 ( .A(n201), .B(n245), .Y(n234) );
  NAND3X2 U281 ( .A(n393), .B(n390), .C(n361), .Y(n357) );
  NAND3X4 U282 ( .A(n198), .B(n199), .C(n196), .Y(n353) );
  NAND2X2 U283 ( .A(n363), .B(n361), .Y(n358) );
  NAND3X6 U284 ( .A(n275), .B(n274), .C(n273), .Y(n313) );
  NOR2X8 U285 ( .A(n224), .B(is_double), .Y(n239) );
  AOI22X4 U286 ( .A0(n395), .A1(n220), .B0(n437), .B1(n219), .Y(n381) );
  OAI2BB1X4 U287 ( .A0N(n262), .A1N(n183), .B0(n305), .Y(n377) );
  OAI2BB1X4 U288 ( .A0N(n358), .A1N(n357), .B0(n356), .Y(n410) );
  NOR2X1 U289 ( .A(n409), .B(n163), .Y(n365) );
  NAND2X4 U290 ( .A(n189), .B(n191), .Y(n409) );
  NAND2X4 U291 ( .A(n232), .B(n231), .Y(n233) );
  INVX8 U292 ( .A(n283), .Y(n277) );
  AND2X8 U293 ( .A(n313), .B(n390), .Y(n166) );
  OAI21X2 U294 ( .A0(n378), .A1(n427), .B0(n395), .Y(n275) );
  NAND3BX2 U295 ( .AN(n209), .B(n175), .C(n318), .Y(n174) );
  BUFX4 U296 ( .A(n284), .Y(n168) );
  OA21X4 U297 ( .A0(n345), .A1(n147), .B0(n351), .Y(n299) );
  BUFX16 U298 ( .A(n232), .Y(n176) );
  NAND2X6 U299 ( .A(n243), .B(n176), .Y(n182) );
  XOR2X4 U300 ( .A(n346), .B(n345), .Y(n347) );
  NAND2X1 U301 ( .A(n368), .B(n428), .Y(n119) );
  CLKINVX1 U302 ( .A(n295), .Y(n296) );
  AOI21X4 U303 ( .A0(n298), .A1(n297), .B0(n296), .Y(n346) );
  MXI2X4 U304 ( .A(n300), .B(n299), .S0(n346), .Y(n309) );
  NOR2X4 U305 ( .A(n251), .B(n264), .Y(n306) );
  NAND2X6 U306 ( .A(n279), .B(n280), .Y(n282) );
  BUFX4 U307 ( .A(n385), .Y(n170) );
  NAND3X2 U308 ( .A(n280), .B(n279), .C(score_p0[3]), .Y(n295) );
  INVX6 U309 ( .A(n284), .Y(n278) );
  NAND3X6 U310 ( .A(n278), .B(n277), .C(score_p1[4]), .Y(n390) );
  BUFX4 U311 ( .A(n224), .Y(n172) );
  OAI21X2 U312 ( .A0(n201), .A1(is_double), .B0(n213), .Y(n214) );
  INVX3 U313 ( .A(n244), .Y(n212) );
  INVX3 U314 ( .A(n297), .Y(n251) );
  NAND3X6 U315 ( .A(n204), .B(n202), .C(n225), .Y(n188) );
  INVX3 U316 ( .A(n406), .Y(n175) );
  NOR2X2 U317 ( .A(n272), .B(n271), .Y(n378) );
  NAND2X2 U318 ( .A(n408), .B(n428), .Y(n130) );
  NAND3BX2 U319 ( .AN(n144), .B(n306), .C(n307), .Y(n178) );
  NAND2X8 U320 ( .A(is_double), .B(n181), .Y(n375) );
  INVX12 U321 ( .A(is_triple), .Y(n181) );
  AOI21X2 U322 ( .A0(n353), .A1(n354), .B0(n190), .Y(n189) );
  NAND2X6 U323 ( .A(n192), .B(n354), .Y(n191) );
  AOI21X4 U324 ( .A0(n302), .A1(n290), .B0(n289), .Y(n354) );
  OAI211X1 U325 ( .A0(n387), .A1(n438), .B0(n310), .C0(n428), .Y(n311) );
  NAND2X6 U326 ( .A(n205), .B(n167), .Y(n279) );
  AOI21X4 U327 ( .A0(n200), .A1(n195), .B0(n291), .Y(n406) );
  NAND2BX4 U328 ( .AN(n197), .B(n155), .Y(n196) );
  NAND2X1 U329 ( .A(n173), .B(n430), .Y(n197) );
  AOI21X4 U330 ( .A0(n168), .A1(n433), .B0(n145), .Y(n198) );
  NAND2X1 U331 ( .A(n283), .B(n433), .Y(n199) );
  INVX20 U332 ( .A(points[0]), .Y(n201) );
  XOR2X4 U333 ( .A(n229), .B(n228), .Y(n205) );
  NOR2X8 U334 ( .A(n207), .B(n206), .Y(n280) );
  NOR2X4 U335 ( .A(n153), .B(n150), .Y(n206) );
  NAND2X2 U336 ( .A(n208), .B(n428), .Y(n133) );
  NAND3X2 U337 ( .A(n250), .B(n249), .C(n248), .Y(n264) );
  INVX3 U338 ( .A(n385), .Y(n298) );
  XOR2X4 U339 ( .A(n230), .B(n246), .Y(n235) );
  NOR2X4 U340 ( .A(n283), .B(n284), .Y(n317) );
  XNOR2X4 U341 ( .A(n221), .B(points[2]), .Y(n222) );
  INVX20 U342 ( .A(points[2]), .Y(n245) );
  OAI2BB2X1 U343 ( .B0(n442), .B1(n365), .A0N(n398), .A1N(n359), .Y(n135) );
  INVX20 U344 ( .A(points[4]), .Y(n246) );
  NAND2X2 U345 ( .A(n271), .B(points[3]), .Y(n242) );
  XNOR2X4 U346 ( .A(points[4]), .B(points[3]), .Y(n240) );
  INVX20 U347 ( .A(points[3]), .Y(n232) );
  AOI21X4 U348 ( .A0(n381), .A1(n227), .B0(n226), .Y(n385) );
  NAND2X2 U349 ( .A(points[0]), .B(n271), .Y(n218) );
  OAI21X2 U350 ( .A0(n213), .A1(is_double), .B0(n224), .Y(n215) );
  NAND3X2 U351 ( .A(n216), .B(n214), .C(n215), .Y(n217) );
  XOR2X4 U352 ( .A(is_double), .B(n223), .Y(n237) );
  XNOR2X4 U353 ( .A(points[3]), .B(points[2]), .Y(n229) );
  NAND2X2 U354 ( .A(n385), .B(n295), .Y(n307) );
  OAI2BB1X4 U355 ( .A0N(points[4]), .A1N(n237), .B0(n236), .Y(n284) );
  NAND3X1 U356 ( .A(n285), .B(n286), .C(n438), .Y(n248) );
  NAND2X1 U357 ( .A(n306), .B(n307), .Y(n262) );
  CLKINVX1 U358 ( .A(score_p0[1]), .Y(n343) );
  OR2X1 U359 ( .A(score_p0[8]), .B(score_p0[0]), .Y(n254) );
  NOR4X1 U360 ( .A(score_p0[2]), .B(score_p0[3]), .C(n255), .D(n254), .Y(n259)
         );
  OR2X1 U361 ( .A(score_p1[0]), .B(score_p1[8]), .Y(n257) );
  NOR2X1 U362 ( .A(score_p1[7]), .B(score_p1[6]), .Y(n356) );
  NOR4X1 U363 ( .A(score_p1[3]), .B(score_p1[2]), .C(n257), .D(n256), .Y(n258)
         );
  NOR2X1 U364 ( .A(n259), .B(n258), .Y(n260) );
  INVX1 U365 ( .A(n306), .Y(n266) );
  AOI2BB1X1 U366 ( .A0N(n264), .A1N(n295), .B0(n263), .Y(n265) );
  OA21X4 U367 ( .A0(n266), .A1(n170), .B0(n265), .Y(n372) );
  NAND2X1 U368 ( .A(n313), .B(n281), .Y(n276) );
  XOR2X1 U369 ( .A(n276), .B(n282), .Y(n292) );
  NAND2BX1 U370 ( .AN(score_p1[8]), .B(n356), .Y(n287) );
  NAND2X1 U371 ( .A(player), .B(n287), .Y(n288) );
  NOR3X2 U372 ( .A(n406), .B(n292), .C(n405), .Y(n293) );
  NAND2X2 U373 ( .A(n294), .B(n428), .Y(n131) );
  INVX1 U374 ( .A(n317), .Y(n345) );
  NOR2X1 U375 ( .A(n301), .B(n146), .Y(n304) );
  OAI21XL U376 ( .A0(n302), .A1(n147), .B0(n317), .Y(n303) );
  OAI21X1 U377 ( .A0(n317), .A1(n304), .B0(n303), .Y(n308) );
  OAI21X4 U378 ( .A0(n316), .A1(n315), .B0(n314), .Y(n393) );
  OR2X4 U379 ( .A(n317), .B(score_p1[4]), .Y(n391) );
  NAND3X1 U380 ( .A(n360), .B(n351), .C(n391), .Y(n318) );
  CLKINVX1 U381 ( .A(n405), .Y(n355) );
  OAI21X2 U382 ( .A0(n391), .A1(n351), .B0(n355), .Y(n319) );
  NOR2X1 U383 ( .A(n418), .B(n413), .Y(n421) );
  NAND2XL U384 ( .A(dart_count[1]), .B(dart_count[0]), .Y(n321) );
  NOR2X1 U385 ( .A(dart_count[2]), .B(n321), .Y(n420) );
  NOR2BX1 U386 ( .AN(n412), .B(n418), .Y(u_fsm_n1) );
  BUFX2 U387 ( .A(rst_n), .Y(n447) );
  OAI21XL U388 ( .A0(n413), .A1(n444), .B0(n414), .Y(n323) );
  NAND2XL U389 ( .A(n421), .B(n432), .Y(n322) );
  NAND2XL U390 ( .A(n343), .B(score_p1[1]), .Y(n324) );
  NAND3BX1 U391 ( .AN(score_p1[0]), .B(score_p0[0]), .C(n324), .Y(n326) );
  NAND2XL U392 ( .A(n427), .B(score_p0[1]), .Y(n325) );
  AOI2BB2X1 U393 ( .B0(n326), .B1(n325), .A0N(n446), .A1N(score_p0[2]), .Y(
        n330) );
  OAI22XL U394 ( .A0(score_p1[2]), .A1(n429), .B0(score_p1[3]), .B1(n439), .Y(
        n329) );
  OAI21XL U395 ( .A0(n330), .A1(n329), .B0(n328), .Y(n333) );
  OA22X1 U396 ( .A0(score_p1[5]), .A1(n438), .B0(score_p1[4]), .B1(n147), .Y(
        n332) );
  OAI22XL U397 ( .A0(score_p0[5]), .A1(n430), .B0(score_p0[6]), .B1(n441), .Y(
        n331) );
  OAI22XL U398 ( .A0(score_p1[6]), .A1(n370), .B0(n431), .B1(score_p1[7]), .Y(
        n334) );
  OAI22XL U399 ( .A0(n335), .A1(n334), .B0(n426), .B1(n442), .Y(n337) );
  AOI2BB1X1 U400 ( .A0N(n337), .A1N(score_p1[8]), .B0(score_p0[8]), .Y(n336)
         );
  NAND2XL U401 ( .A(n343), .B(n428), .Y(n344) );
  CLKINVX1 U402 ( .A(n395), .Y(n339) );
  NOR2X1 U403 ( .A(n339), .B(n338), .Y(n340) );
  NOR2BX1 U404 ( .AN(n341), .B(n340), .Y(n342) );
  NAND2X2 U405 ( .A(n351), .B(score_p1[5]), .Y(n361) );
  OAI21X2 U406 ( .A0(score_p1[5]), .A1(n351), .B0(n391), .Y(n363) );
  NOR3X2 U407 ( .A(n406), .B(state[1]), .C(n405), .Y(n398) );
  INVX1 U408 ( .A(n360), .Y(n364) );
  NOR2XL U409 ( .A(score_p1[6]), .B(state[1]), .Y(n362) );
  OAI211XL U410 ( .A0(n364), .A1(n363), .B0(n362), .C0(n361), .Y(n366) );
  OAI22X1 U411 ( .A0(n409), .A1(n366), .B0(n365), .B1(n441), .Y(n134) );
  OAI21X1 U412 ( .A0(n367), .A1(n377), .B0(score_p0[8]), .Y(n368) );
  OAI21X1 U413 ( .A0(n369), .A1(n377), .B0(score_p0[6]), .Y(n374) );
  NAND2X1 U414 ( .A(n373), .B(n374), .Y(n121) );
  NAND2X1 U415 ( .A(points[0]), .B(n153), .Y(n379) );
  OAI211XL U416 ( .A0(n377), .A1(n338), .B0(n428), .C0(n376), .Y(n127) );
  CLKINVX1 U417 ( .A(n378), .Y(n400) );
  OAI31X1 U418 ( .A0(n406), .A1(n405), .A2(n379), .B0(score_p1[0]), .Y(n380)
         );
  OAI211XL U419 ( .A0(n400), .A1(n409), .B0(n380), .C0(n428), .Y(n128) );
  CLKINVX1 U420 ( .A(n402), .Y(n382) );
  XNOR2X1 U421 ( .A(n382), .B(n381), .Y(n383) );
  NAND2X1 U422 ( .A(n384), .B(n428), .Y(n125) );
  XOR2X1 U423 ( .A(n282), .B(n170), .Y(n386) );
  NAND2X1 U424 ( .A(n391), .B(n390), .Y(n392) );
  XOR2X1 U425 ( .A(n392), .B(n393), .Y(n394) );
  AO22X2 U426 ( .A0(n398), .A1(n394), .B0(score_p1[4]), .B1(n409), .Y(n132) );
  NAND2X1 U427 ( .A(n395), .B(n427), .Y(n399) );
  NOR2X1 U428 ( .A(n395), .B(n427), .Y(n401) );
  NOR2BX1 U429 ( .AN(n399), .B(n401), .Y(n396) );
  XOR2X1 U430 ( .A(n396), .B(n400), .Y(n397) );
  AO22X2 U431 ( .A0(n398), .A1(n397), .B0(score_p1[1]), .B1(n409), .Y(n129) );
  XOR2X1 U432 ( .A(n403), .B(n402), .Y(n404) );
  NOR3X2 U433 ( .A(n406), .B(n405), .C(n404), .Y(n407) );
  NAND3BX1 U434 ( .AN(state[0]), .B(in_valid), .C(n428), .Y(n415) );
  OAI21XL U435 ( .A0(n412), .A1(n418), .B0(n415), .Y(n142) );
  NAND2XL U436 ( .A(in_valid), .B(n428), .Y(n417) );
  NAND2XL U437 ( .A(n414), .B(n413), .Y(n416) );
  OAI221XL U438 ( .A0(dart_count[0]), .A1(n417), .B0(n444), .B1(n416), .C0(
        n415), .Y(n140) );
  AOI31XL U439 ( .A0(in_valid), .A1(dart_count[1]), .A2(dart_count[0]), .B0(
        n418), .Y(n419) );
  AO22X1 U440 ( .A0(n421), .A1(n420), .B0(dart_count[2]), .B1(n419), .Y(n138)
         );
endmodule

