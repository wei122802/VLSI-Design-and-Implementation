//############################################################################
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//   (C) Copyright ISIP Lab. 2026
//   All Right Reserved
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   VLSI LAB 2026 Spring
//   Lab05 Exercise : AMED (Adjugate Matrix with Error Detection)
//   Author         : ISIP LAB
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   File Name   : TESTBED.v
//   Module Name : TESTBED
//   Release version : V1.0 (Release Date: 2026-05)
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//############################################################################

`timescale 1ns/10ps
`include "PATTERN.v"
`include "MULT_err_SIM.vp"
`ifdef RTL
    `include "AMED.v"
`endif
`ifdef GATE
    `include "AMED_SYN.v"
`endif

module TESTBED;

// reg and wire declaration
wire clk, rst_n, in_valid;
wire [71:0] in_data;
wire out_valid;
wire [215:0] out_data;

initial begin
  `ifdef RTL
    $fsdbDumpfile("AMED.fsdb");
    $fsdbDumpvars(0,"+mda");
    $fsdbDumpvars();
  `endif
  `ifdef GATE
    $sdf_annotate("AMED_SYN.sdf", u_AMED);
    // $fsdbDumpfile("AMED_SYN.fsdb");
    // $fsdbDumpvars(0,"+mda");
    // $fsdbDumpvars();
  `endif
end

AMED u_AMED(
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