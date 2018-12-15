// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Tue Nov 20 20:51:50 2018
// Host        : hubbery running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               D:/prj/pynq/zynq_prj/zynq_prj.srcs/sources_1/bd/system/ip/system_HDMI_FPGA_ML_0_0/system_HDMI_FPGA_ML_0_0_sim_netlist.v
// Design      : system_HDMI_FPGA_ML_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "system_HDMI_FPGA_ML_0_0,HDMI_FPGA_ML,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "HDMI_FPGA_ML,Vivado 2017.4" *) 
(* NotValidForBitStream *)
module system_HDMI_FPGA_ML_0_0
   (PXLCLK_I,
    PXLCLK_5X_I,
    LOCKED_I,
    RST_N,
    VGA_HS,
    VGA_VS,
    VGA_DE,
    VGA_RGB,
    HDMI_CLK_P,
    HDMI_CLK_N,
    HDMI_D2_P,
    HDMI_D2_N,
    HDMI_D1_P,
    HDMI_D1_N,
    HDMI_D0_P,
    HDMI_D0_N);
  input PXLCLK_I;
  input PXLCLK_5X_I;
  input LOCKED_I;
  input RST_N;
  input VGA_HS;
  input VGA_VS;
  input VGA_DE;
  input [23:0]VGA_RGB;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 HDMI_CLK_P CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME HDMI_CLK_P, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN system_HDMI_FPGA_ML_0_0_HDMI_CLK_P" *) output HDMI_CLK_P;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 HDMI_CLK_N CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME HDMI_CLK_N, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN system_HDMI_FPGA_ML_0_0_HDMI_CLK_N" *) output HDMI_CLK_N;
  output HDMI_D2_P;
  output HDMI_D2_N;
  output HDMI_D1_P;
  output HDMI_D1_N;
  output HDMI_D0_P;
  output HDMI_D0_N;

  (* SLEW = "SLOW" *) wire HDMI_CLK_N;
  (* SLEW = "SLOW" *) wire HDMI_CLK_P;
  (* SLEW = "SLOW" *) wire HDMI_D0_N;
  (* SLEW = "SLOW" *) wire HDMI_D0_P;
  (* SLEW = "SLOW" *) wire HDMI_D1_N;
  (* SLEW = "SLOW" *) wire HDMI_D1_P;
  (* SLEW = "SLOW" *) wire HDMI_D2_N;
  (* SLEW = "SLOW" *) wire HDMI_D2_P;
  wire LOCKED_I;
  wire PXLCLK_5X_I;
  wire PXLCLK_I;
  wire RST_N;
  wire VGA_DE;
  wire VGA_HS;
  wire [23:0]VGA_RGB;
  wire VGA_VS;

  system_HDMI_FPGA_ML_0_0_HDMI_FPGA_ML U0
       (.HDMI_CLK_N(HDMI_CLK_N),
        .HDMI_CLK_P(HDMI_CLK_P),
        .HDMI_D0_N(HDMI_D0_N),
        .HDMI_D0_P(HDMI_D0_P),
        .HDMI_D1_N(HDMI_D1_N),
        .HDMI_D1_P(HDMI_D1_P),
        .HDMI_D2_N(HDMI_D2_N),
        .HDMI_D2_P(HDMI_D2_P),
        .LOCKED_I(LOCKED_I),
        .PXLCLK_5X_I(PXLCLK_5X_I),
        .PXLCLK_I(PXLCLK_I),
        .RST_N(RST_N),
        .VGA_DE(VGA_DE),
        .VGA_HS(VGA_HS),
        .VGA_RGB(VGA_RGB),
        .VGA_VS(VGA_VS));
endmodule

(* ORIG_REF_NAME = "DVITransmitter" *) 
module system_HDMI_FPGA_ML_0_0_DVITransmitter
   (HDMI_CLK_P,
    HDMI_CLK_N,
    HDMI_D2_P,
    HDMI_D2_N,
    HDMI_D1_P,
    HDMI_D1_N,
    HDMI_D0_P,
    HDMI_D0_N,
    PXLCLK_5X_I,
    PXLCLK_I,
    VGA_DE,
    VGA_RGB,
    VGA_HS,
    VGA_VS,
    RST_N,
    LOCKED_I);
  output HDMI_CLK_P;
  output HDMI_CLK_N;
  output HDMI_D2_P;
  output HDMI_D2_N;
  output HDMI_D1_P;
  output HDMI_D1_N;
  output HDMI_D0_P;
  output HDMI_D0_N;
  input PXLCLK_5X_I;
  input PXLCLK_I;
  input VGA_DE;
  input [23:0]VGA_RGB;
  input VGA_HS;
  input VGA_VS;
  input RST_N;
  input LOCKED_I;

  wire HDMI_CLK_N;
  wire HDMI_CLK_P;
  wire HDMI_D0_N;
  wire HDMI_D0_P;
  wire HDMI_D1_N;
  wire HDMI_D1_P;
  wire HDMI_D2_N;
  wire HDMI_D2_P;
  wire LOCKED_I;
  wire PXLCLK_5X_I;
  wire PXLCLK_I;
  wire RST;
  wire RST_N;
  wire VGA_DE;
  wire VGA_HS;
  wire [23:0]VGA_RGB;
  wire VGA_VS;
  wire de_dd;
  wire [9:0]intTmdsBlue;
  wire [9:0]intTmdsGreen;
  wire [9:0]intTmdsRed;
  wire p_1_in;

  system_HDMI_FPGA_ML_0_0_TMDSEncoder Inst_TMDSEncoder_blue
       (.PXLCLK_I(PXLCLK_I),
        .Q(intTmdsBlue),
        .SR(p_1_in),
        .VGA_HS(VGA_HS),
        .VGA_RGB(VGA_RGB[7:0]),
        .VGA_VS(VGA_VS),
        .de_dd(de_dd));
  system_HDMI_FPGA_ML_0_0_TMDSEncoder_0 Inst_TMDSEncoder_green
       (.PXLCLK_I(PXLCLK_I),
        .Q(intTmdsGreen),
        .SR(p_1_in),
        .VGA_RGB(VGA_RGB[15:8]));
  system_HDMI_FPGA_ML_0_0_TMDSEncoder_1 Inst_TMDSEncoder_red
       (.PXLCLK_I(PXLCLK_I),
        .Q(intTmdsRed),
        .SR(p_1_in),
        .VGA_DE(VGA_DE),
        .VGA_RGB(VGA_RGB[23:16]),
        .de_dd(de_dd));
  system_HDMI_FPGA_ML_0_0_SerializerN_1 Inst_clk_serializer_10_1
       (.HDMI_CLK_N(HDMI_CLK_N),
        .HDMI_CLK_P(HDMI_CLK_P),
        .LOCKED_I(LOCKED_I),
        .PXLCLK_5X_I(PXLCLK_5X_I),
        .PXLCLK_I(PXLCLK_I),
        .RST(RST),
        .RST_N(RST_N));
  system_HDMI_FPGA_ML_0_0_SerializerN_1_2 Inst_d0_serializer_10_1
       (.HDMI_D0_N(HDMI_D0_N),
        .HDMI_D0_P(HDMI_D0_P),
        .PXLCLK_5X_I(PXLCLK_5X_I),
        .PXLCLK_I(PXLCLK_I),
        .Q(intTmdsBlue),
        .RST(RST));
  system_HDMI_FPGA_ML_0_0_SerializerN_1_3 Inst_d1_serializer_10_1
       (.HDMI_D1_N(HDMI_D1_N),
        .HDMI_D1_P(HDMI_D1_P),
        .PXLCLK_5X_I(PXLCLK_5X_I),
        .PXLCLK_I(PXLCLK_I),
        .Q(intTmdsGreen),
        .RST(RST));
  system_HDMI_FPGA_ML_0_0_SerializerN_1_4 Inst_d2_serializer_10_1
       (.HDMI_D2_N(HDMI_D2_N),
        .HDMI_D2_P(HDMI_D2_P),
        .PXLCLK_5X_I(PXLCLK_5X_I),
        .PXLCLK_I(PXLCLK_I),
        .Q(intTmdsRed),
        .RST(RST));
endmodule

(* ORIG_REF_NAME = "HDMI_FPGA_ML" *) 
module system_HDMI_FPGA_ML_0_0_HDMI_FPGA_ML
   (HDMI_CLK_P,
    HDMI_CLK_N,
    HDMI_D2_P,
    HDMI_D2_N,
    HDMI_D1_P,
    HDMI_D1_N,
    HDMI_D0_P,
    HDMI_D0_N,
    PXLCLK_5X_I,
    PXLCLK_I,
    VGA_DE,
    VGA_RGB,
    VGA_HS,
    VGA_VS,
    RST_N,
    LOCKED_I);
  output HDMI_CLK_P;
  output HDMI_CLK_N;
  output HDMI_D2_P;
  output HDMI_D2_N;
  output HDMI_D1_P;
  output HDMI_D1_N;
  output HDMI_D0_P;
  output HDMI_D0_N;
  input PXLCLK_5X_I;
  input PXLCLK_I;
  input VGA_DE;
  input [23:0]VGA_RGB;
  input VGA_HS;
  input VGA_VS;
  input RST_N;
  input LOCKED_I;

  wire HDMI_CLK_N;
  wire HDMI_CLK_P;
  wire HDMI_D0_N;
  wire HDMI_D0_P;
  wire HDMI_D1_N;
  wire HDMI_D1_P;
  wire HDMI_D2_N;
  wire HDMI_D2_P;
  wire LOCKED_I;
  wire PXLCLK_5X_I;
  wire PXLCLK_I;
  wire RST_N;
  wire VGA_DE;
  wire VGA_HS;
  wire [23:0]VGA_RGB;
  wire VGA_VS;

  system_HDMI_FPGA_ML_0_0_DVITransmitter Inst_DVITransmitter
       (.HDMI_CLK_N(HDMI_CLK_N),
        .HDMI_CLK_P(HDMI_CLK_P),
        .HDMI_D0_N(HDMI_D0_N),
        .HDMI_D0_P(HDMI_D0_P),
        .HDMI_D1_N(HDMI_D1_N),
        .HDMI_D1_P(HDMI_D1_P),
        .HDMI_D2_N(HDMI_D2_N),
        .HDMI_D2_P(HDMI_D2_P),
        .LOCKED_I(LOCKED_I),
        .PXLCLK_5X_I(PXLCLK_5X_I),
        .PXLCLK_I(PXLCLK_I),
        .RST_N(RST_N),
        .VGA_DE(VGA_DE),
        .VGA_HS(VGA_HS),
        .VGA_RGB(VGA_RGB),
        .VGA_VS(VGA_VS));
endmodule

(* ORIG_REF_NAME = "SerializerN_1" *) 
module system_HDMI_FPGA_ML_0_0_SerializerN_1
   (HDMI_CLK_P,
    HDMI_CLK_N,
    RST,
    PXLCLK_5X_I,
    PXLCLK_I,
    RST_N,
    LOCKED_I);
  output HDMI_CLK_P;
  output HDMI_CLK_N;
  output RST;
  input PXLCLK_5X_I;
  input PXLCLK_I;
  input RST_N;
  input LOCKED_I;

  wire HDMI_CLK_N;
  wire HDMI_CLK_P;
  wire I;
  wire LOCKED_I;
  wire PXLCLK_5X_I;
  wire PXLCLK_I;
  wire RST;
  wire RST_I;
  wire RST_N;
  wire SHIFTIN1;
  wire SHIFTIN2;
  wire \NLW_family_7.oserdese2_master_OFB_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_master_SHIFTOUT1_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_master_SHIFTOUT2_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_master_TBYTEOUT_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_master_TFB_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_master_TQ_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_slave_OFB_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_slave_OQ_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_slave_TBYTEOUT_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_slave_TFB_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_slave_TQ_UNCONNECTED ;

  LUT2 #(
    .INIT(4'h7)) 
    \family_7.int_rst_i_1 
       (.I0(RST_N),
        .I1(LOCKED_I),
        .O(RST_I));
  FDPE \family_7.int_rst_reg 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(1'b0),
        .PRE(RST_I),
        .Q(RST));
  (* box_type = "PRIMITIVE" *) 
  OSERDESE2 #(
    .DATA_RATE_OQ("DDR"),
    .DATA_RATE_TQ("SDR"),
    .DATA_WIDTH(10),
    .INIT_OQ(1'b0),
    .INIT_TQ(1'b0),
    .IS_CLKDIV_INVERTED(1'b0),
    .IS_CLK_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .IS_D3_INVERTED(1'b0),
    .IS_D4_INVERTED(1'b0),
    .IS_D5_INVERTED(1'b0),
    .IS_D6_INVERTED(1'b0),
    .IS_D7_INVERTED(1'b0),
    .IS_D8_INVERTED(1'b0),
    .IS_T1_INVERTED(1'b0),
    .IS_T2_INVERTED(1'b0),
    .IS_T3_INVERTED(1'b0),
    .IS_T4_INVERTED(1'b0),
    .SERDES_MODE("MASTER"),
    .SRVAL_OQ(1'b0),
    .SRVAL_TQ(1'b0),
    .TBYTE_CTL("FALSE"),
    .TBYTE_SRC("FALSE"),
    .TRISTATE_WIDTH(1)) 
    \family_7.oserdese2_master 
       (.CLK(PXLCLK_5X_I),
        .CLKDIV(PXLCLK_I),
        .D1(1'b0),
        .D2(1'b0),
        .D3(1'b0),
        .D4(1'b0),
        .D5(1'b0),
        .D6(1'b1),
        .D7(1'b1),
        .D8(1'b1),
        .OCE(1'b1),
        .OFB(\NLW_family_7.oserdese2_master_OFB_UNCONNECTED ),
        .OQ(I),
        .RST(RST),
        .SHIFTIN1(SHIFTIN1),
        .SHIFTIN2(SHIFTIN2),
        .SHIFTOUT1(\NLW_family_7.oserdese2_master_SHIFTOUT1_UNCONNECTED ),
        .SHIFTOUT2(\NLW_family_7.oserdese2_master_SHIFTOUT2_UNCONNECTED ),
        .T1(1'b0),
        .T2(1'b0),
        .T3(1'b0),
        .T4(1'b0),
        .TBYTEIN(1'b0),
        .TBYTEOUT(\NLW_family_7.oserdese2_master_TBYTEOUT_UNCONNECTED ),
        .TCE(1'b0),
        .TFB(\NLW_family_7.oserdese2_master_TFB_UNCONNECTED ),
        .TQ(\NLW_family_7.oserdese2_master_TQ_UNCONNECTED ));
  (* box_type = "PRIMITIVE" *) 
  OSERDESE2 #(
    .DATA_RATE_OQ("DDR"),
    .DATA_RATE_TQ("SDR"),
    .DATA_WIDTH(10),
    .INIT_OQ(1'b0),
    .INIT_TQ(1'b0),
    .IS_CLKDIV_INVERTED(1'b0),
    .IS_CLK_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .IS_D3_INVERTED(1'b0),
    .IS_D4_INVERTED(1'b0),
    .IS_D5_INVERTED(1'b0),
    .IS_D6_INVERTED(1'b0),
    .IS_D7_INVERTED(1'b0),
    .IS_D8_INVERTED(1'b0),
    .IS_T1_INVERTED(1'b0),
    .IS_T2_INVERTED(1'b0),
    .IS_T3_INVERTED(1'b0),
    .IS_T4_INVERTED(1'b0),
    .SERDES_MODE("SLAVE"),
    .SRVAL_OQ(1'b0),
    .SRVAL_TQ(1'b0),
    .TBYTE_CTL("FALSE"),
    .TBYTE_SRC("FALSE"),
    .TRISTATE_WIDTH(1)) 
    \family_7.oserdese2_slave 
       (.CLK(PXLCLK_5X_I),
        .CLKDIV(PXLCLK_I),
        .D1(1'b0),
        .D2(1'b0),
        .D3(1'b1),
        .D4(1'b1),
        .D5(1'b0),
        .D6(1'b0),
        .D7(1'b0),
        .D8(1'b0),
        .OCE(1'b1),
        .OFB(\NLW_family_7.oserdese2_slave_OFB_UNCONNECTED ),
        .OQ(\NLW_family_7.oserdese2_slave_OQ_UNCONNECTED ),
        .RST(RST),
        .SHIFTIN1(1'b0),
        .SHIFTIN2(1'b0),
        .SHIFTOUT1(SHIFTIN1),
        .SHIFTOUT2(SHIFTIN2),
        .T1(1'b0),
        .T2(1'b0),
        .T3(1'b0),
        .T4(1'b0),
        .TBYTEIN(1'b0),
        .TBYTEOUT(\NLW_family_7.oserdese2_slave_TBYTEOUT_UNCONNECTED ),
        .TCE(1'b0),
        .TFB(\NLW_family_7.oserdese2_slave_TFB_UNCONNECTED ),
        .TQ(\NLW_family_7.oserdese2_slave_TQ_UNCONNECTED ));
  (* CAPACITANCE = "DONT_CARE" *) 
  (* XILINX_LEGACY_PRIM = "OBUFDS" *) 
  (* box_type = "PRIMITIVE" *) 
  OBUFDS #(
    .IOSTANDARD("DEFAULT")) 
    io_datax_out
       (.I(I),
        .O(HDMI_CLK_P),
        .OB(HDMI_CLK_N));
endmodule

(* ORIG_REF_NAME = "SerializerN_1" *) 
module system_HDMI_FPGA_ML_0_0_SerializerN_1_2
   (HDMI_D0_P,
    HDMI_D0_N,
    PXLCLK_5X_I,
    PXLCLK_I,
    Q,
    RST);
  output HDMI_D0_P;
  output HDMI_D0_N;
  input PXLCLK_5X_I;
  input PXLCLK_I;
  input [9:0]Q;
  input RST;

  wire HDMI_D0_N;
  wire HDMI_D0_P;
  wire I;
  wire PXLCLK_5X_I;
  wire PXLCLK_I;
  wire [9:0]Q;
  wire RST;
  wire SHIFTIN1;
  wire SHIFTIN2;
  wire \NLW_family_7.oserdese2_master_OFB_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_master_SHIFTOUT1_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_master_SHIFTOUT2_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_master_TBYTEOUT_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_master_TFB_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_master_TQ_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_slave_OFB_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_slave_OQ_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_slave_TBYTEOUT_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_slave_TFB_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_slave_TQ_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  OSERDESE2 #(
    .DATA_RATE_OQ("DDR"),
    .DATA_RATE_TQ("SDR"),
    .DATA_WIDTH(10),
    .INIT_OQ(1'b0),
    .INIT_TQ(1'b0),
    .IS_CLKDIV_INVERTED(1'b0),
    .IS_CLK_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .IS_D3_INVERTED(1'b0),
    .IS_D4_INVERTED(1'b0),
    .IS_D5_INVERTED(1'b0),
    .IS_D6_INVERTED(1'b0),
    .IS_D7_INVERTED(1'b0),
    .IS_D8_INVERTED(1'b0),
    .IS_T1_INVERTED(1'b0),
    .IS_T2_INVERTED(1'b0),
    .IS_T3_INVERTED(1'b0),
    .IS_T4_INVERTED(1'b0),
    .SERDES_MODE("MASTER"),
    .SRVAL_OQ(1'b0),
    .SRVAL_TQ(1'b0),
    .TBYTE_CTL("FALSE"),
    .TBYTE_SRC("FALSE"),
    .TRISTATE_WIDTH(1)) 
    \family_7.oserdese2_master 
       (.CLK(PXLCLK_5X_I),
        .CLKDIV(PXLCLK_I),
        .D1(Q[0]),
        .D2(Q[1]),
        .D3(Q[2]),
        .D4(Q[3]),
        .D5(Q[4]),
        .D6(Q[5]),
        .D7(Q[6]),
        .D8(Q[7]),
        .OCE(1'b1),
        .OFB(\NLW_family_7.oserdese2_master_OFB_UNCONNECTED ),
        .OQ(I),
        .RST(RST),
        .SHIFTIN1(SHIFTIN1),
        .SHIFTIN2(SHIFTIN2),
        .SHIFTOUT1(\NLW_family_7.oserdese2_master_SHIFTOUT1_UNCONNECTED ),
        .SHIFTOUT2(\NLW_family_7.oserdese2_master_SHIFTOUT2_UNCONNECTED ),
        .T1(1'b0),
        .T2(1'b0),
        .T3(1'b0),
        .T4(1'b0),
        .TBYTEIN(1'b0),
        .TBYTEOUT(\NLW_family_7.oserdese2_master_TBYTEOUT_UNCONNECTED ),
        .TCE(1'b0),
        .TFB(\NLW_family_7.oserdese2_master_TFB_UNCONNECTED ),
        .TQ(\NLW_family_7.oserdese2_master_TQ_UNCONNECTED ));
  (* box_type = "PRIMITIVE" *) 
  OSERDESE2 #(
    .DATA_RATE_OQ("DDR"),
    .DATA_RATE_TQ("SDR"),
    .DATA_WIDTH(10),
    .INIT_OQ(1'b0),
    .INIT_TQ(1'b0),
    .IS_CLKDIV_INVERTED(1'b0),
    .IS_CLK_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .IS_D3_INVERTED(1'b0),
    .IS_D4_INVERTED(1'b0),
    .IS_D5_INVERTED(1'b0),
    .IS_D6_INVERTED(1'b0),
    .IS_D7_INVERTED(1'b0),
    .IS_D8_INVERTED(1'b0),
    .IS_T1_INVERTED(1'b0),
    .IS_T2_INVERTED(1'b0),
    .IS_T3_INVERTED(1'b0),
    .IS_T4_INVERTED(1'b0),
    .SERDES_MODE("SLAVE"),
    .SRVAL_OQ(1'b0),
    .SRVAL_TQ(1'b0),
    .TBYTE_CTL("FALSE"),
    .TBYTE_SRC("FALSE"),
    .TRISTATE_WIDTH(1)) 
    \family_7.oserdese2_slave 
       (.CLK(PXLCLK_5X_I),
        .CLKDIV(PXLCLK_I),
        .D1(1'b0),
        .D2(1'b0),
        .D3(Q[8]),
        .D4(Q[9]),
        .D5(1'b0),
        .D6(1'b0),
        .D7(1'b0),
        .D8(1'b0),
        .OCE(1'b1),
        .OFB(\NLW_family_7.oserdese2_slave_OFB_UNCONNECTED ),
        .OQ(\NLW_family_7.oserdese2_slave_OQ_UNCONNECTED ),
        .RST(RST),
        .SHIFTIN1(1'b0),
        .SHIFTIN2(1'b0),
        .SHIFTOUT1(SHIFTIN1),
        .SHIFTOUT2(SHIFTIN2),
        .T1(1'b0),
        .T2(1'b0),
        .T3(1'b0),
        .T4(1'b0),
        .TBYTEIN(1'b0),
        .TBYTEOUT(\NLW_family_7.oserdese2_slave_TBYTEOUT_UNCONNECTED ),
        .TCE(1'b0),
        .TFB(\NLW_family_7.oserdese2_slave_TFB_UNCONNECTED ),
        .TQ(\NLW_family_7.oserdese2_slave_TQ_UNCONNECTED ));
  (* CAPACITANCE = "DONT_CARE" *) 
  (* XILINX_LEGACY_PRIM = "OBUFDS" *) 
  (* box_type = "PRIMITIVE" *) 
  OBUFDS #(
    .IOSTANDARD("DEFAULT")) 
    io_datax_out
       (.I(I),
        .O(HDMI_D0_P),
        .OB(HDMI_D0_N));
endmodule

(* ORIG_REF_NAME = "SerializerN_1" *) 
module system_HDMI_FPGA_ML_0_0_SerializerN_1_3
   (HDMI_D1_P,
    HDMI_D1_N,
    PXLCLK_5X_I,
    PXLCLK_I,
    Q,
    RST);
  output HDMI_D1_P;
  output HDMI_D1_N;
  input PXLCLK_5X_I;
  input PXLCLK_I;
  input [9:0]Q;
  input RST;

  wire HDMI_D1_N;
  wire HDMI_D1_P;
  wire I;
  wire PXLCLK_5X_I;
  wire PXLCLK_I;
  wire [9:0]Q;
  wire RST;
  wire SHIFTIN1;
  wire SHIFTIN2;
  wire \NLW_family_7.oserdese2_master_OFB_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_master_SHIFTOUT1_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_master_SHIFTOUT2_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_master_TBYTEOUT_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_master_TFB_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_master_TQ_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_slave_OFB_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_slave_OQ_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_slave_TBYTEOUT_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_slave_TFB_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_slave_TQ_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  OSERDESE2 #(
    .DATA_RATE_OQ("DDR"),
    .DATA_RATE_TQ("SDR"),
    .DATA_WIDTH(10),
    .INIT_OQ(1'b0),
    .INIT_TQ(1'b0),
    .IS_CLKDIV_INVERTED(1'b0),
    .IS_CLK_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .IS_D3_INVERTED(1'b0),
    .IS_D4_INVERTED(1'b0),
    .IS_D5_INVERTED(1'b0),
    .IS_D6_INVERTED(1'b0),
    .IS_D7_INVERTED(1'b0),
    .IS_D8_INVERTED(1'b0),
    .IS_T1_INVERTED(1'b0),
    .IS_T2_INVERTED(1'b0),
    .IS_T3_INVERTED(1'b0),
    .IS_T4_INVERTED(1'b0),
    .SERDES_MODE("MASTER"),
    .SRVAL_OQ(1'b0),
    .SRVAL_TQ(1'b0),
    .TBYTE_CTL("FALSE"),
    .TBYTE_SRC("FALSE"),
    .TRISTATE_WIDTH(1)) 
    \family_7.oserdese2_master 
       (.CLK(PXLCLK_5X_I),
        .CLKDIV(PXLCLK_I),
        .D1(Q[0]),
        .D2(Q[1]),
        .D3(Q[2]),
        .D4(Q[3]),
        .D5(Q[4]),
        .D6(Q[5]),
        .D7(Q[6]),
        .D8(Q[7]),
        .OCE(1'b1),
        .OFB(\NLW_family_7.oserdese2_master_OFB_UNCONNECTED ),
        .OQ(I),
        .RST(RST),
        .SHIFTIN1(SHIFTIN1),
        .SHIFTIN2(SHIFTIN2),
        .SHIFTOUT1(\NLW_family_7.oserdese2_master_SHIFTOUT1_UNCONNECTED ),
        .SHIFTOUT2(\NLW_family_7.oserdese2_master_SHIFTOUT2_UNCONNECTED ),
        .T1(1'b0),
        .T2(1'b0),
        .T3(1'b0),
        .T4(1'b0),
        .TBYTEIN(1'b0),
        .TBYTEOUT(\NLW_family_7.oserdese2_master_TBYTEOUT_UNCONNECTED ),
        .TCE(1'b0),
        .TFB(\NLW_family_7.oserdese2_master_TFB_UNCONNECTED ),
        .TQ(\NLW_family_7.oserdese2_master_TQ_UNCONNECTED ));
  (* box_type = "PRIMITIVE" *) 
  OSERDESE2 #(
    .DATA_RATE_OQ("DDR"),
    .DATA_RATE_TQ("SDR"),
    .DATA_WIDTH(10),
    .INIT_OQ(1'b0),
    .INIT_TQ(1'b0),
    .IS_CLKDIV_INVERTED(1'b0),
    .IS_CLK_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .IS_D3_INVERTED(1'b0),
    .IS_D4_INVERTED(1'b0),
    .IS_D5_INVERTED(1'b0),
    .IS_D6_INVERTED(1'b0),
    .IS_D7_INVERTED(1'b0),
    .IS_D8_INVERTED(1'b0),
    .IS_T1_INVERTED(1'b0),
    .IS_T2_INVERTED(1'b0),
    .IS_T3_INVERTED(1'b0),
    .IS_T4_INVERTED(1'b0),
    .SERDES_MODE("SLAVE"),
    .SRVAL_OQ(1'b0),
    .SRVAL_TQ(1'b0),
    .TBYTE_CTL("FALSE"),
    .TBYTE_SRC("FALSE"),
    .TRISTATE_WIDTH(1)) 
    \family_7.oserdese2_slave 
       (.CLK(PXLCLK_5X_I),
        .CLKDIV(PXLCLK_I),
        .D1(1'b0),
        .D2(1'b0),
        .D3(Q[8]),
        .D4(Q[9]),
        .D5(1'b0),
        .D6(1'b0),
        .D7(1'b0),
        .D8(1'b0),
        .OCE(1'b1),
        .OFB(\NLW_family_7.oserdese2_slave_OFB_UNCONNECTED ),
        .OQ(\NLW_family_7.oserdese2_slave_OQ_UNCONNECTED ),
        .RST(RST),
        .SHIFTIN1(1'b0),
        .SHIFTIN2(1'b0),
        .SHIFTOUT1(SHIFTIN1),
        .SHIFTOUT2(SHIFTIN2),
        .T1(1'b0),
        .T2(1'b0),
        .T3(1'b0),
        .T4(1'b0),
        .TBYTEIN(1'b0),
        .TBYTEOUT(\NLW_family_7.oserdese2_slave_TBYTEOUT_UNCONNECTED ),
        .TCE(1'b0),
        .TFB(\NLW_family_7.oserdese2_slave_TFB_UNCONNECTED ),
        .TQ(\NLW_family_7.oserdese2_slave_TQ_UNCONNECTED ));
  (* CAPACITANCE = "DONT_CARE" *) 
  (* XILINX_LEGACY_PRIM = "OBUFDS" *) 
  (* box_type = "PRIMITIVE" *) 
  OBUFDS #(
    .IOSTANDARD("DEFAULT")) 
    io_datax_out
       (.I(I),
        .O(HDMI_D1_P),
        .OB(HDMI_D1_N));
endmodule

(* ORIG_REF_NAME = "SerializerN_1" *) 
module system_HDMI_FPGA_ML_0_0_SerializerN_1_4
   (HDMI_D2_P,
    HDMI_D2_N,
    PXLCLK_5X_I,
    PXLCLK_I,
    Q,
    RST);
  output HDMI_D2_P;
  output HDMI_D2_N;
  input PXLCLK_5X_I;
  input PXLCLK_I;
  input [9:0]Q;
  input RST;

  wire HDMI_D2_N;
  wire HDMI_D2_P;
  wire I;
  wire PXLCLK_5X_I;
  wire PXLCLK_I;
  wire [9:0]Q;
  wire RST;
  wire SHIFTIN1;
  wire SHIFTIN2;
  wire \NLW_family_7.oserdese2_master_OFB_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_master_SHIFTOUT1_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_master_SHIFTOUT2_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_master_TBYTEOUT_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_master_TFB_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_master_TQ_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_slave_OFB_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_slave_OQ_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_slave_TBYTEOUT_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_slave_TFB_UNCONNECTED ;
  wire \NLW_family_7.oserdese2_slave_TQ_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  OSERDESE2 #(
    .DATA_RATE_OQ("DDR"),
    .DATA_RATE_TQ("SDR"),
    .DATA_WIDTH(10),
    .INIT_OQ(1'b0),
    .INIT_TQ(1'b0),
    .IS_CLKDIV_INVERTED(1'b0),
    .IS_CLK_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .IS_D3_INVERTED(1'b0),
    .IS_D4_INVERTED(1'b0),
    .IS_D5_INVERTED(1'b0),
    .IS_D6_INVERTED(1'b0),
    .IS_D7_INVERTED(1'b0),
    .IS_D8_INVERTED(1'b0),
    .IS_T1_INVERTED(1'b0),
    .IS_T2_INVERTED(1'b0),
    .IS_T3_INVERTED(1'b0),
    .IS_T4_INVERTED(1'b0),
    .SERDES_MODE("MASTER"),
    .SRVAL_OQ(1'b0),
    .SRVAL_TQ(1'b0),
    .TBYTE_CTL("FALSE"),
    .TBYTE_SRC("FALSE"),
    .TRISTATE_WIDTH(1)) 
    \family_7.oserdese2_master 
       (.CLK(PXLCLK_5X_I),
        .CLKDIV(PXLCLK_I),
        .D1(Q[0]),
        .D2(Q[1]),
        .D3(Q[2]),
        .D4(Q[3]),
        .D5(Q[4]),
        .D6(Q[5]),
        .D7(Q[6]),
        .D8(Q[7]),
        .OCE(1'b1),
        .OFB(\NLW_family_7.oserdese2_master_OFB_UNCONNECTED ),
        .OQ(I),
        .RST(RST),
        .SHIFTIN1(SHIFTIN1),
        .SHIFTIN2(SHIFTIN2),
        .SHIFTOUT1(\NLW_family_7.oserdese2_master_SHIFTOUT1_UNCONNECTED ),
        .SHIFTOUT2(\NLW_family_7.oserdese2_master_SHIFTOUT2_UNCONNECTED ),
        .T1(1'b0),
        .T2(1'b0),
        .T3(1'b0),
        .T4(1'b0),
        .TBYTEIN(1'b0),
        .TBYTEOUT(\NLW_family_7.oserdese2_master_TBYTEOUT_UNCONNECTED ),
        .TCE(1'b0),
        .TFB(\NLW_family_7.oserdese2_master_TFB_UNCONNECTED ),
        .TQ(\NLW_family_7.oserdese2_master_TQ_UNCONNECTED ));
  (* box_type = "PRIMITIVE" *) 
  OSERDESE2 #(
    .DATA_RATE_OQ("DDR"),
    .DATA_RATE_TQ("SDR"),
    .DATA_WIDTH(10),
    .INIT_OQ(1'b0),
    .INIT_TQ(1'b0),
    .IS_CLKDIV_INVERTED(1'b0),
    .IS_CLK_INVERTED(1'b0),
    .IS_D1_INVERTED(1'b0),
    .IS_D2_INVERTED(1'b0),
    .IS_D3_INVERTED(1'b0),
    .IS_D4_INVERTED(1'b0),
    .IS_D5_INVERTED(1'b0),
    .IS_D6_INVERTED(1'b0),
    .IS_D7_INVERTED(1'b0),
    .IS_D8_INVERTED(1'b0),
    .IS_T1_INVERTED(1'b0),
    .IS_T2_INVERTED(1'b0),
    .IS_T3_INVERTED(1'b0),
    .IS_T4_INVERTED(1'b0),
    .SERDES_MODE("SLAVE"),
    .SRVAL_OQ(1'b0),
    .SRVAL_TQ(1'b0),
    .TBYTE_CTL("FALSE"),
    .TBYTE_SRC("FALSE"),
    .TRISTATE_WIDTH(1)) 
    \family_7.oserdese2_slave 
       (.CLK(PXLCLK_5X_I),
        .CLKDIV(PXLCLK_I),
        .D1(1'b0),
        .D2(1'b0),
        .D3(Q[8]),
        .D4(Q[9]),
        .D5(1'b0),
        .D6(1'b0),
        .D7(1'b0),
        .D8(1'b0),
        .OCE(1'b1),
        .OFB(\NLW_family_7.oserdese2_slave_OFB_UNCONNECTED ),
        .OQ(\NLW_family_7.oserdese2_slave_OQ_UNCONNECTED ),
        .RST(RST),
        .SHIFTIN1(1'b0),
        .SHIFTIN2(1'b0),
        .SHIFTOUT1(SHIFTIN1),
        .SHIFTOUT2(SHIFTIN2),
        .T1(1'b0),
        .T2(1'b0),
        .T3(1'b0),
        .T4(1'b0),
        .TBYTEIN(1'b0),
        .TBYTEOUT(\NLW_family_7.oserdese2_slave_TBYTEOUT_UNCONNECTED ),
        .TCE(1'b0),
        .TFB(\NLW_family_7.oserdese2_slave_TFB_UNCONNECTED ),
        .TQ(\NLW_family_7.oserdese2_slave_TQ_UNCONNECTED ));
  (* CAPACITANCE = "DONT_CARE" *) 
  (* XILINX_LEGACY_PRIM = "OBUFDS" *) 
  (* box_type = "PRIMITIVE" *) 
  OBUFDS #(
    .IOSTANDARD("DEFAULT")) 
    io_datax_out
       (.I(I),
        .O(HDMI_D2_P),
        .OB(HDMI_D2_N));
endmodule

(* ORIG_REF_NAME = "TMDSEncoder" *) 
module system_HDMI_FPGA_ML_0_0_TMDSEncoder
   (Q,
    VGA_HS,
    PXLCLK_I,
    VGA_VS,
    de_dd,
    VGA_RGB,
    SR);
  output [9:0]Q;
  input VGA_HS;
  input PXLCLK_I;
  input VGA_VS;
  input de_dd;
  input [7:0]VGA_RGB;
  input [0:0]SR;

  wire PXLCLK_I;
  wire [9:0]Q;
  wire [0:0]SR;
  wire VGA_HS;
  wire [7:0]VGA_RGB;
  wire VGA_VS;
  wire c0_d;
  wire c0_dd;
  wire c1_d_reg_n_0;
  wire c1_dd;
  wire [4:1]cnt_t;
  wire [4:1]cnt_t_1;
  wire \cnt_t_1[1]_i_2__1_n_0 ;
  wire \cnt_t_1[1]_i_3__1_n_0 ;
  wire \cnt_t_1[1]_i_4__0_n_0 ;
  wire \cnt_t_1[2]_i_2__1_n_0 ;
  wire \cnt_t_1[3]_i_2__1_n_0 ;
  wire \cnt_t_1[3]_i_3__0_n_0 ;
  wire \cnt_t_1[3]_i_4__1_n_0 ;
  wire \cnt_t_1[3]_i_5_n_0 ;
  wire \cnt_t_1[3]_i_6__0_n_0 ;
  wire \cnt_t_1[4]_i_10_n_0 ;
  wire \cnt_t_1[4]_i_11__0_n_0 ;
  wire \cnt_t_1[4]_i_2__1_n_0 ;
  wire \cnt_t_1[4]_i_3__1_n_0 ;
  wire \cnt_t_1[4]_i_4__1_n_0 ;
  wire \cnt_t_1[4]_i_5__0_n_0 ;
  wire \cnt_t_1[4]_i_6_n_0 ;
  wire \cnt_t_1[4]_i_7__1_n_0 ;
  wire \cnt_t_1[4]_i_8__1_n_0 ;
  wire \cnt_t_1[4]_i_9__0_n_0 ;
  wire \d_d_reg_n_0_[0] ;
  wire \d_d_reg_n_0_[1] ;
  wire de_dd;
  wire \n0_q_m[1]_i_1__0_n_0 ;
  wire \n0_q_m[2]_i_1__1_n_0 ;
  wire \n0_q_m[3]_i_1__1_n_0 ;
  wire \n0_q_m[3]_i_2__1_n_0 ;
  wire \n0_q_m[3]_i_3__1_n_0 ;
  wire \n0_q_m[3]_i_4__1_n_0 ;
  wire \n0_q_m[3]_i_5__0_n_0 ;
  wire \n0_q_m[3]_i_6__0_n_0 ;
  wire \n0_q_m[3]_i_7__1_n_0 ;
  wire \n0_q_m_reg_n_0_[1] ;
  wire \n0_q_m_reg_n_0_[2] ;
  wire \n0_q_m_reg_n_0_[3] ;
  wire [3:0]n1_d;
  wire \n1_d[0]_i_1_n_0 ;
  wire \n1_d[0]_i_2_n_0 ;
  wire \n1_d[1]_i_1_n_0 ;
  wire \n1_d[1]_i_2_n_0 ;
  wire \n1_d[2]_i_1_n_0 ;
  wire \n1_d[2]_i_2_n_0 ;
  wire \n1_d[3]_i_1_n_0 ;
  wire \n1_d[3]_i_2_n_0 ;
  wire \n1_d[3]_i_3_n_0 ;
  wire \n1_d[3]_i_4_n_0 ;
  wire \n1_q_m[1]_i_1__1_n_0 ;
  wire \n1_q_m[2]_i_1__0_n_0 ;
  wire \n1_q_m[3]_i_1__0_n_0 ;
  wire \n1_q_m[3]_i_2__0_n_0 ;
  wire \n1_q_m_reg_n_0_[1] ;
  wire \n1_q_m_reg_n_0_[2] ;
  wire \n1_q_m_reg_n_0_[3] ;
  wire p_0_in;
  wire p_0_in0_in;
  wire p_0_in10_in;
  wire p_0_in2_in;
  wire p_0_in4_in;
  wire p_0_in6_in;
  wire p_0_in8_in;
  wire \q_m_d[1]_i_1__1_n_0 ;
  wire \q_m_d[2]_i_1__1_n_0 ;
  wire \q_m_d[3]_i_1__0_n_0 ;
  wire \q_m_d[4]_i_1__1_n_0 ;
  wire \q_m_d[5]_i_1__1_n_0 ;
  wire \q_m_d[6]_i_1__1_n_0 ;
  wire \q_m_d[6]_i_2__1_n_0 ;
  wire \q_m_d[7]_i_1__0_n_0 ;
  wire \q_m_d[8]_i_1__1_n_0 ;
  wire \q_m_d_reg_n_0_[0] ;
  wire \q_m_d_reg_n_0_[1] ;
  wire \q_m_d_reg_n_0_[2] ;
  wire \q_m_d_reg_n_0_[3] ;
  wire \q_m_d_reg_n_0_[4] ;
  wire \q_m_d_reg_n_0_[5] ;
  wire \q_m_d_reg_n_0_[6] ;
  wire \q_m_d_reg_n_0_[7] ;
  wire \q_out_d[0]_i_1_n_0 ;
  wire \q_out_d[1]_i_1_n_0 ;
  wire \q_out_d[2]_i_1_n_0 ;
  wire \q_out_d[3]_i_1_n_0 ;
  wire \q_out_d[4]_i_1_n_0 ;
  wire \q_out_d[5]_i_1_n_0 ;
  wire \q_out_d[6]_i_1_n_0 ;
  wire \q_out_d[7]_i_1_n_0 ;
  wire \q_out_d[8]_i_1_n_0 ;
  wire \q_out_d[9]_i_1_n_0 ;
  wire \q_out_d[9]_i_2_n_0 ;
  wire \q_out_d[9]_i_3_n_0 ;

  FDRE c0_d_reg
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_HS),
        .Q(c0_d),
        .R(1'b0));
  FDRE c0_dd_reg
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(c0_d),
        .Q(c0_dd),
        .R(1'b0));
  FDRE c1_d_reg
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_VS),
        .Q(c1_d_reg_n_0),
        .R(1'b0));
  FDRE c1_dd_reg
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(c1_d_reg_n_0),
        .Q(c1_dd),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h96666696)) 
    \cnt_t_1[1]_i_1__1 
       (.I0(\cnt_t_1[1]_i_2__1_n_0 ),
        .I1(cnt_t_1[1]),
        .I2(\cnt_t_1[4]_i_3__1_n_0 ),
        .I3(\cnt_t_1[1]_i_3__1_n_0 ),
        .I4(\q_m_d[8]_i_1__1_n_0 ),
        .O(cnt_t[1]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \cnt_t_1[1]_i_2__1 
       (.I0(\n1_q_m_reg_n_0_[1] ),
        .I1(\n0_q_m_reg_n_0_[1] ),
        .O(\cnt_t_1[1]_i_2__1_n_0 ));
  LUT6 #(
    .INIT(64'h000000FEFFFF00FE)) 
    \cnt_t_1[1]_i_3__1 
       (.I0(cnt_t_1[2]),
        .I1(cnt_t_1[1]),
        .I2(cnt_t_1[3]),
        .I3(\cnt_t_1[4]_i_9__0_n_0 ),
        .I4(cnt_t_1[4]),
        .I5(\cnt_t_1[1]_i_4__0_n_0 ),
        .O(\cnt_t_1[1]_i_3__1_n_0 ));
  LUT6 #(
    .INIT(64'hDD4D4D44DD4DDD4D)) 
    \cnt_t_1[1]_i_4__0 
       (.I0(\n0_q_m_reg_n_0_[3] ),
        .I1(\n1_q_m_reg_n_0_[3] ),
        .I2(\n0_q_m_reg_n_0_[2] ),
        .I3(\n1_q_m_reg_n_0_[2] ),
        .I4(\n1_q_m_reg_n_0_[1] ),
        .I5(\n0_q_m_reg_n_0_[1] ),
        .O(\cnt_t_1[1]_i_4__0_n_0 ));
  LUT6 #(
    .INIT(64'h2DD2D22DD22D2DD2)) 
    \cnt_t_1[2]_i_1__1 
       (.I0(\n1_q_m_reg_n_0_[1] ),
        .I1(\n0_q_m_reg_n_0_[1] ),
        .I2(\n0_q_m_reg_n_0_[2] ),
        .I3(\n1_q_m_reg_n_0_[2] ),
        .I4(cnt_t_1[2]),
        .I5(\cnt_t_1[2]_i_2__1_n_0 ),
        .O(cnt_t[2]));
  LUT6 #(
    .INIT(64'hD0BF8010D0B08010)) 
    \cnt_t_1[2]_i_2__1 
       (.I0(\q_m_d[8]_i_1__1_n_0 ),
        .I1(\cnt_t_1[1]_i_3__1_n_0 ),
        .I2(\cnt_t_1[4]_i_3__1_n_0 ),
        .I3(cnt_t_1[1]),
        .I4(\cnt_t_1[1]_i_2__1_n_0 ),
        .I5(p_0_in),
        .O(\cnt_t_1[2]_i_2__1_n_0 ));
  LUT6 #(
    .INIT(64'hF3FF0D01030FFDF1)) 
    \cnt_t_1[3]_i_1__1 
       (.I0(\cnt_t_1[3]_i_2__1_n_0 ),
        .I1(p_0_in),
        .I2(\cnt_t_1[4]_i_3__1_n_0 ),
        .I3(\cnt_t_1[3]_i_3__0_n_0 ),
        .I4(\cnt_t_1[3]_i_4__1_n_0 ),
        .I5(\cnt_t_1[3]_i_5_n_0 ),
        .O(cnt_t[3]));
  LUT6 #(
    .INIT(64'hC7DF10F710F7C7DF)) 
    \cnt_t_1[3]_i_2__1 
       (.I0(cnt_t_1[1]),
        .I1(\n0_q_m_reg_n_0_[1] ),
        .I2(\n1_q_m_reg_n_0_[1] ),
        .I3(cnt_t_1[2]),
        .I4(\n1_q_m_reg_n_0_[2] ),
        .I5(\n0_q_m_reg_n_0_[2] ),
        .O(\cnt_t_1[3]_i_2__1_n_0 ));
  LUT6 #(
    .INIT(64'h044602BF02BF0446)) 
    \cnt_t_1[3]_i_3__0 
       (.I0(\n0_q_m_reg_n_0_[1] ),
        .I1(\n1_q_m_reg_n_0_[1] ),
        .I2(cnt_t_1[1]),
        .I3(cnt_t_1[2]),
        .I4(\n1_q_m_reg_n_0_[2] ),
        .I5(\n0_q_m_reg_n_0_[2] ),
        .O(\cnt_t_1[3]_i_3__0_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \cnt_t_1[3]_i_4__1 
       (.I0(cnt_t_1[3]),
        .I1(\cnt_t_1[4]_i_7__1_n_0 ),
        .O(\cnt_t_1[3]_i_4__1_n_0 ));
  LUT6 #(
    .INIT(64'h746074F660E2F6E2)) 
    \cnt_t_1[3]_i_5 
       (.I0(\cnt_t_1[1]_i_3__1_n_0 ),
        .I1(cnt_t_1[2]),
        .I2(\cnt_t_1[3]_i_6__0_n_0 ),
        .I3(cnt_t_1[1]),
        .I4(\cnt_t_1[1]_i_2__1_n_0 ),
        .I5(\q_m_d[8]_i_1__1_n_0 ),
        .O(\cnt_t_1[3]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'hD22D)) 
    \cnt_t_1[3]_i_6__0 
       (.I0(\n1_q_m_reg_n_0_[1] ),
        .I1(\n0_q_m_reg_n_0_[1] ),
        .I2(\n0_q_m_reg_n_0_[2] ),
        .I3(\n1_q_m_reg_n_0_[2] ),
        .O(\cnt_t_1[3]_i_6__0_n_0 ));
  LUT6 #(
    .INIT(64'h41D7FFFF000041D7)) 
    \cnt_t_1[4]_i_10 
       (.I0(cnt_t_1[1]),
        .I1(\n0_q_m_reg_n_0_[1] ),
        .I2(\n1_q_m_reg_n_0_[1] ),
        .I3(\q_m_d[8]_i_1__1_n_0 ),
        .I4(cnt_t_1[2]),
        .I5(\cnt_t_1[3]_i_6__0_n_0 ),
        .O(\cnt_t_1[4]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hEEE8E8EEE88888E8)) 
    \cnt_t_1[4]_i_11__0 
       (.I0(cnt_t_1[2]),
        .I1(\cnt_t_1[3]_i_6__0_n_0 ),
        .I2(cnt_t_1[1]),
        .I3(\n0_q_m_reg_n_0_[1] ),
        .I4(\n1_q_m_reg_n_0_[1] ),
        .I5(\q_m_d[8]_i_1__1_n_0 ),
        .O(\cnt_t_1[4]_i_11__0_n_0 ));
  LUT6 #(
    .INIT(64'hF2FDFEF1020D0E01)) 
    \cnt_t_1[4]_i_1__1 
       (.I0(\cnt_t_1[4]_i_2__1_n_0 ),
        .I1(p_0_in),
        .I2(\cnt_t_1[4]_i_3__1_n_0 ),
        .I3(\cnt_t_1[4]_i_4__1_n_0 ),
        .I4(\cnt_t_1[4]_i_5__0_n_0 ),
        .I5(\cnt_t_1[4]_i_6_n_0 ),
        .O(cnt_t[4]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h4D)) 
    \cnt_t_1[4]_i_2__1 
       (.I0(\cnt_t_1[4]_i_7__1_n_0 ),
        .I1(\cnt_t_1[3]_i_2__1_n_0 ),
        .I2(cnt_t_1[3]),
        .O(\cnt_t_1[4]_i_2__1_n_0 ));
  LUT5 #(
    .INIT(32'h0000FFFE)) 
    \cnt_t_1[4]_i_3__1 
       (.I0(cnt_t_1[4]),
        .I1(cnt_t_1[3]),
        .I2(cnt_t_1[1]),
        .I3(cnt_t_1[2]),
        .I4(\cnt_t_1[4]_i_8__1_n_0 ),
        .O(\cnt_t_1[4]_i_3__1_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \cnt_t_1[4]_i_4__1 
       (.I0(\cnt_t_1[4]_i_9__0_n_0 ),
        .I1(cnt_t_1[4]),
        .O(\cnt_t_1[4]_i_4__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'h8E)) 
    \cnt_t_1[4]_i_5__0 
       (.I0(\cnt_t_1[4]_i_7__1_n_0 ),
        .I1(\cnt_t_1[3]_i_3__0_n_0 ),
        .I2(cnt_t_1[3]),
        .O(\cnt_t_1[4]_i_5__0_n_0 ));
  LUT6 #(
    .INIT(64'h3C0F8787B4B4F0C3)) 
    \cnt_t_1[4]_i_6 
       (.I0(\cnt_t_1[4]_i_10_n_0 ),
        .I1(\cnt_t_1[1]_i_3__1_n_0 ),
        .I2(\cnt_t_1[4]_i_4__1_n_0 ),
        .I3(\cnt_t_1[4]_i_11__0_n_0 ),
        .I4(cnt_t_1[3]),
        .I5(\cnt_t_1[4]_i_7__1_n_0 ),
        .O(\cnt_t_1[4]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h2F02D0FDD0FD2F02)) 
    \cnt_t_1[4]_i_7__1 
       (.I0(\n1_q_m_reg_n_0_[1] ),
        .I1(\n0_q_m_reg_n_0_[1] ),
        .I2(\n0_q_m_reg_n_0_[2] ),
        .I3(\n1_q_m_reg_n_0_[2] ),
        .I4(\n1_q_m_reg_n_0_[3] ),
        .I5(\n0_q_m_reg_n_0_[3] ),
        .O(\cnt_t_1[4]_i_7__1_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \cnt_t_1[4]_i_8__1 
       (.I0(\n1_q_m_reg_n_0_[3] ),
        .I1(\n0_q_m_reg_n_0_[3] ),
        .I2(\n1_q_m_reg_n_0_[1] ),
        .I3(\n0_q_m_reg_n_0_[1] ),
        .I4(\n1_q_m_reg_n_0_[2] ),
        .I5(\n0_q_m_reg_n_0_[2] ),
        .O(\cnt_t_1[4]_i_8__1_n_0 ));
  LUT6 #(
    .INIT(64'hD4DDFFFF0000D4DD)) 
    \cnt_t_1[4]_i_9__0 
       (.I0(\n1_q_m_reg_n_0_[2] ),
        .I1(\n0_q_m_reg_n_0_[2] ),
        .I2(\n0_q_m_reg_n_0_[1] ),
        .I3(\n1_q_m_reg_n_0_[1] ),
        .I4(\n1_q_m_reg_n_0_[3] ),
        .I5(\n0_q_m_reg_n_0_[3] ),
        .O(\cnt_t_1[4]_i_9__0_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_t_1_reg[1] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(cnt_t[1]),
        .Q(cnt_t_1[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_t_1_reg[2] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(cnt_t[2]),
        .Q(cnt_t_1[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_t_1_reg[3] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(cnt_t[3]),
        .Q(cnt_t_1[3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_t_1_reg[4] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(cnt_t[4]),
        .Q(cnt_t_1[4]),
        .R(SR));
  FDRE \d_d_reg[0] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_RGB[0]),
        .Q(\d_d_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \d_d_reg[1] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_RGB[1]),
        .Q(\d_d_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \d_d_reg[2] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_RGB[2]),
        .Q(p_0_in0_in),
        .R(1'b0));
  FDRE \d_d_reg[3] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_RGB[3]),
        .Q(p_0_in2_in),
        .R(1'b0));
  FDRE \d_d_reg[4] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_RGB[4]),
        .Q(p_0_in4_in),
        .R(1'b0));
  FDRE \d_d_reg[5] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_RGB[5]),
        .Q(p_0_in6_in),
        .R(1'b0));
  FDRE \d_d_reg[6] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_RGB[6]),
        .Q(p_0_in8_in),
        .R(1'b0));
  FDRE \d_d_reg[7] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_RGB[7]),
        .Q(p_0_in10_in),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h9996699969996669)) 
    \n0_q_m[1]_i_1__0 
       (.I0(\n0_q_m[3]_i_5__0_n_0 ),
        .I1(\n0_q_m[3]_i_4__1_n_0 ),
        .I2(\q_m_d[7]_i_1__0_n_0 ),
        .I3(\d_d_reg_n_0_[0] ),
        .I4(\n0_q_m[3]_i_3__1_n_0 ),
        .I5(\n0_q_m[3]_i_2__1_n_0 ),
        .O(\n0_q_m[1]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h00088EEF8EEFFFF7)) 
    \n0_q_m[2]_i_1__1 
       (.I0(\n0_q_m[3]_i_2__1_n_0 ),
        .I1(\n0_q_m[3]_i_3__1_n_0 ),
        .I2(\d_d_reg_n_0_[0] ),
        .I3(\q_m_d[7]_i_1__0_n_0 ),
        .I4(\n0_q_m[3]_i_4__1_n_0 ),
        .I5(\n0_q_m[3]_i_5__0_n_0 ),
        .O(\n0_q_m[2]_i_1__1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000008)) 
    \n0_q_m[3]_i_1__1 
       (.I0(\n0_q_m[3]_i_2__1_n_0 ),
        .I1(\n0_q_m[3]_i_3__1_n_0 ),
        .I2(\d_d_reg_n_0_[0] ),
        .I3(\q_m_d[7]_i_1__0_n_0 ),
        .I4(\n0_q_m[3]_i_4__1_n_0 ),
        .I5(\n0_q_m[3]_i_5__0_n_0 ),
        .O(\n0_q_m[3]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h69)) 
    \n0_q_m[3]_i_2__1 
       (.I0(\d_d_reg_n_0_[1] ),
        .I1(\d_d_reg_n_0_[0] ),
        .I2(p_0_in2_in),
        .O(\n0_q_m[3]_i_2__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'h96696996)) 
    \n0_q_m[3]_i_3__1 
       (.I0(\n0_q_m[3]_i_6__0_n_0 ),
        .I1(p_0_in4_in),
        .I2(p_0_in2_in),
        .I3(p_0_in0_in),
        .I4(p_0_in8_in),
        .O(\n0_q_m[3]_i_3__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h4BB4D22D)) 
    \n0_q_m[3]_i_4__1 
       (.I0(\q_m_d[8]_i_1__1_n_0 ),
        .I1(p_0_in0_in),
        .I2(\d_d_reg_n_0_[0] ),
        .I3(\d_d_reg_n_0_[1] ),
        .I4(p_0_in2_in),
        .O(\n0_q_m[3]_i_4__1_n_0 ));
  LUT6 #(
    .INIT(64'h9966966969969966)) 
    \n0_q_m[3]_i_5__0 
       (.I0(\n0_q_m[3]_i_7__1_n_0 ),
        .I1(\q_m_d[6]_i_2__1_n_0 ),
        .I2(\q_m_d[8]_i_1__1_n_0 ),
        .I3(p_0_in4_in),
        .I4(p_0_in6_in),
        .I5(p_0_in8_in),
        .O(\n0_q_m[3]_i_5__0_n_0 ));
  LUT6 #(
    .INIT(64'h55AA55AA66996A99)) 
    \n0_q_m[3]_i_6__0 
       (.I0(\d_d_reg_n_0_[1] ),
        .I1(n1_d[2]),
        .I2(n1_d[1]),
        .I3(\d_d_reg_n_0_[0] ),
        .I4(n1_d[0]),
        .I5(n1_d[3]),
        .O(\n0_q_m[3]_i_6__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \n0_q_m[3]_i_7__1 
       (.I0(\d_d_reg_n_0_[1] ),
        .I1(\d_d_reg_n_0_[0] ),
        .O(\n0_q_m[3]_i_7__1_n_0 ));
  FDRE \n0_q_m_reg[1] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\n0_q_m[1]_i_1__0_n_0 ),
        .Q(\n0_q_m_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \n0_q_m_reg[2] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\n0_q_m[2]_i_1__1_n_0 ),
        .Q(\n0_q_m_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \n0_q_m_reg[3] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\n0_q_m[3]_i_1__1_n_0 ),
        .Q(\n0_q_m_reg_n_0_[3] ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \n1_d[0]_i_1 
       (.I0(VGA_RGB[0]),
        .I1(VGA_RGB[7]),
        .I2(\n1_d[0]_i_2_n_0 ),
        .I3(VGA_RGB[2]),
        .I4(VGA_RGB[1]),
        .I5(VGA_RGB[3]),
        .O(\n1_d[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \n1_d[0]_i_2 
       (.I0(VGA_RGB[6]),
        .I1(VGA_RGB[4]),
        .I2(VGA_RGB[5]),
        .O(\n1_d[0]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h96)) 
    \n1_d[1]_i_1 
       (.I0(\n1_d[3]_i_2_n_0 ),
        .I1(\n1_d[1]_i_2_n_0 ),
        .I2(\n1_d[3]_i_3_n_0 ),
        .O(\n1_d[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    \n1_d[1]_i_2 
       (.I0(VGA_RGB[3]),
        .I1(VGA_RGB[2]),
        .I2(VGA_RGB[1]),
        .I3(VGA_RGB[6]),
        .I4(VGA_RGB[5]),
        .I5(VGA_RGB[4]),
        .O(\n1_d[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7E7E7EE87EE8E8E8)) 
    \n1_d[2]_i_1 
       (.I0(\n1_d[3]_i_2_n_0 ),
        .I1(\n1_d[3]_i_3_n_0 ),
        .I2(\n1_d[2]_i_2_n_0 ),
        .I3(VGA_RGB[4]),
        .I4(VGA_RGB[5]),
        .I5(VGA_RGB[6]),
        .O(\n1_d[2]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hE8)) 
    \n1_d[2]_i_2 
       (.I0(VGA_RGB[1]),
        .I1(VGA_RGB[2]),
        .I2(VGA_RGB[3]),
        .O(\n1_d[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h8880800000000000)) 
    \n1_d[3]_i_1 
       (.I0(\n1_d[3]_i_2_n_0 ),
        .I1(\n1_d[3]_i_3_n_0 ),
        .I2(VGA_RGB[3]),
        .I3(VGA_RGB[2]),
        .I4(VGA_RGB[1]),
        .I5(\n1_d[3]_i_4_n_0 ),
        .O(\n1_d[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h9600009600969600)) 
    \n1_d[3]_i_2 
       (.I0(VGA_RGB[2]),
        .I1(VGA_RGB[1]),
        .I2(VGA_RGB[3]),
        .I3(VGA_RGB[0]),
        .I4(VGA_RGB[7]),
        .I5(\n1_d[0]_i_2_n_0 ),
        .O(\n1_d[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hE88E8EE8)) 
    \n1_d[3]_i_3 
       (.I0(VGA_RGB[7]),
        .I1(VGA_RGB[0]),
        .I2(VGA_RGB[5]),
        .I3(VGA_RGB[4]),
        .I4(VGA_RGB[6]),
        .O(\n1_d[3]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'hE8)) 
    \n1_d[3]_i_4 
       (.I0(VGA_RGB[4]),
        .I1(VGA_RGB[5]),
        .I2(VGA_RGB[6]),
        .O(\n1_d[3]_i_4_n_0 ));
  FDRE \n1_d_reg[0] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\n1_d[0]_i_1_n_0 ),
        .Q(n1_d[0]),
        .R(1'b0));
  FDRE \n1_d_reg[1] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\n1_d[1]_i_1_n_0 ),
        .Q(n1_d[1]),
        .R(1'b0));
  FDRE \n1_d_reg[2] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\n1_d[2]_i_1_n_0 ),
        .Q(n1_d[2]),
        .R(1'b0));
  FDRE \n1_d_reg[3] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\n1_d[3]_i_1_n_0 ),
        .Q(n1_d[3]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h9969696696999969)) 
    \n1_q_m[1]_i_1__1 
       (.I0(\n0_q_m[3]_i_4__1_n_0 ),
        .I1(\n0_q_m[3]_i_5__0_n_0 ),
        .I2(\n0_q_m[3]_i_3__1_n_0 ),
        .I3(\q_m_d[7]_i_1__0_n_0 ),
        .I4(\d_d_reg_n_0_[0] ),
        .I5(\n0_q_m[3]_i_2__1_n_0 ),
        .O(\n1_q_m[1]_i_1__1_n_0 ));
  LUT6 #(
    .INIT(64'hEE8E8E88E7EEEE8E)) 
    \n1_q_m[2]_i_1__0 
       (.I0(\n0_q_m[3]_i_5__0_n_0 ),
        .I1(\n0_q_m[3]_i_4__1_n_0 ),
        .I2(\n0_q_m[3]_i_2__1_n_0 ),
        .I3(\d_d_reg_n_0_[0] ),
        .I4(\q_m_d[7]_i_1__0_n_0 ),
        .I5(\n0_q_m[3]_i_3__1_n_0 ),
        .O(\n1_q_m[2]_i_1__0_n_0 ));
  LUT5 #(
    .INIT(32'h00002000)) 
    \n1_q_m[3]_i_1__0 
       (.I0(\n1_q_m[3]_i_2__0_n_0 ),
        .I1(\n0_q_m[3]_i_3__1_n_0 ),
        .I2(\q_m_d[7]_i_1__0_n_0 ),
        .I3(\d_d_reg_n_0_[0] ),
        .I4(\n0_q_m[3]_i_2__1_n_0 ),
        .O(\n1_q_m[3]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h28820AA0A00A2882)) 
    \n1_q_m[3]_i_2__0 
       (.I0(\n0_q_m[3]_i_5__0_n_0 ),
        .I1(p_0_in2_in),
        .I2(\d_d_reg_n_0_[1] ),
        .I3(\d_d_reg_n_0_[0] ),
        .I4(p_0_in0_in),
        .I5(\q_m_d[8]_i_1__1_n_0 ),
        .O(\n1_q_m[3]_i_2__0_n_0 ));
  FDRE \n1_q_m_reg[1] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\n1_q_m[1]_i_1__1_n_0 ),
        .Q(\n1_q_m_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \n1_q_m_reg[2] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\n1_q_m[2]_i_1__0_n_0 ),
        .Q(\n1_q_m_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \n1_q_m_reg[3] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\n1_q_m[3]_i_1__0_n_0 ),
        .Q(\n1_q_m_reg_n_0_[3] ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hF0E0A5A50F1F5A5A)) 
    \q_m_d[1]_i_1__1 
       (.I0(n1_d[3]),
        .I1(n1_d[0]),
        .I2(\d_d_reg_n_0_[0] ),
        .I3(n1_d[1]),
        .I4(n1_d[2]),
        .I5(\d_d_reg_n_0_[1] ),
        .O(\q_m_d[1]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \q_m_d[2]_i_1__1 
       (.I0(p_0_in0_in),
        .I1(\d_d_reg_n_0_[0] ),
        .I2(\d_d_reg_n_0_[1] ),
        .O(\q_m_d[2]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h69969669)) 
    \q_m_d[3]_i_1__0 
       (.I0(\q_m_d[8]_i_1__1_n_0 ),
        .I1(p_0_in0_in),
        .I2(p_0_in2_in),
        .I3(\d_d_reg_n_0_[1] ),
        .I4(\d_d_reg_n_0_[0] ),
        .O(\q_m_d[3]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h96696996)) 
    \q_m_d[4]_i_1__1 
       (.I0(p_0_in4_in),
        .I1(p_0_in2_in),
        .I2(p_0_in0_in),
        .I3(\d_d_reg_n_0_[1] ),
        .I4(\d_d_reg_n_0_[0] ),
        .O(\q_m_d[4]_i_1__1_n_0 ));
  LUT6 #(
    .INIT(64'h9669699669969669)) 
    \q_m_d[5]_i_1__1 
       (.I0(\d_d_reg_n_0_[0] ),
        .I1(\d_d_reg_n_0_[1] ),
        .I2(\q_m_d[6]_i_2__1_n_0 ),
        .I3(\q_m_d[8]_i_1__1_n_0 ),
        .I4(p_0_in4_in),
        .I5(p_0_in6_in),
        .O(\q_m_d[5]_i_1__1_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \q_m_d[6]_i_1__1 
       (.I0(p_0_in4_in),
        .I1(\q_m_d[6]_i_2__1_n_0 ),
        .I2(\d_d_reg_n_0_[1] ),
        .I3(\d_d_reg_n_0_[0] ),
        .I4(p_0_in8_in),
        .I5(p_0_in6_in),
        .O(\q_m_d[6]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \q_m_d[6]_i_2__1 
       (.I0(p_0_in0_in),
        .I1(p_0_in2_in),
        .O(\q_m_d[6]_i_2__1_n_0 ));
  LUT5 #(
    .INIT(32'h96696996)) 
    \q_m_d[7]_i_1__0 
       (.I0(\q_m_d[3]_i_1__0_n_0 ),
        .I1(p_0_in8_in),
        .I2(p_0_in10_in),
        .I3(p_0_in6_in),
        .I4(p_0_in4_in),
        .O(\q_m_d[7]_i_1__0_n_0 ));
  LUT5 #(
    .INIT(32'h00105555)) 
    \q_m_d[8]_i_1__1 
       (.I0(n1_d[3]),
        .I1(n1_d[0]),
        .I2(\d_d_reg_n_0_[0] ),
        .I3(n1_d[1]),
        .I4(n1_d[2]),
        .O(\q_m_d[8]_i_1__1_n_0 ));
  FDRE \q_m_d_reg[0] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\d_d_reg_n_0_[0] ),
        .Q(\q_m_d_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \q_m_d_reg[1] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_m_d[1]_i_1__1_n_0 ),
        .Q(\q_m_d_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \q_m_d_reg[2] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_m_d[2]_i_1__1_n_0 ),
        .Q(\q_m_d_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \q_m_d_reg[3] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_m_d[3]_i_1__0_n_0 ),
        .Q(\q_m_d_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \q_m_d_reg[4] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_m_d[4]_i_1__1_n_0 ),
        .Q(\q_m_d_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \q_m_d_reg[5] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_m_d[5]_i_1__1_n_0 ),
        .Q(\q_m_d_reg_n_0_[5] ),
        .R(1'b0));
  FDRE \q_m_d_reg[6] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_m_d[6]_i_1__1_n_0 ),
        .Q(\q_m_d_reg_n_0_[6] ),
        .R(1'b0));
  FDRE \q_m_d_reg[7] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_m_d[7]_i_1__0_n_0 ),
        .Q(\q_m_d_reg_n_0_[7] ),
        .R(1'b0));
  FDRE \q_m_d_reg[8] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_m_d[8]_i_1__1_n_0 ),
        .Q(p_0_in),
        .R(1'b0));
  LUT5 #(
    .INIT(32'h6F606F6F)) 
    \q_out_d[0]_i_1 
       (.I0(\q_m_d_reg_n_0_[0] ),
        .I1(\q_out_d[9]_i_3_n_0 ),
        .I2(de_dd),
        .I3(c0_dd),
        .I4(c1_dd),
        .O(\q_out_d[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h6F606F6F)) 
    \q_out_d[1]_i_1 
       (.I0(\q_m_d_reg_n_0_[1] ),
        .I1(\q_out_d[9]_i_3_n_0 ),
        .I2(de_dd),
        .I3(c0_dd),
        .I4(c1_dd),
        .O(\q_out_d[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h48487B48)) 
    \q_out_d[2]_i_1 
       (.I0(\q_out_d[9]_i_3_n_0 ),
        .I1(de_dd),
        .I2(\q_m_d_reg_n_0_[2] ),
        .I3(c1_dd),
        .I4(c0_dd),
        .O(\q_out_d[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h6F606F6F)) 
    \q_out_d[3]_i_1 
       (.I0(\q_m_d_reg_n_0_[3] ),
        .I1(\q_out_d[9]_i_3_n_0 ),
        .I2(de_dd),
        .I3(c0_dd),
        .I4(c1_dd),
        .O(\q_out_d[3]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h48487B48)) 
    \q_out_d[4]_i_1 
       (.I0(\q_out_d[9]_i_3_n_0 ),
        .I1(de_dd),
        .I2(\q_m_d_reg_n_0_[4] ),
        .I3(c1_dd),
        .I4(c0_dd),
        .O(\q_out_d[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h6F606F6F)) 
    \q_out_d[5]_i_1 
       (.I0(\q_m_d_reg_n_0_[5] ),
        .I1(\q_out_d[9]_i_3_n_0 ),
        .I2(de_dd),
        .I3(c0_dd),
        .I4(c1_dd),
        .O(\q_out_d[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h48487B48)) 
    \q_out_d[6]_i_1 
       (.I0(\q_out_d[9]_i_3_n_0 ),
        .I1(de_dd),
        .I2(\q_m_d_reg_n_0_[6] ),
        .I3(c1_dd),
        .I4(c0_dd),
        .O(\q_out_d[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h6F606F6F)) 
    \q_out_d[7]_i_1 
       (.I0(\q_m_d_reg_n_0_[7] ),
        .I1(\q_out_d[9]_i_3_n_0 ),
        .I2(de_dd),
        .I3(c0_dd),
        .I4(c1_dd),
        .O(\q_out_d[7]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h88B8)) 
    \q_out_d[8]_i_1 
       (.I0(p_0_in),
        .I1(de_dd),
        .I2(c1_dd),
        .I3(c0_dd),
        .O(\q_out_d[8]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'h01)) 
    \q_out_d[9]_i_1 
       (.I0(de_dd),
        .I1(c1_dd),
        .I2(c0_dd),
        .O(\q_out_d[9]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'hB88B)) 
    \q_out_d[9]_i_2 
       (.I0(\q_out_d[9]_i_3_n_0 ),
        .I1(de_dd),
        .I2(c1_dd),
        .I3(c0_dd),
        .O(\q_out_d[9]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'hF1)) 
    \q_out_d[9]_i_3 
       (.I0(\cnt_t_1[4]_i_3__1_n_0 ),
        .I1(p_0_in),
        .I2(\cnt_t_1[1]_i_3__1_n_0 ),
        .O(\q_out_d[9]_i_3_n_0 ));
  FDRE \q_out_d_reg[0] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[0]_i_1_n_0 ),
        .Q(Q[0]),
        .R(\q_out_d[9]_i_1_n_0 ));
  FDRE \q_out_d_reg[1] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[1]_i_1_n_0 ),
        .Q(Q[1]),
        .R(\q_out_d[9]_i_1_n_0 ));
  FDSE \q_out_d_reg[2] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[2]_i_1_n_0 ),
        .Q(Q[2]),
        .S(\q_out_d[9]_i_1_n_0 ));
  FDRE \q_out_d_reg[3] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[3]_i_1_n_0 ),
        .Q(Q[3]),
        .R(\q_out_d[9]_i_1_n_0 ));
  FDSE \q_out_d_reg[4] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[4]_i_1_n_0 ),
        .Q(Q[4]),
        .S(\q_out_d[9]_i_1_n_0 ));
  FDRE \q_out_d_reg[5] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[5]_i_1_n_0 ),
        .Q(Q[5]),
        .R(\q_out_d[9]_i_1_n_0 ));
  FDSE \q_out_d_reg[6] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[6]_i_1_n_0 ),
        .Q(Q[6]),
        .S(\q_out_d[9]_i_1_n_0 ));
  FDRE \q_out_d_reg[7] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[7]_i_1_n_0 ),
        .Q(Q[7]),
        .R(\q_out_d[9]_i_1_n_0 ));
  FDSE \q_out_d_reg[8] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[8]_i_1_n_0 ),
        .Q(Q[8]),
        .S(\q_out_d[9]_i_1_n_0 ));
  FDSE \q_out_d_reg[9] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[9]_i_2_n_0 ),
        .Q(Q[9]),
        .S(\q_out_d[9]_i_1_n_0 ));
endmodule

(* ORIG_REF_NAME = "TMDSEncoder" *) 
module system_HDMI_FPGA_ML_0_0_TMDSEncoder_0
   (Q,
    VGA_RGB,
    PXLCLK_I,
    SR);
  output [9:0]Q;
  input [7:0]VGA_RGB;
  input PXLCLK_I;
  input [0:0]SR;

  wire PXLCLK_I;
  wire [9:0]Q;
  wire [0:0]SR;
  wire [7:0]VGA_RGB;
  wire [4:1]cnt_t;
  wire [4:1]cnt_t_1;
  wire \cnt_t_1[1]_i_2__0_n_0 ;
  wire \cnt_t_1[1]_i_3__0_n_0 ;
  wire \cnt_t_1[1]_i_4_n_0 ;
  wire \cnt_t_1[2]_i_2__0_n_0 ;
  wire \cnt_t_1[3]_i_2__0_n_0 ;
  wire \cnt_t_1[3]_i_3__1_n_0 ;
  wire \cnt_t_1[3]_i_4__0_n_0 ;
  wire \cnt_t_1[4]_i_2__0_n_0 ;
  wire \cnt_t_1[4]_i_3__0_n_0 ;
  wire \cnt_t_1[4]_i_4__0_n_0 ;
  wire \cnt_t_1[4]_i_5_n_0 ;
  wire \cnt_t_1[4]_i_6__1_n_0 ;
  wire \cnt_t_1[4]_i_7__0_n_0 ;
  wire \cnt_t_1[4]_i_8_n_0 ;
  wire \cnt_t_1[4]_i_9_n_0 ;
  wire \d_d_reg_n_0_[0] ;
  wire \d_d_reg_n_0_[1] ;
  wire \n0_q_m[1]_i_1_n_0 ;
  wire \n0_q_m[2]_i_1__0_n_0 ;
  wire \n0_q_m[3]_i_1__0_n_0 ;
  wire \n0_q_m[3]_i_2_n_0 ;
  wire \n0_q_m[3]_i_3__0_n_0 ;
  wire \n0_q_m[3]_i_4__0_n_0 ;
  wire \n0_q_m[3]_i_5__1_n_0 ;
  wire \n0_q_m[3]_i_6_n_0 ;
  wire \n0_q_m[3]_i_7__0_n_0 ;
  wire \n0_q_m_reg_n_0_[1] ;
  wire \n0_q_m_reg_n_0_[2] ;
  wire \n0_q_m_reg_n_0_[3] ;
  wire [3:0]n1_d;
  wire \n1_d[0]_i_1_n_0 ;
  wire \n1_d[0]_i_2_n_0 ;
  wire \n1_d[1]_i_1_n_0 ;
  wire \n1_d[1]_i_2_n_0 ;
  wire \n1_d[2]_i_1_n_0 ;
  wire \n1_d[2]_i_2_n_0 ;
  wire \n1_d[3]_i_1_n_0 ;
  wire \n1_d[3]_i_2_n_0 ;
  wire \n1_d[3]_i_3_n_0 ;
  wire \n1_d[3]_i_4_n_0 ;
  wire \n1_q_m[1]_i_1__0_n_0 ;
  wire \n1_q_m[2]_i_1_n_0 ;
  wire \n1_q_m[3]_i_1_n_0 ;
  wire \n1_q_m[3]_i_2_n_0 ;
  wire \n1_q_m_reg_n_0_[1] ;
  wire \n1_q_m_reg_n_0_[2] ;
  wire \n1_q_m_reg_n_0_[3] ;
  wire p_0_in;
  wire p_0_in0_in;
  wire p_0_in10_in;
  wire p_0_in2_in;
  wire p_0_in4_in;
  wire p_0_in6_in;
  wire p_0_in8_in;
  wire \q_m_d[1]_i_1__0_n_0 ;
  wire \q_m_d[2]_i_1__0_n_0 ;
  wire \q_m_d[3]_i_1_n_0 ;
  wire \q_m_d[4]_i_1__0_n_0 ;
  wire \q_m_d[5]_i_1__0_n_0 ;
  wire \q_m_d[6]_i_1__0_n_0 ;
  wire \q_m_d[6]_i_2__0_n_0 ;
  wire \q_m_d[7]_i_1_n_0 ;
  wire \q_m_d[8]_i_1__0_n_0 ;
  wire \q_m_d_reg_n_0_[0] ;
  wire \q_m_d_reg_n_0_[1] ;
  wire \q_m_d_reg_n_0_[2] ;
  wire \q_m_d_reg_n_0_[3] ;
  wire \q_m_d_reg_n_0_[4] ;
  wire \q_m_d_reg_n_0_[5] ;
  wire \q_m_d_reg_n_0_[6] ;
  wire \q_m_d_reg_n_0_[7] ;
  wire \q_out_d[0]_i_1__1_n_0 ;
  wire \q_out_d[1]_i_1__1_n_0 ;
  wire \q_out_d[2]_i_1__1_n_0 ;
  wire \q_out_d[3]_i_1__1_n_0 ;
  wire \q_out_d[4]_i_1__1_n_0 ;
  wire \q_out_d[5]_i_1__1_n_0 ;
  wire \q_out_d[6]_i_1__1_n_0 ;
  wire \q_out_d[7]_i_1__1_n_0 ;
  wire \q_out_d[9]_i_1__1_n_0 ;

  LUT5 #(
    .INIT(32'h96666696)) 
    \cnt_t_1[1]_i_1__0 
       (.I0(\cnt_t_1[1]_i_2__0_n_0 ),
        .I1(cnt_t_1[1]),
        .I2(\cnt_t_1[4]_i_4__0_n_0 ),
        .I3(\cnt_t_1[1]_i_3__0_n_0 ),
        .I4(\q_m_d[8]_i_1__0_n_0 ),
        .O(cnt_t[1]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \cnt_t_1[1]_i_2__0 
       (.I0(\n1_q_m_reg_n_0_[1] ),
        .I1(\n0_q_m_reg_n_0_[1] ),
        .O(\cnt_t_1[1]_i_2__0_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE00FFFFFE00)) 
    \cnt_t_1[1]_i_3__0 
       (.I0(cnt_t_1[2]),
        .I1(cnt_t_1[1]),
        .I2(cnt_t_1[3]),
        .I3(\cnt_t_1[4]_i_2__0_n_0 ),
        .I4(cnt_t_1[4]),
        .I5(\cnt_t_1[1]_i_4_n_0 ),
        .O(\cnt_t_1[1]_i_3__0_n_0 ));
  LUT6 #(
    .INIT(64'hDD4D4D44DD4DDD4D)) 
    \cnt_t_1[1]_i_4 
       (.I0(\n0_q_m_reg_n_0_[3] ),
        .I1(\n1_q_m_reg_n_0_[3] ),
        .I2(\n0_q_m_reg_n_0_[2] ),
        .I3(\n1_q_m_reg_n_0_[2] ),
        .I4(\n1_q_m_reg_n_0_[1] ),
        .I5(\n0_q_m_reg_n_0_[1] ),
        .O(\cnt_t_1[1]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h2DD2D22DD22D2DD2)) 
    \cnt_t_1[2]_i_1__0 
       (.I0(\n1_q_m_reg_n_0_[1] ),
        .I1(\n0_q_m_reg_n_0_[1] ),
        .I2(\n0_q_m_reg_n_0_[2] ),
        .I3(\n1_q_m_reg_n_0_[2] ),
        .I4(cnt_t_1[2]),
        .I5(\cnt_t_1[2]_i_2__0_n_0 ),
        .O(cnt_t[2]));
  LUT6 #(
    .INIT(64'hD0BF8010D0B08010)) 
    \cnt_t_1[2]_i_2__0 
       (.I0(\q_m_d[8]_i_1__0_n_0 ),
        .I1(\cnt_t_1[1]_i_3__0_n_0 ),
        .I2(\cnt_t_1[4]_i_4__0_n_0 ),
        .I3(cnt_t_1[1]),
        .I4(\cnt_t_1[1]_i_2__0_n_0 ),
        .I5(p_0_in),
        .O(\cnt_t_1[2]_i_2__0_n_0 ));
  LUT3 #(
    .INIT(8'h96)) 
    \cnt_t_1[3]_i_1__0 
       (.I0(\cnt_t_1[3]_i_2__0_n_0 ),
        .I1(cnt_t_1[3]),
        .I2(\cnt_t_1[3]_i_3__1_n_0 ),
        .O(cnt_t[3]));
  LUT6 #(
    .INIT(64'h2F02D0FDD0FD2F02)) 
    \cnt_t_1[3]_i_2__0 
       (.I0(\n1_q_m_reg_n_0_[1] ),
        .I1(\n0_q_m_reg_n_0_[1] ),
        .I2(\n0_q_m_reg_n_0_[2] ),
        .I3(\n1_q_m_reg_n_0_[2] ),
        .I4(\n1_q_m_reg_n_0_[3] ),
        .I5(\n0_q_m_reg_n_0_[3] ),
        .O(\cnt_t_1[3]_i_2__0_n_0 ));
  LUT6 #(
    .INIT(64'h20ECECEC20EC2020)) 
    \cnt_t_1[3]_i_3__1 
       (.I0(p_0_in),
        .I1(\cnt_t_1[4]_i_4__0_n_0 ),
        .I2(\cnt_t_1[3]_i_4__0_n_0 ),
        .I3(\cnt_t_1[4]_i_8_n_0 ),
        .I4(\cnt_t_1[1]_i_3__0_n_0 ),
        .I5(\cnt_t_1[4]_i_9_n_0 ),
        .O(\cnt_t_1[3]_i_3__1_n_0 ));
  LUT6 #(
    .INIT(64'h0000696609606FF6)) 
    \cnt_t_1[3]_i_4__0 
       (.I0(\n1_q_m_reg_n_0_[2] ),
        .I1(\n0_q_m_reg_n_0_[2] ),
        .I2(\n0_q_m_reg_n_0_[1] ),
        .I3(\n1_q_m_reg_n_0_[1] ),
        .I4(cnt_t_1[2]),
        .I5(cnt_t_1[1]),
        .O(\cnt_t_1[3]_i_4__0_n_0 ));
  LUT6 #(
    .INIT(64'h9999966666666666)) 
    \cnt_t_1[4]_i_1__0 
       (.I0(cnt_t_1[4]),
        .I1(\cnt_t_1[4]_i_2__0_n_0 ),
        .I2(\cnt_t_1[4]_i_3__0_n_0 ),
        .I3(p_0_in),
        .I4(\cnt_t_1[4]_i_4__0_n_0 ),
        .I5(\cnt_t_1[4]_i_5_n_0 ),
        .O(cnt_t[4]));
  LUT6 #(
    .INIT(64'h22B2B2BB22B222B2)) 
    \cnt_t_1[4]_i_2__0 
       (.I0(\n1_q_m_reg_n_0_[3] ),
        .I1(\n0_q_m_reg_n_0_[3] ),
        .I2(\n1_q_m_reg_n_0_[2] ),
        .I3(\n0_q_m_reg_n_0_[2] ),
        .I4(\n0_q_m_reg_n_0_[1] ),
        .I5(\n1_q_m_reg_n_0_[1] ),
        .O(\cnt_t_1[4]_i_2__0_n_0 ));
  LUT6 #(
    .INIT(64'h11710000FFFF1171)) 
    \cnt_t_1[4]_i_3__0 
       (.I0(\cnt_t_1[4]_i_6__1_n_0 ),
        .I1(cnt_t_1[2]),
        .I2(\cnt_t_1[1]_i_2__0_n_0 ),
        .I3(cnt_t_1[1]),
        .I4(\cnt_t_1[3]_i_2__0_n_0 ),
        .I5(cnt_t_1[3]),
        .O(\cnt_t_1[4]_i_3__0_n_0 ));
  LUT5 #(
    .INIT(32'h0000FFFE)) 
    \cnt_t_1[4]_i_4__0 
       (.I0(cnt_t_1[4]),
        .I1(cnt_t_1[3]),
        .I2(cnt_t_1[1]),
        .I3(cnt_t_1[2]),
        .I4(\cnt_t_1[4]_i_7__0_n_0 ),
        .O(\cnt_t_1[4]_i_4__0_n_0 ));
  LUT6 #(
    .INIT(64'hFF777733F3FF33F3)) 
    \cnt_t_1[4]_i_5 
       (.I0(\cnt_t_1[4]_i_8_n_0 ),
        .I1(\cnt_t_1[4]_i_4__0_n_0 ),
        .I2(\cnt_t_1[4]_i_9_n_0 ),
        .I3(cnt_t_1[3]),
        .I4(\cnt_t_1[3]_i_2__0_n_0 ),
        .I5(\cnt_t_1[1]_i_3__0_n_0 ),
        .O(\cnt_t_1[4]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT4 #(
    .INIT(16'hD22D)) 
    \cnt_t_1[4]_i_6__1 
       (.I0(\n1_q_m_reg_n_0_[1] ),
        .I1(\n0_q_m_reg_n_0_[1] ),
        .I2(\n0_q_m_reg_n_0_[2] ),
        .I3(\n1_q_m_reg_n_0_[2] ),
        .O(\cnt_t_1[4]_i_6__1_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \cnt_t_1[4]_i_7__0 
       (.I0(\n1_q_m_reg_n_0_[3] ),
        .I1(\n0_q_m_reg_n_0_[3] ),
        .I2(\n1_q_m_reg_n_0_[1] ),
        .I3(\n0_q_m_reg_n_0_[1] ),
        .I4(\n1_q_m_reg_n_0_[2] ),
        .I5(\n0_q_m_reg_n_0_[2] ),
        .O(\cnt_t_1[4]_i_7__0_n_0 ));
  LUT6 #(
    .INIT(64'h71170000FFFF7117)) 
    \cnt_t_1[4]_i_8 
       (.I0(\q_m_d[8]_i_1__0_n_0 ),
        .I1(cnt_t_1[1]),
        .I2(\n0_q_m_reg_n_0_[1] ),
        .I3(\n1_q_m_reg_n_0_[1] ),
        .I4(\cnt_t_1[4]_i_6__1_n_0 ),
        .I5(cnt_t_1[2]),
        .O(\cnt_t_1[4]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h1117171117777717)) 
    \cnt_t_1[4]_i_9 
       (.I0(cnt_t_1[2]),
        .I1(\cnt_t_1[4]_i_6__1_n_0 ),
        .I2(cnt_t_1[1]),
        .I3(\n0_q_m_reg_n_0_[1] ),
        .I4(\n1_q_m_reg_n_0_[1] ),
        .I5(\q_m_d[8]_i_1__0_n_0 ),
        .O(\cnt_t_1[4]_i_9_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_t_1_reg[1] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(cnt_t[1]),
        .Q(cnt_t_1[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_t_1_reg[2] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(cnt_t[2]),
        .Q(cnt_t_1[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_t_1_reg[3] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(cnt_t[3]),
        .Q(cnt_t_1[3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_t_1_reg[4] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(cnt_t[4]),
        .Q(cnt_t_1[4]),
        .R(SR));
  FDRE \d_d_reg[0] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_RGB[0]),
        .Q(\d_d_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \d_d_reg[1] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_RGB[1]),
        .Q(\d_d_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \d_d_reg[2] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_RGB[2]),
        .Q(p_0_in0_in),
        .R(1'b0));
  FDRE \d_d_reg[3] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_RGB[3]),
        .Q(p_0_in2_in),
        .R(1'b0));
  FDRE \d_d_reg[4] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_RGB[4]),
        .Q(p_0_in4_in),
        .R(1'b0));
  FDRE \d_d_reg[5] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_RGB[5]),
        .Q(p_0_in6_in),
        .R(1'b0));
  FDRE \d_d_reg[6] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_RGB[6]),
        .Q(p_0_in8_in),
        .R(1'b0));
  FDRE \d_d_reg[7] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_RGB[7]),
        .Q(p_0_in10_in),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h9996699969996669)) 
    \n0_q_m[1]_i_1 
       (.I0(\n0_q_m[3]_i_2_n_0 ),
        .I1(\n0_q_m[3]_i_3__0_n_0 ),
        .I2(\q_m_d[7]_i_1_n_0 ),
        .I3(\d_d_reg_n_0_[0] ),
        .I4(\n0_q_m[3]_i_4__0_n_0 ),
        .I5(\n0_q_m[3]_i_5__1_n_0 ),
        .O(\n0_q_m[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00088EEF8EEFFFF7)) 
    \n0_q_m[2]_i_1__0 
       (.I0(\n0_q_m[3]_i_5__1_n_0 ),
        .I1(\n0_q_m[3]_i_4__0_n_0 ),
        .I2(\d_d_reg_n_0_[0] ),
        .I3(\q_m_d[7]_i_1_n_0 ),
        .I4(\n0_q_m[3]_i_3__0_n_0 ),
        .I5(\n0_q_m[3]_i_2_n_0 ),
        .O(\n0_q_m[2]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h0001000000000000)) 
    \n0_q_m[3]_i_1__0 
       (.I0(\n0_q_m[3]_i_2_n_0 ),
        .I1(\n0_q_m[3]_i_3__0_n_0 ),
        .I2(\q_m_d[7]_i_1_n_0 ),
        .I3(\d_d_reg_n_0_[0] ),
        .I4(\n0_q_m[3]_i_4__0_n_0 ),
        .I5(\n0_q_m[3]_i_5__1_n_0 ),
        .O(\n0_q_m[3]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'hD22DB44B2DD24BB4)) 
    \n0_q_m[3]_i_2 
       (.I0(p_0_in6_in),
        .I1(p_0_in8_in),
        .I2(\n0_q_m[3]_i_6_n_0 ),
        .I3(\q_m_d[6]_i_2__0_n_0 ),
        .I4(\q_m_d[8]_i_1__0_n_0 ),
        .I5(p_0_in4_in),
        .O(\n0_q_m[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT5 #(
    .INIT(32'h4BB4D22D)) 
    \n0_q_m[3]_i_3__0 
       (.I0(\q_m_d[8]_i_1__0_n_0 ),
        .I1(p_0_in0_in),
        .I2(\d_d_reg_n_0_[0] ),
        .I3(\d_d_reg_n_0_[1] ),
        .I4(p_0_in2_in),
        .O(\n0_q_m[3]_i_3__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'h96696996)) 
    \n0_q_m[3]_i_4__0 
       (.I0(\n0_q_m[3]_i_7__0_n_0 ),
        .I1(p_0_in4_in),
        .I2(p_0_in2_in),
        .I3(p_0_in0_in),
        .I4(p_0_in8_in),
        .O(\n0_q_m[3]_i_4__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'h69)) 
    \n0_q_m[3]_i_5__1 
       (.I0(\d_d_reg_n_0_[1] ),
        .I1(\d_d_reg_n_0_[0] ),
        .I2(p_0_in2_in),
        .O(\n0_q_m[3]_i_5__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \n0_q_m[3]_i_6 
       (.I0(\d_d_reg_n_0_[1] ),
        .I1(\d_d_reg_n_0_[0] ),
        .O(\n0_q_m[3]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h55AA55AA66996A99)) 
    \n0_q_m[3]_i_7__0 
       (.I0(\d_d_reg_n_0_[1] ),
        .I1(n1_d[2]),
        .I2(n1_d[1]),
        .I3(\d_d_reg_n_0_[0] ),
        .I4(n1_d[0]),
        .I5(n1_d[3]),
        .O(\n0_q_m[3]_i_7__0_n_0 ));
  FDRE \n0_q_m_reg[1] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\n0_q_m[1]_i_1_n_0 ),
        .Q(\n0_q_m_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \n0_q_m_reg[2] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\n0_q_m[2]_i_1__0_n_0 ),
        .Q(\n0_q_m_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \n0_q_m_reg[3] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\n0_q_m[3]_i_1__0_n_0 ),
        .Q(\n0_q_m_reg_n_0_[3] ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \n1_d[0]_i_1 
       (.I0(VGA_RGB[0]),
        .I1(VGA_RGB[7]),
        .I2(\n1_d[0]_i_2_n_0 ),
        .I3(VGA_RGB[2]),
        .I4(VGA_RGB[1]),
        .I5(VGA_RGB[3]),
        .O(\n1_d[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \n1_d[0]_i_2 
       (.I0(VGA_RGB[6]),
        .I1(VGA_RGB[4]),
        .I2(VGA_RGB[5]),
        .O(\n1_d[0]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h96)) 
    \n1_d[1]_i_1 
       (.I0(\n1_d[3]_i_2_n_0 ),
        .I1(\n1_d[1]_i_2_n_0 ),
        .I2(\n1_d[3]_i_3_n_0 ),
        .O(\n1_d[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    \n1_d[1]_i_2 
       (.I0(VGA_RGB[3]),
        .I1(VGA_RGB[2]),
        .I2(VGA_RGB[1]),
        .I3(VGA_RGB[6]),
        .I4(VGA_RGB[5]),
        .I5(VGA_RGB[4]),
        .O(\n1_d[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7E7E7EE87EE8E8E8)) 
    \n1_d[2]_i_1 
       (.I0(\n1_d[3]_i_2_n_0 ),
        .I1(\n1_d[3]_i_3_n_0 ),
        .I2(\n1_d[2]_i_2_n_0 ),
        .I3(VGA_RGB[4]),
        .I4(VGA_RGB[5]),
        .I5(VGA_RGB[6]),
        .O(\n1_d[2]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hE8)) 
    \n1_d[2]_i_2 
       (.I0(VGA_RGB[1]),
        .I1(VGA_RGB[2]),
        .I2(VGA_RGB[3]),
        .O(\n1_d[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h8880800000000000)) 
    \n1_d[3]_i_1 
       (.I0(\n1_d[3]_i_2_n_0 ),
        .I1(\n1_d[3]_i_3_n_0 ),
        .I2(VGA_RGB[3]),
        .I3(VGA_RGB[2]),
        .I4(VGA_RGB[1]),
        .I5(\n1_d[3]_i_4_n_0 ),
        .O(\n1_d[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h9600009600969600)) 
    \n1_d[3]_i_2 
       (.I0(VGA_RGB[2]),
        .I1(VGA_RGB[1]),
        .I2(VGA_RGB[3]),
        .I3(VGA_RGB[0]),
        .I4(VGA_RGB[7]),
        .I5(\n1_d[0]_i_2_n_0 ),
        .O(\n1_d[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'hE88E8EE8)) 
    \n1_d[3]_i_3 
       (.I0(VGA_RGB[7]),
        .I1(VGA_RGB[0]),
        .I2(VGA_RGB[5]),
        .I3(VGA_RGB[4]),
        .I4(VGA_RGB[6]),
        .O(\n1_d[3]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'hE8)) 
    \n1_d[3]_i_4 
       (.I0(VGA_RGB[4]),
        .I1(VGA_RGB[5]),
        .I2(VGA_RGB[6]),
        .O(\n1_d[3]_i_4_n_0 ));
  FDRE \n1_d_reg[0] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\n1_d[0]_i_1_n_0 ),
        .Q(n1_d[0]),
        .R(1'b0));
  FDRE \n1_d_reg[1] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\n1_d[1]_i_1_n_0 ),
        .Q(n1_d[1]),
        .R(1'b0));
  FDRE \n1_d_reg[2] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\n1_d[2]_i_1_n_0 ),
        .Q(n1_d[2]),
        .R(1'b0));
  FDRE \n1_d_reg[3] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\n1_d[3]_i_1_n_0 ),
        .Q(n1_d[3]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hC39669C369C33C69)) 
    \n1_q_m[1]_i_1__0 
       (.I0(\n0_q_m[3]_i_5__1_n_0 ),
        .I1(\n0_q_m[3]_i_3__0_n_0 ),
        .I2(\n0_q_m[3]_i_2_n_0 ),
        .I3(\n0_q_m[3]_i_4__0_n_0 ),
        .I4(\q_m_d[7]_i_1_n_0 ),
        .I5(\d_d_reg_n_0_[0] ),
        .O(\n1_q_m[1]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'hEFFFF771F7711000)) 
    \n1_q_m[2]_i_1 
       (.I0(\n0_q_m[3]_i_5__1_n_0 ),
        .I1(\n0_q_m[3]_i_4__0_n_0 ),
        .I2(\d_d_reg_n_0_[0] ),
        .I3(\q_m_d[7]_i_1_n_0 ),
        .I4(\n0_q_m[3]_i_3__0_n_0 ),
        .I5(\n0_q_m[3]_i_2_n_0 ),
        .O(\n1_q_m[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00080000)) 
    \n1_q_m[3]_i_1 
       (.I0(\q_m_d[7]_i_1_n_0 ),
        .I1(\d_d_reg_n_0_[0] ),
        .I2(\n0_q_m[3]_i_4__0_n_0 ),
        .I3(\n0_q_m[3]_i_5__1_n_0 ),
        .I4(\n1_q_m[3]_i_2_n_0 ),
        .O(\n1_q_m[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h28820AA0A00A2882)) 
    \n1_q_m[3]_i_2 
       (.I0(\n0_q_m[3]_i_2_n_0 ),
        .I1(p_0_in2_in),
        .I2(\d_d_reg_n_0_[1] ),
        .I3(\d_d_reg_n_0_[0] ),
        .I4(p_0_in0_in),
        .I5(\q_m_d[8]_i_1__0_n_0 ),
        .O(\n1_q_m[3]_i_2_n_0 ));
  FDRE \n1_q_m_reg[1] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\n1_q_m[1]_i_1__0_n_0 ),
        .Q(\n1_q_m_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \n1_q_m_reg[2] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\n1_q_m[2]_i_1_n_0 ),
        .Q(\n1_q_m_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \n1_q_m_reg[3] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\n1_q_m[3]_i_1_n_0 ),
        .Q(\n1_q_m_reg_n_0_[3] ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hF0E0A5A50F1F5A5A)) 
    \q_m_d[1]_i_1__0 
       (.I0(n1_d[3]),
        .I1(n1_d[0]),
        .I2(\d_d_reg_n_0_[0] ),
        .I3(n1_d[1]),
        .I4(n1_d[2]),
        .I5(\d_d_reg_n_0_[1] ),
        .O(\q_m_d[1]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \q_m_d[2]_i_1__0 
       (.I0(p_0_in0_in),
        .I1(\d_d_reg_n_0_[0] ),
        .I2(\d_d_reg_n_0_[1] ),
        .O(\q_m_d[2]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT5 #(
    .INIT(32'h69969669)) 
    \q_m_d[3]_i_1 
       (.I0(\q_m_d[8]_i_1__0_n_0 ),
        .I1(p_0_in0_in),
        .I2(p_0_in2_in),
        .I3(\d_d_reg_n_0_[1] ),
        .I4(\d_d_reg_n_0_[0] ),
        .O(\q_m_d[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'h96696996)) 
    \q_m_d[4]_i_1__0 
       (.I0(p_0_in4_in),
        .I1(p_0_in2_in),
        .I2(p_0_in0_in),
        .I3(\d_d_reg_n_0_[1] ),
        .I4(\d_d_reg_n_0_[0] ),
        .O(\q_m_d[4]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h9669699669969669)) 
    \q_m_d[5]_i_1__0 
       (.I0(\d_d_reg_n_0_[0] ),
        .I1(\d_d_reg_n_0_[1] ),
        .I2(\q_m_d[6]_i_2__0_n_0 ),
        .I3(\q_m_d[8]_i_1__0_n_0 ),
        .I4(p_0_in4_in),
        .I5(p_0_in6_in),
        .O(\q_m_d[5]_i_1__0_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \q_m_d[6]_i_1__0 
       (.I0(p_0_in4_in),
        .I1(\q_m_d[6]_i_2__0_n_0 ),
        .I2(\d_d_reg_n_0_[1] ),
        .I3(\d_d_reg_n_0_[0] ),
        .I4(p_0_in8_in),
        .I5(p_0_in6_in),
        .O(\q_m_d[6]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \q_m_d[6]_i_2__0 
       (.I0(p_0_in0_in),
        .I1(p_0_in2_in),
        .O(\q_m_d[6]_i_2__0_n_0 ));
  LUT5 #(
    .INIT(32'h96696996)) 
    \q_m_d[7]_i_1 
       (.I0(\q_m_d[3]_i_1_n_0 ),
        .I1(p_0_in8_in),
        .I2(p_0_in10_in),
        .I3(p_0_in6_in),
        .I4(p_0_in4_in),
        .O(\q_m_d[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00105555)) 
    \q_m_d[8]_i_1__0 
       (.I0(n1_d[3]),
        .I1(n1_d[0]),
        .I2(\d_d_reg_n_0_[0] ),
        .I3(n1_d[1]),
        .I4(n1_d[2]),
        .O(\q_m_d[8]_i_1__0_n_0 ));
  FDRE \q_m_d_reg[0] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\d_d_reg_n_0_[0] ),
        .Q(\q_m_d_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \q_m_d_reg[1] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_m_d[1]_i_1__0_n_0 ),
        .Q(\q_m_d_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \q_m_d_reg[2] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_m_d[2]_i_1__0_n_0 ),
        .Q(\q_m_d_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \q_m_d_reg[3] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_m_d[3]_i_1_n_0 ),
        .Q(\q_m_d_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \q_m_d_reg[4] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_m_d[4]_i_1__0_n_0 ),
        .Q(\q_m_d_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \q_m_d_reg[5] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_m_d[5]_i_1__0_n_0 ),
        .Q(\q_m_d_reg_n_0_[5] ),
        .R(1'b0));
  FDRE \q_m_d_reg[6] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_m_d[6]_i_1__0_n_0 ),
        .Q(\q_m_d_reg_n_0_[6] ),
        .R(1'b0));
  FDRE \q_m_d_reg[7] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_m_d[7]_i_1_n_0 ),
        .Q(\q_m_d_reg_n_0_[7] ),
        .R(1'b0));
  FDRE \q_m_d_reg[8] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_m_d[8]_i_1__0_n_0 ),
        .Q(p_0_in),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'h0EF1)) 
    \q_out_d[0]_i_1__1 
       (.I0(p_0_in),
        .I1(\cnt_t_1[4]_i_4__0_n_0 ),
        .I2(\cnt_t_1[1]_i_3__0_n_0 ),
        .I3(\q_m_d_reg_n_0_[0] ),
        .O(\q_out_d[0]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'h0EF1)) 
    \q_out_d[1]_i_1__1 
       (.I0(p_0_in),
        .I1(\cnt_t_1[4]_i_4__0_n_0 ),
        .I2(\cnt_t_1[1]_i_3__0_n_0 ),
        .I3(\q_m_d_reg_n_0_[1] ),
        .O(\q_out_d[1]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'h0EF1)) 
    \q_out_d[2]_i_1__1 
       (.I0(p_0_in),
        .I1(\cnt_t_1[4]_i_4__0_n_0 ),
        .I2(\cnt_t_1[1]_i_3__0_n_0 ),
        .I3(\q_m_d_reg_n_0_[2] ),
        .O(\q_out_d[2]_i_1__1_n_0 ));
  LUT4 #(
    .INIT(16'h0EF1)) 
    \q_out_d[3]_i_1__1 
       (.I0(p_0_in),
        .I1(\cnt_t_1[4]_i_4__0_n_0 ),
        .I2(\cnt_t_1[1]_i_3__0_n_0 ),
        .I3(\q_m_d_reg_n_0_[3] ),
        .O(\q_out_d[3]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT4 #(
    .INIT(16'h0EF1)) 
    \q_out_d[4]_i_1__1 
       (.I0(p_0_in),
        .I1(\cnt_t_1[4]_i_4__0_n_0 ),
        .I2(\cnt_t_1[1]_i_3__0_n_0 ),
        .I3(\q_m_d_reg_n_0_[4] ),
        .O(\q_out_d[4]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'h0EF1)) 
    \q_out_d[5]_i_1__1 
       (.I0(p_0_in),
        .I1(\cnt_t_1[4]_i_4__0_n_0 ),
        .I2(\cnt_t_1[1]_i_3__0_n_0 ),
        .I3(\q_m_d_reg_n_0_[5] ),
        .O(\q_out_d[5]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT4 #(
    .INIT(16'h0EF1)) 
    \q_out_d[6]_i_1__1 
       (.I0(p_0_in),
        .I1(\cnt_t_1[4]_i_4__0_n_0 ),
        .I2(\cnt_t_1[1]_i_3__0_n_0 ),
        .I3(\q_m_d_reg_n_0_[6] ),
        .O(\q_out_d[6]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'h0EF1)) 
    \q_out_d[7]_i_1__1 
       (.I0(p_0_in),
        .I1(\cnt_t_1[4]_i_4__0_n_0 ),
        .I2(\cnt_t_1[1]_i_3__0_n_0 ),
        .I3(\q_m_d_reg_n_0_[7] ),
        .O(\q_out_d[7]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hF1)) 
    \q_out_d[9]_i_1__1 
       (.I0(p_0_in),
        .I1(\cnt_t_1[4]_i_4__0_n_0 ),
        .I2(\cnt_t_1[1]_i_3__0_n_0 ),
        .O(\q_out_d[9]_i_1__1_n_0 ));
  FDRE \q_out_d_reg[0] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[0]_i_1__1_n_0 ),
        .Q(Q[0]),
        .R(SR));
  FDRE \q_out_d_reg[1] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[1]_i_1__1_n_0 ),
        .Q(Q[1]),
        .R(SR));
  FDSE \q_out_d_reg[2] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[2]_i_1__1_n_0 ),
        .Q(Q[2]),
        .S(SR));
  FDRE \q_out_d_reg[3] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[3]_i_1__1_n_0 ),
        .Q(Q[3]),
        .R(SR));
  FDSE \q_out_d_reg[4] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[4]_i_1__1_n_0 ),
        .Q(Q[4]),
        .S(SR));
  FDRE \q_out_d_reg[5] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[5]_i_1__1_n_0 ),
        .Q(Q[5]),
        .R(SR));
  FDSE \q_out_d_reg[6] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[6]_i_1__1_n_0 ),
        .Q(Q[6]),
        .S(SR));
  FDRE \q_out_d_reg[7] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[7]_i_1__1_n_0 ),
        .Q(Q[7]),
        .R(SR));
  FDSE \q_out_d_reg[8] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(p_0_in),
        .Q(Q[8]),
        .S(SR));
  FDSE \q_out_d_reg[9] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[9]_i_1__1_n_0 ),
        .Q(Q[9]),
        .S(SR));
endmodule

(* ORIG_REF_NAME = "TMDSEncoder" *) 
module system_HDMI_FPGA_ML_0_0_TMDSEncoder_1
   (de_dd,
    SR,
    Q,
    VGA_DE,
    PXLCLK_I,
    VGA_RGB);
  output de_dd;
  output [0:0]SR;
  output [9:0]Q;
  input VGA_DE;
  input PXLCLK_I;
  input [7:0]VGA_RGB;

  wire PXLCLK_I;
  wire [9:0]Q;
  wire R0;
  wire [0:0]SR;
  wire VGA_DE;
  wire [7:0]VGA_RGB;
  wire [4:1]cnt_t;
  wire [4:1]cnt_t_1;
  wire \cnt_t_1[1]_i_2_n_0 ;
  wire \cnt_t_1[1]_i_3_n_0 ;
  wire \cnt_t_1[2]_i_2_n_0 ;
  wire \cnt_t_1[2]_i_3_n_0 ;
  wire \cnt_t_1[3]_i_2_n_0 ;
  wire \cnt_t_1[3]_i_3_n_0 ;
  wire \cnt_t_1[3]_i_4_n_0 ;
  wire \cnt_t_1[3]_i_5__0_n_0 ;
  wire \cnt_t_1[3]_i_6_n_0 ;
  wire \cnt_t_1[3]_i_7_n_0 ;
  wire \cnt_t_1[4]_i_10__0_n_0 ;
  wire \cnt_t_1[4]_i_11_n_0 ;
  wire \cnt_t_1[4]_i_12_n_0 ;
  wire \cnt_t_1[4]_i_3_n_0 ;
  wire \cnt_t_1[4]_i_4_n_0 ;
  wire \cnt_t_1[4]_i_5__1_n_0 ;
  wire \cnt_t_1[4]_i_6__0_n_0 ;
  wire \cnt_t_1[4]_i_7_n_0 ;
  wire \cnt_t_1[4]_i_8__0_n_0 ;
  wire \cnt_t_1[4]_i_9__1_n_0 ;
  wire \d_d_reg_n_0_[0] ;
  wire \d_d_reg_n_0_[1] ;
  wire de_d;
  wire de_dd;
  wire [3:1]int_n1_q_m;
  wire [3:1]n0_q_m;
  wire \n0_q_m[1]_i_1__1_n_0 ;
  wire \n0_q_m[1]_i_2_n_0 ;
  wire \n0_q_m[2]_i_1_n_0 ;
  wire \n0_q_m[3]_i_1_n_0 ;
  wire \n0_q_m[3]_i_2__0_n_0 ;
  wire \n0_q_m[3]_i_3_n_0 ;
  wire \n0_q_m[3]_i_4_n_0 ;
  wire \n0_q_m[3]_i_5_n_0 ;
  wire \n0_q_m[3]_i_6__1_n_0 ;
  wire \n0_q_m[3]_i_7_n_0 ;
  wire [3:0]n1_d;
  wire \n1_d[0]_i_2_n_0 ;
  wire \n1_d[1]_i_2_n_0 ;
  wire \n1_d[2]_i_2_n_0 ;
  wire \n1_d[3]_i_2_n_0 ;
  wire \n1_d[3]_i_3_n_0 ;
  wire \n1_d[3]_i_4_n_0 ;
  wire [3:1]n1_q_m;
  wire \n1_q_m[3]_i_2__1_n_0 ;
  wire p_0_in;
  wire p_0_in0_in;
  wire p_0_in10_in;
  wire p_0_in2_in;
  wire p_0_in4_in;
  wire p_0_in6_in;
  wire p_0_in8_in;
  wire [3:0]plusOp6_out;
  wire \q_m_d[1]_i_1_n_0 ;
  wire \q_m_d[2]_i_1_n_0 ;
  wire \q_m_d[3]_i_1__1_n_0 ;
  wire \q_m_d[4]_i_1_n_0 ;
  wire \q_m_d[5]_i_1_n_0 ;
  wire \q_m_d[6]_i_1_n_0 ;
  wire \q_m_d[6]_i_2_n_0 ;
  wire \q_m_d[7]_i_1__1_n_0 ;
  wire \q_m_d[7]_i_2_n_0 ;
  wire \q_m_d[7]_i_3_n_0 ;
  wire \q_m_d_reg_n_0_[0] ;
  wire \q_m_d_reg_n_0_[1] ;
  wire \q_m_d_reg_n_0_[2] ;
  wire \q_m_d_reg_n_0_[3] ;
  wire \q_m_d_reg_n_0_[4] ;
  wire \q_m_d_reg_n_0_[5] ;
  wire \q_m_d_reg_n_0_[6] ;
  wire \q_m_d_reg_n_0_[7] ;
  wire [6:2]q_out0_in;
  wire \q_out_d[0]_i_1__0_n_0 ;
  wire \q_out_d[1]_i_1__0_n_0 ;
  wire \q_out_d[3]_i_1__0_n_0 ;
  wire \q_out_d[5]_i_1__0_n_0 ;
  wire \q_out_d[7]_i_1__0_n_0 ;
  wire \q_out_d[9]_i_1__0_n_0 ;

  LUT6 #(
    .INIT(64'h6996966996969696)) 
    \cnt_t_1[1]_i_1 
       (.I0(n1_q_m[1]),
        .I1(n0_q_m[1]),
        .I2(cnt_t_1[1]),
        .I3(\q_m_d[7]_i_2_n_0 ),
        .I4(\cnt_t_1[1]_i_2_n_0 ),
        .I5(\cnt_t_1[4]_i_4_n_0 ),
        .O(cnt_t[1]));
  LUT6 #(
    .INIT(64'hBBBBBBBB8888888B)) 
    \cnt_t_1[1]_i_2 
       (.I0(\cnt_t_1[1]_i_3_n_0 ),
        .I1(cnt_t_1[4]),
        .I2(cnt_t_1[2]),
        .I3(cnt_t_1[1]),
        .I4(cnt_t_1[3]),
        .I5(\cnt_t_1[4]_i_10__0_n_0 ),
        .O(\cnt_t_1[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hDD4D4D44DD4DDD4D)) 
    \cnt_t_1[1]_i_3 
       (.I0(n0_q_m[3]),
        .I1(n1_q_m[3]),
        .I2(n0_q_m[2]),
        .I3(n1_q_m[2]),
        .I4(n1_q_m[1]),
        .I5(n0_q_m[1]),
        .O(\cnt_t_1[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h4BB4B44BB44B4BB4)) 
    \cnt_t_1[2]_i_1 
       (.I0(n0_q_m[1]),
        .I1(n1_q_m[1]),
        .I2(n0_q_m[2]),
        .I3(n1_q_m[2]),
        .I4(cnt_t_1[2]),
        .I5(\cnt_t_1[2]_i_2_n_0 ),
        .O(cnt_t[2]));
  LUT6 #(
    .INIT(64'hB0DF1080B0D01080)) 
    \cnt_t_1[2]_i_2 
       (.I0(\q_m_d[7]_i_2_n_0 ),
        .I1(\cnt_t_1[1]_i_2_n_0 ),
        .I2(\cnt_t_1[4]_i_4_n_0 ),
        .I3(cnt_t_1[1]),
        .I4(\cnt_t_1[2]_i_3_n_0 ),
        .I5(p_0_in),
        .O(\cnt_t_1[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \cnt_t_1[2]_i_3 
       (.I0(n1_q_m[1]),
        .I1(n0_q_m[1]),
        .O(\cnt_t_1[2]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h01F10DFD0EFE02F2)) 
    \cnt_t_1[3]_i_1 
       (.I0(\cnt_t_1[3]_i_2_n_0 ),
        .I1(p_0_in),
        .I2(\cnt_t_1[4]_i_4_n_0 ),
        .I3(\cnt_t_1[3]_i_3_n_0 ),
        .I4(\cnt_t_1[3]_i_4_n_0 ),
        .I5(\cnt_t_1[3]_i_5__0_n_0 ),
        .O(cnt_t[3]));
  LUT6 #(
    .INIT(64'h3820EF08EF083820)) 
    \cnt_t_1[3]_i_2 
       (.I0(cnt_t_1[1]),
        .I1(n0_q_m[1]),
        .I2(n1_q_m[1]),
        .I3(cnt_t_1[2]),
        .I4(n1_q_m[2]),
        .I5(n0_q_m[2]),
        .O(\cnt_t_1[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h4D004DFFB2FFB200)) 
    \cnt_t_1[3]_i_3 
       (.I0(\cnt_t_1[3]_i_6_n_0 ),
        .I1(\cnt_t_1[3]_i_7_n_0 ),
        .I2(cnt_t_1[2]),
        .I3(\cnt_t_1[1]_i_2_n_0 ),
        .I4(\cnt_t_1[4]_i_12_n_0 ),
        .I5(\cnt_t_1[3]_i_5__0_n_0 ),
        .O(\cnt_t_1[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h14144114147DD714)) 
    \cnt_t_1[3]_i_4 
       (.I0(cnt_t_1[2]),
        .I1(n1_q_m[2]),
        .I2(n0_q_m[2]),
        .I3(n1_q_m[1]),
        .I4(n0_q_m[1]),
        .I5(cnt_t_1[1]),
        .O(\cnt_t_1[3]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \cnt_t_1[3]_i_5__0 
       (.I0(cnt_t_1[3]),
        .I1(\cnt_t_1[4]_i_8__0_n_0 ),
        .O(\cnt_t_1[3]_i_5__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT4 #(
    .INIT(16'h82EB)) 
    \cnt_t_1[3]_i_6 
       (.I0(cnt_t_1[1]),
        .I1(n0_q_m[1]),
        .I2(n1_q_m[1]),
        .I3(\q_m_d[7]_i_2_n_0 ),
        .O(\cnt_t_1[3]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'h4BB4)) 
    \cnt_t_1[3]_i_7 
       (.I0(n0_q_m[1]),
        .I1(n1_q_m[1]),
        .I2(n0_q_m[2]),
        .I3(n1_q_m[2]),
        .O(\cnt_t_1[3]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \cnt_t_1[4]_i_1 
       (.I0(de_dd),
        .O(SR));
  LUT6 #(
    .INIT(64'hBB2BFFFF0000BB2B)) 
    \cnt_t_1[4]_i_10__0 
       (.I0(n0_q_m[2]),
        .I1(n1_q_m[2]),
        .I2(n1_q_m[1]),
        .I3(n0_q_m[1]),
        .I4(n1_q_m[3]),
        .I5(n0_q_m[3]),
        .O(\cnt_t_1[4]_i_10__0_n_0 ));
  LUT6 #(
    .INIT(64'h4DDDDD4D444D4D44)) 
    \cnt_t_1[4]_i_11 
       (.I0(cnt_t_1[2]),
        .I1(\cnt_t_1[3]_i_7_n_0 ),
        .I2(cnt_t_1[1]),
        .I3(n0_q_m[1]),
        .I4(n1_q_m[1]),
        .I5(\q_m_d[7]_i_2_n_0 ),
        .O(\cnt_t_1[4]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h2B03032B3F2B2B3F)) 
    \cnt_t_1[4]_i_12 
       (.I0(\q_m_d[7]_i_2_n_0 ),
        .I1(\cnt_t_1[3]_i_7_n_0 ),
        .I2(cnt_t_1[2]),
        .I3(n1_q_m[1]),
        .I4(n0_q_m[1]),
        .I5(cnt_t_1[1]),
        .O(\cnt_t_1[4]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'hF1FEFDF2010E0D02)) 
    \cnt_t_1[4]_i_2 
       (.I0(\cnt_t_1[4]_i_3_n_0 ),
        .I1(p_0_in),
        .I2(\cnt_t_1[4]_i_4_n_0 ),
        .I3(\cnt_t_1[4]_i_5__1_n_0 ),
        .I4(\cnt_t_1[4]_i_6__0_n_0 ),
        .I5(\cnt_t_1[4]_i_7_n_0 ),
        .O(cnt_t[4]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hE8)) 
    \cnt_t_1[4]_i_3 
       (.I0(\cnt_t_1[3]_i_2_n_0 ),
        .I1(\cnt_t_1[4]_i_8__0_n_0 ),
        .I2(cnt_t_1[3]),
        .O(\cnt_t_1[4]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h0000FFFE)) 
    \cnt_t_1[4]_i_4 
       (.I0(cnt_t_1[4]),
        .I1(cnt_t_1[3]),
        .I2(cnt_t_1[1]),
        .I3(cnt_t_1[2]),
        .I4(\cnt_t_1[4]_i_9__1_n_0 ),
        .O(\cnt_t_1[4]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \cnt_t_1[4]_i_5__1 
       (.I0(\cnt_t_1[4]_i_10__0_n_0 ),
        .I1(cnt_t_1[4]),
        .O(\cnt_t_1[4]_i_5__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'h8E)) 
    \cnt_t_1[4]_i_6__0 
       (.I0(\cnt_t_1[4]_i_8__0_n_0 ),
        .I1(\cnt_t_1[3]_i_4_n_0 ),
        .I2(cnt_t_1[3]),
        .O(\cnt_t_1[4]_i_6__0_n_0 ));
  LUT6 #(
    .INIT(64'h4B4B3C0FF0C37878)) 
    \cnt_t_1[4]_i_7 
       (.I0(\cnt_t_1[4]_i_11_n_0 ),
        .I1(\cnt_t_1[1]_i_2_n_0 ),
        .I2(\cnt_t_1[4]_i_5__1_n_0 ),
        .I3(\cnt_t_1[4]_i_12_n_0 ),
        .I4(cnt_t_1[3]),
        .I5(\cnt_t_1[4]_i_8__0_n_0 ),
        .O(\cnt_t_1[4]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h40F4BF0BBF0B40F4)) 
    \cnt_t_1[4]_i_8__0 
       (.I0(n0_q_m[1]),
        .I1(n1_q_m[1]),
        .I2(n1_q_m[2]),
        .I3(n0_q_m[2]),
        .I4(n1_q_m[3]),
        .I5(n0_q_m[3]),
        .O(\cnt_t_1[4]_i_8__0_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \cnt_t_1[4]_i_9__1 
       (.I0(n0_q_m[2]),
        .I1(n1_q_m[2]),
        .I2(n0_q_m[3]),
        .I3(n1_q_m[3]),
        .I4(n1_q_m[1]),
        .I5(n0_q_m[1]),
        .O(\cnt_t_1[4]_i_9__1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_t_1_reg[1] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(cnt_t[1]),
        .Q(cnt_t_1[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_t_1_reg[2] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(cnt_t[2]),
        .Q(cnt_t_1[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_t_1_reg[3] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(cnt_t[3]),
        .Q(cnt_t_1[3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \cnt_t_1_reg[4] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(cnt_t[4]),
        .Q(cnt_t_1[4]),
        .R(SR));
  FDRE \d_d_reg[0] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_RGB[0]),
        .Q(\d_d_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \d_d_reg[1] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_RGB[1]),
        .Q(\d_d_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \d_d_reg[2] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_RGB[2]),
        .Q(p_0_in0_in),
        .R(1'b0));
  FDRE \d_d_reg[3] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_RGB[3]),
        .Q(p_0_in2_in),
        .R(1'b0));
  FDRE \d_d_reg[4] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_RGB[4]),
        .Q(p_0_in4_in),
        .R(1'b0));
  FDRE \d_d_reg[5] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_RGB[5]),
        .Q(p_0_in6_in),
        .R(1'b0));
  FDRE \d_d_reg[6] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_RGB[6]),
        .Q(p_0_in8_in),
        .R(1'b0));
  FDRE \d_d_reg[7] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_RGB[7]),
        .Q(p_0_in10_in),
        .R(1'b0));
  FDRE de_d_reg
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(VGA_DE),
        .Q(de_d),
        .R(1'b0));
  FDRE de_dd_reg
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(de_d),
        .Q(de_dd),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT5 #(
    .INIT(32'h69969669)) 
    \n0_q_m[1]_i_1__1 
       (.I0(int_n1_q_m[1]),
        .I1(\n0_q_m[1]_i_2_n_0 ),
        .I2(\d_d_reg_n_0_[1] ),
        .I3(\d_d_reg_n_0_[0] ),
        .I4(p_0_in2_in),
        .O(\n0_q_m[1]_i_1__1_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \n0_q_m[1]_i_2 
       (.I0(\q_m_d[7]_i_1__1_n_0 ),
        .I1(\d_d_reg_n_0_[0] ),
        .I2(p_0_in8_in),
        .I3(\q_m_d[6]_i_2_n_0 ),
        .I4(p_0_in4_in),
        .I5(\n0_q_m[3]_i_6__1_n_0 ),
        .O(\n0_q_m[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h8EEFFFF700088EEF)) 
    \n0_q_m[2]_i_1 
       (.I0(\n0_q_m[3]_i_2__0_n_0 ),
        .I1(\n0_q_m[3]_i_3_n_0 ),
        .I2(\d_d_reg_n_0_[0] ),
        .I3(\q_m_d[7]_i_1__1_n_0 ),
        .I4(\n0_q_m[3]_i_4_n_0 ),
        .I5(\n0_q_m[3]_i_5_n_0 ),
        .O(\n0_q_m[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000800000000)) 
    \n0_q_m[3]_i_1 
       (.I0(\n0_q_m[3]_i_2__0_n_0 ),
        .I1(\n0_q_m[3]_i_3_n_0 ),
        .I2(\d_d_reg_n_0_[0] ),
        .I3(\q_m_d[7]_i_1__1_n_0 ),
        .I4(\n0_q_m[3]_i_4_n_0 ),
        .I5(\n0_q_m[3]_i_5_n_0 ),
        .O(\n0_q_m[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'h69)) 
    \n0_q_m[3]_i_2__0 
       (.I0(\d_d_reg_n_0_[1] ),
        .I1(\d_d_reg_n_0_[0] ),
        .I2(p_0_in2_in),
        .O(\n0_q_m[3]_i_2__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT5 #(
    .INIT(32'h96696996)) 
    \n0_q_m[3]_i_3 
       (.I0(\n0_q_m[3]_i_6__1_n_0 ),
        .I1(p_0_in4_in),
        .I2(p_0_in2_in),
        .I3(p_0_in0_in),
        .I4(p_0_in8_in),
        .O(\n0_q_m[3]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT5 #(
    .INIT(32'h8778E11E)) 
    \n0_q_m[3]_i_4 
       (.I0(\q_m_d[7]_i_2_n_0 ),
        .I1(p_0_in0_in),
        .I2(\d_d_reg_n_0_[0] ),
        .I3(\d_d_reg_n_0_[1] ),
        .I4(p_0_in2_in),
        .O(\n0_q_m[3]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h6699966969966699)) 
    \n0_q_m[3]_i_5 
       (.I0(\n0_q_m[3]_i_7_n_0 ),
        .I1(\q_m_d[6]_i_2_n_0 ),
        .I2(\q_m_d[7]_i_2_n_0 ),
        .I3(p_0_in4_in),
        .I4(p_0_in6_in),
        .I5(p_0_in8_in),
        .O(\n0_q_m[3]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h55AA55AA66996A99)) 
    \n0_q_m[3]_i_6__1 
       (.I0(\d_d_reg_n_0_[1] ),
        .I1(n1_d[2]),
        .I2(n1_d[1]),
        .I3(\d_d_reg_n_0_[0] ),
        .I4(n1_d[0]),
        .I5(n1_d[3]),
        .O(\n0_q_m[3]_i_6__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \n0_q_m[3]_i_7 
       (.I0(\d_d_reg_n_0_[1] ),
        .I1(\d_d_reg_n_0_[0] ),
        .O(\n0_q_m[3]_i_7_n_0 ));
  FDRE \n0_q_m_reg[1] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\n0_q_m[1]_i_1__1_n_0 ),
        .Q(n0_q_m[1]),
        .R(1'b0));
  FDRE \n0_q_m_reg[2] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\n0_q_m[2]_i_1_n_0 ),
        .Q(n0_q_m[2]),
        .R(1'b0));
  FDRE \n0_q_m_reg[3] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\n0_q_m[3]_i_1_n_0 ),
        .Q(n0_q_m[3]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \n1_d[0]_i_1 
       (.I0(VGA_RGB[0]),
        .I1(VGA_RGB[7]),
        .I2(\n1_d[0]_i_2_n_0 ),
        .I3(VGA_RGB[2]),
        .I4(VGA_RGB[1]),
        .I5(VGA_RGB[3]),
        .O(plusOp6_out[0]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \n1_d[0]_i_2 
       (.I0(VGA_RGB[6]),
        .I1(VGA_RGB[4]),
        .I2(VGA_RGB[5]),
        .O(\n1_d[0]_i_2_n_0 ));
  LUT3 #(
    .INIT(8'h96)) 
    \n1_d[1]_i_1 
       (.I0(\n1_d[3]_i_2_n_0 ),
        .I1(\n1_d[1]_i_2_n_0 ),
        .I2(\n1_d[3]_i_3_n_0 ),
        .O(plusOp6_out[1]));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    \n1_d[1]_i_2 
       (.I0(VGA_RGB[3]),
        .I1(VGA_RGB[2]),
        .I2(VGA_RGB[1]),
        .I3(VGA_RGB[6]),
        .I4(VGA_RGB[5]),
        .I5(VGA_RGB[4]),
        .O(\n1_d[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h7E7E7EE87EE8E8E8)) 
    \n1_d[2]_i_1 
       (.I0(\n1_d[3]_i_2_n_0 ),
        .I1(\n1_d[3]_i_3_n_0 ),
        .I2(\n1_d[2]_i_2_n_0 ),
        .I3(VGA_RGB[4]),
        .I4(VGA_RGB[5]),
        .I5(VGA_RGB[6]),
        .O(plusOp6_out[2]));
  LUT3 #(
    .INIT(8'hE8)) 
    \n1_d[2]_i_2 
       (.I0(VGA_RGB[1]),
        .I1(VGA_RGB[2]),
        .I2(VGA_RGB[3]),
        .O(\n1_d[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h8880800000000000)) 
    \n1_d[3]_i_1 
       (.I0(\n1_d[3]_i_2_n_0 ),
        .I1(\n1_d[3]_i_3_n_0 ),
        .I2(VGA_RGB[3]),
        .I3(VGA_RGB[2]),
        .I4(VGA_RGB[1]),
        .I5(\n1_d[3]_i_4_n_0 ),
        .O(plusOp6_out[3]));
  LUT6 #(
    .INIT(64'h9600009600969600)) 
    \n1_d[3]_i_2 
       (.I0(VGA_RGB[2]),
        .I1(VGA_RGB[1]),
        .I2(VGA_RGB[3]),
        .I3(VGA_RGB[0]),
        .I4(VGA_RGB[7]),
        .I5(\n1_d[0]_i_2_n_0 ),
        .O(\n1_d[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT5 #(
    .INIT(32'hE88E8EE8)) 
    \n1_d[3]_i_3 
       (.I0(VGA_RGB[7]),
        .I1(VGA_RGB[0]),
        .I2(VGA_RGB[5]),
        .I3(VGA_RGB[4]),
        .I4(VGA_RGB[6]),
        .O(\n1_d[3]_i_3_n_0 ));
  LUT3 #(
    .INIT(8'hE8)) 
    \n1_d[3]_i_4 
       (.I0(VGA_RGB[4]),
        .I1(VGA_RGB[5]),
        .I2(VGA_RGB[6]),
        .O(\n1_d[3]_i_4_n_0 ));
  FDRE \n1_d_reg[0] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(plusOp6_out[0]),
        .Q(n1_d[0]),
        .R(1'b0));
  FDRE \n1_d_reg[1] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(plusOp6_out[1]),
        .Q(n1_d[1]),
        .R(1'b0));
  FDRE \n1_d_reg[2] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(plusOp6_out[2]),
        .Q(n1_d[2]),
        .R(1'b0));
  FDRE \n1_d_reg[3] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(plusOp6_out[3]),
        .Q(n1_d[3]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h6696969969666696)) 
    \n1_q_m[1]_i_1 
       (.I0(\n0_q_m[3]_i_4_n_0 ),
        .I1(\n0_q_m[3]_i_5_n_0 ),
        .I2(\n0_q_m[3]_i_3_n_0 ),
        .I3(\q_m_d[7]_i_1__1_n_0 ),
        .I4(\d_d_reg_n_0_[0] ),
        .I5(\n0_q_m[3]_i_2__0_n_0 ),
        .O(int_n1_q_m[1]));
  LUT6 #(
    .INIT(64'hD4FDFFBF0040D4FD)) 
    \n1_q_m[2]_i_1__1 
       (.I0(\n0_q_m[3]_i_3_n_0 ),
        .I1(\q_m_d[7]_i_1__1_n_0 ),
        .I2(\d_d_reg_n_0_[0] ),
        .I3(\n0_q_m[3]_i_2__0_n_0 ),
        .I4(\n0_q_m[3]_i_5_n_0 ),
        .I5(\n0_q_m[3]_i_4_n_0 ),
        .O(int_n1_q_m[2]));
  LUT6 #(
    .INIT(64'h0000000000009000)) 
    \n1_q_m[3]_i_1__1 
       (.I0(\d_d_reg_n_0_[1] ),
        .I1(p_0_in2_in),
        .I2(\d_d_reg_n_0_[0] ),
        .I3(\q_m_d[7]_i_1__1_n_0 ),
        .I4(\n0_q_m[3]_i_3_n_0 ),
        .I5(\n1_q_m[3]_i_2__1_n_0 ),
        .O(int_n1_q_m[3]));
  LUT6 #(
    .INIT(64'hAFFAEBBEEBBEFAAF)) 
    \n1_q_m[3]_i_2__1 
       (.I0(\n0_q_m[3]_i_5_n_0 ),
        .I1(p_0_in2_in),
        .I2(\d_d_reg_n_0_[1] ),
        .I3(\d_d_reg_n_0_[0] ),
        .I4(p_0_in0_in),
        .I5(\q_m_d[7]_i_2_n_0 ),
        .O(\n1_q_m[3]_i_2__1_n_0 ));
  FDRE \n1_q_m_reg[1] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(int_n1_q_m[1]),
        .Q(n1_q_m[1]),
        .R(1'b0));
  FDRE \n1_q_m_reg[2] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(int_n1_q_m[2]),
        .Q(n1_q_m[2]),
        .R(1'b0));
  FDRE \n1_q_m_reg[3] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(int_n1_q_m[3]),
        .Q(n1_q_m[3]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hF0E0A5A50F1F5A5A)) 
    \q_m_d[1]_i_1 
       (.I0(n1_d[3]),
        .I1(n1_d[0]),
        .I2(\d_d_reg_n_0_[0] ),
        .I3(n1_d[1]),
        .I4(n1_d[2]),
        .I5(\d_d_reg_n_0_[1] ),
        .O(\q_m_d[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \q_m_d[2]_i_1 
       (.I0(p_0_in0_in),
        .I1(\d_d_reg_n_0_[0] ),
        .I2(\d_d_reg_n_0_[1] ),
        .O(\q_m_d[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT5 #(
    .INIT(32'h96696996)) 
    \q_m_d[3]_i_1__1 
       (.I0(\q_m_d[7]_i_2_n_0 ),
        .I1(p_0_in0_in),
        .I2(p_0_in2_in),
        .I3(\d_d_reg_n_0_[1] ),
        .I4(\d_d_reg_n_0_[0] ),
        .O(\q_m_d[3]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT5 #(
    .INIT(32'h96696996)) 
    \q_m_d[4]_i_1 
       (.I0(p_0_in4_in),
        .I1(p_0_in2_in),
        .I2(p_0_in0_in),
        .I3(\d_d_reg_n_0_[1] ),
        .I4(\d_d_reg_n_0_[0] ),
        .O(\q_m_d[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \q_m_d[5]_i_1 
       (.I0(\d_d_reg_n_0_[0] ),
        .I1(\d_d_reg_n_0_[1] ),
        .I2(\q_m_d[6]_i_2_n_0 ),
        .I3(\q_m_d[7]_i_2_n_0 ),
        .I4(p_0_in4_in),
        .I5(p_0_in6_in),
        .O(\q_m_d[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \q_m_d[6]_i_1 
       (.I0(p_0_in4_in),
        .I1(\q_m_d[6]_i_2_n_0 ),
        .I2(\d_d_reg_n_0_[1] ),
        .I3(\d_d_reg_n_0_[0] ),
        .I4(p_0_in8_in),
        .I5(p_0_in6_in),
        .O(\q_m_d[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \q_m_d[6]_i_2 
       (.I0(p_0_in0_in),
        .I1(p_0_in2_in),
        .O(\q_m_d[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h9669699669969669)) 
    \q_m_d[7]_i_1__1 
       (.I0(\q_m_d[7]_i_2_n_0 ),
        .I1(p_0_in4_in),
        .I2(p_0_in6_in),
        .I3(p_0_in10_in),
        .I4(p_0_in8_in),
        .I5(\q_m_d[7]_i_3_n_0 ),
        .O(\q_m_d[7]_i_1__1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT5 #(
    .INIT(32'hFFEFAAAA)) 
    \q_m_d[7]_i_2 
       (.I0(n1_d[3]),
        .I1(n1_d[0]),
        .I2(\d_d_reg_n_0_[0] ),
        .I3(n1_d[1]),
        .I4(n1_d[2]),
        .O(\q_m_d[7]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT4 #(
    .INIT(16'h9669)) 
    \q_m_d[7]_i_3 
       (.I0(\d_d_reg_n_0_[0] ),
        .I1(\d_d_reg_n_0_[1] ),
        .I2(p_0_in2_in),
        .I3(p_0_in0_in),
        .O(\q_m_d[7]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT5 #(
    .INIT(32'h00005575)) 
    \q_m_d[8]_i_1 
       (.I0(n1_d[2]),
        .I1(n1_d[1]),
        .I2(\d_d_reg_n_0_[0] ),
        .I3(n1_d[0]),
        .I4(n1_d[3]),
        .O(R0));
  FDRE \q_m_d_reg[0] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\d_d_reg_n_0_[0] ),
        .Q(\q_m_d_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \q_m_d_reg[1] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_m_d[1]_i_1_n_0 ),
        .Q(\q_m_d_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \q_m_d_reg[2] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_m_d[2]_i_1_n_0 ),
        .Q(\q_m_d_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \q_m_d_reg[3] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_m_d[3]_i_1__1_n_0 ),
        .Q(\q_m_d_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \q_m_d_reg[4] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_m_d[4]_i_1_n_0 ),
        .Q(\q_m_d_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \q_m_d_reg[5] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_m_d[5]_i_1_n_0 ),
        .Q(\q_m_d_reg_n_0_[5] ),
        .R(1'b0));
  FDRE \q_m_d_reg[6] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_m_d[6]_i_1_n_0 ),
        .Q(\q_m_d_reg_n_0_[6] ),
        .R(1'b0));
  FDRE \q_m_d_reg[7] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_m_d[7]_i_1__1_n_0 ),
        .Q(\q_m_d_reg_n_0_[7] ),
        .R(1'b0));
  FDRE \q_m_d_reg[8] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(R0),
        .Q(p_0_in),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT4 #(
    .INIT(16'hE01F)) 
    \q_out_d[0]_i_1__0 
       (.I0(p_0_in),
        .I1(\cnt_t_1[4]_i_4_n_0 ),
        .I2(\cnt_t_1[1]_i_2_n_0 ),
        .I3(\q_m_d_reg_n_0_[0] ),
        .O(\q_out_d[0]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT4 #(
    .INIT(16'hE01F)) 
    \q_out_d[1]_i_1__0 
       (.I0(p_0_in),
        .I1(\cnt_t_1[4]_i_4_n_0 ),
        .I2(\cnt_t_1[1]_i_2_n_0 ),
        .I3(\q_m_d_reg_n_0_[1] ),
        .O(\q_out_d[1]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT4 #(
    .INIT(16'hE01F)) 
    \q_out_d[2]_i_1__0 
       (.I0(p_0_in),
        .I1(\cnt_t_1[4]_i_4_n_0 ),
        .I2(\cnt_t_1[1]_i_2_n_0 ),
        .I3(\q_m_d_reg_n_0_[2] ),
        .O(q_out0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT4 #(
    .INIT(16'hE01F)) 
    \q_out_d[3]_i_1__0 
       (.I0(p_0_in),
        .I1(\cnt_t_1[4]_i_4_n_0 ),
        .I2(\cnt_t_1[1]_i_2_n_0 ),
        .I3(\q_m_d_reg_n_0_[3] ),
        .O(\q_out_d[3]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT4 #(
    .INIT(16'hE01F)) 
    \q_out_d[4]_i_1__0 
       (.I0(p_0_in),
        .I1(\cnt_t_1[4]_i_4_n_0 ),
        .I2(\cnt_t_1[1]_i_2_n_0 ),
        .I3(\q_m_d_reg_n_0_[4] ),
        .O(q_out0_in[4]));
  LUT4 #(
    .INIT(16'hE01F)) 
    \q_out_d[5]_i_1__0 
       (.I0(p_0_in),
        .I1(\cnt_t_1[4]_i_4_n_0 ),
        .I2(\cnt_t_1[1]_i_2_n_0 ),
        .I3(\q_m_d_reg_n_0_[5] ),
        .O(\q_out_d[5]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT4 #(
    .INIT(16'hE01F)) 
    \q_out_d[6]_i_1__0 
       (.I0(p_0_in),
        .I1(\cnt_t_1[4]_i_4_n_0 ),
        .I2(\cnt_t_1[1]_i_2_n_0 ),
        .I3(\q_m_d_reg_n_0_[6] ),
        .O(q_out0_in[6]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT4 #(
    .INIT(16'hE01F)) 
    \q_out_d[7]_i_1__0 
       (.I0(p_0_in),
        .I1(\cnt_t_1[4]_i_4_n_0 ),
        .I2(\cnt_t_1[1]_i_2_n_0 ),
        .I3(\q_m_d_reg_n_0_[7] ),
        .O(\q_out_d[7]_i_1__0_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'h1F)) 
    \q_out_d[9]_i_1__0 
       (.I0(p_0_in),
        .I1(\cnt_t_1[4]_i_4_n_0 ),
        .I2(\cnt_t_1[1]_i_2_n_0 ),
        .O(\q_out_d[9]_i_1__0_n_0 ));
  FDRE \q_out_d_reg[0] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[0]_i_1__0_n_0 ),
        .Q(Q[0]),
        .R(SR));
  FDRE \q_out_d_reg[1] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[1]_i_1__0_n_0 ),
        .Q(Q[1]),
        .R(SR));
  FDSE \q_out_d_reg[2] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(q_out0_in[2]),
        .Q(Q[2]),
        .S(SR));
  FDRE \q_out_d_reg[3] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[3]_i_1__0_n_0 ),
        .Q(Q[3]),
        .R(SR));
  FDSE \q_out_d_reg[4] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(q_out0_in[4]),
        .Q(Q[4]),
        .S(SR));
  FDRE \q_out_d_reg[5] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[5]_i_1__0_n_0 ),
        .Q(Q[5]),
        .R(SR));
  FDSE \q_out_d_reg[6] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(q_out0_in[6]),
        .Q(Q[6]),
        .S(SR));
  FDRE \q_out_d_reg[7] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[7]_i_1__0_n_0 ),
        .Q(Q[7]),
        .R(SR));
  FDSE \q_out_d_reg[8] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(p_0_in),
        .Q(Q[8]),
        .S(SR));
  FDSE \q_out_d_reg[9] 
       (.C(PXLCLK_I),
        .CE(1'b1),
        .D(\q_out_d[9]_i_1__0_n_0 ),
        .Q(Q[9]),
        .S(SR));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
