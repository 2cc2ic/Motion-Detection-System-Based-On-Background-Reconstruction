//*****************************************************************************
//  (c) Copyright 2013 Xilinx, Inc. All rights reserved.
//
//  This file contains confidential and proprietary information
//  of Xilinx, Inc. and is protected under U.S. and
//  international copyright and other intellectual property
//  laws.
//
//  DISCLAIMER
//  This disclaimer is not a license and does not grant any
//  rights to the materials distributed herewith. Except as
//  otherwise provided in a valid license issued to you by
//  Xilinx, and to the maximum extent permitted by applicable
//  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
//  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
//  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
//  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
//  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
//  (2) Xilinx shall not be liable (whether in contract or tort,
//  including negligence, or under any other theory of
//  liability) for any loss or damage of any kind or nature
//  related to, arising under or in connection with these
//  materials, including for any direct, or any indirect,
//  special, incidental, or consequential loss or damage
//  (including loss of data, profits, goodwill, or any type of
//  loss or damage suffered as a result of any action brought
//  by a third party) even if such damage or loss was
//  reasonably foreseeable or Xilinx had been advised of the
//  possibility of the same.
//
//  CRITICAL APPLICATIONS
//  Xilinx products are not designed or intended to be fail-
//  safe, or for use in any application requiring fail-safe
//  performance, such as life-support or safety devices or
//  systems, Class III medical devices, nuclear facilities,
//  applications related to the deployment of airbags, or any
//  other applications that could lead to death, personal
//  injury, or severe property or environmental damage
//  (individually and collectively, "Critical
//  Applications"). Customer assumes the sole risk and
//  liability of any use of Xilinx products in Critical
//  Applications, subject only to applicable laws and
//  regulations governing limitations on product liability.
//
//  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
//  PART OF THIS FILE AT ALL TIMES. 
//
//*****************************************************************************
// Description
//   This module instantiates the clock synchronization logic.  It passes the 
//   incoming signal through two flops to ensure metastability. 
//              
//*****************************************************************************
`timescale 1ps / 1ps
`default_nettype none

(* DowngradeIPIdentifiedWarnings="yes" *)
module axis_infrastructure_v1_1_0_clock_synchronizer # (
///////////////////////////////////////////////////////////////////////////////
// Parameter Definitions
///////////////////////////////////////////////////////////////////////////////
  parameter integer C_NUM_STAGES              = 4
)     
(
///////////////////////////////////////////////////////////////////////////////
// Port Declarations     
///////////////////////////////////////////////////////////////////////////////
  input  wire                               clk,
  input  wire                               synch_in ,
  output wire                               synch_out
);

////////////////////////////////////////////////////////////////////////////////
// Local Parameters           
////////////////////////////////////////////////////////////////////////////////
localparam integer P_SYNCH_D_WIDTH = (C_NUM_STAGES > 0) ? C_NUM_STAGES : 1;
////////////////////////////////////////////////////////////////////////////////
// Wires/Reg declarations
////////////////////////////////////////////////////////////////////////////////
(* ASYNC_REG = "TRUE" *) reg [P_SYNCH_D_WIDTH-1:0] synch_d = 'b0;

  generate 
  if (C_NUM_STAGES > 0) begin : gen_synchronizer
    genvar i;

    always @(posedge clk) begin
      synch_d[0] <= synch_in;
    end

    for (i = 1; i < C_NUM_STAGES ; i = i + 1) begin : gen_stage
      always @(posedge clk) begin
        synch_d[i] <= synch_d[i-1];
      end
    end

    assign synch_out = synch_d[C_NUM_STAGES-1];
  end
  else begin : gen_no_synchronizer
    assign synch_out = synch_in;
  end
  endgenerate

endmodule

`default_nettype wire
