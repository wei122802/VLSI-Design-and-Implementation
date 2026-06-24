//############################################################################
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//   (C) Copyright ISIP Lab. 2026
//   All Right Reserved
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   VLSI LAB 2026 Spring
//   Lab01 Exercise	: FIFO
//   Author     		: ISIP LAB
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
`ifdef RTL
  `include "FIFO.v"
`endif
`ifdef GATE
  `include "FIFO_SYN.v"
`endif
 
module TESTBED;
  
parameter DATA_WIDTH  = 16;
parameter FIFO_DEPTH  = 32;

// reg and wire declaration
wire                  clk;
wire                  rst_n;
wire                  w_en;
wire [15:0]           w_data;
wire                  r_en;

wire [15:0]           r_data;
wire                  full;
wire                  empty;

initial begin
  `ifdef RTL
    $fsdbDumpfile("FIFO.fsdb");
	  $fsdbDumpvars(0,"+mda");
    $fsdbDumpvars();
  `endif
  `ifdef GATE
    $sdf_annotate("FIFO_SYN.sdf", u_FIFO);
    $fsdbDumpfile("FIFO_SYN.fsdb");
	  $fsdbDumpvars(0,"+mda");
    $fsdbDumpvars();
  `endif
end

FIFO #(
  .DATA_WIDTH(DATA_WIDTH),
  .FIFO_DEPTH(FIFO_DEPTH)
)  u_FIFO(
    .clk   (clk),
    .rst_n (rst_n),
    .w_en  (w_en),
    .w_data(w_data),
    .r_en  (r_en),
    .r_data(r_data),
    .full  (full),
    .empty (empty)
);

PATTERN #(
  .DATA_WIDTH(DATA_WIDTH),
  .FIFO_DEPTH(FIFO_DEPTH)
) u_PATTERN(
    .clk   (clk),
    .rst_n (rst_n),
    .w_en  (w_en),
    .w_data(w_data),
    .r_en  (r_en),
    .r_data(r_data),
    .full  (full),
    .empty (empty)
);
 
endmodule
