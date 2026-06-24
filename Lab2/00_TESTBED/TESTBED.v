//############################################################################
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//   (C) Copyright ISIP Lab. 2026
//   All Right Reserved
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   VLSI LAB 2026 Spring
//   Lab01 Exercise		: DART
//   Author     		: ISIP LAB
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   File Name   : TESTBED.v
//   Module Name : TESTBED
//   Release version : V1.0 (Release Date: 2026-03)
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//############################################################################

`timescale 1ns/10ps
`include "PATTERN.v"
`ifdef RTL
  `include "DART.v"
`endif
`ifdef GATE
  `include "DART_SYN.v"
`endif
 
module TESTBED;

// reg and wire declaration
wire clk, rst_n, in_valid;
wire player, is_double, is_triple;
wire [4:0] points;
wire out_valid, out_winner;

initial begin
  `ifdef RTL
    $fsdbDumpfile("DART.fsdb");
	  $fsdbDumpvars(0,"+mda");
    $fsdbDumpvars();
  `endif
  `ifdef GATE
    $sdf_annotate("DART_SYN.sdf", u_DART);
    // $fsdbDumpfile("DART_SYN.fsdb");
	  // $fsdbDumpvars(0,"+mda");
    // $fsdbDumpvars();    
  `endif
end

DART u_DART(
    .clk(clk),
    .rst_n(rst_n),
    .in_valid(in_valid),
    .player(player),
    .is_double(is_double),
    .is_triple(is_triple),
    .points(points),
    .out_valid(out_valid),
    .out_winner(out_winner)
);

PATTERN u_PATTERN(
    .clk(clk),
    .rst_n(rst_n),
    .in_valid(in_valid),
    .player(player),
    .is_double(is_double),
    .is_triple(is_triple),
    .points(points),
    .out_valid(out_valid),
    .out_winner(out_winner)
);
 
endmodule
