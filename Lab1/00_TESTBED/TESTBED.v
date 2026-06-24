//############################################################################
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//   (C) Copyright ISIP Lab. 2026
//   All Right Reserved
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   VLSI LAB 2026 Spring
//   Lab01 Exercise		: MATRIX_MULT
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
  `include "MATRIX_MULT.v"
`endif
`ifdef GATE
  `include "MATRIX_MULT_SYN.v"
`endif
 
module TESTBED;

// reg and wire declaration
wire clk, rst_n, in_valid;
wire [63:0] in_data;
wire out_valid;
wire [19:0] out_data;

initial begin
  `ifdef RTL
    $fsdbDumpfile("MATRIX_MULT.fsdb");
	  $fsdbDumpvars(0,"+mda");
    $fsdbDumpvars();
  `endif
  `ifdef GATE
    $sdf_annotate("MATRIX_MULT_SYN.sdf", u_MATRIX_MULT);
    // $fsdbDumpfile("MATRIX_MULT_SYN.fsdb");
	  // $fsdbDumpvars(0,"+mda");
    // $fsdbDumpvars();
  `endif
end

MATRIX_MULT u_MATRIX_MULT(
    .clk(clk),
    .rst_n(rst_n),
    .in_valid(in_valid),
    .in_data(in_data),
    .out_valid(out_valid),
    .out_data(out_data)
);

PATTERN u_PATTERN(
    .clk(clk),
    .rst_n(rst_n),
    .in_valid(in_valid),
    .in_data(in_data),
    .out_valid(out_valid),
    .out_data(out_data)
);
 
endmodule
