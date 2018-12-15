// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Mon Oct 29 00:15:54 2018
// Host        : hubbery running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top line_shift_register -prefix
//               line_shift_register_ c_shift_ram_0_stub.v
// Design      : c_shift_ram_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "c_shift_ram_v12_0_11,Vivado 2017.4" *)
module line_shift_register(D, CLK, CE, Q)
/* synthesis syn_black_box black_box_pad_pin="D[7:0],CLK,CE,Q[7:0]" */;
  input [7:0]D;
  input CLK;
  input CE;
  output [7:0]Q;
endmodule
