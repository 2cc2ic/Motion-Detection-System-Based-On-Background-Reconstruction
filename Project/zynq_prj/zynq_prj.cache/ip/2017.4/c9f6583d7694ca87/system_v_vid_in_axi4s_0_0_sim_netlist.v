// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Tue Nov 20 20:47:32 2018
// Host        : hubbery running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ system_v_vid_in_axi4s_0_0_sim_netlist.v
// Design      : system_v_vid_in_axi4s_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "system_v_vid_in_axi4s_0_0,v_vid_in_axi4s_v4_0_7,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* X_CORE_INFO = "v_vid_in_axi4s_v4_0_7,Vivado 2017.4" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (vid_io_in_clk,
    vid_io_in_ce,
    vid_io_in_reset,
    vid_active_video,
    vid_vblank,
    vid_hblank,
    vid_vsync,
    vid_hsync,
    vid_field_id,
    vid_data,
    aclk,
    aclken,
    aresetn,
    m_axis_video_tdata,
    m_axis_video_tvalid,
    m_axis_video_tready,
    m_axis_video_tuser,
    m_axis_video_tlast,
    fid,
    vtd_active_video,
    vtd_vblank,
    vtd_hblank,
    vtd_vsync,
    vtd_hsync,
    vtd_field_id,
    overflow,
    underflow,
    axis_enable);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 vid_io_in_clk_intf CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME vid_io_in_clk_intf, ASSOCIATED_BUSIF vid_io_in, FREQ_HZ 74250000, PHASE 0.000" *) input vid_io_in_clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clockenable:1.0 vid_io_in_ce_intf CE" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME vid_io_in_ce_intf, POLARITY ACTIVE_LOW" *) input vid_io_in_ce;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 vid_io_in_reset_intf RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME vid_io_in_reset_intf, POLARITY ACTIVE_HIGH" *) input vid_io_in_reset;
  (* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid_io_in ACTIVE_VIDEO" *) input vid_active_video;
  (* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid_io_in VBLANK" *) input vid_vblank;
  (* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid_io_in HBLANK" *) input vid_hblank;
  (* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid_io_in VSYNC" *) input vid_vsync;
  (* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid_io_in HSYNC" *) input vid_hsync;
  (* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid_io_in FIELD" *) input vid_field_id;
  (* X_INTERFACE_INFO = "xilinx.com:interface:vid_io:1.0 vid_io_in DATA" *) input [23:0]vid_data;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 aclk_intf CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME aclk_intf, ASSOCIATED_BUSIF video_out, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN system_processing_system7_0_0_FCLK_CLK0" *) input aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clockenable:1.0 aclken_intf CE" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME aclken_intf, POLARITY ACTIVE_LOW" *) input aclken;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 aresetn_intf RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME aresetn_intf, POLARITY ACTIVE_LOW" *) input aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 video_out TDATA" *) output [23:0]m_axis_video_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 video_out TVALID" *) output m_axis_video_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 video_out TREADY" *) input m_axis_video_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 video_out TUSER" *) output m_axis_video_tuser;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 video_out TLAST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME video_out, TDATA_NUM_BYTES 3, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 1, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN system_processing_system7_0_0_FCLK_CLK0, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {TDATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value xilinx.com:video:G_B_R_444:1.0} bitwidth {attribs {resolve_type automatic dependency {} format long minimum {} maximum {}} value 24} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} array_type {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value rows} size {attribs {resolve_type generated dependency active_rows format long minimum {} maximum {}} value 1} stride {attribs {resolve_type generated dependency active_rows_stride format long minimum {} maximum {}} value 24} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type automatic dependency {} format long minimum {} maximum {}} value 24} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} array_type {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value cols} size {attribs {resolve_type generated dependency active_cols format long minimum {} maximum {}} value 1} stride {attribs {resolve_type generated dependency active_cols_stride format long minimum {} maximum {}} value 24} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type automatic dependency {} format long minimum {} maximum {}} value 24} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} struct {field_G {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value G} enabled {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency video_data_width format long minimum {} maximum {}} value 8} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} integer {signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}} field_B {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value B} enabled {attribs {resolve_type generated dependency video_comp1_enabled format bool minimum {} maximum {}} value true} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency video_data_width format long minimum {} maximum {}} value 8} bitoffset {attribs {resolve_type generated dependency video_comp1_offset format long minimum {} maximum {}} value 8} integer {signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}} field_R {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value R} enabled {attribs {resolve_type generated dependency video_comp2_enabled format bool minimum {} maximum {}} value true} datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type generated dependency video_data_width format long minimum {} maximum {}} value 8} bitoffset {attribs {resolve_type generated dependency video_comp2_offset format long minimum {} maximum {}} value 16} integer {signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}}}}}} TDATA_WIDTH 24}" *) output m_axis_video_tlast;
  output fid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:video_timing:2.0 vtiming_out ACTIVE_VIDEO" *) output vtd_active_video;
  (* X_INTERFACE_INFO = "xilinx.com:interface:video_timing:2.0 vtiming_out VBLANK" *) output vtd_vblank;
  (* X_INTERFACE_INFO = "xilinx.com:interface:video_timing:2.0 vtiming_out HBLANK" *) output vtd_hblank;
  (* X_INTERFACE_INFO = "xilinx.com:interface:video_timing:2.0 vtiming_out VSYNC" *) output vtd_vsync;
  (* X_INTERFACE_INFO = "xilinx.com:interface:video_timing:2.0 vtiming_out HSYNC" *) output vtd_hsync;
  (* X_INTERFACE_INFO = "xilinx.com:interface:video_timing:2.0 vtiming_out FIELD" *) output vtd_field_id;
  output overflow;
  output underflow;
  input axis_enable;

  wire aclk;
  wire aclken;
  wire aresetn;
  wire axis_enable;
  wire fid;
  wire [23:0]m_axis_video_tdata;
  wire m_axis_video_tlast;
  wire m_axis_video_tready;
  wire m_axis_video_tuser;
  wire m_axis_video_tvalid;
  wire overflow;
  wire underflow;
  wire vid_active_video;
  wire [23:0]vid_data;
  wire vid_field_id;
  wire vid_hblank;
  wire vid_hsync;
  wire vid_io_in_ce;
  wire vid_io_in_clk;
  wire vid_io_in_reset;
  wire vid_vblank;
  wire vid_vsync;
  wire vtd_active_video;
  wire vtd_field_id;
  wire vtd_hblank;
  wire vtd_hsync;
  wire vtd_vblank;
  wire vtd_vsync;

  (* C_ADDR_WIDTH = "11" *) 
  (* C_ADDR_WIDTH_PIXEL_REMAP_420 = "10" *) 
  (* C_COMPONENTS_PER_PIXEL = "3" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_HAS_ASYNC_CLK = "1" *) 
  (* C_INCLUDE_PIXEL_DROP = "0" *) 
  (* C_INCLUDE_PIXEL_REMAP_420 = "0" *) 
  (* C_M_AXIS_COMPONENT_WIDTH = "8" *) 
  (* C_M_AXIS_TDATA_WIDTH = "24" *) 
  (* C_NATIVE_COMPONENT_WIDTH = "8" *) 
  (* C_NATIVE_DATA_WIDTH = "24" *) 
  (* C_PIXELS_PER_CLOCK = "1" *) 
  (* DowngradeIPIdentifiedWarnings = "yes" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_v_vid_in_axi4s_v4_0_7 inst
       (.aclk(aclk),
        .aclken(aclken),
        .aresetn(aresetn),
        .axis_enable(axis_enable),
        .drop_en(1'b0),
        .fid(fid),
        .m_axis_video_tdata(m_axis_video_tdata),
        .m_axis_video_tlast(m_axis_video_tlast),
        .m_axis_video_tready(m_axis_video_tready),
        .m_axis_video_tuser(m_axis_video_tuser),
        .m_axis_video_tvalid(m_axis_video_tvalid),
        .overflow(overflow),
        .remap_420_en(1'b0),
        .underflow(underflow),
        .vid_active_video(vid_active_video),
        .vid_data(vid_data),
        .vid_field_id(vid_field_id),
        .vid_hblank(vid_hblank),
        .vid_hsync(vid_hsync),
        .vid_io_in_ce(vid_io_in_ce),
        .vid_io_in_clk(vid_io_in_clk),
        .vid_io_in_reset(vid_io_in_reset),
        .vid_vblank(vid_vblank),
        .vid_vsync(vid_vsync),
        .vtd_active_video(vtd_active_video),
        .vtd_field_id(vtd_field_id),
        .vtd_hblank(vtd_hblank),
        .vtd_hsync(vtd_hsync),
        .vtd_vblank(vtd_vblank),
        .vtd_vsync(vtd_vsync));
endmodule

(* C_ADDR_WIDTH = "11" *) (* C_ADDR_WIDTH_PIXEL_REMAP_420 = "10" *) (* C_COMPONENTS_PER_PIXEL = "3" *) 
(* C_FAMILY = "zynq" *) (* C_HAS_ASYNC_CLK = "1" *) (* C_INCLUDE_PIXEL_DROP = "0" *) 
(* C_INCLUDE_PIXEL_REMAP_420 = "0" *) (* C_M_AXIS_COMPONENT_WIDTH = "8" *) (* C_M_AXIS_TDATA_WIDTH = "24" *) 
(* C_NATIVE_COMPONENT_WIDTH = "8" *) (* C_NATIVE_DATA_WIDTH = "24" *) (* C_PIXELS_PER_CLOCK = "1" *) 
(* DowngradeIPIdentifiedWarnings = "yes" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_v_vid_in_axi4s_v4_0_7
   (vid_io_in_clk,
    vid_io_in_ce,
    vid_io_in_reset,
    vid_active_video,
    vid_vblank,
    vid_hblank,
    vid_vsync,
    vid_hsync,
    vid_field_id,
    vid_data,
    aclk,
    aclken,
    aresetn,
    m_axis_video_tdata,
    m_axis_video_tvalid,
    m_axis_video_tready,
    m_axis_video_tuser,
    m_axis_video_tlast,
    fid,
    vtd_active_video,
    vtd_vblank,
    vtd_hblank,
    vtd_vsync,
    vtd_hsync,
    vtd_field_id,
    overflow,
    underflow,
    axis_enable,
    drop_en,
    remap_420_en);
  input vid_io_in_clk;
  input vid_io_in_ce;
  input vid_io_in_reset;
  input vid_active_video;
  input vid_vblank;
  input vid_hblank;
  input vid_vsync;
  input vid_hsync;
  input vid_field_id;
  input [23:0]vid_data;
  input aclk;
  input aclken;
  input aresetn;
  output [23:0]m_axis_video_tdata;
  output m_axis_video_tvalid;
  input m_axis_video_tready;
  output m_axis_video_tuser;
  output m_axis_video_tlast;
  output fid;
  output vtd_active_video;
  output vtd_vblank;
  output vtd_hblank;
  output vtd_vsync;
  output vtd_hsync;
  output vtd_field_id;
  output overflow;
  output underflow;
  input axis_enable;
  input drop_en;
  input remap_420_en;

  wire COUPLER_INST_n_30;
  wire COUPLER_INST_n_31;
  wire COUPLER_INST_n_32;
  wire COUPLER_INST_n_33;
  wire COUPLER_INST_n_34;
  wire COUPLER_INST_n_35;
  wire COUPLER_INST_n_36;
  wire COUPLER_INST_n_37;
  wire COUPLER_INST_n_38;
  wire COUPLER_INST_n_39;
  wire COUPLER_INST_n_40;
  wire COUPLER_INST_n_42;
  wire COUPLER_INST_n_43;
  wire COUPLER_INST_n_44;
  wire FORMATTER_INST_n_1;
  wire aclk;
  wire aclken;
  wire axis_enable;
  wire fid;
  wire [11:1]fifo_overflow_from_coupler_cnt0;
  wire \fifo_overflow_from_coupler_cnt[11]_i_3_n_0 ;
  wire \fifo_overflow_from_coupler_cnt[11]_i_4_n_0 ;
  wire \fifo_overflow_from_coupler_cnt[11]_i_6_n_0 ;
  wire \fifo_overflow_from_coupler_cnt[11]_i_7_n_0 ;
  wire \fifo_overflow_from_coupler_cnt[11]_i_8_n_0 ;
  wire \fifo_overflow_from_coupler_cnt[4]_i_3_n_0 ;
  wire \fifo_overflow_from_coupler_cnt[4]_i_4_n_0 ;
  wire \fifo_overflow_from_coupler_cnt[4]_i_5_n_0 ;
  wire \fifo_overflow_from_coupler_cnt[4]_i_6_n_0 ;
  wire \fifo_overflow_from_coupler_cnt[8]_i_3_n_0 ;
  wire \fifo_overflow_from_coupler_cnt[8]_i_4_n_0 ;
  wire \fifo_overflow_from_coupler_cnt[8]_i_5_n_0 ;
  wire \fifo_overflow_from_coupler_cnt[8]_i_6_n_0 ;
  wire \fifo_overflow_from_coupler_cnt_reg[11]_i_5_n_2 ;
  wire \fifo_overflow_from_coupler_cnt_reg[11]_i_5_n_3 ;
  wire \fifo_overflow_from_coupler_cnt_reg[4]_i_2_n_0 ;
  wire \fifo_overflow_from_coupler_cnt_reg[4]_i_2_n_1 ;
  wire \fifo_overflow_from_coupler_cnt_reg[4]_i_2_n_2 ;
  wire \fifo_overflow_from_coupler_cnt_reg[4]_i_2_n_3 ;
  wire \fifo_overflow_from_coupler_cnt_reg[8]_i_2_n_0 ;
  wire \fifo_overflow_from_coupler_cnt_reg[8]_i_2_n_1 ;
  wire \fifo_overflow_from_coupler_cnt_reg[8]_i_2_n_2 ;
  wire \fifo_overflow_from_coupler_cnt_reg[8]_i_2_n_3 ;
  wire \fifo_overflow_from_coupler_cnt_reg_n_0_[0] ;
  wire \fifo_overflow_from_coupler_cnt_reg_n_0_[10] ;
  wire \fifo_overflow_from_coupler_cnt_reg_n_0_[11] ;
  wire \fifo_overflow_from_coupler_cnt_reg_n_0_[1] ;
  wire \fifo_overflow_from_coupler_cnt_reg_n_0_[2] ;
  wire \fifo_overflow_from_coupler_cnt_reg_n_0_[3] ;
  wire \fifo_overflow_from_coupler_cnt_reg_n_0_[4] ;
  wire \fifo_overflow_from_coupler_cnt_reg_n_0_[5] ;
  wire \fifo_overflow_from_coupler_cnt_reg_n_0_[6] ;
  wire \fifo_overflow_from_coupler_cnt_reg_n_0_[7] ;
  wire \fifo_overflow_from_coupler_cnt_reg_n_0_[8] ;
  wire \fifo_overflow_from_coupler_cnt_reg_n_0_[9] ;
  wire fifo_overflow_from_coupler_pulse_reg_n_0;
  wire [26:0]idf_data;
  wire [23:0]m_axis_video_tdata;
  wire m_axis_video_tlast;
  wire m_axis_video_tready;
  wire m_axis_video_tuser;
  wire m_axis_video_tvalid;
  wire overflow;
  wire underflow;
  wire vid_active_video;
  wire [23:0]vid_data;
  wire vid_field_id;
  wire vid_hblank;
  wire vid_hsync;
  wire vid_io_in_ce;
  wire vid_io_in_clk;
  wire vid_io_in_reset;
  wire vid_vblank;
  wire vid_vsync;
  wire vtd_active_video;
  wire vtd_field_id;
  wire vtd_hblank;
  wire vtd_hsync;
  wire vtd_vblank;
  wire vtd_vsync;
  wire wr_en_i;
  wire wr_rst_busy_i;
  wire [3:2]\NLW_fifo_overflow_from_coupler_cnt_reg[11]_i_5_CO_UNCONNECTED ;
  wire [3:3]\NLW_fifo_overflow_from_coupler_cnt_reg[11]_i_5_O_UNCONNECTED ;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_v_vid_in_axi4s_v4_0_7_cdc_single__xdcDup__1 CDC_SINGLE_COUPLER_OVERFLOW_INST
       (.aclk(aclk),
        .fifo_overflow_from_coupler_pulse_reg(fifo_overflow_from_coupler_pulse_reg_n_0));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_v_vid_in_axi4s_v4_0_7_cdc_single CDC_SINGLE_REMAP_OVERFLOW_INST
       (.vid_io_in_clk(vid_io_in_clk));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_v_vid_in_axi4s_v4_0_7_coupler COUPLER_INST
       (.D(fifo_overflow_from_coupler_cnt0),
        .Q(\fifo_overflow_from_coupler_cnt_reg_n_0_[0] ),
        .aclk(aclk),
        .aclken(aclken),
        .din(idf_data),
        .dout({fid,m_axis_video_tuser,m_axis_video_tlast,m_axis_video_tdata}),
        .\fifo_overflow_from_coupler_cnt_reg[0] (COUPLER_INST_n_42),
        .\fifo_overflow_from_coupler_cnt_reg[0]_0 (COUPLER_INST_n_44),
        .\fifo_overflow_from_coupler_cnt_reg[10] (COUPLER_INST_n_31),
        .\fifo_overflow_from_coupler_cnt_reg[10]_0 (\fifo_overflow_from_coupler_cnt[11]_i_4_n_0 ),
        .\fifo_overflow_from_coupler_cnt_reg[11] (COUPLER_INST_n_30),
        .\fifo_overflow_from_coupler_cnt_reg[1] (COUPLER_INST_n_40),
        .\fifo_overflow_from_coupler_cnt_reg[2] (COUPLER_INST_n_39),
        .\fifo_overflow_from_coupler_cnt_reg[3] (COUPLER_INST_n_38),
        .\fifo_overflow_from_coupler_cnt_reg[4] (COUPLER_INST_n_37),
        .\fifo_overflow_from_coupler_cnt_reg[5] (COUPLER_INST_n_36),
        .\fifo_overflow_from_coupler_cnt_reg[5]_0 (\fifo_overflow_from_coupler_cnt[11]_i_3_n_0 ),
        .\fifo_overflow_from_coupler_cnt_reg[6] (COUPLER_INST_n_35),
        .\fifo_overflow_from_coupler_cnt_reg[7] (COUPLER_INST_n_34),
        .\fifo_overflow_from_coupler_cnt_reg[8] (COUPLER_INST_n_33),
        .\fifo_overflow_from_coupler_cnt_reg[9] (COUPLER_INST_n_32),
        .fifo_overflow_from_coupler_pulse_reg(COUPLER_INST_n_43),
        .fifo_overflow_from_coupler_pulse_reg_0(FORMATTER_INST_n_1),
        .fifo_overflow_from_coupler_pulse_reg_1(fifo_overflow_from_coupler_pulse_reg_n_0),
        .m_axis_video_tready(m_axis_video_tready),
        .m_axis_video_tvalid(m_axis_video_tvalid),
        .overflow(overflow),
        .underflow(underflow),
        .vid_io_in_ce(vid_io_in_ce),
        .vid_io_in_clk(vid_io_in_clk),
        .vid_io_in_reset(vid_io_in_reset),
        .wr_en(wr_en_i),
        .wr_rst_busy(wr_rst_busy_i));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_v_vid_in_axi4s_v4_0_7_formatter FORMATTER_INST
       (.axis_enable(axis_enable),
        .din(idf_data),
        .fifo_overflow_from_coupler_pulse_reg(fifo_overflow_from_coupler_pulse_reg_n_0),
        .v_blank_sync_2_reg_0(FORMATTER_INST_n_1),
        .vid_active_video(vid_active_video),
        .vid_data(vid_data),
        .vid_field_id(vid_field_id),
        .vid_hblank(vid_hblank),
        .vid_hsync(vid_hsync),
        .vid_io_in_ce(vid_io_in_ce),
        .vid_io_in_clk(vid_io_in_clk),
        .vid_io_in_reset(vid_io_in_reset),
        .vid_vblank(vid_vblank),
        .vid_vsync(vid_vsync),
        .vtd_active_video(vtd_active_video),
        .vtd_field_id(vtd_field_id),
        .vtd_hblank(vtd_hblank),
        .vtd_hsync(vtd_hsync),
        .vtd_vblank(vtd_vblank),
        .vtd_vsync(vtd_vsync),
        .wr_en(wr_en_i),
        .wr_rst_busy(wr_rst_busy_i));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \fifo_overflow_from_coupler_cnt[11]_i_3 
       (.I0(\fifo_overflow_from_coupler_cnt_reg_n_0_[5] ),
        .I1(\fifo_overflow_from_coupler_cnt_reg_n_0_[3] ),
        .I2(\fifo_overflow_from_coupler_cnt_reg_n_0_[4] ),
        .I3(\fifo_overflow_from_coupler_cnt_reg_n_0_[0] ),
        .I4(\fifo_overflow_from_coupler_cnt_reg_n_0_[1] ),
        .I5(\fifo_overflow_from_coupler_cnt_reg_n_0_[2] ),
        .O(\fifo_overflow_from_coupler_cnt[11]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \fifo_overflow_from_coupler_cnt[11]_i_4 
       (.I0(\fifo_overflow_from_coupler_cnt_reg_n_0_[10] ),
        .I1(\fifo_overflow_from_coupler_cnt_reg_n_0_[9] ),
        .I2(\fifo_overflow_from_coupler_cnt_reg_n_0_[11] ),
        .I3(\fifo_overflow_from_coupler_cnt_reg_n_0_[6] ),
        .I4(\fifo_overflow_from_coupler_cnt_reg_n_0_[7] ),
        .I5(\fifo_overflow_from_coupler_cnt_reg_n_0_[8] ),
        .O(\fifo_overflow_from_coupler_cnt[11]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \fifo_overflow_from_coupler_cnt[11]_i_6 
       (.I0(\fifo_overflow_from_coupler_cnt_reg_n_0_[11] ),
        .O(\fifo_overflow_from_coupler_cnt[11]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \fifo_overflow_from_coupler_cnt[11]_i_7 
       (.I0(\fifo_overflow_from_coupler_cnt_reg_n_0_[10] ),
        .O(\fifo_overflow_from_coupler_cnt[11]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \fifo_overflow_from_coupler_cnt[11]_i_8 
       (.I0(\fifo_overflow_from_coupler_cnt_reg_n_0_[9] ),
        .O(\fifo_overflow_from_coupler_cnt[11]_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \fifo_overflow_from_coupler_cnt[4]_i_3 
       (.I0(\fifo_overflow_from_coupler_cnt_reg_n_0_[4] ),
        .O(\fifo_overflow_from_coupler_cnt[4]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \fifo_overflow_from_coupler_cnt[4]_i_4 
       (.I0(\fifo_overflow_from_coupler_cnt_reg_n_0_[3] ),
        .O(\fifo_overflow_from_coupler_cnt[4]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \fifo_overflow_from_coupler_cnt[4]_i_5 
       (.I0(\fifo_overflow_from_coupler_cnt_reg_n_0_[2] ),
        .O(\fifo_overflow_from_coupler_cnt[4]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \fifo_overflow_from_coupler_cnt[4]_i_6 
       (.I0(\fifo_overflow_from_coupler_cnt_reg_n_0_[1] ),
        .O(\fifo_overflow_from_coupler_cnt[4]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \fifo_overflow_from_coupler_cnt[8]_i_3 
       (.I0(\fifo_overflow_from_coupler_cnt_reg_n_0_[8] ),
        .O(\fifo_overflow_from_coupler_cnt[8]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \fifo_overflow_from_coupler_cnt[8]_i_4 
       (.I0(\fifo_overflow_from_coupler_cnt_reg_n_0_[7] ),
        .O(\fifo_overflow_from_coupler_cnt[8]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \fifo_overflow_from_coupler_cnt[8]_i_5 
       (.I0(\fifo_overflow_from_coupler_cnt_reg_n_0_[6] ),
        .O(\fifo_overflow_from_coupler_cnt[8]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \fifo_overflow_from_coupler_cnt[8]_i_6 
       (.I0(\fifo_overflow_from_coupler_cnt_reg_n_0_[5] ),
        .O(\fifo_overflow_from_coupler_cnt[8]_i_6_n_0 ));
  FDRE \fifo_overflow_from_coupler_cnt_reg[0] 
       (.C(vid_io_in_clk),
        .CE(COUPLER_INST_n_44),
        .D(COUPLER_INST_n_42),
        .Q(\fifo_overflow_from_coupler_cnt_reg_n_0_[0] ),
        .R(vid_io_in_reset));
  FDRE \fifo_overflow_from_coupler_cnt_reg[10] 
       (.C(vid_io_in_clk),
        .CE(COUPLER_INST_n_44),
        .D(COUPLER_INST_n_31),
        .Q(\fifo_overflow_from_coupler_cnt_reg_n_0_[10] ),
        .R(vid_io_in_reset));
  FDRE \fifo_overflow_from_coupler_cnt_reg[11] 
       (.C(vid_io_in_clk),
        .CE(COUPLER_INST_n_44),
        .D(COUPLER_INST_n_30),
        .Q(\fifo_overflow_from_coupler_cnt_reg_n_0_[11] ),
        .R(vid_io_in_reset));
  CARRY4 \fifo_overflow_from_coupler_cnt_reg[11]_i_5 
       (.CI(\fifo_overflow_from_coupler_cnt_reg[8]_i_2_n_0 ),
        .CO({\NLW_fifo_overflow_from_coupler_cnt_reg[11]_i_5_CO_UNCONNECTED [3:2],\fifo_overflow_from_coupler_cnt_reg[11]_i_5_n_2 ,\fifo_overflow_from_coupler_cnt_reg[11]_i_5_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,\fifo_overflow_from_coupler_cnt_reg_n_0_[10] ,\fifo_overflow_from_coupler_cnt_reg_n_0_[9] }),
        .O({\NLW_fifo_overflow_from_coupler_cnt_reg[11]_i_5_O_UNCONNECTED [3],fifo_overflow_from_coupler_cnt0[11:9]}),
        .S({1'b0,\fifo_overflow_from_coupler_cnt[11]_i_6_n_0 ,\fifo_overflow_from_coupler_cnt[11]_i_7_n_0 ,\fifo_overflow_from_coupler_cnt[11]_i_8_n_0 }));
  FDRE \fifo_overflow_from_coupler_cnt_reg[1] 
       (.C(vid_io_in_clk),
        .CE(COUPLER_INST_n_44),
        .D(COUPLER_INST_n_40),
        .Q(\fifo_overflow_from_coupler_cnt_reg_n_0_[1] ),
        .R(vid_io_in_reset));
  FDRE \fifo_overflow_from_coupler_cnt_reg[2] 
       (.C(vid_io_in_clk),
        .CE(COUPLER_INST_n_44),
        .D(COUPLER_INST_n_39),
        .Q(\fifo_overflow_from_coupler_cnt_reg_n_0_[2] ),
        .R(vid_io_in_reset));
  FDRE \fifo_overflow_from_coupler_cnt_reg[3] 
       (.C(vid_io_in_clk),
        .CE(COUPLER_INST_n_44),
        .D(COUPLER_INST_n_38),
        .Q(\fifo_overflow_from_coupler_cnt_reg_n_0_[3] ),
        .R(vid_io_in_reset));
  FDRE \fifo_overflow_from_coupler_cnt_reg[4] 
       (.C(vid_io_in_clk),
        .CE(COUPLER_INST_n_44),
        .D(COUPLER_INST_n_37),
        .Q(\fifo_overflow_from_coupler_cnt_reg_n_0_[4] ),
        .R(vid_io_in_reset));
  CARRY4 \fifo_overflow_from_coupler_cnt_reg[4]_i_2 
       (.CI(1'b0),
        .CO({\fifo_overflow_from_coupler_cnt_reg[4]_i_2_n_0 ,\fifo_overflow_from_coupler_cnt_reg[4]_i_2_n_1 ,\fifo_overflow_from_coupler_cnt_reg[4]_i_2_n_2 ,\fifo_overflow_from_coupler_cnt_reg[4]_i_2_n_3 }),
        .CYINIT(\fifo_overflow_from_coupler_cnt_reg_n_0_[0] ),
        .DI({\fifo_overflow_from_coupler_cnt_reg_n_0_[4] ,\fifo_overflow_from_coupler_cnt_reg_n_0_[3] ,\fifo_overflow_from_coupler_cnt_reg_n_0_[2] ,\fifo_overflow_from_coupler_cnt_reg_n_0_[1] }),
        .O(fifo_overflow_from_coupler_cnt0[4:1]),
        .S({\fifo_overflow_from_coupler_cnt[4]_i_3_n_0 ,\fifo_overflow_from_coupler_cnt[4]_i_4_n_0 ,\fifo_overflow_from_coupler_cnt[4]_i_5_n_0 ,\fifo_overflow_from_coupler_cnt[4]_i_6_n_0 }));
  FDRE \fifo_overflow_from_coupler_cnt_reg[5] 
       (.C(vid_io_in_clk),
        .CE(COUPLER_INST_n_44),
        .D(COUPLER_INST_n_36),
        .Q(\fifo_overflow_from_coupler_cnt_reg_n_0_[5] ),
        .R(vid_io_in_reset));
  FDRE \fifo_overflow_from_coupler_cnt_reg[6] 
       (.C(vid_io_in_clk),
        .CE(COUPLER_INST_n_44),
        .D(COUPLER_INST_n_35),
        .Q(\fifo_overflow_from_coupler_cnt_reg_n_0_[6] ),
        .R(vid_io_in_reset));
  FDRE \fifo_overflow_from_coupler_cnt_reg[7] 
       (.C(vid_io_in_clk),
        .CE(COUPLER_INST_n_44),
        .D(COUPLER_INST_n_34),
        .Q(\fifo_overflow_from_coupler_cnt_reg_n_0_[7] ),
        .R(vid_io_in_reset));
  FDRE \fifo_overflow_from_coupler_cnt_reg[8] 
       (.C(vid_io_in_clk),
        .CE(COUPLER_INST_n_44),
        .D(COUPLER_INST_n_33),
        .Q(\fifo_overflow_from_coupler_cnt_reg_n_0_[8] ),
        .R(vid_io_in_reset));
  CARRY4 \fifo_overflow_from_coupler_cnt_reg[8]_i_2 
       (.CI(\fifo_overflow_from_coupler_cnt_reg[4]_i_2_n_0 ),
        .CO({\fifo_overflow_from_coupler_cnt_reg[8]_i_2_n_0 ,\fifo_overflow_from_coupler_cnt_reg[8]_i_2_n_1 ,\fifo_overflow_from_coupler_cnt_reg[8]_i_2_n_2 ,\fifo_overflow_from_coupler_cnt_reg[8]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({\fifo_overflow_from_coupler_cnt_reg_n_0_[8] ,\fifo_overflow_from_coupler_cnt_reg_n_0_[7] ,\fifo_overflow_from_coupler_cnt_reg_n_0_[6] ,\fifo_overflow_from_coupler_cnt_reg_n_0_[5] }),
        .O(fifo_overflow_from_coupler_cnt0[8:5]),
        .S({\fifo_overflow_from_coupler_cnt[8]_i_3_n_0 ,\fifo_overflow_from_coupler_cnt[8]_i_4_n_0 ,\fifo_overflow_from_coupler_cnt[8]_i_5_n_0 ,\fifo_overflow_from_coupler_cnt[8]_i_6_n_0 }));
  FDRE \fifo_overflow_from_coupler_cnt_reg[9] 
       (.C(vid_io_in_clk),
        .CE(COUPLER_INST_n_44),
        .D(COUPLER_INST_n_32),
        .Q(\fifo_overflow_from_coupler_cnt_reg_n_0_[9] ),
        .R(vid_io_in_reset));
  FDRE fifo_overflow_from_coupler_pulse_reg
       (.C(vid_io_in_clk),
        .CE(1'b1),
        .D(COUPLER_INST_n_43),
        .Q(fifo_overflow_from_coupler_pulse_reg_n_0),
        .R(1'b0));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_v_vid_in_axi4s_v4_0_7_cdc_single
   (vid_io_in_clk);
  input vid_io_in_clk;

  wire vid_io_in_clk;
  wire xpm_cdc_single_inst_n_0;

  (* DEST_SYNC_FF = "4" *) 
  (* INIT_SYNC_FF = "0" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* SRC_INPUT_REG = "0" *) 
  (* VERSION = "0" *) 
  (* XPM_CDC = "SINGLE" *) 
  (* XPM_MODULE = "TRUE" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_cdc_single xpm_cdc_single_inst
       (.dest_clk(vid_io_in_clk),
        .dest_out(xpm_cdc_single_inst_n_0),
        .src_clk(1'b0),
        .src_in(1'b0));
endmodule

(* ORIG_REF_NAME = "v_vid_in_axi4s_v4_0_7_cdc_single" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_v_vid_in_axi4s_v4_0_7_cdc_single__xdcDup__1
   (fifo_overflow_from_coupler_pulse_reg,
    aclk);
  input fifo_overflow_from_coupler_pulse_reg;
  input aclk;

  wire aclk;
  wire fifo_overflow_from_coupler_pulse_reg;
  wire fifo_overflow_from_coupler_sync;

  (* DEST_SYNC_FF = "4" *) 
  (* INIT_SYNC_FF = "0" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* SRC_INPUT_REG = "0" *) 
  (* VERSION = "0" *) 
  (* XPM_CDC = "SINGLE" *) 
  (* XPM_MODULE = "TRUE" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_cdc_single__2 xpm_cdc_single_inst
       (.dest_clk(aclk),
        .dest_out(fifo_overflow_from_coupler_sync),
        .src_clk(1'b0),
        .src_in(fifo_overflow_from_coupler_pulse_reg));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_v_vid_in_axi4s_v4_0_7_coupler
   (overflow,
    wr_rst_busy,
    dout,
    underflow,
    \fifo_overflow_from_coupler_cnt_reg[11] ,
    \fifo_overflow_from_coupler_cnt_reg[10] ,
    \fifo_overflow_from_coupler_cnt_reg[9] ,
    \fifo_overflow_from_coupler_cnt_reg[8] ,
    \fifo_overflow_from_coupler_cnt_reg[7] ,
    \fifo_overflow_from_coupler_cnt_reg[6] ,
    \fifo_overflow_from_coupler_cnt_reg[5] ,
    \fifo_overflow_from_coupler_cnt_reg[4] ,
    \fifo_overflow_from_coupler_cnt_reg[3] ,
    \fifo_overflow_from_coupler_cnt_reg[2] ,
    \fifo_overflow_from_coupler_cnt_reg[1] ,
    m_axis_video_tvalid,
    \fifo_overflow_from_coupler_cnt_reg[0] ,
    fifo_overflow_from_coupler_pulse_reg,
    \fifo_overflow_from_coupler_cnt_reg[0]_0 ,
    fifo_overflow_from_coupler_pulse_reg_0,
    vid_io_in_clk,
    wr_en,
    din,
    aclk,
    D,
    m_axis_video_tready,
    aclken,
    Q,
    \fifo_overflow_from_coupler_cnt_reg[5]_0 ,
    \fifo_overflow_from_coupler_cnt_reg[10]_0 ,
    fifo_overflow_from_coupler_pulse_reg_1,
    vid_io_in_ce,
    vid_io_in_reset);
  output overflow;
  output wr_rst_busy;
  output [26:0]dout;
  output underflow;
  output \fifo_overflow_from_coupler_cnt_reg[11] ;
  output \fifo_overflow_from_coupler_cnt_reg[10] ;
  output \fifo_overflow_from_coupler_cnt_reg[9] ;
  output \fifo_overflow_from_coupler_cnt_reg[8] ;
  output \fifo_overflow_from_coupler_cnt_reg[7] ;
  output \fifo_overflow_from_coupler_cnt_reg[6] ;
  output \fifo_overflow_from_coupler_cnt_reg[5] ;
  output \fifo_overflow_from_coupler_cnt_reg[4] ;
  output \fifo_overflow_from_coupler_cnt_reg[3] ;
  output \fifo_overflow_from_coupler_cnt_reg[2] ;
  output \fifo_overflow_from_coupler_cnt_reg[1] ;
  output m_axis_video_tvalid;
  output \fifo_overflow_from_coupler_cnt_reg[0] ;
  output fifo_overflow_from_coupler_pulse_reg;
  output \fifo_overflow_from_coupler_cnt_reg[0]_0 ;
  input fifo_overflow_from_coupler_pulse_reg_0;
  input vid_io_in_clk;
  input wr_en;
  input [26:0]din;
  input aclk;
  input [10:0]D;
  input m_axis_video_tready;
  input aclken;
  input [0:0]Q;
  input \fifo_overflow_from_coupler_cnt_reg[5]_0 ;
  input \fifo_overflow_from_coupler_cnt_reg[10]_0 ;
  input fifo_overflow_from_coupler_pulse_reg_1;
  input vid_io_in_ce;
  input vid_io_in_reset;

  wire [10:0]D;
  wire [0:0]Q;
  wire aclk;
  wire aclken;
  wire [26:0]din;
  wire [26:0]dout;
  wire \fifo_overflow_from_coupler_cnt_reg[0] ;
  wire \fifo_overflow_from_coupler_cnt_reg[0]_0 ;
  wire \fifo_overflow_from_coupler_cnt_reg[10] ;
  wire \fifo_overflow_from_coupler_cnt_reg[10]_0 ;
  wire \fifo_overflow_from_coupler_cnt_reg[11] ;
  wire \fifo_overflow_from_coupler_cnt_reg[1] ;
  wire \fifo_overflow_from_coupler_cnt_reg[2] ;
  wire \fifo_overflow_from_coupler_cnt_reg[3] ;
  wire \fifo_overflow_from_coupler_cnt_reg[4] ;
  wire \fifo_overflow_from_coupler_cnt_reg[5] ;
  wire \fifo_overflow_from_coupler_cnt_reg[5]_0 ;
  wire \fifo_overflow_from_coupler_cnt_reg[6] ;
  wire \fifo_overflow_from_coupler_cnt_reg[7] ;
  wire \fifo_overflow_from_coupler_cnt_reg[8] ;
  wire \fifo_overflow_from_coupler_cnt_reg[9] ;
  wire fifo_overflow_from_coupler_pulse_reg;
  wire fifo_overflow_from_coupler_pulse_reg_0;
  wire fifo_overflow_from_coupler_pulse_reg_1;
  wire m_axis_video_tready;
  wire m_axis_video_tvalid;
  wire overflow;
  wire underflow;
  wire vid_io_in_ce;
  wire vid_io_in_clk;
  wire vid_io_in_reset;
  wire wr_en;
  wire wr_rst_busy;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_v_vid_in_axi4s_v4_0_7_fifo_async \generate_async_fifo.FIFO_INST 
       (.D(D),
        .Q(Q),
        .aclk(aclk),
        .aclken(aclken),
        .din(din),
        .dout(dout),
        .\fifo_overflow_from_coupler_cnt_reg[0] (\fifo_overflow_from_coupler_cnt_reg[0] ),
        .\fifo_overflow_from_coupler_cnt_reg[0]_0 (\fifo_overflow_from_coupler_cnt_reg[0]_0 ),
        .\fifo_overflow_from_coupler_cnt_reg[10] (\fifo_overflow_from_coupler_cnt_reg[10] ),
        .\fifo_overflow_from_coupler_cnt_reg[10]_0 (\fifo_overflow_from_coupler_cnt_reg[10]_0 ),
        .\fifo_overflow_from_coupler_cnt_reg[11] (\fifo_overflow_from_coupler_cnt_reg[11] ),
        .\fifo_overflow_from_coupler_cnt_reg[1] (\fifo_overflow_from_coupler_cnt_reg[1] ),
        .\fifo_overflow_from_coupler_cnt_reg[2] (\fifo_overflow_from_coupler_cnt_reg[2] ),
        .\fifo_overflow_from_coupler_cnt_reg[3] (\fifo_overflow_from_coupler_cnt_reg[3] ),
        .\fifo_overflow_from_coupler_cnt_reg[4] (\fifo_overflow_from_coupler_cnt_reg[4] ),
        .\fifo_overflow_from_coupler_cnt_reg[5] (\fifo_overflow_from_coupler_cnt_reg[5] ),
        .\fifo_overflow_from_coupler_cnt_reg[5]_0 (\fifo_overflow_from_coupler_cnt_reg[5]_0 ),
        .\fifo_overflow_from_coupler_cnt_reg[6] (\fifo_overflow_from_coupler_cnt_reg[6] ),
        .\fifo_overflow_from_coupler_cnt_reg[7] (\fifo_overflow_from_coupler_cnt_reg[7] ),
        .\fifo_overflow_from_coupler_cnt_reg[8] (\fifo_overflow_from_coupler_cnt_reg[8] ),
        .\fifo_overflow_from_coupler_cnt_reg[9] (\fifo_overflow_from_coupler_cnt_reg[9] ),
        .fifo_overflow_from_coupler_pulse_reg(fifo_overflow_from_coupler_pulse_reg),
        .fifo_overflow_from_coupler_pulse_reg_0(fifo_overflow_from_coupler_pulse_reg_0),
        .fifo_overflow_from_coupler_pulse_reg_1(fifo_overflow_from_coupler_pulse_reg_1),
        .m_axis_video_tready(m_axis_video_tready),
        .m_axis_video_tvalid(m_axis_video_tvalid),
        .overflow(overflow),
        .underflow(underflow),
        .vid_io_in_ce(vid_io_in_ce),
        .vid_io_in_clk(vid_io_in_clk),
        .vid_io_in_reset(vid_io_in_reset),
        .wr_en(wr_en),
        .wr_rst_busy(wr_rst_busy));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_v_vid_in_axi4s_v4_0_7_fifo_async
   (overflow,
    wr_rst_busy,
    dout,
    underflow,
    \fifo_overflow_from_coupler_cnt_reg[11] ,
    \fifo_overflow_from_coupler_cnt_reg[10] ,
    \fifo_overflow_from_coupler_cnt_reg[9] ,
    \fifo_overflow_from_coupler_cnt_reg[8] ,
    \fifo_overflow_from_coupler_cnt_reg[7] ,
    \fifo_overflow_from_coupler_cnt_reg[6] ,
    \fifo_overflow_from_coupler_cnt_reg[5] ,
    \fifo_overflow_from_coupler_cnt_reg[4] ,
    \fifo_overflow_from_coupler_cnt_reg[3] ,
    \fifo_overflow_from_coupler_cnt_reg[2] ,
    \fifo_overflow_from_coupler_cnt_reg[1] ,
    m_axis_video_tvalid,
    \fifo_overflow_from_coupler_cnt_reg[0] ,
    fifo_overflow_from_coupler_pulse_reg,
    \fifo_overflow_from_coupler_cnt_reg[0]_0 ,
    fifo_overflow_from_coupler_pulse_reg_0,
    vid_io_in_clk,
    wr_en,
    din,
    aclk,
    D,
    m_axis_video_tready,
    aclken,
    Q,
    \fifo_overflow_from_coupler_cnt_reg[5]_0 ,
    \fifo_overflow_from_coupler_cnt_reg[10]_0 ,
    fifo_overflow_from_coupler_pulse_reg_1,
    vid_io_in_ce,
    vid_io_in_reset);
  output overflow;
  output wr_rst_busy;
  output [26:0]dout;
  output underflow;
  output \fifo_overflow_from_coupler_cnt_reg[11] ;
  output \fifo_overflow_from_coupler_cnt_reg[10] ;
  output \fifo_overflow_from_coupler_cnt_reg[9] ;
  output \fifo_overflow_from_coupler_cnt_reg[8] ;
  output \fifo_overflow_from_coupler_cnt_reg[7] ;
  output \fifo_overflow_from_coupler_cnt_reg[6] ;
  output \fifo_overflow_from_coupler_cnt_reg[5] ;
  output \fifo_overflow_from_coupler_cnt_reg[4] ;
  output \fifo_overflow_from_coupler_cnt_reg[3] ;
  output \fifo_overflow_from_coupler_cnt_reg[2] ;
  output \fifo_overflow_from_coupler_cnt_reg[1] ;
  output m_axis_video_tvalid;
  output \fifo_overflow_from_coupler_cnt_reg[0] ;
  output fifo_overflow_from_coupler_pulse_reg;
  output \fifo_overflow_from_coupler_cnt_reg[0]_0 ;
  input fifo_overflow_from_coupler_pulse_reg_0;
  input vid_io_in_clk;
  input wr_en;
  input [26:0]din;
  input aclk;
  input [10:0]D;
  input m_axis_video_tready;
  input aclken;
  input [0:0]Q;
  input \fifo_overflow_from_coupler_cnt_reg[5]_0 ;
  input \fifo_overflow_from_coupler_cnt_reg[10]_0 ;
  input fifo_overflow_from_coupler_pulse_reg_1;
  input vid_io_in_ce;
  input vid_io_in_reset;

  wire [10:0]D;
  wire [0:0]Q;
  wire aclk;
  wire aclken;
  wire [26:0]din;
  wire [26:0]dout;
  wire \fifo_overflow_from_coupler_cnt_reg[0] ;
  wire \fifo_overflow_from_coupler_cnt_reg[0]_0 ;
  wire \fifo_overflow_from_coupler_cnt_reg[10] ;
  wire \fifo_overflow_from_coupler_cnt_reg[10]_0 ;
  wire \fifo_overflow_from_coupler_cnt_reg[11] ;
  wire \fifo_overflow_from_coupler_cnt_reg[1] ;
  wire \fifo_overflow_from_coupler_cnt_reg[2] ;
  wire \fifo_overflow_from_coupler_cnt_reg[3] ;
  wire \fifo_overflow_from_coupler_cnt_reg[4] ;
  wire \fifo_overflow_from_coupler_cnt_reg[5] ;
  wire \fifo_overflow_from_coupler_cnt_reg[5]_0 ;
  wire \fifo_overflow_from_coupler_cnt_reg[6] ;
  wire \fifo_overflow_from_coupler_cnt_reg[7] ;
  wire \fifo_overflow_from_coupler_cnt_reg[8] ;
  wire \fifo_overflow_from_coupler_cnt_reg[9] ;
  wire fifo_overflow_from_coupler_pulse_reg;
  wire fifo_overflow_from_coupler_pulse_reg_0;
  wire fifo_overflow_from_coupler_pulse_reg_1;
  wire m_axis_video_tready;
  wire m_axis_video_tvalid;
  wire overflow;
  wire underflow;
  wire vid_io_in_ce;
  wire vid_io_in_clk;
  wire vid_io_in_reset;
  wire wr_en;
  wire wr_rst_busy;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_fifo_async XPM_FIFO_ASYNC_INST
       (.D(D),
        .Q(Q),
        .aclk(aclk),
        .aclken(aclken),
        .din(din),
        .dout(dout),
        .\fifo_overflow_from_coupler_cnt_reg[0] (\fifo_overflow_from_coupler_cnt_reg[0] ),
        .\fifo_overflow_from_coupler_cnt_reg[0]_0 (\fifo_overflow_from_coupler_cnt_reg[0]_0 ),
        .\fifo_overflow_from_coupler_cnt_reg[10] (\fifo_overflow_from_coupler_cnt_reg[10] ),
        .\fifo_overflow_from_coupler_cnt_reg[10]_0 (\fifo_overflow_from_coupler_cnt_reg[10]_0 ),
        .\fifo_overflow_from_coupler_cnt_reg[11] (\fifo_overflow_from_coupler_cnt_reg[11] ),
        .\fifo_overflow_from_coupler_cnt_reg[1] (\fifo_overflow_from_coupler_cnt_reg[1] ),
        .\fifo_overflow_from_coupler_cnt_reg[2] (\fifo_overflow_from_coupler_cnt_reg[2] ),
        .\fifo_overflow_from_coupler_cnt_reg[3] (\fifo_overflow_from_coupler_cnt_reg[3] ),
        .\fifo_overflow_from_coupler_cnt_reg[4] (\fifo_overflow_from_coupler_cnt_reg[4] ),
        .\fifo_overflow_from_coupler_cnt_reg[5] (\fifo_overflow_from_coupler_cnt_reg[5] ),
        .\fifo_overflow_from_coupler_cnt_reg[5]_0 (\fifo_overflow_from_coupler_cnt_reg[5]_0 ),
        .\fifo_overflow_from_coupler_cnt_reg[6] (\fifo_overflow_from_coupler_cnt_reg[6] ),
        .\fifo_overflow_from_coupler_cnt_reg[7] (\fifo_overflow_from_coupler_cnt_reg[7] ),
        .\fifo_overflow_from_coupler_cnt_reg[8] (\fifo_overflow_from_coupler_cnt_reg[8] ),
        .\fifo_overflow_from_coupler_cnt_reg[9] (\fifo_overflow_from_coupler_cnt_reg[9] ),
        .fifo_overflow_from_coupler_pulse_reg(fifo_overflow_from_coupler_pulse_reg),
        .fifo_overflow_from_coupler_pulse_reg_0(fifo_overflow_from_coupler_pulse_reg_0),
        .fifo_overflow_from_coupler_pulse_reg_1(fifo_overflow_from_coupler_pulse_reg_1),
        .m_axis_video_tready(m_axis_video_tready),
        .m_axis_video_tvalid(m_axis_video_tvalid),
        .overflow(overflow),
        .underflow(underflow),
        .vid_io_in_ce(vid_io_in_ce),
        .vid_io_in_clk(vid_io_in_clk),
        .vid_io_in_reset(vid_io_in_reset),
        .wr_en(wr_en),
        .wr_rst_busy(wr_rst_busy));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_v_vid_in_axi4s_v4_0_7_formatter
   (vtd_active_video,
    v_blank_sync_2_reg_0,
    vtd_vblank,
    vtd_hblank,
    vtd_vsync,
    vtd_hsync,
    vtd_field_id,
    din,
    wr_en,
    vid_io_in_ce,
    vid_active_video,
    vid_io_in_clk,
    vid_vblank,
    vid_hblank,
    vid_vsync,
    vid_hsync,
    vid_field_id,
    axis_enable,
    wr_rst_busy,
    fifo_overflow_from_coupler_pulse_reg,
    vid_io_in_reset,
    vid_data);
  output vtd_active_video;
  output v_blank_sync_2_reg_0;
  output vtd_vblank;
  output vtd_hblank;
  output vtd_vsync;
  output vtd_hsync;
  output vtd_field_id;
  output [26:0]din;
  output wr_en;
  input vid_io_in_ce;
  input vid_active_video;
  input vid_io_in_clk;
  input vid_vblank;
  input vid_hblank;
  input vid_vsync;
  input vid_hsync;
  input vid_field_id;
  input axis_enable;
  input wr_rst_busy;
  input fifo_overflow_from_coupler_pulse_reg;
  input vid_io_in_reset;
  input [23:0]vid_data;

  wire axis_enable;
  wire [23:0]data_1;
  wire [23:0]data_2;
  wire de_2;
  wire de_3;
  wire [26:0]din;
  wire eol_i_1_n_0;
  wire field_id_2;
  wire fifo_overflow_from_coupler_pulse_reg;
  wire sof;
  wire sof0;
  wire v_blank_sync_1;
  wire v_blank_sync_2;
  wire v_blank_sync_2_reg_0;
  wire vert_blanking_intvl_i_1_n_0;
  wire vert_blanking_intvl_reg_n_0;
  wire vid_active_video;
  wire [23:0]vid_data;
  wire vid_field_id;
  wire vid_hblank;
  wire vid_hsync;
  wire vid_io_in_ce;
  wire vid_io_in_clk;
  wire vid_io_in_reset;
  wire vid_vblank;
  wire vid_vsync;
  wire vtd_active_video;
  wire vtd_field_id;
  wire vtd_hblank;
  wire vtd_hsync;
  wire vtd_locked_i_1_n_0;
  wire vtd_locked_reg_n_0;
  wire vtd_vblank;
  wire vtd_vsync;
  wire wr_en;
  wire wr_rst_busy;

  FDRE #(
    .INIT(1'b0)) 
    \data_1_reg[0] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_data[0]),
        .Q(data_1[0]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_1_reg[10] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_data[10]),
        .Q(data_1[10]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_1_reg[11] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_data[11]),
        .Q(data_1[11]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_1_reg[12] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_data[12]),
        .Q(data_1[12]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_1_reg[13] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_data[13]),
        .Q(data_1[13]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_1_reg[14] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_data[14]),
        .Q(data_1[14]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_1_reg[15] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_data[15]),
        .Q(data_1[15]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_1_reg[16] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_data[16]),
        .Q(data_1[16]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_1_reg[17] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_data[17]),
        .Q(data_1[17]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_1_reg[18] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_data[18]),
        .Q(data_1[18]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_1_reg[19] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_data[19]),
        .Q(data_1[19]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_1_reg[1] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_data[1]),
        .Q(data_1[1]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_1_reg[20] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_data[20]),
        .Q(data_1[20]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_1_reg[21] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_data[21]),
        .Q(data_1[21]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_1_reg[22] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_data[22]),
        .Q(data_1[22]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_1_reg[23] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_data[23]),
        .Q(data_1[23]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_1_reg[2] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_data[2]),
        .Q(data_1[2]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_1_reg[3] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_data[3]),
        .Q(data_1[3]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_1_reg[4] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_data[4]),
        .Q(data_1[4]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_1_reg[5] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_data[5]),
        .Q(data_1[5]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_1_reg[6] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_data[6]),
        .Q(data_1[6]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_1_reg[7] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_data[7]),
        .Q(data_1[7]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_1_reg[8] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_data[8]),
        .Q(data_1[8]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_1_reg[9] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_data[9]),
        .Q(data_1[9]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_2_reg[0] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_1[0]),
        .Q(data_2[0]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_2_reg[10] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_1[10]),
        .Q(data_2[10]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_2_reg[11] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_1[11]),
        .Q(data_2[11]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_2_reg[12] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_1[12]),
        .Q(data_2[12]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_2_reg[13] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_1[13]),
        .Q(data_2[13]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_2_reg[14] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_1[14]),
        .Q(data_2[14]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_2_reg[15] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_1[15]),
        .Q(data_2[15]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_2_reg[16] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_1[16]),
        .Q(data_2[16]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_2_reg[17] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_1[17]),
        .Q(data_2[17]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_2_reg[18] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_1[18]),
        .Q(data_2[18]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_2_reg[19] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_1[19]),
        .Q(data_2[19]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_2_reg[1] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_1[1]),
        .Q(data_2[1]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_2_reg[20] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_1[20]),
        .Q(data_2[20]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_2_reg[21] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_1[21]),
        .Q(data_2[21]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_2_reg[22] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_1[22]),
        .Q(data_2[22]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_2_reg[23] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_1[23]),
        .Q(data_2[23]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_2_reg[2] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_1[2]),
        .Q(data_2[2]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_2_reg[3] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_1[3]),
        .Q(data_2[3]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_2_reg[4] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_1[4]),
        .Q(data_2[4]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_2_reg[5] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_1[5]),
        .Q(data_2[5]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_2_reg[6] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_1[6]),
        .Q(data_2[6]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_2_reg[7] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_1[7]),
        .Q(data_2[7]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_2_reg[8] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_1[8]),
        .Q(data_2[8]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_2_reg[9] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_1[9]),
        .Q(data_2[9]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_3_reg[0] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_2[0]),
        .Q(din[0]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_3_reg[10] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_2[10]),
        .Q(din[10]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_3_reg[11] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_2[11]),
        .Q(din[11]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_3_reg[12] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_2[12]),
        .Q(din[12]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_3_reg[13] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_2[13]),
        .Q(din[13]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_3_reg[14] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_2[14]),
        .Q(din[14]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_3_reg[15] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_2[15]),
        .Q(din[15]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_3_reg[16] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_2[16]),
        .Q(din[16]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_3_reg[17] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_2[17]),
        .Q(din[17]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_3_reg[18] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_2[18]),
        .Q(din[18]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_3_reg[19] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_2[19]),
        .Q(din[19]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_3_reg[1] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_2[1]),
        .Q(din[1]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_3_reg[20] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_2[20]),
        .Q(din[20]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_3_reg[21] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_2[21]),
        .Q(din[21]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_3_reg[22] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_2[22]),
        .Q(din[22]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_3_reg[23] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_2[23]),
        .Q(din[23]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_3_reg[2] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_2[2]),
        .Q(din[2]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_3_reg[3] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_2[3]),
        .Q(din[3]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_3_reg[4] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_2[4]),
        .Q(din[4]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_3_reg[5] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_2[5]),
        .Q(din[5]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_3_reg[6] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_2[6]),
        .Q(din[6]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_3_reg[7] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_2[7]),
        .Q(din[7]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_3_reg[8] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_2[8]),
        .Q(din[8]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    \data_3_reg[9] 
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(data_2[9]),
        .Q(din[9]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    de_1_reg
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_active_video),
        .Q(vtd_active_video),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    de_2_reg
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vtd_active_video),
        .Q(de_2),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    de_3_reg
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(de_2),
        .Q(de_3),
        .R(v_blank_sync_2_reg_0));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h2)) 
    eol_i_1
       (.I0(de_2),
        .I1(vtd_active_video),
        .O(eol_i_1_n_0));
  FDRE eol_reg
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(eol_i_1_n_0),
        .Q(din[24]),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    field_id_1_reg
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_field_id),
        .Q(vtd_field_id),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    field_id_2_reg
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vtd_field_id),
        .Q(field_id_2),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    field_id_3_reg
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(field_id_2),
        .Q(din[26]),
        .R(v_blank_sync_2_reg_0));
  LUT2 #(
    .INIT(4'hE)) 
    \gnuram_async_fifo.xpm_fifo_base_inst_i_1 
       (.I0(vid_io_in_reset),
        .I1(fifo_overflow_from_coupler_pulse_reg),
        .O(v_blank_sync_2_reg_0));
  LUT6 #(
    .INIT(64'h0100000000000000)) 
    \gnuram_async_fifo.xpm_fifo_base_inst_i_2 
       (.I0(wr_rst_busy),
        .I1(fifo_overflow_from_coupler_pulse_reg),
        .I2(vid_io_in_reset),
        .I3(de_3),
        .I4(vtd_locked_reg_n_0),
        .I5(vid_io_in_ce),
        .O(wr_en));
  FDRE #(
    .INIT(1'b0)) 
    hblank_1_reg
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_hblank),
        .Q(vtd_hblank),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    hsync_1_reg
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_hsync),
        .Q(vtd_hsync),
        .R(v_blank_sync_2_reg_0));
  FDRE sof_1_reg
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(sof),
        .Q(din[25]),
        .R(v_blank_sync_2_reg_0));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'h40)) 
    sof_i_1
       (.I0(de_2),
        .I1(vtd_active_video),
        .I2(vert_blanking_intvl_reg_n_0),
        .O(sof0));
  FDRE sof_reg
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(sof0),
        .Q(sof),
        .R(v_blank_sync_2_reg_0));
  LUT2 #(
    .INIT(4'hE)) 
    v_blank_sync_2_i_1
       (.I0(vtd_vblank),
        .I1(vtd_vsync),
        .O(v_blank_sync_1));
  FDRE #(
    .INIT(1'b0)) 
    v_blank_sync_2_reg
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(v_blank_sync_1),
        .Q(v_blank_sync_2),
        .R(v_blank_sync_2_reg_0));
  FDRE #(
    .INIT(1'b0)) 
    vblank_1_reg
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_vblank),
        .Q(vtd_vblank),
        .R(v_blank_sync_2_reg_0));
  LUT6 #(
    .INIT(64'hB0B0F0F0FFB0F0F0)) 
    vert_blanking_intvl_i_1
       (.I0(de_2),
        .I1(vtd_active_video),
        .I2(vert_blanking_intvl_reg_n_0),
        .I3(v_blank_sync_1),
        .I4(vid_io_in_ce),
        .I5(v_blank_sync_2),
        .O(vert_blanking_intvl_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    vert_blanking_intvl_reg
       (.C(vid_io_in_clk),
        .CE(1'b1),
        .D(vert_blanking_intvl_i_1_n_0),
        .Q(vert_blanking_intvl_reg_n_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    vsync_1_reg
       (.C(vid_io_in_clk),
        .CE(vid_io_in_ce),
        .D(vid_vsync),
        .Q(vtd_vsync),
        .R(v_blank_sync_2_reg_0));
  LUT6 #(
    .INIT(64'h00000000BAAA0000)) 
    vtd_locked_i_1
       (.I0(vtd_locked_reg_n_0),
        .I1(din[25]),
        .I2(vid_io_in_ce),
        .I3(sof),
        .I4(axis_enable),
        .I5(v_blank_sync_2_reg_0),
        .O(vtd_locked_i_1_n_0));
  FDRE vtd_locked_reg
       (.C(vid_io_in_clk),
        .CE(1'b1),
        .D(vtd_locked_i_1_n_0),
        .Q(vtd_locked_reg_n_0),
        .R(1'b0));
endmodule

(* DEST_SYNC_FF = "4" *) (* INIT_SYNC_FF = "0" *) (* REG_OUTPUT = "0" *) 
(* SIM_ASSERT_CHK = "0" *) (* SIM_LOSSLESS_GRAY_CHK = "0" *) (* VERSION = "0" *) 
(* WIDTH = "11" *) (* XPM_MODULE = "TRUE" *) (* xpm_cdc = "GRAY" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_cdc_gray
   (src_clk,
    src_in_bin,
    dest_clk,
    dest_out_bin);
  input src_clk;
  input [10:0]src_in_bin;
  input dest_clk;
  output [10:0]dest_out_bin;

  wire [10:0]async_path;
  wire dest_clk;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [10:0]\dest_graysync_ff[0] ;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [10:0]\dest_graysync_ff[1] ;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [10:0]\dest_graysync_ff[2] ;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [10:0]\dest_graysync_ff[3] ;
  wire [9:0]\^dest_out_bin ;
  wire \dest_out_bin[0]_INST_0_i_1_n_0 ;
  wire \dest_out_bin[2]_INST_0_i_1_n_0 ;
  wire \dest_out_bin[3]_INST_0_i_1_n_0 ;
  wire [9:0]gray_enc;
  wire src_clk;
  wire [10:0]src_in_bin;

  assign dest_out_bin[10] = \dest_graysync_ff[3] [10];
  assign dest_out_bin[9:0] = \^dest_out_bin [9:0];
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[0]),
        .Q(\dest_graysync_ff[0] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][10] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[10]),
        .Q(\dest_graysync_ff[0] [10]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[1]),
        .Q(\dest_graysync_ff[0] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[2]),
        .Q(\dest_graysync_ff[0] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[3]),
        .Q(\dest_graysync_ff[0] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[4]),
        .Q(\dest_graysync_ff[0] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[5]),
        .Q(\dest_graysync_ff[0] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[6]),
        .Q(\dest_graysync_ff[0] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[7]),
        .Q(\dest_graysync_ff[0] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[8]),
        .Q(\dest_graysync_ff[0] [8]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][9] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[9]),
        .Q(\dest_graysync_ff[0] [9]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [0]),
        .Q(\dest_graysync_ff[1] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][10] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [10]),
        .Q(\dest_graysync_ff[1] [10]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [1]),
        .Q(\dest_graysync_ff[1] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [2]),
        .Q(\dest_graysync_ff[1] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [3]),
        .Q(\dest_graysync_ff[1] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [4]),
        .Q(\dest_graysync_ff[1] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [5]),
        .Q(\dest_graysync_ff[1] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [6]),
        .Q(\dest_graysync_ff[1] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [7]),
        .Q(\dest_graysync_ff[1] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [8]),
        .Q(\dest_graysync_ff[1] [8]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][9] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [9]),
        .Q(\dest_graysync_ff[1] [9]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [0]),
        .Q(\dest_graysync_ff[2] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][10] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [10]),
        .Q(\dest_graysync_ff[2] [10]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [1]),
        .Q(\dest_graysync_ff[2] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [2]),
        .Q(\dest_graysync_ff[2] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [3]),
        .Q(\dest_graysync_ff[2] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [4]),
        .Q(\dest_graysync_ff[2] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [5]),
        .Q(\dest_graysync_ff[2] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [6]),
        .Q(\dest_graysync_ff[2] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [7]),
        .Q(\dest_graysync_ff[2] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [8]),
        .Q(\dest_graysync_ff[2] [8]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][9] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [9]),
        .Q(\dest_graysync_ff[2] [9]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [0]),
        .Q(\dest_graysync_ff[3] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][10] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [10]),
        .Q(\dest_graysync_ff[3] [10]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [1]),
        .Q(\dest_graysync_ff[3] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [2]),
        .Q(\dest_graysync_ff[3] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [3]),
        .Q(\dest_graysync_ff[3] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [4]),
        .Q(\dest_graysync_ff[3] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [5]),
        .Q(\dest_graysync_ff[3] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [6]),
        .Q(\dest_graysync_ff[3] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [7]),
        .Q(\dest_graysync_ff[3] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [8]),
        .Q(\dest_graysync_ff[3] [8]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][9] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [9]),
        .Q(\dest_graysync_ff[3] [9]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[0]_INST_0 
       (.I0(\dest_graysync_ff[3] [1]),
        .I1(\dest_graysync_ff[3] [0]),
        .I2(\dest_graysync_ff[3] [2]),
        .I3(\dest_out_bin[2]_INST_0_i_1_n_0 ),
        .I4(\dest_out_bin[0]_INST_0_i_1_n_0 ),
        .I5(\dest_graysync_ff[3] [3]),
        .O(\^dest_out_bin [0]));
  LUT3 #(
    .INIT(8'h96)) 
    \dest_out_bin[0]_INST_0_i_1 
       (.I0(\dest_graysync_ff[3] [9]),
        .I1(\dest_graysync_ff[3] [10]),
        .I2(\dest_graysync_ff[3] [4]),
        .O(\dest_out_bin[0]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[1]_INST_0 
       (.I0(\dest_graysync_ff[3] [2]),
        .I1(\dest_out_bin[2]_INST_0_i_1_n_0 ),
        .I2(\^dest_out_bin [9]),
        .I3(\dest_graysync_ff[3] [4]),
        .I4(\dest_graysync_ff[3] [3]),
        .I5(\dest_graysync_ff[3] [1]),
        .O(\^dest_out_bin [1]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[2]_INST_0 
       (.I0(\dest_graysync_ff[3] [3]),
        .I1(\dest_graysync_ff[3] [4]),
        .I2(\dest_graysync_ff[3] [10]),
        .I3(\dest_graysync_ff[3] [9]),
        .I4(\dest_out_bin[2]_INST_0_i_1_n_0 ),
        .I5(\dest_graysync_ff[3] [2]),
        .O(\^dest_out_bin [2]));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin[2]_INST_0_i_1 
       (.I0(\dest_graysync_ff[3] [5]),
        .I1(\dest_graysync_ff[3] [6]),
        .I2(\dest_graysync_ff[3] [7]),
        .I3(\dest_graysync_ff[3] [8]),
        .O(\dest_out_bin[2]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[3]_INST_0 
       (.I0(\dest_graysync_ff[3] [5]),
        .I1(\dest_graysync_ff[3] [6]),
        .I2(\dest_out_bin[3]_INST_0_i_1_n_0 ),
        .I3(\^dest_out_bin [9]),
        .I4(\dest_graysync_ff[3] [4]),
        .I5(\dest_graysync_ff[3] [3]),
        .O(\^dest_out_bin [3]));
  LUT2 #(
    .INIT(4'h6)) 
    \dest_out_bin[3]_INST_0_i_1 
       (.I0(\dest_graysync_ff[3] [8]),
        .I1(\dest_graysync_ff[3] [7]),
        .O(\dest_out_bin[3]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[4]_INST_0 
       (.I0(\dest_graysync_ff[3] [4]),
        .I1(\^dest_out_bin [9]),
        .I2(\dest_graysync_ff[3] [8]),
        .I3(\dest_graysync_ff[3] [7]),
        .I4(\dest_graysync_ff[3] [6]),
        .I5(\dest_graysync_ff[3] [5]),
        .O(\^dest_out_bin [4]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[5]_INST_0 
       (.I0(\dest_graysync_ff[3] [9]),
        .I1(\dest_graysync_ff[3] [10]),
        .I2(\dest_graysync_ff[3] [6]),
        .I3(\dest_graysync_ff[3] [5]),
        .I4(\dest_graysync_ff[3] [8]),
        .I5(\dest_graysync_ff[3] [7]),
        .O(\^dest_out_bin [5]));
  LUT5 #(
    .INIT(32'h96696996)) 
    \dest_out_bin[6]_INST_0 
       (.I0(\dest_graysync_ff[3] [10]),
        .I1(\dest_graysync_ff[3] [7]),
        .I2(\dest_graysync_ff[3] [6]),
        .I3(\dest_graysync_ff[3] [9]),
        .I4(\dest_graysync_ff[3] [8]),
        .O(\^dest_out_bin [6]));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin[7]_INST_0 
       (.I0(\dest_graysync_ff[3] [9]),
        .I1(\dest_graysync_ff[3] [10]),
        .I2(\dest_graysync_ff[3] [7]),
        .I3(\dest_graysync_ff[3] [8]),
        .O(\^dest_out_bin [7]));
  LUT3 #(
    .INIT(8'h96)) 
    \dest_out_bin[8]_INST_0 
       (.I0(\dest_graysync_ff[3] [10]),
        .I1(\dest_graysync_ff[3] [8]),
        .I2(\dest_graysync_ff[3] [9]),
        .O(\^dest_out_bin [8]));
  LUT2 #(
    .INIT(4'h6)) 
    \dest_out_bin[9]_INST_0 
       (.I0(\dest_graysync_ff[3] [10]),
        .I1(\dest_graysync_ff[3] [9]),
        .O(\^dest_out_bin [9]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[0]_i_1 
       (.I0(src_in_bin[0]),
        .I1(src_in_bin[1]),
        .O(gray_enc[0]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[1]_i_1 
       (.I0(src_in_bin[1]),
        .I1(src_in_bin[2]),
        .O(gray_enc[1]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[2]_i_1 
       (.I0(src_in_bin[2]),
        .I1(src_in_bin[3]),
        .O(gray_enc[2]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[3]_i_1 
       (.I0(src_in_bin[3]),
        .I1(src_in_bin[4]),
        .O(gray_enc[3]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[4]_i_1 
       (.I0(src_in_bin[4]),
        .I1(src_in_bin[5]),
        .O(gray_enc[4]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[5]_i_1 
       (.I0(src_in_bin[5]),
        .I1(src_in_bin[6]),
        .O(gray_enc[5]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[6]_i_1 
       (.I0(src_in_bin[6]),
        .I1(src_in_bin[7]),
        .O(gray_enc[6]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[7]_i_1 
       (.I0(src_in_bin[7]),
        .I1(src_in_bin[8]),
        .O(gray_enc[7]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[8]_i_1 
       (.I0(src_in_bin[8]),
        .I1(src_in_bin[9]),
        .O(gray_enc[8]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[9]_i_1 
       (.I0(src_in_bin[9]),
        .I1(src_in_bin[10]),
        .O(gray_enc[9]));
  FDRE \src_gray_ff_reg[0] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[0]),
        .Q(async_path[0]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[10] 
       (.C(src_clk),
        .CE(1'b1),
        .D(src_in_bin[10]),
        .Q(async_path[10]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[1] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[1]),
        .Q(async_path[1]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[2] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[2]),
        .Q(async_path[2]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[3] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[3]),
        .Q(async_path[3]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[4] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[4]),
        .Q(async_path[4]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[5] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[5]),
        .Q(async_path[5]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[6] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[6]),
        .Q(async_path[6]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[7] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[7]),
        .Q(async_path[7]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[8] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[8]),
        .Q(async_path[8]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[9] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[9]),
        .Q(async_path[9]),
        .R(1'b0));
endmodule

(* DEST_SYNC_FF = "4" *) (* INIT_SYNC_FF = "0" *) (* ORIG_REF_NAME = "xpm_cdc_gray" *) 
(* REG_OUTPUT = "0" *) (* SIM_ASSERT_CHK = "0" *) (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
(* VERSION = "0" *) (* WIDTH = "11" *) (* XPM_MODULE = "TRUE" *) 
(* xpm_cdc = "GRAY" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_cdc_gray__1
   (src_clk,
    src_in_bin,
    dest_clk,
    dest_out_bin);
  input src_clk;
  input [10:0]src_in_bin;
  input dest_clk;
  output [10:0]dest_out_bin;

  wire [10:0]async_path;
  wire dest_clk;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [10:0]\dest_graysync_ff[0] ;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [10:0]\dest_graysync_ff[1] ;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [10:0]\dest_graysync_ff[2] ;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [10:0]\dest_graysync_ff[3] ;
  wire [9:0]\^dest_out_bin ;
  wire \dest_out_bin[0]_INST_0_i_1_n_0 ;
  wire \dest_out_bin[2]_INST_0_i_1_n_0 ;
  wire \dest_out_bin[3]_INST_0_i_1_n_0 ;
  wire [9:0]gray_enc;
  wire src_clk;
  wire [10:0]src_in_bin;

  assign dest_out_bin[10] = \dest_graysync_ff[3] [10];
  assign dest_out_bin[9:0] = \^dest_out_bin [9:0];
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[0]),
        .Q(\dest_graysync_ff[0] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][10] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[10]),
        .Q(\dest_graysync_ff[0] [10]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[1]),
        .Q(\dest_graysync_ff[0] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[2]),
        .Q(\dest_graysync_ff[0] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[3]),
        .Q(\dest_graysync_ff[0] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[4]),
        .Q(\dest_graysync_ff[0] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[5]),
        .Q(\dest_graysync_ff[0] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[6]),
        .Q(\dest_graysync_ff[0] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[7]),
        .Q(\dest_graysync_ff[0] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[8]),
        .Q(\dest_graysync_ff[0] [8]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][9] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[9]),
        .Q(\dest_graysync_ff[0] [9]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [0]),
        .Q(\dest_graysync_ff[1] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][10] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [10]),
        .Q(\dest_graysync_ff[1] [10]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [1]),
        .Q(\dest_graysync_ff[1] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [2]),
        .Q(\dest_graysync_ff[1] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [3]),
        .Q(\dest_graysync_ff[1] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [4]),
        .Q(\dest_graysync_ff[1] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [5]),
        .Q(\dest_graysync_ff[1] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [6]),
        .Q(\dest_graysync_ff[1] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [7]),
        .Q(\dest_graysync_ff[1] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [8]),
        .Q(\dest_graysync_ff[1] [8]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][9] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [9]),
        .Q(\dest_graysync_ff[1] [9]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [0]),
        .Q(\dest_graysync_ff[2] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][10] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [10]),
        .Q(\dest_graysync_ff[2] [10]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [1]),
        .Q(\dest_graysync_ff[2] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [2]),
        .Q(\dest_graysync_ff[2] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [3]),
        .Q(\dest_graysync_ff[2] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [4]),
        .Q(\dest_graysync_ff[2] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [5]),
        .Q(\dest_graysync_ff[2] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [6]),
        .Q(\dest_graysync_ff[2] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [7]),
        .Q(\dest_graysync_ff[2] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [8]),
        .Q(\dest_graysync_ff[2] [8]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][9] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [9]),
        .Q(\dest_graysync_ff[2] [9]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [0]),
        .Q(\dest_graysync_ff[3] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][10] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [10]),
        .Q(\dest_graysync_ff[3] [10]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [1]),
        .Q(\dest_graysync_ff[3] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [2]),
        .Q(\dest_graysync_ff[3] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [3]),
        .Q(\dest_graysync_ff[3] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [4]),
        .Q(\dest_graysync_ff[3] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [5]),
        .Q(\dest_graysync_ff[3] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [6]),
        .Q(\dest_graysync_ff[3] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [7]),
        .Q(\dest_graysync_ff[3] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [8]),
        .Q(\dest_graysync_ff[3] [8]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][9] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [9]),
        .Q(\dest_graysync_ff[3] [9]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[0]_INST_0 
       (.I0(\dest_graysync_ff[3] [1]),
        .I1(\dest_graysync_ff[3] [0]),
        .I2(\dest_graysync_ff[3] [2]),
        .I3(\dest_out_bin[2]_INST_0_i_1_n_0 ),
        .I4(\dest_out_bin[0]_INST_0_i_1_n_0 ),
        .I5(\dest_graysync_ff[3] [3]),
        .O(\^dest_out_bin [0]));
  LUT3 #(
    .INIT(8'h96)) 
    \dest_out_bin[0]_INST_0_i_1 
       (.I0(\dest_graysync_ff[3] [9]),
        .I1(\dest_graysync_ff[3] [10]),
        .I2(\dest_graysync_ff[3] [4]),
        .O(\dest_out_bin[0]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[1]_INST_0 
       (.I0(\dest_graysync_ff[3] [2]),
        .I1(\dest_out_bin[2]_INST_0_i_1_n_0 ),
        .I2(\^dest_out_bin [9]),
        .I3(\dest_graysync_ff[3] [4]),
        .I4(\dest_graysync_ff[3] [3]),
        .I5(\dest_graysync_ff[3] [1]),
        .O(\^dest_out_bin [1]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[2]_INST_0 
       (.I0(\dest_graysync_ff[3] [3]),
        .I1(\dest_graysync_ff[3] [4]),
        .I2(\dest_graysync_ff[3] [10]),
        .I3(\dest_graysync_ff[3] [9]),
        .I4(\dest_out_bin[2]_INST_0_i_1_n_0 ),
        .I5(\dest_graysync_ff[3] [2]),
        .O(\^dest_out_bin [2]));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin[2]_INST_0_i_1 
       (.I0(\dest_graysync_ff[3] [5]),
        .I1(\dest_graysync_ff[3] [6]),
        .I2(\dest_graysync_ff[3] [7]),
        .I3(\dest_graysync_ff[3] [8]),
        .O(\dest_out_bin[2]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[3]_INST_0 
       (.I0(\dest_graysync_ff[3] [5]),
        .I1(\dest_graysync_ff[3] [6]),
        .I2(\dest_out_bin[3]_INST_0_i_1_n_0 ),
        .I3(\^dest_out_bin [9]),
        .I4(\dest_graysync_ff[3] [4]),
        .I5(\dest_graysync_ff[3] [3]),
        .O(\^dest_out_bin [3]));
  LUT2 #(
    .INIT(4'h6)) 
    \dest_out_bin[3]_INST_0_i_1 
       (.I0(\dest_graysync_ff[3] [8]),
        .I1(\dest_graysync_ff[3] [7]),
        .O(\dest_out_bin[3]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[4]_INST_0 
       (.I0(\dest_graysync_ff[3] [4]),
        .I1(\^dest_out_bin [9]),
        .I2(\dest_graysync_ff[3] [8]),
        .I3(\dest_graysync_ff[3] [7]),
        .I4(\dest_graysync_ff[3] [6]),
        .I5(\dest_graysync_ff[3] [5]),
        .O(\^dest_out_bin [4]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[5]_INST_0 
       (.I0(\dest_graysync_ff[3] [9]),
        .I1(\dest_graysync_ff[3] [10]),
        .I2(\dest_graysync_ff[3] [6]),
        .I3(\dest_graysync_ff[3] [5]),
        .I4(\dest_graysync_ff[3] [8]),
        .I5(\dest_graysync_ff[3] [7]),
        .O(\^dest_out_bin [5]));
  LUT5 #(
    .INIT(32'h96696996)) 
    \dest_out_bin[6]_INST_0 
       (.I0(\dest_graysync_ff[3] [10]),
        .I1(\dest_graysync_ff[3] [7]),
        .I2(\dest_graysync_ff[3] [6]),
        .I3(\dest_graysync_ff[3] [9]),
        .I4(\dest_graysync_ff[3] [8]),
        .O(\^dest_out_bin [6]));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin[7]_INST_0 
       (.I0(\dest_graysync_ff[3] [9]),
        .I1(\dest_graysync_ff[3] [10]),
        .I2(\dest_graysync_ff[3] [7]),
        .I3(\dest_graysync_ff[3] [8]),
        .O(\^dest_out_bin [7]));
  LUT3 #(
    .INIT(8'h96)) 
    \dest_out_bin[8]_INST_0 
       (.I0(\dest_graysync_ff[3] [10]),
        .I1(\dest_graysync_ff[3] [8]),
        .I2(\dest_graysync_ff[3] [9]),
        .O(\^dest_out_bin [8]));
  LUT2 #(
    .INIT(4'h6)) 
    \dest_out_bin[9]_INST_0 
       (.I0(\dest_graysync_ff[3] [10]),
        .I1(\dest_graysync_ff[3] [9]),
        .O(\^dest_out_bin [9]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[0]_i_1 
       (.I0(src_in_bin[0]),
        .I1(src_in_bin[1]),
        .O(gray_enc[0]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[1]_i_1 
       (.I0(src_in_bin[1]),
        .I1(src_in_bin[2]),
        .O(gray_enc[1]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[2]_i_1 
       (.I0(src_in_bin[2]),
        .I1(src_in_bin[3]),
        .O(gray_enc[2]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[3]_i_1 
       (.I0(src_in_bin[3]),
        .I1(src_in_bin[4]),
        .O(gray_enc[3]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[4]_i_1 
       (.I0(src_in_bin[4]),
        .I1(src_in_bin[5]),
        .O(gray_enc[4]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[5]_i_1 
       (.I0(src_in_bin[5]),
        .I1(src_in_bin[6]),
        .O(gray_enc[5]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[6]_i_1 
       (.I0(src_in_bin[6]),
        .I1(src_in_bin[7]),
        .O(gray_enc[6]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[7]_i_1 
       (.I0(src_in_bin[7]),
        .I1(src_in_bin[8]),
        .O(gray_enc[7]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[8]_i_1 
       (.I0(src_in_bin[8]),
        .I1(src_in_bin[9]),
        .O(gray_enc[8]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[9]_i_1 
       (.I0(src_in_bin[9]),
        .I1(src_in_bin[10]),
        .O(gray_enc[9]));
  FDRE \src_gray_ff_reg[0] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[0]),
        .Q(async_path[0]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[10] 
       (.C(src_clk),
        .CE(1'b1),
        .D(src_in_bin[10]),
        .Q(async_path[10]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[1] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[1]),
        .Q(async_path[1]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[2] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[2]),
        .Q(async_path[2]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[3] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[3]),
        .Q(async_path[3]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[4] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[4]),
        .Q(async_path[4]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[5] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[5]),
        .Q(async_path[5]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[6] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[6]),
        .Q(async_path[6]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[7] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[7]),
        .Q(async_path[7]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[8] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[8]),
        .Q(async_path[8]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[9] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[9]),
        .Q(async_path[9]),
        .R(1'b0));
endmodule

(* DEST_SYNC_FF = "6" *) (* INIT_SYNC_FF = "0" *) (* ORIG_REF_NAME = "xpm_cdc_gray" *) 
(* REG_OUTPUT = "0" *) (* SIM_ASSERT_CHK = "0" *) (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
(* VERSION = "0" *) (* WIDTH = "12" *) (* XPM_MODULE = "TRUE" *) 
(* xpm_cdc = "GRAY" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_cdc_gray__parameterized0
   (src_clk,
    src_in_bin,
    dest_clk,
    dest_out_bin);
  input src_clk;
  input [11:0]src_in_bin;
  input dest_clk;
  output [11:0]dest_out_bin;

  wire [11:0]async_path;
  wire dest_clk;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [11:0]\dest_graysync_ff[0] ;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [11:0]\dest_graysync_ff[1] ;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [11:0]\dest_graysync_ff[2] ;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [11:0]\dest_graysync_ff[3] ;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [11:0]\dest_graysync_ff[4] ;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [11:0]\dest_graysync_ff[5] ;
  wire [10:0]\^dest_out_bin ;
  wire \dest_out_bin[0]_INST_0_i_1_n_0 ;
  wire \dest_out_bin[1]_INST_0_i_1_n_0 ;
  wire \dest_out_bin[2]_INST_0_i_1_n_0 ;
  wire \dest_out_bin[3]_INST_0_i_1_n_0 ;
  wire [10:0]gray_enc;
  wire src_clk;
  wire [11:0]src_in_bin;

  assign dest_out_bin[11] = \dest_graysync_ff[5] [11];
  assign dest_out_bin[10:0] = \^dest_out_bin [10:0];
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[0]),
        .Q(\dest_graysync_ff[0] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][10] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[10]),
        .Q(\dest_graysync_ff[0] [10]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][11] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[11]),
        .Q(\dest_graysync_ff[0] [11]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[1]),
        .Q(\dest_graysync_ff[0] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[2]),
        .Q(\dest_graysync_ff[0] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[3]),
        .Q(\dest_graysync_ff[0] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[4]),
        .Q(\dest_graysync_ff[0] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[5]),
        .Q(\dest_graysync_ff[0] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[6]),
        .Q(\dest_graysync_ff[0] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[7]),
        .Q(\dest_graysync_ff[0] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[8]),
        .Q(\dest_graysync_ff[0] [8]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][9] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[9]),
        .Q(\dest_graysync_ff[0] [9]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [0]),
        .Q(\dest_graysync_ff[1] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][10] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [10]),
        .Q(\dest_graysync_ff[1] [10]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][11] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [11]),
        .Q(\dest_graysync_ff[1] [11]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [1]),
        .Q(\dest_graysync_ff[1] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [2]),
        .Q(\dest_graysync_ff[1] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [3]),
        .Q(\dest_graysync_ff[1] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [4]),
        .Q(\dest_graysync_ff[1] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [5]),
        .Q(\dest_graysync_ff[1] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [6]),
        .Q(\dest_graysync_ff[1] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [7]),
        .Q(\dest_graysync_ff[1] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [8]),
        .Q(\dest_graysync_ff[1] [8]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][9] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [9]),
        .Q(\dest_graysync_ff[1] [9]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [0]),
        .Q(\dest_graysync_ff[2] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][10] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [10]),
        .Q(\dest_graysync_ff[2] [10]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][11] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [11]),
        .Q(\dest_graysync_ff[2] [11]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [1]),
        .Q(\dest_graysync_ff[2] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [2]),
        .Q(\dest_graysync_ff[2] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [3]),
        .Q(\dest_graysync_ff[2] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [4]),
        .Q(\dest_graysync_ff[2] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [5]),
        .Q(\dest_graysync_ff[2] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [6]),
        .Q(\dest_graysync_ff[2] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [7]),
        .Q(\dest_graysync_ff[2] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [8]),
        .Q(\dest_graysync_ff[2] [8]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][9] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [9]),
        .Q(\dest_graysync_ff[2] [9]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [0]),
        .Q(\dest_graysync_ff[3] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][10] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [10]),
        .Q(\dest_graysync_ff[3] [10]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][11] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [11]),
        .Q(\dest_graysync_ff[3] [11]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [1]),
        .Q(\dest_graysync_ff[3] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [2]),
        .Q(\dest_graysync_ff[3] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [3]),
        .Q(\dest_graysync_ff[3] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [4]),
        .Q(\dest_graysync_ff[3] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [5]),
        .Q(\dest_graysync_ff[3] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [6]),
        .Q(\dest_graysync_ff[3] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [7]),
        .Q(\dest_graysync_ff[3] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [8]),
        .Q(\dest_graysync_ff[3] [8]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][9] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [9]),
        .Q(\dest_graysync_ff[3] [9]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[4][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[3] [0]),
        .Q(\dest_graysync_ff[4] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[4][10] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[3] [10]),
        .Q(\dest_graysync_ff[4] [10]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[4][11] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[3] [11]),
        .Q(\dest_graysync_ff[4] [11]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[4][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[3] [1]),
        .Q(\dest_graysync_ff[4] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[4][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[3] [2]),
        .Q(\dest_graysync_ff[4] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[4][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[3] [3]),
        .Q(\dest_graysync_ff[4] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[4][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[3] [4]),
        .Q(\dest_graysync_ff[4] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[4][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[3] [5]),
        .Q(\dest_graysync_ff[4] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[4][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[3] [6]),
        .Q(\dest_graysync_ff[4] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[4][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[3] [7]),
        .Q(\dest_graysync_ff[4] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[4][8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[3] [8]),
        .Q(\dest_graysync_ff[4] [8]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[4][9] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[3] [9]),
        .Q(\dest_graysync_ff[4] [9]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[5][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[4] [0]),
        .Q(\dest_graysync_ff[5] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[5][10] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[4] [10]),
        .Q(\dest_graysync_ff[5] [10]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[5][11] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[4] [11]),
        .Q(\dest_graysync_ff[5] [11]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[5][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[4] [1]),
        .Q(\dest_graysync_ff[5] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[5][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[4] [2]),
        .Q(\dest_graysync_ff[5] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[5][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[4] [3]),
        .Q(\dest_graysync_ff[5] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[5][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[4] [4]),
        .Q(\dest_graysync_ff[5] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[5][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[4] [5]),
        .Q(\dest_graysync_ff[5] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[5][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[4] [6]),
        .Q(\dest_graysync_ff[5] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[5][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[4] [7]),
        .Q(\dest_graysync_ff[5] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[5][8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[4] [8]),
        .Q(\dest_graysync_ff[5] [8]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[5][9] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[4] [9]),
        .Q(\dest_graysync_ff[5] [9]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[0]_INST_0 
       (.I0(\^dest_out_bin [8]),
        .I1(\dest_graysync_ff[5] [2]),
        .I2(\dest_graysync_ff[5] [3]),
        .I3(\dest_graysync_ff[5] [0]),
        .I4(\dest_graysync_ff[5] [1]),
        .I5(\dest_out_bin[0]_INST_0_i_1_n_0 ),
        .O(\^dest_out_bin [0]));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin[0]_INST_0_i_1 
       (.I0(\dest_graysync_ff[5] [6]),
        .I1(\dest_graysync_ff[5] [7]),
        .I2(\dest_graysync_ff[5] [4]),
        .I3(\dest_graysync_ff[5] [5]),
        .O(\dest_out_bin[0]_INST_0_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \dest_out_bin[10]_INST_0 
       (.I0(\dest_graysync_ff[5] [11]),
        .I1(\dest_graysync_ff[5] [10]),
        .O(\^dest_out_bin [10]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[1]_INST_0 
       (.I0(\^dest_out_bin [9]),
        .I1(\dest_graysync_ff[5] [3]),
        .I2(\dest_graysync_ff[5] [4]),
        .I3(\dest_graysync_ff[5] [1]),
        .I4(\dest_graysync_ff[5] [2]),
        .I5(\dest_out_bin[1]_INST_0_i_1_n_0 ),
        .O(\^dest_out_bin [1]));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin[1]_INST_0_i_1 
       (.I0(\dest_graysync_ff[5] [7]),
        .I1(\dest_graysync_ff[5] [8]),
        .I2(\dest_graysync_ff[5] [5]),
        .I3(\dest_graysync_ff[5] [6]),
        .O(\dest_out_bin[1]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[2]_INST_0 
       (.I0(\^dest_out_bin [10]),
        .I1(\dest_graysync_ff[5] [4]),
        .I2(\dest_graysync_ff[5] [5]),
        .I3(\dest_graysync_ff[5] [2]),
        .I4(\dest_graysync_ff[5] [3]),
        .I5(\dest_out_bin[2]_INST_0_i_1_n_0 ),
        .O(\^dest_out_bin [2]));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin[2]_INST_0_i_1 
       (.I0(\dest_graysync_ff[5] [8]),
        .I1(\dest_graysync_ff[5] [9]),
        .I2(\dest_graysync_ff[5] [6]),
        .I3(\dest_graysync_ff[5] [7]),
        .O(\dest_out_bin[2]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[3]_INST_0 
       (.I0(\dest_graysync_ff[5] [11]),
        .I1(\dest_graysync_ff[5] [5]),
        .I2(\dest_graysync_ff[5] [6]),
        .I3(\dest_graysync_ff[5] [3]),
        .I4(\dest_graysync_ff[5] [4]),
        .I5(\dest_out_bin[3]_INST_0_i_1_n_0 ),
        .O(\^dest_out_bin [3]));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin[3]_INST_0_i_1 
       (.I0(\dest_graysync_ff[5] [9]),
        .I1(\dest_graysync_ff[5] [10]),
        .I2(\dest_graysync_ff[5] [7]),
        .I3(\dest_graysync_ff[5] [8]),
        .O(\dest_out_bin[3]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h96696996)) 
    \dest_out_bin[4]_INST_0 
       (.I0(\^dest_out_bin [8]),
        .I1(\dest_graysync_ff[5] [5]),
        .I2(\dest_graysync_ff[5] [4]),
        .I3(\dest_graysync_ff[5] [7]),
        .I4(\dest_graysync_ff[5] [6]),
        .O(\^dest_out_bin [4]));
  LUT5 #(
    .INIT(32'h96696996)) 
    \dest_out_bin[5]_INST_0 
       (.I0(\^dest_out_bin [9]),
        .I1(\dest_graysync_ff[5] [6]),
        .I2(\dest_graysync_ff[5] [5]),
        .I3(\dest_graysync_ff[5] [8]),
        .I4(\dest_graysync_ff[5] [7]),
        .O(\^dest_out_bin [5]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[6]_INST_0 
       (.I0(\dest_graysync_ff[5] [10]),
        .I1(\dest_graysync_ff[5] [11]),
        .I2(\dest_graysync_ff[5] [7]),
        .I3(\dest_graysync_ff[5] [6]),
        .I4(\dest_graysync_ff[5] [9]),
        .I5(\dest_graysync_ff[5] [8]),
        .O(\^dest_out_bin [6]));
  LUT5 #(
    .INIT(32'h96696996)) 
    \dest_out_bin[7]_INST_0 
       (.I0(\dest_graysync_ff[5] [11]),
        .I1(\dest_graysync_ff[5] [8]),
        .I2(\dest_graysync_ff[5] [7]),
        .I3(\dest_graysync_ff[5] [10]),
        .I4(\dest_graysync_ff[5] [9]),
        .O(\^dest_out_bin [7]));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin[8]_INST_0 
       (.I0(\dest_graysync_ff[5] [10]),
        .I1(\dest_graysync_ff[5] [11]),
        .I2(\dest_graysync_ff[5] [8]),
        .I3(\dest_graysync_ff[5] [9]),
        .O(\^dest_out_bin [8]));
  LUT3 #(
    .INIT(8'h96)) 
    \dest_out_bin[9]_INST_0 
       (.I0(\dest_graysync_ff[5] [11]),
        .I1(\dest_graysync_ff[5] [9]),
        .I2(\dest_graysync_ff[5] [10]),
        .O(\^dest_out_bin [9]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[0]_i_1 
       (.I0(src_in_bin[0]),
        .I1(src_in_bin[1]),
        .O(gray_enc[0]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[10]_i_1 
       (.I0(src_in_bin[10]),
        .I1(src_in_bin[11]),
        .O(gray_enc[10]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[1]_i_1 
       (.I0(src_in_bin[1]),
        .I1(src_in_bin[2]),
        .O(gray_enc[1]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[2]_i_1 
       (.I0(src_in_bin[2]),
        .I1(src_in_bin[3]),
        .O(gray_enc[2]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[3]_i_1 
       (.I0(src_in_bin[3]),
        .I1(src_in_bin[4]),
        .O(gray_enc[3]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[4]_i_1 
       (.I0(src_in_bin[4]),
        .I1(src_in_bin[5]),
        .O(gray_enc[4]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[5]_i_1 
       (.I0(src_in_bin[5]),
        .I1(src_in_bin[6]),
        .O(gray_enc[5]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[6]_i_1 
       (.I0(src_in_bin[6]),
        .I1(src_in_bin[7]),
        .O(gray_enc[6]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[7]_i_1 
       (.I0(src_in_bin[7]),
        .I1(src_in_bin[8]),
        .O(gray_enc[7]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[8]_i_1 
       (.I0(src_in_bin[8]),
        .I1(src_in_bin[9]),
        .O(gray_enc[8]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[9]_i_1 
       (.I0(src_in_bin[9]),
        .I1(src_in_bin[10]),
        .O(gray_enc[9]));
  FDRE \src_gray_ff_reg[0] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[0]),
        .Q(async_path[0]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[10] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[10]),
        .Q(async_path[10]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[11] 
       (.C(src_clk),
        .CE(1'b1),
        .D(src_in_bin[11]),
        .Q(async_path[11]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[1] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[1]),
        .Q(async_path[1]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[2] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[2]),
        .Q(async_path[2]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[3] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[3]),
        .Q(async_path[3]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[4] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[4]),
        .Q(async_path[4]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[5] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[5]),
        .Q(async_path[5]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[6] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[6]),
        .Q(async_path[6]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[7] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[7]),
        .Q(async_path[7]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[8] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[8]),
        .Q(async_path[8]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[9] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[9]),
        .Q(async_path[9]),
        .R(1'b0));
endmodule

(* DEST_SYNC_FF = "4" *) (* INIT_SYNC_FF = "0" *) (* ORIG_REF_NAME = "xpm_cdc_gray" *) 
(* REG_OUTPUT = "0" *) (* SIM_ASSERT_CHK = "0" *) (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
(* VERSION = "0" *) (* WIDTH = "12" *) (* XPM_MODULE = "TRUE" *) 
(* xpm_cdc = "GRAY" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_cdc_gray__parameterized1
   (src_clk,
    src_in_bin,
    dest_clk,
    dest_out_bin);
  input src_clk;
  input [11:0]src_in_bin;
  input dest_clk;
  output [11:0]dest_out_bin;

  wire [11:0]async_path;
  wire dest_clk;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [11:0]\dest_graysync_ff[0] ;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [11:0]\dest_graysync_ff[1] ;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [11:0]\dest_graysync_ff[2] ;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "GRAY" *) wire [11:0]\dest_graysync_ff[3] ;
  wire [10:0]\^dest_out_bin ;
  wire \dest_out_bin[0]_INST_0_i_1_n_0 ;
  wire \dest_out_bin[1]_INST_0_i_1_n_0 ;
  wire \dest_out_bin[2]_INST_0_i_1_n_0 ;
  wire \dest_out_bin[3]_INST_0_i_1_n_0 ;
  wire [10:0]gray_enc;
  wire src_clk;
  wire [11:0]src_in_bin;

  assign dest_out_bin[11] = \dest_graysync_ff[3] [11];
  assign dest_out_bin[10:0] = \^dest_out_bin [10:0];
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[0]),
        .Q(\dest_graysync_ff[0] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][10] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[10]),
        .Q(\dest_graysync_ff[0] [10]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][11] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[11]),
        .Q(\dest_graysync_ff[0] [11]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[1]),
        .Q(\dest_graysync_ff[0] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[2]),
        .Q(\dest_graysync_ff[0] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[3]),
        .Q(\dest_graysync_ff[0] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[4]),
        .Q(\dest_graysync_ff[0] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[5]),
        .Q(\dest_graysync_ff[0] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[6]),
        .Q(\dest_graysync_ff[0] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[7]),
        .Q(\dest_graysync_ff[0] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[8]),
        .Q(\dest_graysync_ff[0] [8]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[0][9] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(async_path[9]),
        .Q(\dest_graysync_ff[0] [9]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [0]),
        .Q(\dest_graysync_ff[1] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][10] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [10]),
        .Q(\dest_graysync_ff[1] [10]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][11] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [11]),
        .Q(\dest_graysync_ff[1] [11]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [1]),
        .Q(\dest_graysync_ff[1] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [2]),
        .Q(\dest_graysync_ff[1] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [3]),
        .Q(\dest_graysync_ff[1] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [4]),
        .Q(\dest_graysync_ff[1] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [5]),
        .Q(\dest_graysync_ff[1] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [6]),
        .Q(\dest_graysync_ff[1] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [7]),
        .Q(\dest_graysync_ff[1] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [8]),
        .Q(\dest_graysync_ff[1] [8]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[1][9] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[0] [9]),
        .Q(\dest_graysync_ff[1] [9]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [0]),
        .Q(\dest_graysync_ff[2] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][10] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [10]),
        .Q(\dest_graysync_ff[2] [10]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][11] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [11]),
        .Q(\dest_graysync_ff[2] [11]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [1]),
        .Q(\dest_graysync_ff[2] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [2]),
        .Q(\dest_graysync_ff[2] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [3]),
        .Q(\dest_graysync_ff[2] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [4]),
        .Q(\dest_graysync_ff[2] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [5]),
        .Q(\dest_graysync_ff[2] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [6]),
        .Q(\dest_graysync_ff[2] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [7]),
        .Q(\dest_graysync_ff[2] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [8]),
        .Q(\dest_graysync_ff[2] [8]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[2][9] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[1] [9]),
        .Q(\dest_graysync_ff[2] [9]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [0]),
        .Q(\dest_graysync_ff[3] [0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][10] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [10]),
        .Q(\dest_graysync_ff[3] [10]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][11] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [11]),
        .Q(\dest_graysync_ff[3] [11]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [1]),
        .Q(\dest_graysync_ff[3] [1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [2]),
        .Q(\dest_graysync_ff[3] [2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [3]),
        .Q(\dest_graysync_ff[3] [3]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][4] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [4]),
        .Q(\dest_graysync_ff[3] [4]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][5] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [5]),
        .Q(\dest_graysync_ff[3] [5]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][6] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [6]),
        .Q(\dest_graysync_ff[3] [6]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][7] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [7]),
        .Q(\dest_graysync_ff[3] [7]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][8] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [8]),
        .Q(\dest_graysync_ff[3] [8]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "GRAY" *) 
  FDRE \dest_graysync_ff_reg[3][9] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff[2] [9]),
        .Q(\dest_graysync_ff[3] [9]),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[0]_INST_0 
       (.I0(\^dest_out_bin [8]),
        .I1(\dest_graysync_ff[3] [2]),
        .I2(\dest_graysync_ff[3] [3]),
        .I3(\dest_graysync_ff[3] [0]),
        .I4(\dest_graysync_ff[3] [1]),
        .I5(\dest_out_bin[0]_INST_0_i_1_n_0 ),
        .O(\^dest_out_bin [0]));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin[0]_INST_0_i_1 
       (.I0(\dest_graysync_ff[3] [6]),
        .I1(\dest_graysync_ff[3] [7]),
        .I2(\dest_graysync_ff[3] [4]),
        .I3(\dest_graysync_ff[3] [5]),
        .O(\dest_out_bin[0]_INST_0_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \dest_out_bin[10]_INST_0 
       (.I0(\dest_graysync_ff[3] [11]),
        .I1(\dest_graysync_ff[3] [10]),
        .O(\^dest_out_bin [10]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[1]_INST_0 
       (.I0(\^dest_out_bin [9]),
        .I1(\dest_graysync_ff[3] [3]),
        .I2(\dest_graysync_ff[3] [4]),
        .I3(\dest_graysync_ff[3] [1]),
        .I4(\dest_graysync_ff[3] [2]),
        .I5(\dest_out_bin[1]_INST_0_i_1_n_0 ),
        .O(\^dest_out_bin [1]));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin[1]_INST_0_i_1 
       (.I0(\dest_graysync_ff[3] [7]),
        .I1(\dest_graysync_ff[3] [8]),
        .I2(\dest_graysync_ff[3] [5]),
        .I3(\dest_graysync_ff[3] [6]),
        .O(\dest_out_bin[1]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[2]_INST_0 
       (.I0(\^dest_out_bin [10]),
        .I1(\dest_graysync_ff[3] [4]),
        .I2(\dest_graysync_ff[3] [5]),
        .I3(\dest_graysync_ff[3] [2]),
        .I4(\dest_graysync_ff[3] [3]),
        .I5(\dest_out_bin[2]_INST_0_i_1_n_0 ),
        .O(\^dest_out_bin [2]));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin[2]_INST_0_i_1 
       (.I0(\dest_graysync_ff[3] [8]),
        .I1(\dest_graysync_ff[3] [9]),
        .I2(\dest_graysync_ff[3] [6]),
        .I3(\dest_graysync_ff[3] [7]),
        .O(\dest_out_bin[2]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[3]_INST_0 
       (.I0(\dest_graysync_ff[3] [11]),
        .I1(\dest_graysync_ff[3] [5]),
        .I2(\dest_graysync_ff[3] [6]),
        .I3(\dest_graysync_ff[3] [3]),
        .I4(\dest_graysync_ff[3] [4]),
        .I5(\dest_out_bin[3]_INST_0_i_1_n_0 ),
        .O(\^dest_out_bin [3]));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin[3]_INST_0_i_1 
       (.I0(\dest_graysync_ff[3] [9]),
        .I1(\dest_graysync_ff[3] [10]),
        .I2(\dest_graysync_ff[3] [7]),
        .I3(\dest_graysync_ff[3] [8]),
        .O(\dest_out_bin[3]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h96696996)) 
    \dest_out_bin[4]_INST_0 
       (.I0(\^dest_out_bin [8]),
        .I1(\dest_graysync_ff[3] [5]),
        .I2(\dest_graysync_ff[3] [4]),
        .I3(\dest_graysync_ff[3] [7]),
        .I4(\dest_graysync_ff[3] [6]),
        .O(\^dest_out_bin [4]));
  LUT5 #(
    .INIT(32'h96696996)) 
    \dest_out_bin[5]_INST_0 
       (.I0(\^dest_out_bin [9]),
        .I1(\dest_graysync_ff[3] [6]),
        .I2(\dest_graysync_ff[3] [5]),
        .I3(\dest_graysync_ff[3] [8]),
        .I4(\dest_graysync_ff[3] [7]),
        .O(\^dest_out_bin [5]));
  LUT6 #(
    .INIT(64'h6996966996696996)) 
    \dest_out_bin[6]_INST_0 
       (.I0(\dest_graysync_ff[3] [10]),
        .I1(\dest_graysync_ff[3] [11]),
        .I2(\dest_graysync_ff[3] [7]),
        .I3(\dest_graysync_ff[3] [6]),
        .I4(\dest_graysync_ff[3] [9]),
        .I5(\dest_graysync_ff[3] [8]),
        .O(\^dest_out_bin [6]));
  LUT5 #(
    .INIT(32'h96696996)) 
    \dest_out_bin[7]_INST_0 
       (.I0(\dest_graysync_ff[3] [11]),
        .I1(\dest_graysync_ff[3] [8]),
        .I2(\dest_graysync_ff[3] [7]),
        .I3(\dest_graysync_ff[3] [10]),
        .I4(\dest_graysync_ff[3] [9]),
        .O(\^dest_out_bin [7]));
  LUT4 #(
    .INIT(16'h6996)) 
    \dest_out_bin[8]_INST_0 
       (.I0(\dest_graysync_ff[3] [10]),
        .I1(\dest_graysync_ff[3] [11]),
        .I2(\dest_graysync_ff[3] [8]),
        .I3(\dest_graysync_ff[3] [9]),
        .O(\^dest_out_bin [8]));
  LUT3 #(
    .INIT(8'h96)) 
    \dest_out_bin[9]_INST_0 
       (.I0(\dest_graysync_ff[3] [11]),
        .I1(\dest_graysync_ff[3] [9]),
        .I2(\dest_graysync_ff[3] [10]),
        .O(\^dest_out_bin [9]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[0]_i_1 
       (.I0(src_in_bin[0]),
        .I1(src_in_bin[1]),
        .O(gray_enc[0]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[10]_i_1 
       (.I0(src_in_bin[10]),
        .I1(src_in_bin[11]),
        .O(gray_enc[10]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[1]_i_1 
       (.I0(src_in_bin[1]),
        .I1(src_in_bin[2]),
        .O(gray_enc[1]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[2]_i_1 
       (.I0(src_in_bin[2]),
        .I1(src_in_bin[3]),
        .O(gray_enc[2]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[3]_i_1 
       (.I0(src_in_bin[3]),
        .I1(src_in_bin[4]),
        .O(gray_enc[3]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[4]_i_1 
       (.I0(src_in_bin[4]),
        .I1(src_in_bin[5]),
        .O(gray_enc[4]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[5]_i_1 
       (.I0(src_in_bin[5]),
        .I1(src_in_bin[6]),
        .O(gray_enc[5]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[6]_i_1 
       (.I0(src_in_bin[6]),
        .I1(src_in_bin[7]),
        .O(gray_enc[6]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[7]_i_1 
       (.I0(src_in_bin[7]),
        .I1(src_in_bin[8]),
        .O(gray_enc[7]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[8]_i_1 
       (.I0(src_in_bin[8]),
        .I1(src_in_bin[9]),
        .O(gray_enc[8]));
  LUT2 #(
    .INIT(4'h6)) 
    \src_gray_ff[9]_i_1 
       (.I0(src_in_bin[9]),
        .I1(src_in_bin[10]),
        .O(gray_enc[9]));
  FDRE \src_gray_ff_reg[0] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[0]),
        .Q(async_path[0]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[10] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[10]),
        .Q(async_path[10]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[11] 
       (.C(src_clk),
        .CE(1'b1),
        .D(src_in_bin[11]),
        .Q(async_path[11]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[1] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[1]),
        .Q(async_path[1]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[2] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[2]),
        .Q(async_path[2]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[3] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[3]),
        .Q(async_path[3]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[4] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[4]),
        .Q(async_path[4]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[5] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[5]),
        .Q(async_path[5]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[6] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[6]),
        .Q(async_path[6]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[7] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[7]),
        .Q(async_path[7]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[8] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[8]),
        .Q(async_path[8]),
        .R(1'b0));
  FDRE \src_gray_ff_reg[9] 
       (.C(src_clk),
        .CE(1'b1),
        .D(gray_enc[9]),
        .Q(async_path[9]),
        .R(1'b0));
endmodule

(* DEST_SYNC_FF = "4" *) (* INIT_SYNC_FF = "0" *) (* SIM_ASSERT_CHK = "0" *) 
(* SRC_INPUT_REG = "0" *) (* VERSION = "0" *) (* XPM_MODULE = "TRUE" *) 
(* xpm_cdc = "SINGLE" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_cdc_single
   (src_clk,
    src_in,
    dest_clk,
    dest_out);
  input src_clk;
  input src_in;
  input dest_clk;
  output dest_out;

  wire dest_clk;
  wire src_in;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "SINGLE" *) wire [3:0]syncstages_ff;

  assign dest_out = syncstages_ff[3];
  (* ASYNC_REG *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(src_in),
        .Q(syncstages_ff[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[0]),
        .Q(syncstages_ff[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[1]),
        .Q(syncstages_ff[2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[2]),
        .Q(syncstages_ff[3]),
        .R(1'b0));
endmodule

(* DEST_SYNC_FF = "4" *) (* INIT_SYNC_FF = "0" *) (* ORIG_REF_NAME = "xpm_cdc_single" *) 
(* SIM_ASSERT_CHK = "0" *) (* SRC_INPUT_REG = "0" *) (* VERSION = "0" *) 
(* XPM_MODULE = "TRUE" *) (* xpm_cdc = "SINGLE" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_cdc_single__2
   (src_clk,
    src_in,
    dest_clk,
    dest_out);
  input src_clk;
  input src_in;
  input dest_clk;
  output dest_out;

  wire dest_clk;
  wire src_in;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "SINGLE" *) wire [3:0]syncstages_ff;

  assign dest_out = syncstages_ff[3];
  (* ASYNC_REG *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(src_in),
        .Q(syncstages_ff[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[0]),
        .Q(syncstages_ff[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[1]),
        .Q(syncstages_ff[2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "SINGLE" *) 
  FDRE \syncstages_ff_reg[3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[2]),
        .Q(syncstages_ff[3]),
        .R(1'b0));
endmodule

(* DEF_VAL = "1'b0" *) (* DEST_SYNC_FF = "4" *) (* INIT = "0" *) 
(* INIT_SYNC_FF = "0" *) (* SIM_ASSERT_CHK = "1" *) (* VERSION = "0" *) 
(* XPM_MODULE = "TRUE" *) (* xpm_cdc = "SYNC_RST" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_cdc_sync_rst
   (src_rst,
    dest_clk,
    dest_rst);
  input src_rst;
  input dest_clk;
  output dest_rst;

  wire dest_clk;
  wire src_rst;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "SYNC_RST" *) wire [3:0]syncstages_ff;

  assign dest_rst = syncstages_ff[3];
  (* ASYNC_REG *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b0)) 
    \syncstages_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(src_rst),
        .Q(syncstages_ff[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b0)) 
    \syncstages_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[0]),
        .Q(syncstages_ff[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b0)) 
    \syncstages_ff_reg[2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[1]),
        .Q(syncstages_ff[2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b0)) 
    \syncstages_ff_reg[3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[2]),
        .Q(syncstages_ff[3]),
        .R(1'b0));
endmodule

(* DEF_VAL = "1'b0" *) (* DEST_SYNC_FF = "4" *) (* INIT = "0" *) 
(* INIT_SYNC_FF = "0" *) (* ORIG_REF_NAME = "xpm_cdc_sync_rst" *) (* SIM_ASSERT_CHK = "1" *) 
(* VERSION = "0" *) (* XPM_MODULE = "TRUE" *) (* xpm_cdc = "SYNC_RST" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_cdc_sync_rst__1
   (src_rst,
    dest_clk,
    dest_rst);
  input src_rst;
  input dest_clk;
  output dest_rst;

  wire dest_clk;
  wire src_rst;
  (* RTL_KEEP = "true" *) (* async_reg = "true" *) (* xpm_cdc = "SYNC_RST" *) wire [3:0]syncstages_ff;

  assign dest_rst = syncstages_ff[3];
  (* ASYNC_REG *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b0)) 
    \syncstages_ff_reg[0] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(src_rst),
        .Q(syncstages_ff[0]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b0)) 
    \syncstages_ff_reg[1] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[0]),
        .Q(syncstages_ff[1]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b0)) 
    \syncstages_ff_reg[2] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[1]),
        .Q(syncstages_ff[2]),
        .R(1'b0));
  (* ASYNC_REG *) 
  (* XPM_CDC = "SYNC_RST" *) 
  FDRE #(
    .INIT(1'b0)) 
    \syncstages_ff_reg[3] 
       (.C(dest_clk),
        .CE(1'b1),
        .D(syncstages_ff[2]),
        .Q(syncstages_ff[3]),
        .R(1'b0));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_counter_updn
   (S,
    DI,
    count_value_i,
    Q,
    \reg_out_i_reg[1] ,
    \gen_fwft.curr_fwft_state_reg[1] ,
    ram_empty_i,
    rd_en,
    SR,
    rd_clk);
  output [1:0]S;
  output [0:0]DI;
  output [1:0]count_value_i;
  input [1:0]Q;
  input [1:0]\reg_out_i_reg[1] ;
  input [1:0]\gen_fwft.curr_fwft_state_reg[1] ;
  input ram_empty_i;
  input rd_en;
  input [0:0]SR;
  input rd_clk;

  wire [0:0]DI;
  wire [1:0]Q;
  wire [1:0]S;
  wire [0:0]SR;
  wire [1:0]count_value_i;
  wire \count_value_i[0]_i_1_n_0 ;
  wire \count_value_i[1]_i_1_n_0 ;
  wire \count_value_i[1]_i_2_n_0 ;
  wire [1:0]\gen_fwft.curr_fwft_state_reg[1] ;
  wire ram_empty_i;
  wire rd_clk;
  wire rd_en;
  wire [1:0]\reg_out_i_reg[1] ;

  LUT6 #(
    .INIT(64'h000000005AA98585)) 
    \count_value_i[0]_i_1 
       (.I0(count_value_i[0]),
        .I1(\gen_fwft.curr_fwft_state_reg[1] [1]),
        .I2(ram_empty_i),
        .I3(rd_en),
        .I4(\gen_fwft.curr_fwft_state_reg[1] [0]),
        .I5(SR),
        .O(\count_value_i[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h0000AA8A)) 
    \count_value_i[1]_i_1 
       (.I0(\count_value_i[1]_i_2_n_0 ),
        .I1(\gen_fwft.curr_fwft_state_reg[1] [1]),
        .I2(ram_empty_i),
        .I3(\gen_fwft.curr_fwft_state_reg[1] [0]),
        .I4(SR),
        .O(\count_value_i[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFFDF5F550020A0A)) 
    \count_value_i[1]_i_2 
       (.I0(count_value_i[0]),
        .I1(\gen_fwft.curr_fwft_state_reg[1] [1]),
        .I2(ram_empty_i),
        .I3(rd_en),
        .I4(\gen_fwft.curr_fwft_state_reg[1] [0]),
        .I5(count_value_i[1]),
        .O(\count_value_i[1]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[0] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\count_value_i[0]_i_1_n_0 ),
        .Q(count_value_i[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\count_value_i[1]_i_1_n_0 ),
        .Q(count_value_i[1]),
        .R(1'b0));
  (* HLUTNM = "lutpair0" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \grdc.rd_data_count_i[3]_i_4 
       (.I0(count_value_i[0]),
        .I1(Q[0]),
        .O(DI));
  LUT4 #(
    .INIT(16'h9669)) 
    \grdc.rd_data_count_i[3]_i_7 
       (.I0(DI),
        .I1(count_value_i[1]),
        .I2(Q[1]),
        .I3(\reg_out_i_reg[1] [1]),
        .O(S[1]));
  (* HLUTNM = "lutpair0" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \grdc.rd_data_count_i[3]_i_8 
       (.I0(count_value_i[0]),
        .I1(Q[0]),
        .I2(\reg_out_i_reg[1] [0]),
        .O(S[0]));
endmodule

(* ORIG_REF_NAME = "xpm_counter_updn" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_counter_updn__parameterized0
   (Q,
    src_in_bin,
    S,
    \grdc.rd_data_count_i_reg[7] ,
    \grdc.rd_data_count_i_reg[11] ,
    DI,
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3] ,
    E,
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] ,
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] ,
    \reg_out_i_reg[11] ,
    count_value_i,
    ram_empty_i,
    rd_en,
    \gen_fwft.curr_fwft_state_reg[1] ,
    \reg_out_i_reg[10] ,
    SR,
    rd_clk);
  output [10:0]Q;
  output [11:0]src_in_bin;
  output [0:0]S;
  output [3:0]\grdc.rd_data_count_i_reg[7] ;
  output [3:0]\grdc.rd_data_count_i_reg[11] ;
  output [0:0]DI;
  output [3:0]\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3] ;
  output [0:0]E;
  output [2:0]\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] ;
  output [3:0]\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] ;
  input [10:0]\reg_out_i_reg[11] ;
  input [1:0]count_value_i;
  input ram_empty_i;
  input rd_en;
  input [1:0]\gen_fwft.curr_fwft_state_reg[1] ;
  input [9:0]\reg_out_i_reg[10] ;
  input [0:0]SR;
  input rd_clk;

  wire [0:0]DI;
  wire [0:0]E;
  wire [10:0]Q;
  wire [0:0]S;
  wire [0:0]SR;
  wire [1:0]count_value_i;
  wire \count_value_i[3]_i_2__3_n_0 ;
  wire \count_value_i_reg[11]_i_1__0_n_1 ;
  wire \count_value_i_reg[11]_i_1__0_n_2 ;
  wire \count_value_i_reg[11]_i_1__0_n_3 ;
  wire \count_value_i_reg[11]_i_1__0_n_4 ;
  wire \count_value_i_reg[11]_i_1__0_n_5 ;
  wire \count_value_i_reg[11]_i_1__0_n_6 ;
  wire \count_value_i_reg[11]_i_1__0_n_7 ;
  wire \count_value_i_reg[3]_i_1__3_n_0 ;
  wire \count_value_i_reg[3]_i_1__3_n_1 ;
  wire \count_value_i_reg[3]_i_1__3_n_2 ;
  wire \count_value_i_reg[3]_i_1__3_n_3 ;
  wire \count_value_i_reg[3]_i_1__3_n_4 ;
  wire \count_value_i_reg[3]_i_1__3_n_5 ;
  wire \count_value_i_reg[3]_i_1__3_n_6 ;
  wire \count_value_i_reg[3]_i_1__3_n_7 ;
  wire \count_value_i_reg[7]_i_1__3_n_0 ;
  wire \count_value_i_reg[7]_i_1__3_n_1 ;
  wire \count_value_i_reg[7]_i_1__3_n_2 ;
  wire \count_value_i_reg[7]_i_1__3_n_3 ;
  wire \count_value_i_reg[7]_i_1__3_n_4 ;
  wire \count_value_i_reg[7]_i_1__3_n_5 ;
  wire \count_value_i_reg[7]_i_1__3_n_6 ;
  wire \count_value_i_reg[7]_i_1__3_n_7 ;
  wire \count_value_i_reg_n_0_[11] ;
  wire \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_10_n_0 ;
  wire \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_11_n_0 ;
  wire \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_12_n_0 ;
  wire \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_13_n_0 ;
  wire \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_14_n_0 ;
  wire \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_15_n_0 ;
  wire \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_1_n_1 ;
  wire \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_1_n_2 ;
  wire \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_1_n_3 ;
  wire \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_2_n_0 ;
  wire \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_2_n_1 ;
  wire \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_2_n_2 ;
  wire \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_2_n_3 ;
  wire \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_3_n_0 ;
  wire \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_3_n_1 ;
  wire \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_3_n_2 ;
  wire \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_3_n_3 ;
  wire \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_4_n_0 ;
  wire \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_5_n_0 ;
  wire \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_6_n_0 ;
  wire \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_7_n_0 ;
  wire \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_8_n_0 ;
  wire \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_9_n_0 ;
  wire [1:0]\gen_fwft.curr_fwft_state_reg[1] ;
  wire [2:0]\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] ;
  wire [3:0]\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3] ;
  wire [3:0]\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] ;
  wire [3:0]\grdc.rd_data_count_i_reg[11] ;
  wire [3:0]\grdc.rd_data_count_i_reg[7] ;
  wire ram_empty_i;
  wire rd_clk;
  wire rd_en;
  wire [9:0]\reg_out_i_reg[10] ;
  wire [10:0]\reg_out_i_reg[11] ;
  wire [11:0]src_in_bin;
  wire [3:3]\NLW_count_value_i_reg[11]_i_1__0_CO_UNCONNECTED ;
  wire [3:3]\NLW_gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_1_CO_UNCONNECTED ;

  LUT5 #(
    .INIT(32'hBAAA4555)) 
    \count_value_i[3]_i_2__3 
       (.I0(ram_empty_i),
        .I1(rd_en),
        .I2(\gen_fwft.curr_fwft_state_reg[1] [1]),
        .I3(\gen_fwft.curr_fwft_state_reg[1] [0]),
        .I4(Q[0]),
        .O(\count_value_i[3]_i_2__3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[0] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i_reg[3]_i_1__3_n_7 ),
        .Q(Q[0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[10] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i_reg[11]_i_1__0_n_5 ),
        .Q(Q[10]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[11] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i_reg[11]_i_1__0_n_4 ),
        .Q(\count_value_i_reg_n_0_[11] ),
        .R(SR));
  CARRY4 \count_value_i_reg[11]_i_1__0 
       (.CI(\count_value_i_reg[7]_i_1__3_n_0 ),
        .CO({\NLW_count_value_i_reg[11]_i_1__0_CO_UNCONNECTED [3],\count_value_i_reg[11]_i_1__0_n_1 ,\count_value_i_reg[11]_i_1__0_n_2 ,\count_value_i_reg[11]_i_1__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\count_value_i_reg[11]_i_1__0_n_4 ,\count_value_i_reg[11]_i_1__0_n_5 ,\count_value_i_reg[11]_i_1__0_n_6 ,\count_value_i_reg[11]_i_1__0_n_7 }),
        .S({\count_value_i_reg_n_0_[11] ,Q[10:8]}));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[1] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i_reg[3]_i_1__3_n_6 ),
        .Q(Q[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[2] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i_reg[3]_i_1__3_n_5 ),
        .Q(Q[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[3] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i_reg[3]_i_1__3_n_4 ),
        .Q(Q[3]),
        .R(SR));
  CARRY4 \count_value_i_reg[3]_i_1__3 
       (.CI(1'b0),
        .CO({\count_value_i_reg[3]_i_1__3_n_0 ,\count_value_i_reg[3]_i_1__3_n_1 ,\count_value_i_reg[3]_i_1__3_n_2 ,\count_value_i_reg[3]_i_1__3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,Q[0]}),
        .O({\count_value_i_reg[3]_i_1__3_n_4 ,\count_value_i_reg[3]_i_1__3_n_5 ,\count_value_i_reg[3]_i_1__3_n_6 ,\count_value_i_reg[3]_i_1__3_n_7 }),
        .S({Q[3:1],\count_value_i[3]_i_2__3_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[4] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i_reg[7]_i_1__3_n_7 ),
        .Q(Q[4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[5] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i_reg[7]_i_1__3_n_6 ),
        .Q(Q[5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[6] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i_reg[7]_i_1__3_n_5 ),
        .Q(Q[6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[7] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i_reg[7]_i_1__3_n_4 ),
        .Q(Q[7]),
        .R(SR));
  CARRY4 \count_value_i_reg[7]_i_1__3 
       (.CI(\count_value_i_reg[3]_i_1__3_n_0 ),
        .CO({\count_value_i_reg[7]_i_1__3_n_0 ,\count_value_i_reg[7]_i_1__3_n_1 ,\count_value_i_reg[7]_i_1__3_n_2 ,\count_value_i_reg[7]_i_1__3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\count_value_i_reg[7]_i_1__3_n_4 ,\count_value_i_reg[7]_i_1__3_n_5 ,\count_value_i_reg[7]_i_1__3_n_6 ,\count_value_i_reg[7]_i_1__3_n_7 }),
        .S(Q[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[8] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i_reg[11]_i_1__0_n_7 ),
        .Q(Q[8]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[9] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i_reg[11]_i_1__0_n_6 ),
        .Q(Q[9]),
        .R(SR));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_1 
       (.CI(\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_2_n_0 ),
        .CO({\NLW_gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_1_CO_UNCONNECTED [3],\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_1_n_1 ,\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_1_n_2 ,\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,Q[10:8]}),
        .O(src_in_bin[11:8]),
        .S({\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_4_n_0 ,\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_5_n_0 ,\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_6_n_0 ,\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_7_n_0 }));
  LUT1 #(
    .INIT(2'h1)) 
    \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_10 
       (.I0(Q[5]),
        .O(\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_10_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_11 
       (.I0(Q[4]),
        .O(\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_12 
       (.I0(Q[3]),
        .O(\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_12_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_13 
       (.I0(Q[2]),
        .O(\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_13_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_14 
       (.I0(Q[1]),
        .I1(count_value_i[1]),
        .O(\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_14_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_15 
       (.I0(Q[0]),
        .I1(count_value_i[0]),
        .O(\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_15_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_2 
       (.CI(\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_3_n_0 ),
        .CO({\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_2_n_0 ,\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_2_n_1 ,\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_2_n_2 ,\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI(Q[7:4]),
        .O(src_in_bin[7:4]),
        .S({\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_8_n_0 ,\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_9_n_0 ,\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_10_n_0 ,\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_11_n_0 }));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_3 
       (.CI(1'b0),
        .CO({\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_3_n_0 ,\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_3_n_1 ,\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_3_n_2 ,\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_3_n_3 }),
        .CYINIT(1'b1),
        .DI(Q[3:0]),
        .O(src_in_bin[3:0]),
        .S({\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_12_n_0 ,\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_13_n_0 ,\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_14_n_0 ,\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_15_n_0 }));
  LUT1 #(
    .INIT(2'h1)) 
    \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_4 
       (.I0(\count_value_i_reg_n_0_[11] ),
        .O(\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_5 
       (.I0(Q[10]),
        .O(\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_6 
       (.I0(Q[9]),
        .O(\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_7 
       (.I0(Q[8]),
        .O(\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_8 
       (.I0(Q[7]),
        .O(\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_9 
       (.I0(Q[6]),
        .O(\gen_cdc_pntr.rd_pntr_cdc_dc_inst_i_9_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe[10]_i_2 
       (.I0(Q[10]),
        .I1(\reg_out_i_reg[10] [9]),
        .O(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [2]));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe[10]_i_3 
       (.I0(Q[9]),
        .I1(\reg_out_i_reg[10] [8]),
        .O(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [1]));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe[10]_i_4 
       (.I0(Q[8]),
        .I1(\reg_out_i_reg[10] [7]),
        .O(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [0]));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe[3]_i_3 
       (.I0(Q[3]),
        .I1(\reg_out_i_reg[10] [2]),
        .O(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3] [3]));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe[3]_i_4 
       (.I0(Q[2]),
        .I1(\reg_out_i_reg[10] [1]),
        .O(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3] [2]));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe[3]_i_5 
       (.I0(Q[1]),
        .I1(\reg_out_i_reg[10] [0]),
        .O(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3] [1]));
  LUT5 #(
    .INIT(32'hBAAA4555)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe[3]_i_6 
       (.I0(ram_empty_i),
        .I1(rd_en),
        .I2(\gen_fwft.curr_fwft_state_reg[1] [1]),
        .I3(\gen_fwft.curr_fwft_state_reg[1] [0]),
        .I4(Q[0]),
        .O(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3] [0]));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe[7]_i_2 
       (.I0(Q[7]),
        .I1(\reg_out_i_reg[10] [6]),
        .O(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] [3]));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe[7]_i_3 
       (.I0(Q[6]),
        .I1(\reg_out_i_reg[10] [5]),
        .O(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] [2]));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe[7]_i_4 
       (.I0(Q[5]),
        .I1(\reg_out_i_reg[10] [4]),
        .O(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] [1]));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe[7]_i_5 
       (.I0(Q[4]),
        .I1(\reg_out_i_reg[10] [3]),
        .O(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] [0]));
  LUT4 #(
    .INIT(16'h00F7)) 
    \gen_sdpram.xpm_memory_base_inst_i_3 
       (.I0(\gen_fwft.curr_fwft_state_reg[1] [0]),
        .I1(\gen_fwft.curr_fwft_state_reg[1] [1]),
        .I2(rd_en),
        .I3(ram_empty_i),
        .O(E));
  LUT4 #(
    .INIT(16'hB44B)) 
    \grdc.rd_data_count_i[11]_i_6 
       (.I0(Q[10]),
        .I1(\reg_out_i_reg[11] [9]),
        .I2(\count_value_i_reg_n_0_[11] ),
        .I3(\reg_out_i_reg[11] [10]),
        .O(\grdc.rd_data_count_i_reg[11] [3]));
  LUT4 #(
    .INIT(16'hB44B)) 
    \grdc.rd_data_count_i[11]_i_7 
       (.I0(Q[9]),
        .I1(\reg_out_i_reg[11] [8]),
        .I2(Q[10]),
        .I3(\reg_out_i_reg[11] [9]),
        .O(\grdc.rd_data_count_i_reg[11] [2]));
  LUT4 #(
    .INIT(16'hB44B)) 
    \grdc.rd_data_count_i[11]_i_8 
       (.I0(Q[8]),
        .I1(\reg_out_i_reg[11] [7]),
        .I2(Q[9]),
        .I3(\reg_out_i_reg[11] [8]),
        .O(\grdc.rd_data_count_i_reg[11] [1]));
  LUT4 #(
    .INIT(16'hB44B)) 
    \grdc.rd_data_count_i[11]_i_9 
       (.I0(Q[7]),
        .I1(\reg_out_i_reg[11] [6]),
        .I2(Q[8]),
        .I3(\reg_out_i_reg[11] [7]),
        .O(\grdc.rd_data_count_i_reg[11] [0]));
  LUT3 #(
    .INIT(8'hD4)) 
    \grdc.rd_data_count_i[3]_i_3 
       (.I0(Q[1]),
        .I1(count_value_i[1]),
        .I2(\reg_out_i_reg[11] [0]),
        .O(DI));
  LUT4 #(
    .INIT(16'hB44B)) 
    \grdc.rd_data_count_i[3]_i_5 
       (.I0(Q[2]),
        .I1(\reg_out_i_reg[11] [1]),
        .I2(Q[3]),
        .I3(\reg_out_i_reg[11] [2]),
        .O(S));
  LUT4 #(
    .INIT(16'hB44B)) 
    \grdc.rd_data_count_i[7]_i_6 
       (.I0(Q[6]),
        .I1(\reg_out_i_reg[11] [5]),
        .I2(Q[7]),
        .I3(\reg_out_i_reg[11] [6]),
        .O(\grdc.rd_data_count_i_reg[7] [3]));
  LUT4 #(
    .INIT(16'hB44B)) 
    \grdc.rd_data_count_i[7]_i_7 
       (.I0(Q[5]),
        .I1(\reg_out_i_reg[11] [4]),
        .I2(Q[6]),
        .I3(\reg_out_i_reg[11] [5]),
        .O(\grdc.rd_data_count_i_reg[7] [2]));
  LUT4 #(
    .INIT(16'hB44B)) 
    \grdc.rd_data_count_i[7]_i_8 
       (.I0(Q[4]),
        .I1(\reg_out_i_reg[11] [3]),
        .I2(Q[5]),
        .I3(\reg_out_i_reg[11] [4]),
        .O(\grdc.rd_data_count_i_reg[7] [1]));
  LUT4 #(
    .INIT(16'hB44B)) 
    \grdc.rd_data_count_i[7]_i_9 
       (.I0(Q[3]),
        .I1(\reg_out_i_reg[11] [2]),
        .I2(Q[4]),
        .I3(\reg_out_i_reg[11] [3]),
        .O(\grdc.rd_data_count_i_reg[7] [0]));
endmodule

(* ORIG_REF_NAME = "xpm_counter_updn" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_counter_updn__parameterized0_2
   (Q,
    D,
    S,
    \reg_out_i_reg[11] ,
    SR,
    ena,
    wr_clk);
  output [11:0]Q;
  output [11:0]D;
  input [0:0]S;
  input [11:0]\reg_out_i_reg[11] ;
  input [0:0]SR;
  input ena;
  input wr_clk;

  wire [11:0]D;
  wire [11:0]Q;
  wire [0:0]S;
  wire [0:0]SR;
  wire \count_value_i_reg[11]_i_1_n_1 ;
  wire \count_value_i_reg[11]_i_1_n_2 ;
  wire \count_value_i_reg[11]_i_1_n_3 ;
  wire \count_value_i_reg[11]_i_1_n_4 ;
  wire \count_value_i_reg[11]_i_1_n_5 ;
  wire \count_value_i_reg[11]_i_1_n_6 ;
  wire \count_value_i_reg[11]_i_1_n_7 ;
  wire \count_value_i_reg[3]_i_1__1_n_0 ;
  wire \count_value_i_reg[3]_i_1__1_n_1 ;
  wire \count_value_i_reg[3]_i_1__1_n_2 ;
  wire \count_value_i_reg[3]_i_1__1_n_3 ;
  wire \count_value_i_reg[3]_i_1__1_n_4 ;
  wire \count_value_i_reg[3]_i_1__1_n_5 ;
  wire \count_value_i_reg[3]_i_1__1_n_6 ;
  wire \count_value_i_reg[3]_i_1__1_n_7 ;
  wire \count_value_i_reg[7]_i_1__1_n_0 ;
  wire \count_value_i_reg[7]_i_1__1_n_1 ;
  wire \count_value_i_reg[7]_i_1__1_n_2 ;
  wire \count_value_i_reg[7]_i_1__1_n_3 ;
  wire \count_value_i_reg[7]_i_1__1_n_4 ;
  wire \count_value_i_reg[7]_i_1__1_n_5 ;
  wire \count_value_i_reg[7]_i_1__1_n_6 ;
  wire \count_value_i_reg[7]_i_1__1_n_7 ;
  wire ena;
  wire \gwdc.wr_data_count_i[11]_i_2_n_0 ;
  wire \gwdc.wr_data_count_i[11]_i_3_n_0 ;
  wire \gwdc.wr_data_count_i[11]_i_4_n_0 ;
  wire \gwdc.wr_data_count_i[11]_i_5_n_0 ;
  wire \gwdc.wr_data_count_i[3]_i_2_n_0 ;
  wire \gwdc.wr_data_count_i[3]_i_3_n_0 ;
  wire \gwdc.wr_data_count_i[3]_i_4_n_0 ;
  wire \gwdc.wr_data_count_i[3]_i_5_n_0 ;
  wire \gwdc.wr_data_count_i[7]_i_2_n_0 ;
  wire \gwdc.wr_data_count_i[7]_i_3_n_0 ;
  wire \gwdc.wr_data_count_i[7]_i_4_n_0 ;
  wire \gwdc.wr_data_count_i[7]_i_5_n_0 ;
  wire \gwdc.wr_data_count_i_reg[11]_i_1_n_1 ;
  wire \gwdc.wr_data_count_i_reg[11]_i_1_n_2 ;
  wire \gwdc.wr_data_count_i_reg[11]_i_1_n_3 ;
  wire \gwdc.wr_data_count_i_reg[3]_i_1_n_0 ;
  wire \gwdc.wr_data_count_i_reg[3]_i_1_n_1 ;
  wire \gwdc.wr_data_count_i_reg[3]_i_1_n_2 ;
  wire \gwdc.wr_data_count_i_reg[3]_i_1_n_3 ;
  wire \gwdc.wr_data_count_i_reg[7]_i_1_n_0 ;
  wire \gwdc.wr_data_count_i_reg[7]_i_1_n_1 ;
  wire \gwdc.wr_data_count_i_reg[7]_i_1_n_2 ;
  wire \gwdc.wr_data_count_i_reg[7]_i_1_n_3 ;
  wire [11:0]\reg_out_i_reg[11] ;
  wire wr_clk;
  wire [3:3]\NLW_count_value_i_reg[11]_i_1_CO_UNCONNECTED ;
  wire [3:3]\NLW_gwdc.wr_data_count_i_reg[11]_i_1_CO_UNCONNECTED ;

  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[0] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[3]_i_1__1_n_7 ),
        .Q(Q[0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[10] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[11]_i_1_n_5 ),
        .Q(Q[10]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[11] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[11]_i_1_n_4 ),
        .Q(Q[11]),
        .R(SR));
  CARRY4 \count_value_i_reg[11]_i_1 
       (.CI(\count_value_i_reg[7]_i_1__1_n_0 ),
        .CO({\NLW_count_value_i_reg[11]_i_1_CO_UNCONNECTED [3],\count_value_i_reg[11]_i_1_n_1 ,\count_value_i_reg[11]_i_1_n_2 ,\count_value_i_reg[11]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\count_value_i_reg[11]_i_1_n_4 ,\count_value_i_reg[11]_i_1_n_5 ,\count_value_i_reg[11]_i_1_n_6 ,\count_value_i_reg[11]_i_1_n_7 }),
        .S(Q[11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[1] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[3]_i_1__1_n_6 ),
        .Q(Q[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[2] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[3]_i_1__1_n_5 ),
        .Q(Q[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[3] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[3]_i_1__1_n_4 ),
        .Q(Q[3]),
        .R(SR));
  CARRY4 \count_value_i_reg[3]_i_1__1 
       (.CI(1'b0),
        .CO({\count_value_i_reg[3]_i_1__1_n_0 ,\count_value_i_reg[3]_i_1__1_n_1 ,\count_value_i_reg[3]_i_1__1_n_2 ,\count_value_i_reg[3]_i_1__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,Q[0]}),
        .O({\count_value_i_reg[3]_i_1__1_n_4 ,\count_value_i_reg[3]_i_1__1_n_5 ,\count_value_i_reg[3]_i_1__1_n_6 ,\count_value_i_reg[3]_i_1__1_n_7 }),
        .S({Q[3:1],S}));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[4] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[7]_i_1__1_n_7 ),
        .Q(Q[4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[5] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[7]_i_1__1_n_6 ),
        .Q(Q[5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[6] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[7]_i_1__1_n_5 ),
        .Q(Q[6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[7] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[7]_i_1__1_n_4 ),
        .Q(Q[7]),
        .R(SR));
  CARRY4 \count_value_i_reg[7]_i_1__1 
       (.CI(\count_value_i_reg[3]_i_1__1_n_0 ),
        .CO({\count_value_i_reg[7]_i_1__1_n_0 ,\count_value_i_reg[7]_i_1__1_n_1 ,\count_value_i_reg[7]_i_1__1_n_2 ,\count_value_i_reg[7]_i_1__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\count_value_i_reg[7]_i_1__1_n_4 ,\count_value_i_reg[7]_i_1__1_n_5 ,\count_value_i_reg[7]_i_1__1_n_6 ,\count_value_i_reg[7]_i_1__1_n_7 }),
        .S(Q[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[8] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[11]_i_1_n_7 ),
        .Q(Q[8]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[9] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[11]_i_1_n_6 ),
        .Q(Q[9]),
        .R(SR));
  LUT2 #(
    .INIT(4'h9)) 
    \gwdc.wr_data_count_i[11]_i_2 
       (.I0(Q[11]),
        .I1(\reg_out_i_reg[11] [11]),
        .O(\gwdc.wr_data_count_i[11]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gwdc.wr_data_count_i[11]_i_3 
       (.I0(Q[10]),
        .I1(\reg_out_i_reg[11] [10]),
        .O(\gwdc.wr_data_count_i[11]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gwdc.wr_data_count_i[11]_i_4 
       (.I0(Q[9]),
        .I1(\reg_out_i_reg[11] [9]),
        .O(\gwdc.wr_data_count_i[11]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gwdc.wr_data_count_i[11]_i_5 
       (.I0(Q[8]),
        .I1(\reg_out_i_reg[11] [8]),
        .O(\gwdc.wr_data_count_i[11]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gwdc.wr_data_count_i[3]_i_2 
       (.I0(Q[3]),
        .I1(\reg_out_i_reg[11] [3]),
        .O(\gwdc.wr_data_count_i[3]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gwdc.wr_data_count_i[3]_i_3 
       (.I0(Q[2]),
        .I1(\reg_out_i_reg[11] [2]),
        .O(\gwdc.wr_data_count_i[3]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gwdc.wr_data_count_i[3]_i_4 
       (.I0(Q[1]),
        .I1(\reg_out_i_reg[11] [1]),
        .O(\gwdc.wr_data_count_i[3]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gwdc.wr_data_count_i[3]_i_5 
       (.I0(Q[0]),
        .I1(\reg_out_i_reg[11] [0]),
        .O(\gwdc.wr_data_count_i[3]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gwdc.wr_data_count_i[7]_i_2 
       (.I0(Q[7]),
        .I1(\reg_out_i_reg[11] [7]),
        .O(\gwdc.wr_data_count_i[7]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gwdc.wr_data_count_i[7]_i_3 
       (.I0(Q[6]),
        .I1(\reg_out_i_reg[11] [6]),
        .O(\gwdc.wr_data_count_i[7]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gwdc.wr_data_count_i[7]_i_4 
       (.I0(Q[5]),
        .I1(\reg_out_i_reg[11] [5]),
        .O(\gwdc.wr_data_count_i[7]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gwdc.wr_data_count_i[7]_i_5 
       (.I0(Q[4]),
        .I1(\reg_out_i_reg[11] [4]),
        .O(\gwdc.wr_data_count_i[7]_i_5_n_0 ));
  CARRY4 \gwdc.wr_data_count_i_reg[11]_i_1 
       (.CI(\gwdc.wr_data_count_i_reg[7]_i_1_n_0 ),
        .CO({\NLW_gwdc.wr_data_count_i_reg[11]_i_1_CO_UNCONNECTED [3],\gwdc.wr_data_count_i_reg[11]_i_1_n_1 ,\gwdc.wr_data_count_i_reg[11]_i_1_n_2 ,\gwdc.wr_data_count_i_reg[11]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,Q[10:8]}),
        .O(D[11:8]),
        .S({\gwdc.wr_data_count_i[11]_i_2_n_0 ,\gwdc.wr_data_count_i[11]_i_3_n_0 ,\gwdc.wr_data_count_i[11]_i_4_n_0 ,\gwdc.wr_data_count_i[11]_i_5_n_0 }));
  CARRY4 \gwdc.wr_data_count_i_reg[3]_i_1 
       (.CI(1'b0),
        .CO({\gwdc.wr_data_count_i_reg[3]_i_1_n_0 ,\gwdc.wr_data_count_i_reg[3]_i_1_n_1 ,\gwdc.wr_data_count_i_reg[3]_i_1_n_2 ,\gwdc.wr_data_count_i_reg[3]_i_1_n_3 }),
        .CYINIT(1'b1),
        .DI(Q[3:0]),
        .O(D[3:0]),
        .S({\gwdc.wr_data_count_i[3]_i_2_n_0 ,\gwdc.wr_data_count_i[3]_i_3_n_0 ,\gwdc.wr_data_count_i[3]_i_4_n_0 ,\gwdc.wr_data_count_i[3]_i_5_n_0 }));
  CARRY4 \gwdc.wr_data_count_i_reg[7]_i_1 
       (.CI(\gwdc.wr_data_count_i_reg[3]_i_1_n_0 ),
        .CO({\gwdc.wr_data_count_i_reg[7]_i_1_n_0 ,\gwdc.wr_data_count_i_reg[7]_i_1_n_1 ,\gwdc.wr_data_count_i_reg[7]_i_1_n_2 ,\gwdc.wr_data_count_i_reg[7]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(Q[7:4]),
        .O(D[7:4]),
        .S({\gwdc.wr_data_count_i[7]_i_2_n_0 ,\gwdc.wr_data_count_i[7]_i_3_n_0 ,\gwdc.wr_data_count_i[7]_i_4_n_0 ,\gwdc.wr_data_count_i[7]_i_5_n_0 }));
endmodule

(* ORIG_REF_NAME = "xpm_counter_updn" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_counter_updn__parameterized1
   (Q,
    ram_empty_i,
    rd_en,
    \gen_fwft.curr_fwft_state_reg[1] ,
    SR,
    E,
    rd_clk);
  output [10:0]Q;
  input ram_empty_i;
  input rd_en;
  input [1:0]\gen_fwft.curr_fwft_state_reg[1] ;
  input [0:0]SR;
  input [0:0]E;
  input rd_clk;

  wire [0:0]E;
  wire [10:0]Q;
  wire [0:0]SR;
  wire \count_value_i[3]_i_2__2_n_0 ;
  wire \count_value_i_reg[10]_i_1__1_n_2 ;
  wire \count_value_i_reg[10]_i_1__1_n_3 ;
  wire \count_value_i_reg[10]_i_1__1_n_5 ;
  wire \count_value_i_reg[10]_i_1__1_n_6 ;
  wire \count_value_i_reg[10]_i_1__1_n_7 ;
  wire \count_value_i_reg[3]_i_1__2_n_0 ;
  wire \count_value_i_reg[3]_i_1__2_n_1 ;
  wire \count_value_i_reg[3]_i_1__2_n_2 ;
  wire \count_value_i_reg[3]_i_1__2_n_3 ;
  wire \count_value_i_reg[3]_i_1__2_n_4 ;
  wire \count_value_i_reg[3]_i_1__2_n_5 ;
  wire \count_value_i_reg[3]_i_1__2_n_6 ;
  wire \count_value_i_reg[3]_i_1__2_n_7 ;
  wire \count_value_i_reg[7]_i_1__2_n_0 ;
  wire \count_value_i_reg[7]_i_1__2_n_1 ;
  wire \count_value_i_reg[7]_i_1__2_n_2 ;
  wire \count_value_i_reg[7]_i_1__2_n_3 ;
  wire \count_value_i_reg[7]_i_1__2_n_4 ;
  wire \count_value_i_reg[7]_i_1__2_n_5 ;
  wire \count_value_i_reg[7]_i_1__2_n_6 ;
  wire \count_value_i_reg[7]_i_1__2_n_7 ;
  wire [1:0]\gen_fwft.curr_fwft_state_reg[1] ;
  wire ram_empty_i;
  wire rd_clk;
  wire rd_en;
  wire [3:2]\NLW_count_value_i_reg[10]_i_1__1_CO_UNCONNECTED ;
  wire [3:3]\NLW_count_value_i_reg[10]_i_1__1_O_UNCONNECTED ;

  LUT5 #(
    .INIT(32'hBAAA4555)) 
    \count_value_i[3]_i_2__2 
       (.I0(ram_empty_i),
        .I1(rd_en),
        .I2(\gen_fwft.curr_fwft_state_reg[1] [1]),
        .I3(\gen_fwft.curr_fwft_state_reg[1] [0]),
        .I4(Q[0]),
        .O(\count_value_i[3]_i_2__2_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \count_value_i_reg[0] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i_reg[3]_i_1__2_n_7 ),
        .Q(Q[0]),
        .S(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[10] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i_reg[10]_i_1__1_n_5 ),
        .Q(Q[10]),
        .R(SR));
  CARRY4 \count_value_i_reg[10]_i_1__1 
       (.CI(\count_value_i_reg[7]_i_1__2_n_0 ),
        .CO({\NLW_count_value_i_reg[10]_i_1__1_CO_UNCONNECTED [3:2],\count_value_i_reg[10]_i_1__1_n_2 ,\count_value_i_reg[10]_i_1__1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_count_value_i_reg[10]_i_1__1_O_UNCONNECTED [3],\count_value_i_reg[10]_i_1__1_n_5 ,\count_value_i_reg[10]_i_1__1_n_6 ,\count_value_i_reg[10]_i_1__1_n_7 }),
        .S({1'b0,Q[10:8]}));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[1] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i_reg[3]_i_1__2_n_6 ),
        .Q(Q[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[2] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i_reg[3]_i_1__2_n_5 ),
        .Q(Q[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[3] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i_reg[3]_i_1__2_n_4 ),
        .Q(Q[3]),
        .R(SR));
  CARRY4 \count_value_i_reg[3]_i_1__2 
       (.CI(1'b0),
        .CO({\count_value_i_reg[3]_i_1__2_n_0 ,\count_value_i_reg[3]_i_1__2_n_1 ,\count_value_i_reg[3]_i_1__2_n_2 ,\count_value_i_reg[3]_i_1__2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,Q[0]}),
        .O({\count_value_i_reg[3]_i_1__2_n_4 ,\count_value_i_reg[3]_i_1__2_n_5 ,\count_value_i_reg[3]_i_1__2_n_6 ,\count_value_i_reg[3]_i_1__2_n_7 }),
        .S({Q[3:1],\count_value_i[3]_i_2__2_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[4] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i_reg[7]_i_1__2_n_7 ),
        .Q(Q[4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[5] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i_reg[7]_i_1__2_n_6 ),
        .Q(Q[5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[6] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i_reg[7]_i_1__2_n_5 ),
        .Q(Q[6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[7] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i_reg[7]_i_1__2_n_4 ),
        .Q(Q[7]),
        .R(SR));
  CARRY4 \count_value_i_reg[7]_i_1__2 
       (.CI(\count_value_i_reg[3]_i_1__2_n_0 ),
        .CO({\count_value_i_reg[7]_i_1__2_n_0 ,\count_value_i_reg[7]_i_1__2_n_1 ,\count_value_i_reg[7]_i_1__2_n_2 ,\count_value_i_reg[7]_i_1__2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\count_value_i_reg[7]_i_1__2_n_4 ,\count_value_i_reg[7]_i_1__2_n_5 ,\count_value_i_reg[7]_i_1__2_n_6 ,\count_value_i_reg[7]_i_1__2_n_7 }),
        .S(Q[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[8] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i_reg[10]_i_1__1_n_7 ),
        .Q(Q[8]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[9] 
       (.C(rd_clk),
        .CE(E),
        .D(\count_value_i_reg[10]_i_1__1_n_6 ),
        .Q(Q[9]),
        .R(SR));
endmodule

(* ORIG_REF_NAME = "xpm_counter_updn" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_counter_updn__parameterized1_3
   (Q,
    D,
    S,
    ena,
    \reg_out_i_reg[10] ,
    SR,
    wr_clk);
  output [10:0]Q;
  output [7:0]D;
  input [0:0]S;
  input ena;
  input [10:0]\reg_out_i_reg[10] ;
  input [0:0]SR;
  input wr_clk;

  wire [7:0]D;
  wire [10:0]Q;
  wire [0:0]S;
  wire [0:0]SR;
  wire \count_value_i_reg[10]_i_1__0_n_2 ;
  wire \count_value_i_reg[10]_i_1__0_n_3 ;
  wire \count_value_i_reg[10]_i_1__0_n_5 ;
  wire \count_value_i_reg[10]_i_1__0_n_6 ;
  wire \count_value_i_reg[10]_i_1__0_n_7 ;
  wire \count_value_i_reg[3]_i_1__0_n_0 ;
  wire \count_value_i_reg[3]_i_1__0_n_1 ;
  wire \count_value_i_reg[3]_i_1__0_n_2 ;
  wire \count_value_i_reg[3]_i_1__0_n_3 ;
  wire \count_value_i_reg[3]_i_1__0_n_4 ;
  wire \count_value_i_reg[3]_i_1__0_n_5 ;
  wire \count_value_i_reg[3]_i_1__0_n_6 ;
  wire \count_value_i_reg[3]_i_1__0_n_7 ;
  wire \count_value_i_reg[7]_i_1__0_n_0 ;
  wire \count_value_i_reg[7]_i_1__0_n_1 ;
  wire \count_value_i_reg[7]_i_1__0_n_2 ;
  wire \count_value_i_reg[7]_i_1__0_n_3 ;
  wire \count_value_i_reg[7]_i_1__0_n_4 ;
  wire \count_value_i_reg[7]_i_1__0_n_5 ;
  wire \count_value_i_reg[7]_i_1__0_n_6 ;
  wire \count_value_i_reg[7]_i_1__0_n_7 ;
  wire ena;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[11]_i_2_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[11]_i_3_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[11]_i_4_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_2_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_3_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_4_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_5_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_2_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_3_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_4_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_5_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[11]_i_1_n_2 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[11]_i_1_n_3 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4]_i_1_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4]_i_1_n_1 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4]_i_1_n_2 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4]_i_1_n_3 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8]_i_1_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8]_i_1_n_1 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8]_i_1_n_2 ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8]_i_1_n_3 ;
  wire [10:0]\reg_out_i_reg[10] ;
  wire wr_clk;
  wire [3:2]\NLW_count_value_i_reg[10]_i_1__0_CO_UNCONNECTED ;
  wire [3:3]\NLW_count_value_i_reg[10]_i_1__0_O_UNCONNECTED ;
  wire [3:2]\NLW_gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[11]_i_1_CO_UNCONNECTED ;
  wire [3:3]\NLW_gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[11]_i_1_O_UNCONNECTED ;
  wire [2:0]\NLW_gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4]_i_1_O_UNCONNECTED ;

  FDSE #(
    .INIT(1'b1)) 
    \count_value_i_reg[0] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[3]_i_1__0_n_7 ),
        .Q(Q[0]),
        .S(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[10] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[10]_i_1__0_n_5 ),
        .Q(Q[10]),
        .R(SR));
  CARRY4 \count_value_i_reg[10]_i_1__0 
       (.CI(\count_value_i_reg[7]_i_1__0_n_0 ),
        .CO({\NLW_count_value_i_reg[10]_i_1__0_CO_UNCONNECTED [3:2],\count_value_i_reg[10]_i_1__0_n_2 ,\count_value_i_reg[10]_i_1__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_count_value_i_reg[10]_i_1__0_O_UNCONNECTED [3],\count_value_i_reg[10]_i_1__0_n_5 ,\count_value_i_reg[10]_i_1__0_n_6 ,\count_value_i_reg[10]_i_1__0_n_7 }),
        .S({1'b0,Q[10:8]}));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[1] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[3]_i_1__0_n_6 ),
        .Q(Q[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[2] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[3]_i_1__0_n_5 ),
        .Q(Q[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[3] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[3]_i_1__0_n_4 ),
        .Q(Q[3]),
        .R(SR));
  CARRY4 \count_value_i_reg[3]_i_1__0 
       (.CI(1'b0),
        .CO({\count_value_i_reg[3]_i_1__0_n_0 ,\count_value_i_reg[3]_i_1__0_n_1 ,\count_value_i_reg[3]_i_1__0_n_2 ,\count_value_i_reg[3]_i_1__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,Q[0]}),
        .O({\count_value_i_reg[3]_i_1__0_n_4 ,\count_value_i_reg[3]_i_1__0_n_5 ,\count_value_i_reg[3]_i_1__0_n_6 ,\count_value_i_reg[3]_i_1__0_n_7 }),
        .S({Q[3:1],S}));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[4] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[7]_i_1__0_n_7 ),
        .Q(Q[4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[5] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[7]_i_1__0_n_6 ),
        .Q(Q[5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[6] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[7]_i_1__0_n_5 ),
        .Q(Q[6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[7] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[7]_i_1__0_n_4 ),
        .Q(Q[7]),
        .R(SR));
  CARRY4 \count_value_i_reg[7]_i_1__0 
       (.CI(\count_value_i_reg[3]_i_1__0_n_0 ),
        .CO({\count_value_i_reg[7]_i_1__0_n_0 ,\count_value_i_reg[7]_i_1__0_n_1 ,\count_value_i_reg[7]_i_1__0_n_2 ,\count_value_i_reg[7]_i_1__0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\count_value_i_reg[7]_i_1__0_n_4 ,\count_value_i_reg[7]_i_1__0_n_5 ,\count_value_i_reg[7]_i_1__0_n_6 ,\count_value_i_reg[7]_i_1__0_n_7 }),
        .S(Q[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[8] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[10]_i_1__0_n_7 ),
        .Q(Q[8]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[9] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[10]_i_1__0_n_6 ),
        .Q(Q[9]),
        .R(SR));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[11]_i_2 
       (.I0(Q[10]),
        .I1(\reg_out_i_reg[10] [10]),
        .O(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[11]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[11]_i_3 
       (.I0(Q[9]),
        .I1(\reg_out_i_reg[10] [9]),
        .O(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[11]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[11]_i_4 
       (.I0(Q[8]),
        .I1(\reg_out_i_reg[10] [8]),
        .O(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[11]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_2 
       (.I0(Q[3]),
        .I1(\reg_out_i_reg[10] [3]),
        .O(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_3 
       (.I0(Q[2]),
        .I1(\reg_out_i_reg[10] [2]),
        .O(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_4 
       (.I0(Q[1]),
        .I1(\reg_out_i_reg[10] [1]),
        .O(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_5 
       (.I0(Q[0]),
        .I1(\reg_out_i_reg[10] [0]),
        .O(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_2 
       (.I0(Q[7]),
        .I1(\reg_out_i_reg[10] [7]),
        .O(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_3 
       (.I0(Q[6]),
        .I1(\reg_out_i_reg[10] [6]),
        .O(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_4 
       (.I0(Q[5]),
        .I1(\reg_out_i_reg[10] [5]),
        .O(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_5 
       (.I0(Q[4]),
        .I1(\reg_out_i_reg[10] [4]),
        .O(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_5_n_0 ));
  CARRY4 \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[11]_i_1 
       (.CI(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8]_i_1_n_0 ),
        .CO({\NLW_gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[11]_i_1_CO_UNCONNECTED [3:2],\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[11]_i_1_n_2 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[11]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,Q[9:8]}),
        .O({\NLW_gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[11]_i_1_O_UNCONNECTED [3],D[7:5]}),
        .S({1'b0,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[11]_i_2_n_0 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[11]_i_3_n_0 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[11]_i_4_n_0 }));
  CARRY4 \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4]_i_1 
       (.CI(1'b0),
        .CO({\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4]_i_1_n_0 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4]_i_1_n_1 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4]_i_1_n_2 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4]_i_1_n_3 }),
        .CYINIT(ena),
        .DI(Q[3:0]),
        .O({D[0],\NLW_gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4]_i_1_O_UNCONNECTED [2:0]}),
        .S({\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_2_n_0 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_3_n_0 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_4_n_0 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[4]_i_5_n_0 }));
  CARRY4 \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8]_i_1 
       (.CI(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4]_i_1_n_0 ),
        .CO({\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8]_i_1_n_0 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8]_i_1_n_1 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8]_i_1_n_2 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(Q[7:4]),
        .O(D[4:1]),
        .S({\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_2_n_0 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_3_n_0 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_4_n_0 ,\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q[8]_i_5_n_0 }));
endmodule

(* ORIG_REF_NAME = "xpm_counter_updn" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_counter_updn__parameterized2
   (Q,
    S,
    SR,
    ena,
    wr_clk);
  output [10:0]Q;
  input [0:0]S;
  input [0:0]SR;
  input ena;
  input wr_clk;

  wire [10:0]Q;
  wire [0:0]S;
  wire [0:0]SR;
  wire \count_value_i_reg[10]_i_1_n_2 ;
  wire \count_value_i_reg[10]_i_1_n_3 ;
  wire \count_value_i_reg[10]_i_1_n_5 ;
  wire \count_value_i_reg[10]_i_1_n_6 ;
  wire \count_value_i_reg[10]_i_1_n_7 ;
  wire \count_value_i_reg[3]_i_1_n_0 ;
  wire \count_value_i_reg[3]_i_1_n_1 ;
  wire \count_value_i_reg[3]_i_1_n_2 ;
  wire \count_value_i_reg[3]_i_1_n_3 ;
  wire \count_value_i_reg[3]_i_1_n_4 ;
  wire \count_value_i_reg[3]_i_1_n_5 ;
  wire \count_value_i_reg[3]_i_1_n_6 ;
  wire \count_value_i_reg[3]_i_1_n_7 ;
  wire \count_value_i_reg[7]_i_1_n_0 ;
  wire \count_value_i_reg[7]_i_1_n_1 ;
  wire \count_value_i_reg[7]_i_1_n_2 ;
  wire \count_value_i_reg[7]_i_1_n_3 ;
  wire \count_value_i_reg[7]_i_1_n_4 ;
  wire \count_value_i_reg[7]_i_1_n_5 ;
  wire \count_value_i_reg[7]_i_1_n_6 ;
  wire \count_value_i_reg[7]_i_1_n_7 ;
  wire ena;
  wire wr_clk;
  wire [3:2]\NLW_count_value_i_reg[10]_i_1_CO_UNCONNECTED ;
  wire [3:3]\NLW_count_value_i_reg[10]_i_1_O_UNCONNECTED ;

  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[0] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[3]_i_1_n_7 ),
        .Q(Q[0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[10] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[10]_i_1_n_5 ),
        .Q(Q[10]),
        .R(SR));
  CARRY4 \count_value_i_reg[10]_i_1 
       (.CI(\count_value_i_reg[7]_i_1_n_0 ),
        .CO({\NLW_count_value_i_reg[10]_i_1_CO_UNCONNECTED [3:2],\count_value_i_reg[10]_i_1_n_2 ,\count_value_i_reg[10]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_count_value_i_reg[10]_i_1_O_UNCONNECTED [3],\count_value_i_reg[10]_i_1_n_5 ,\count_value_i_reg[10]_i_1_n_6 ,\count_value_i_reg[10]_i_1_n_7 }),
        .S({1'b0,Q[10:8]}));
  FDSE #(
    .INIT(1'b1)) 
    \count_value_i_reg[1] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[3]_i_1_n_6 ),
        .Q(Q[1]),
        .S(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[2] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[3]_i_1_n_5 ),
        .Q(Q[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[3] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[3]_i_1_n_4 ),
        .Q(Q[3]),
        .R(SR));
  CARRY4 \count_value_i_reg[3]_i_1 
       (.CI(1'b0),
        .CO({\count_value_i_reg[3]_i_1_n_0 ,\count_value_i_reg[3]_i_1_n_1 ,\count_value_i_reg[3]_i_1_n_2 ,\count_value_i_reg[3]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,Q[0]}),
        .O({\count_value_i_reg[3]_i_1_n_4 ,\count_value_i_reg[3]_i_1_n_5 ,\count_value_i_reg[3]_i_1_n_6 ,\count_value_i_reg[3]_i_1_n_7 }),
        .S({Q[3:1],S}));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[4] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[7]_i_1_n_7 ),
        .Q(Q[4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[5] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[7]_i_1_n_6 ),
        .Q(Q[5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[6] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[7]_i_1_n_5 ),
        .Q(Q[6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[7] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[7]_i_1_n_4 ),
        .Q(Q[7]),
        .R(SR));
  CARRY4 \count_value_i_reg[7]_i_1 
       (.CI(\count_value_i_reg[3]_i_1_n_0 ),
        .CO({\count_value_i_reg[7]_i_1_n_0 ,\count_value_i_reg[7]_i_1_n_1 ,\count_value_i_reg[7]_i_1_n_2 ,\count_value_i_reg[7]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\count_value_i_reg[7]_i_1_n_4 ,\count_value_i_reg[7]_i_1_n_5 ,\count_value_i_reg[7]_i_1_n_6 ,\count_value_i_reg[7]_i_1_n_7 }),
        .S(Q[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[8] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[10]_i_1_n_7 ),
        .Q(Q[8]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \count_value_i_reg[9] 
       (.C(wr_clk),
        .CE(ena),
        .D(\count_value_i_reg[10]_i_1_n_6 ),
        .Q(Q[9]),
        .R(SR));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_fifo_async
   (overflow,
    wr_rst_busy,
    dout,
    underflow,
    \fifo_overflow_from_coupler_cnt_reg[11] ,
    \fifo_overflow_from_coupler_cnt_reg[10] ,
    \fifo_overflow_from_coupler_cnt_reg[9] ,
    \fifo_overflow_from_coupler_cnt_reg[8] ,
    \fifo_overflow_from_coupler_cnt_reg[7] ,
    \fifo_overflow_from_coupler_cnt_reg[6] ,
    \fifo_overflow_from_coupler_cnt_reg[5] ,
    \fifo_overflow_from_coupler_cnt_reg[4] ,
    \fifo_overflow_from_coupler_cnt_reg[3] ,
    \fifo_overflow_from_coupler_cnt_reg[2] ,
    \fifo_overflow_from_coupler_cnt_reg[1] ,
    m_axis_video_tvalid,
    \fifo_overflow_from_coupler_cnt_reg[0] ,
    fifo_overflow_from_coupler_pulse_reg,
    \fifo_overflow_from_coupler_cnt_reg[0]_0 ,
    fifo_overflow_from_coupler_pulse_reg_0,
    vid_io_in_clk,
    wr_en,
    din,
    aclk,
    D,
    m_axis_video_tready,
    aclken,
    Q,
    \fifo_overflow_from_coupler_cnt_reg[5]_0 ,
    \fifo_overflow_from_coupler_cnt_reg[10]_0 ,
    fifo_overflow_from_coupler_pulse_reg_1,
    vid_io_in_ce,
    vid_io_in_reset);
  output overflow;
  output wr_rst_busy;
  output [26:0]dout;
  output underflow;
  output \fifo_overflow_from_coupler_cnt_reg[11] ;
  output \fifo_overflow_from_coupler_cnt_reg[10] ;
  output \fifo_overflow_from_coupler_cnt_reg[9] ;
  output \fifo_overflow_from_coupler_cnt_reg[8] ;
  output \fifo_overflow_from_coupler_cnt_reg[7] ;
  output \fifo_overflow_from_coupler_cnt_reg[6] ;
  output \fifo_overflow_from_coupler_cnt_reg[5] ;
  output \fifo_overflow_from_coupler_cnt_reg[4] ;
  output \fifo_overflow_from_coupler_cnt_reg[3] ;
  output \fifo_overflow_from_coupler_cnt_reg[2] ;
  output \fifo_overflow_from_coupler_cnt_reg[1] ;
  output m_axis_video_tvalid;
  output \fifo_overflow_from_coupler_cnt_reg[0] ;
  output fifo_overflow_from_coupler_pulse_reg;
  output \fifo_overflow_from_coupler_cnt_reg[0]_0 ;
  input fifo_overflow_from_coupler_pulse_reg_0;
  input vid_io_in_clk;
  input wr_en;
  input [26:0]din;
  input aclk;
  input [10:0]D;
  input m_axis_video_tready;
  input aclken;
  input [0:0]Q;
  input \fifo_overflow_from_coupler_cnt_reg[5]_0 ;
  input \fifo_overflow_from_coupler_cnt_reg[10]_0 ;
  input fifo_overflow_from_coupler_pulse_reg_1;
  input vid_io_in_ce;
  input vid_io_in_reset;

  wire [10:0]D;
  wire [0:0]Q;
  wire aclk;
  wire aclken;
  wire [26:0]din;
  wire [26:0]dout;
  wire empty_i;
  wire \fifo_overflow_from_coupler_cnt_reg[0] ;
  wire \fifo_overflow_from_coupler_cnt_reg[0]_0 ;
  wire \fifo_overflow_from_coupler_cnt_reg[10] ;
  wire \fifo_overflow_from_coupler_cnt_reg[10]_0 ;
  wire \fifo_overflow_from_coupler_cnt_reg[11] ;
  wire \fifo_overflow_from_coupler_cnt_reg[1] ;
  wire \fifo_overflow_from_coupler_cnt_reg[2] ;
  wire \fifo_overflow_from_coupler_cnt_reg[3] ;
  wire \fifo_overflow_from_coupler_cnt_reg[4] ;
  wire \fifo_overflow_from_coupler_cnt_reg[5] ;
  wire \fifo_overflow_from_coupler_cnt_reg[5]_0 ;
  wire \fifo_overflow_from_coupler_cnt_reg[6] ;
  wire \fifo_overflow_from_coupler_cnt_reg[7] ;
  wire \fifo_overflow_from_coupler_cnt_reg[8] ;
  wire \fifo_overflow_from_coupler_cnt_reg[9] ;
  wire fifo_overflow_from_coupler_pulse_reg;
  wire fifo_overflow_from_coupler_pulse_reg_0;
  wire fifo_overflow_from_coupler_pulse_reg_1;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_i_3_n_0 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_0 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_10 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_11 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_12 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_13 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_14 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_17 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_18 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_2 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_3 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_4 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_47 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_48 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_49 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_5 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_50 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_51 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_52 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_53 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_54 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_55 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_56 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_57 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_58 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_59 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_6 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_61 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_62 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_63 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_64 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_65 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_7 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_8 ;
  wire \gnuram_async_fifo.xpm_fifo_base_inst_n_9 ;
  wire m_axis_video_tready;
  wire m_axis_video_tvalid;
  wire overflow;
  wire underflow;
  wire vid_io_in_ce;
  wire vid_io_in_clk;
  wire vid_io_in_reset;
  wire wr_en;
  wire wr_rst_busy;
  wire \NLW_gnuram_async_fifo.xpm_fifo_base_inst_full_n_UNCONNECTED ;

  LUT2 #(
    .INIT(4'hB)) 
    \fifo_overflow_from_coupler_cnt[0]_i_1 
       (.I0(overflow),
        .I1(Q),
        .O(\fifo_overflow_from_coupler_cnt_reg[0] ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \fifo_overflow_from_coupler_cnt[10]_i_1 
       (.I0(D[9]),
        .I1(overflow),
        .O(\fifo_overflow_from_coupler_cnt_reg[10] ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'hF700)) 
    \fifo_overflow_from_coupler_cnt[11]_i_1 
       (.I0(\fifo_overflow_from_coupler_cnt_reg[5]_0 ),
        .I1(\fifo_overflow_from_coupler_cnt_reg[10]_0 ),
        .I2(overflow),
        .I3(vid_io_in_ce),
        .O(\fifo_overflow_from_coupler_cnt_reg[0]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \fifo_overflow_from_coupler_cnt[11]_i_2 
       (.I0(D[10]),
        .I1(overflow),
        .O(\fifo_overflow_from_coupler_cnt_reg[11] ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \fifo_overflow_from_coupler_cnt[1]_i_1 
       (.I0(D[0]),
        .I1(overflow),
        .O(\fifo_overflow_from_coupler_cnt_reg[1] ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \fifo_overflow_from_coupler_cnt[2]_i_1 
       (.I0(D[1]),
        .I1(overflow),
        .O(\fifo_overflow_from_coupler_cnt_reg[2] ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \fifo_overflow_from_coupler_cnt[3]_i_1 
       (.I0(D[2]),
        .I1(overflow),
        .O(\fifo_overflow_from_coupler_cnt_reg[3] ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \fifo_overflow_from_coupler_cnt[4]_i_1 
       (.I0(D[3]),
        .I1(overflow),
        .O(\fifo_overflow_from_coupler_cnt_reg[4] ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \fifo_overflow_from_coupler_cnt[5]_i_1 
       (.I0(D[4]),
        .I1(overflow),
        .O(\fifo_overflow_from_coupler_cnt_reg[5] ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \fifo_overflow_from_coupler_cnt[6]_i_1 
       (.I0(D[5]),
        .I1(overflow),
        .O(\fifo_overflow_from_coupler_cnt_reg[6] ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \fifo_overflow_from_coupler_cnt[7]_i_1 
       (.I0(D[6]),
        .I1(overflow),
        .O(\fifo_overflow_from_coupler_cnt_reg[7] ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \fifo_overflow_from_coupler_cnt[8]_i_1 
       (.I0(D[7]),
        .I1(overflow),
        .O(\fifo_overflow_from_coupler_cnt_reg[8] ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \fifo_overflow_from_coupler_cnt[9]_i_1 
       (.I0(D[8]),
        .I1(overflow),
        .O(\fifo_overflow_from_coupler_cnt_reg[9] ));
  LUT6 #(
    .INIT(64'h00000000FF70F0F0)) 
    fifo_overflow_from_coupler_pulse_i_1
       (.I0(\fifo_overflow_from_coupler_cnt_reg[5]_0 ),
        .I1(\fifo_overflow_from_coupler_cnt_reg[10]_0 ),
        .I2(fifo_overflow_from_coupler_pulse_reg_1),
        .I3(overflow),
        .I4(vid_io_in_ce),
        .I5(vid_io_in_reset),
        .O(fifo_overflow_from_coupler_pulse_reg));
  (* CDC_DEST_SYNC_FF = "4" *) 
  (* COMMON_CLOCK = "0" *) 
  (* DOUT_RESET_VALUE = "0" *) 
  (* ECC_MODE = "0" *) 
  (* ENABLE_ECC = "0" *) 
  (* EN_ADV_FEATURE = "16'b0000011100000111" *) 
  (* EN_AE = "1'b0" *) 
  (* EN_AF = "1'b0" *) 
  (* EN_DVLD = "1'b0" *) 
  (* EN_OF = "1'b1" *) 
  (* EN_PE = "1'b1" *) 
  (* EN_PF = "1'b1" *) 
  (* EN_RDC = "1'b1" *) 
  (* EN_UF = "1'b1" *) 
  (* EN_WACK = "1'b0" *) 
  (* EN_WDC = "1'b1" *) 
  (* FG_EQ_ASYM_DOUT = "1'b0" *) 
  (* FIFO_MEMORY_TYPE = "0" *) 
  (* FIFO_MEM_TYPE = "0" *) 
  (* FIFO_READ_DEPTH = "2048" *) 
  (* FIFO_READ_LATENCY = "0" *) 
  (* FIFO_SIZE = "55296" *) 
  (* FIFO_WRITE_DEPTH = "2048" *) 
  (* FULL_RESET_VALUE = "1" *) 
  (* FULL_RST_VAL = "1'b1" *) 
  (* PE_THRESH_ADJ = "8" *) 
  (* PE_THRESH_MAX = "2043" *) 
  (* PE_THRESH_MIN = "5" *) 
  (* PF_THRESH_ADJ = "8" *) 
  (* PF_THRESH_MAX = "2043" *) 
  (* PF_THRESH_MIN = "9" *) 
  (* PROG_EMPTY_THRESH = "10" *) 
  (* PROG_FULL_THRESH = "10" *) 
  (* RD_DATA_COUNT_WIDTH = "12" *) 
  (* RD_DC_WIDTH_EXT = "12" *) 
  (* RD_LATENCY = "2" *) 
  (* RD_MODE = "1" *) 
  (* RD_PNTR_WIDTH = "11" *) 
  (* READ_DATA_WIDTH = "27" *) 
  (* READ_MODE = "1" *) 
  (* RELATED_CLOCKS = "0" *) 
  (* REMOVE_WR_RD_PROT_LOGIC = "0" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* USE_ADV_FEATURES = "0707" *) 
  (* VERSION = "0" *) 
  (* WAKEUP_TIME = "0" *) 
  (* WRITE_DATA_WIDTH = "27" *) 
  (* WR_DATA_COUNT_WIDTH = "12" *) 
  (* WR_DC_WIDTH_EXT = "12" *) 
  (* WR_PNTR_WIDTH = "11" *) 
  (* WR_RD_RATIO = "0" *) 
  (* XPM_MODULE = "TRUE" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_fifo_base \gnuram_async_fifo.xpm_fifo_base_inst 
       (.almost_empty(\gnuram_async_fifo.xpm_fifo_base_inst_n_62 ),
        .almost_full(\gnuram_async_fifo.xpm_fifo_base_inst_n_17 ),
        .data_valid(\gnuram_async_fifo.xpm_fifo_base_inst_n_63 ),
        .dbiterr(\gnuram_async_fifo.xpm_fifo_base_inst_n_65 ),
        .din(din),
        .dout(dout),
        .empty(empty_i),
        .full(\gnuram_async_fifo.xpm_fifo_base_inst_n_0 ),
        .full_n(\NLW_gnuram_async_fifo.xpm_fifo_base_inst_full_n_UNCONNECTED ),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .overflow(overflow),
        .prog_empty(\gnuram_async_fifo.xpm_fifo_base_inst_n_47 ),
        .prog_full(\gnuram_async_fifo.xpm_fifo_base_inst_n_2 ),
        .rd_clk(aclk),
        .rd_data_count({\gnuram_async_fifo.xpm_fifo_base_inst_n_48 ,\gnuram_async_fifo.xpm_fifo_base_inst_n_49 ,\gnuram_async_fifo.xpm_fifo_base_inst_n_50 ,\gnuram_async_fifo.xpm_fifo_base_inst_n_51 ,\gnuram_async_fifo.xpm_fifo_base_inst_n_52 ,\gnuram_async_fifo.xpm_fifo_base_inst_n_53 ,\gnuram_async_fifo.xpm_fifo_base_inst_n_54 ,\gnuram_async_fifo.xpm_fifo_base_inst_n_55 ,\gnuram_async_fifo.xpm_fifo_base_inst_n_56 ,\gnuram_async_fifo.xpm_fifo_base_inst_n_57 ,\gnuram_async_fifo.xpm_fifo_base_inst_n_58 ,\gnuram_async_fifo.xpm_fifo_base_inst_n_59 }),
        .rd_en(\gnuram_async_fifo.xpm_fifo_base_inst_i_3_n_0 ),
        .rd_rst_busy(\gnuram_async_fifo.xpm_fifo_base_inst_n_61 ),
        .rst(fifo_overflow_from_coupler_pulse_reg_0),
        .sbiterr(\gnuram_async_fifo.xpm_fifo_base_inst_n_64 ),
        .sleep(1'b0),
        .underflow(underflow),
        .wr_ack(\gnuram_async_fifo.xpm_fifo_base_inst_n_18 ),
        .wr_clk(vid_io_in_clk),
        .wr_data_count({\gnuram_async_fifo.xpm_fifo_base_inst_n_3 ,\gnuram_async_fifo.xpm_fifo_base_inst_n_4 ,\gnuram_async_fifo.xpm_fifo_base_inst_n_5 ,\gnuram_async_fifo.xpm_fifo_base_inst_n_6 ,\gnuram_async_fifo.xpm_fifo_base_inst_n_7 ,\gnuram_async_fifo.xpm_fifo_base_inst_n_8 ,\gnuram_async_fifo.xpm_fifo_base_inst_n_9 ,\gnuram_async_fifo.xpm_fifo_base_inst_n_10 ,\gnuram_async_fifo.xpm_fifo_base_inst_n_11 ,\gnuram_async_fifo.xpm_fifo_base_inst_n_12 ,\gnuram_async_fifo.xpm_fifo_base_inst_n_13 ,\gnuram_async_fifo.xpm_fifo_base_inst_n_14 }),
        .wr_en(wr_en),
        .wr_rst_busy(wr_rst_busy));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \gnuram_async_fifo.xpm_fifo_base_inst_i_3 
       (.I0(m_axis_video_tready),
        .I1(aclken),
        .I2(empty_i),
        .O(\gnuram_async_fifo.xpm_fifo_base_inst_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT1 #(
    .INIT(2'h1)) 
    m_axis_video_tvalid_INST_0
       (.I0(empty_i),
        .O(m_axis_video_tvalid));
endmodule

(* CDC_DEST_SYNC_FF = "4" *) (* COMMON_CLOCK = "0" *) (* DOUT_RESET_VALUE = "0" *) 
(* ECC_MODE = "0" *) (* ENABLE_ECC = "0" *) (* EN_ADV_FEATURE = "16'b0000011100000111" *) 
(* EN_AE = "1'b0" *) (* EN_AF = "1'b0" *) (* EN_DVLD = "1'b0" *) 
(* EN_OF = "1'b1" *) (* EN_PE = "1'b1" *) (* EN_PF = "1'b1" *) 
(* EN_RDC = "1'b1" *) (* EN_UF = "1'b1" *) (* EN_WACK = "1'b0" *) 
(* EN_WDC = "1'b1" *) (* FG_EQ_ASYM_DOUT = "1'b0" *) (* FIFO_MEMORY_TYPE = "0" *) 
(* FIFO_MEM_TYPE = "0" *) (* FIFO_READ_DEPTH = "2048" *) (* FIFO_READ_LATENCY = "0" *) 
(* FIFO_SIZE = "55296" *) (* FIFO_WRITE_DEPTH = "2048" *) (* FULL_RESET_VALUE = "1" *) 
(* FULL_RST_VAL = "1'b1" *) (* PE_THRESH_ADJ = "8" *) (* PE_THRESH_MAX = "2043" *) 
(* PE_THRESH_MIN = "5" *) (* PF_THRESH_ADJ = "8" *) (* PF_THRESH_MAX = "2043" *) 
(* PF_THRESH_MIN = "9" *) (* PROG_EMPTY_THRESH = "10" *) (* PROG_FULL_THRESH = "10" *) 
(* RD_DATA_COUNT_WIDTH = "12" *) (* RD_DC_WIDTH_EXT = "12" *) (* RD_LATENCY = "2" *) 
(* RD_MODE = "1" *) (* RD_PNTR_WIDTH = "11" *) (* READ_DATA_WIDTH = "27" *) 
(* READ_MODE = "1" *) (* RELATED_CLOCKS = "0" *) (* REMOVE_WR_RD_PROT_LOGIC = "0" *) 
(* SIM_ASSERT_CHK = "0" *) (* USE_ADV_FEATURES = "0707" *) (* VERSION = "0" *) 
(* WAKEUP_TIME = "0" *) (* WRITE_DATA_WIDTH = "27" *) (* WR_DATA_COUNT_WIDTH = "12" *) 
(* WR_DC_WIDTH_EXT = "12" *) (* WR_PNTR_WIDTH = "11" *) (* WR_RD_RATIO = "0" *) 
(* XPM_MODULE = "TRUE" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_fifo_base
   (sleep,
    rst,
    wr_clk,
    wr_en,
    din,
    full,
    full_n,
    prog_full,
    wr_data_count,
    overflow,
    wr_rst_busy,
    almost_full,
    wr_ack,
    rd_clk,
    rd_en,
    dout,
    empty,
    prog_empty,
    rd_data_count,
    underflow,
    rd_rst_busy,
    almost_empty,
    data_valid,
    injectsbiterr,
    injectdbiterr,
    sbiterr,
    dbiterr);
  input sleep;
  input rst;
  input wr_clk;
  input wr_en;
  input [26:0]din;
  output full;
  output full_n;
  output prog_full;
  output [11:0]wr_data_count;
  output overflow;
  output wr_rst_busy;
  output almost_full;
  output wr_ack;
  input rd_clk;
  input rd_en;
  output [26:0]dout;
  output empty;
  output prog_empty;
  output [11:0]rd_data_count;
  output underflow;
  output rd_rst_busy;
  output almost_empty;
  output data_valid;
  input injectsbiterr;
  input injectdbiterr;
  output sbiterr;
  output dbiterr;

  wire \<const0> ;
  wire [1:0]count_value_i;
  wire [10:0]diff_pntr_pe;
  wire [11:4]diff_pntr_pf_q;
  wire [11:4]diff_pntr_pf_q0;
  wire [26:0]din;
  wire [26:0]dout;
  wire empty;
  wire full;
  wire full_n;
  wire \gen_cdc_pntr.rpw_gray_reg_dc_n_0 ;
  wire \gen_cdc_pntr.rpw_gray_reg_dc_n_1 ;
  wire \gen_cdc_pntr.rpw_gray_reg_dc_n_10 ;
  wire \gen_cdc_pntr.rpw_gray_reg_dc_n_11 ;
  wire \gen_cdc_pntr.rpw_gray_reg_dc_n_2 ;
  wire \gen_cdc_pntr.rpw_gray_reg_dc_n_3 ;
  wire \gen_cdc_pntr.rpw_gray_reg_dc_n_4 ;
  wire \gen_cdc_pntr.rpw_gray_reg_dc_n_5 ;
  wire \gen_cdc_pntr.rpw_gray_reg_dc_n_6 ;
  wire \gen_cdc_pntr.rpw_gray_reg_dc_n_7 ;
  wire \gen_cdc_pntr.rpw_gray_reg_dc_n_8 ;
  wire \gen_cdc_pntr.rpw_gray_reg_dc_n_9 ;
  wire \gen_cdc_pntr.rpw_gray_reg_n_13 ;
  wire \gen_cdc_pntr.wpr_gray_reg_dc_n_12 ;
  wire \gen_cdc_pntr.wpr_gray_reg_dc_n_13 ;
  wire \gen_cdc_pntr.wpr_gray_reg_dc_n_14 ;
  wire \gen_cdc_pntr.wpr_gray_reg_dc_n_15 ;
  wire \gen_cdc_pntr.wpr_gray_reg_dc_n_16 ;
  wire \gen_cdc_pntr.wpr_gray_reg_dc_n_17 ;
  wire \gen_cdc_pntr.wpr_gray_reg_dc_n_18 ;
  wire \gen_cdc_pntr.wpr_gray_reg_dc_n_19 ;
  wire \gen_cdc_pntr.wpr_gray_reg_dc_n_20 ;
  wire \gen_cdc_pntr.wpr_gray_reg_dc_n_21 ;
  wire \gen_cdc_pntr.wpr_gray_reg_dc_n_22 ;
  wire \gen_cdc_pntr.wpr_gray_reg_dc_n_23 ;
  wire \gen_cdc_pntr.wpr_gray_reg_n_12 ;
  wire \gen_cdc_pntr.wpr_gray_reg_n_13 ;
  wire \gen_cdc_pntr.wpr_gray_reg_n_14 ;
  wire \gen_cdc_pntr.wpr_gray_reg_n_15 ;
  wire \gen_cdc_pntr.wpr_gray_reg_n_16 ;
  wire \gen_cdc_pntr.wpr_gray_reg_n_17 ;
  wire \gen_cdc_pntr.wpr_gray_reg_n_18 ;
  wire \gen_cdc_pntr.wpr_gray_reg_n_19 ;
  wire \gen_cdc_pntr.wpr_gray_reg_n_20 ;
  wire \gen_cdc_pntr.wpr_gray_reg_n_21 ;
  wire [1:0]\gen_fwft.curr_fwft_state ;
  wire \gen_fwft.empty_fwft_i_reg0 ;
  wire [1:0]\gen_fwft.next_fwft_state ;
  wire \gen_fwft.ram_regout_en ;
  wire \gen_fwft.rdpp1_inst_n_0 ;
  wire \gen_fwft.rdpp1_inst_n_1 ;
  wire \gen_fwft.rdpp1_inst_n_2 ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe[3]_i_2_n_0 ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[0] ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[10] ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[1] ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[2] ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[3] ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[4] ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[5] ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[6] ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[7] ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[8] ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[9] ;
  wire \gen_pf_ic_rc.gpe_ic.prog_empty_i_i_1_n_0 ;
  wire \gen_pf_ic_rc.gpe_ic.prog_empty_i_i_2_n_0 ;
  wire \gen_pf_ic_rc.gpe_ic.prog_empty_i_i_3_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.prog_full_i_i_2_n_0 ;
  wire \gen_pf_ic_rc.gpf_ic.prog_full_i_i_3_n_0 ;
  wire going_full0;
  wire [11:0]\grdc.diff_wr_rd_pntr_rdc ;
  wire \grdc.rd_data_count_i0 ;
  wire [11:0]\gwdc.diff_wr_rd_pntr1_out ;
  wire leaving_full;
  wire overflow;
  wire overflow_i0;
  wire prog_empty;
  wire prog_full;
  wire ram_empty_i;
  wire ram_empty_i0;
  wire rd_clk;
  wire [11:0]rd_data_count;
  wire rd_en;
  wire [10:0]rd_pntr_ext;
  wire [10:0]rd_pntr_wr;
  wire [10:0]rd_pntr_wr_cdc;
  wire [11:0]rd_pntr_wr_cdc_dc;
  wire rd_rst_busy;
  wire rd_rst_i;
  wire rdp_inst_n_23;
  wire rdp_inst_n_24;
  wire rdp_inst_n_25;
  wire rdp_inst_n_26;
  wire rdp_inst_n_27;
  wire rdp_inst_n_28;
  wire rdp_inst_n_29;
  wire rdp_inst_n_30;
  wire rdp_inst_n_31;
  wire rdp_inst_n_32;
  wire rdp_inst_n_33;
  wire rdp_inst_n_34;
  wire rdp_inst_n_35;
  wire rdp_inst_n_36;
  wire rdp_inst_n_37;
  wire rdp_inst_n_38;
  wire rdp_inst_n_39;
  wire rdp_inst_n_40;
  wire rdp_inst_n_41;
  wire rdp_inst_n_42;
  wire rdp_inst_n_43;
  wire rdp_inst_n_44;
  wire rdpp1_inst_n_0;
  wire rdpp1_inst_n_1;
  wire rdpp1_inst_n_10;
  wire rdpp1_inst_n_2;
  wire rdpp1_inst_n_3;
  wire rdpp1_inst_n_4;
  wire rdpp1_inst_n_5;
  wire rdpp1_inst_n_6;
  wire rdpp1_inst_n_7;
  wire rdpp1_inst_n_8;
  wire rdpp1_inst_n_9;
  wire rst;
  wire rst_d1;
  wire rst_d1_inst_n_1;
  wire sleep;
  wire [11:0]src_in_bin00_out;
  wire underflow;
  wire underflow_i0;
  wire wr_clk;
  wire [11:0]wr_data_count;
  wire wr_en;
  wire [11:0]wr_pntr_ext;
  wire [11:1]wr_pntr_plus1_pf;
  wire [10:0]wr_pntr_rd_cdc;
  wire [11:0]wr_pntr_rd_cdc_dc;
  wire wr_rst_busy;
  wire wrpp2_inst_n_0;
  wire wrpp2_inst_n_1;
  wire wrpp2_inst_n_10;
  wire wrpp2_inst_n_2;
  wire wrpp2_inst_n_3;
  wire wrpp2_inst_n_4;
  wire wrpp2_inst_n_5;
  wire wrpp2_inst_n_6;
  wire wrpp2_inst_n_7;
  wire wrpp2_inst_n_8;
  wire wrpp2_inst_n_9;
  wire xpm_fifo_rst_inst_n_10;
  wire xpm_fifo_rst_inst_n_2;
  wire xpm_fifo_rst_inst_n_3;
  wire xpm_fifo_rst_inst_n_4;
  wire xpm_fifo_rst_inst_n_9;
  wire \NLW_gen_sdpram.xpm_memory_base_inst_dbiterra_UNCONNECTED ;
  wire \NLW_gen_sdpram.xpm_memory_base_inst_dbiterrb_UNCONNECTED ;
  wire \NLW_gen_sdpram.xpm_memory_base_inst_sbiterra_UNCONNECTED ;
  wire \NLW_gen_sdpram.xpm_memory_base_inst_sbiterrb_UNCONNECTED ;
  wire [26:0]\NLW_gen_sdpram.xpm_memory_base_inst_douta_UNCONNECTED ;

  assign almost_empty = \<const0> ;
  assign almost_full = \<const0> ;
  assign data_valid = \<const0> ;
  assign dbiterr = \<const0> ;
  assign sbiterr = \<const0> ;
  assign wr_ack = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* DEST_SYNC_FF = "4" *) 
  (* INIT_SYNC_FF = "0" *) 
  (* REG_OUTPUT = "0" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
  (* VERSION = "0" *) 
  (* WIDTH = "12" *) 
  (* XPM_CDC = "GRAY" *) 
  (* XPM_MODULE = "TRUE" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_cdc_gray__parameterized1 \gen_cdc_pntr.rd_pntr_cdc_dc_inst 
       (.dest_clk(wr_clk),
        .dest_out_bin(rd_pntr_wr_cdc_dc),
        .src_clk(rd_clk),
        .src_in_bin(src_in_bin00_out));
  (* DEST_SYNC_FF = "4" *) 
  (* INIT_SYNC_FF = "0" *) 
  (* REG_OUTPUT = "0" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
  (* VERSION = "0" *) 
  (* WIDTH = "11" *) 
  (* XPM_CDC = "GRAY" *) 
  (* XPM_MODULE = "TRUE" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_cdc_gray \gen_cdc_pntr.rd_pntr_cdc_inst 
       (.dest_clk(wr_clk),
        .dest_out_bin(rd_pntr_wr_cdc),
        .src_clk(rd_clk),
        .src_in_bin(rd_pntr_ext));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_fifo_reg_vec \gen_cdc_pntr.rpw_gray_reg 
       (.CO(going_full0),
        .D(rd_pntr_wr_cdc),
        .Q(rd_pntr_wr),
        .SR(wr_rst_busy),
        .\count_value_i_reg[10] ({wrpp2_inst_n_0,wrpp2_inst_n_1,wrpp2_inst_n_2,wrpp2_inst_n_3,wrpp2_inst_n_4,wrpp2_inst_n_5,wrpp2_inst_n_6,wrpp2_inst_n_7,wrpp2_inst_n_8,wrpp2_inst_n_9,wrpp2_inst_n_10}),
        .\count_value_i_reg[10]_0 (wr_pntr_plus1_pf),
        .ena(xpm_fifo_rst_inst_n_10),
        .\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg (leaving_full),
        .\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg_0 (\gen_cdc_pntr.rpw_gray_reg_n_13 ),
        .rst(rst),
        .rst_d1(rst_d1),
        .wr_clk(wr_clk));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_fifo_reg_vec__parameterized0 \gen_cdc_pntr.rpw_gray_reg_dc 
       (.D(rd_pntr_wr_cdc_dc),
        .Q({\gen_cdc_pntr.rpw_gray_reg_dc_n_0 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_1 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_2 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_3 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_4 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_5 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_6 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_7 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_8 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_9 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_10 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_11 }),
        .SR(wr_rst_busy),
        .wr_clk(wr_clk));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_fifo_reg_vec_0 \gen_cdc_pntr.wpr_gray_reg 
       (.D(diff_pntr_pe),
        .DI(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe[3]_i_2_n_0 ),
        .Q(\gen_fwft.curr_fwft_state ),
        .S({rdp_inst_n_33,rdp_inst_n_34,rdp_inst_n_35,rdp_inst_n_36}),
        .SR(rd_rst_i),
        .\count_value_i_reg[10] ({rdp_inst_n_38,rdp_inst_n_39,rdp_inst_n_40}),
        .\count_value_i_reg[10]_0 ({rdpp1_inst_n_0,rdpp1_inst_n_1,rdpp1_inst_n_2,rdpp1_inst_n_3,rdpp1_inst_n_4,rdpp1_inst_n_5,rdpp1_inst_n_6,rdpp1_inst_n_7,rdpp1_inst_n_8,rdpp1_inst_n_9,rdpp1_inst_n_10}),
        .\count_value_i_reg[10]_1 (rd_pntr_ext),
        .\count_value_i_reg[7] ({rdp_inst_n_41,rdp_inst_n_42,rdp_inst_n_43,rdp_inst_n_44}),
        .\dest_graysync_ff_reg[3][10] (wr_pntr_rd_cdc),
        .\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] ({\gen_cdc_pntr.wpr_gray_reg_n_12 ,\gen_cdc_pntr.wpr_gray_reg_n_13 ,\gen_cdc_pntr.wpr_gray_reg_n_14 ,\gen_cdc_pntr.wpr_gray_reg_n_15 ,\gen_cdc_pntr.wpr_gray_reg_n_16 ,\gen_cdc_pntr.wpr_gray_reg_n_17 ,\gen_cdc_pntr.wpr_gray_reg_n_18 ,\gen_cdc_pntr.wpr_gray_reg_n_19 ,\gen_cdc_pntr.wpr_gray_reg_n_20 ,\gen_cdc_pntr.wpr_gray_reg_n_21 }),
        .ram_empty_i(ram_empty_i),
        .ram_empty_i0(ram_empty_i0),
        .rd_clk(rd_clk),
        .rd_en(rd_en));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_fifo_reg_vec__parameterized0_1 \gen_cdc_pntr.wpr_gray_reg_dc 
       (.D(\grdc.diff_wr_rd_pntr_rdc ),
        .DI({rdp_inst_n_32,\gen_fwft.rdpp1_inst_n_2 }),
        .Q({\gen_cdc_pntr.wpr_gray_reg_dc_n_12 ,\gen_cdc_pntr.wpr_gray_reg_dc_n_13 ,\gen_cdc_pntr.wpr_gray_reg_dc_n_14 ,\gen_cdc_pntr.wpr_gray_reg_dc_n_15 ,\gen_cdc_pntr.wpr_gray_reg_dc_n_16 ,\gen_cdc_pntr.wpr_gray_reg_dc_n_17 ,\gen_cdc_pntr.wpr_gray_reg_dc_n_18 ,\gen_cdc_pntr.wpr_gray_reg_dc_n_19 ,\gen_cdc_pntr.wpr_gray_reg_dc_n_20 ,\gen_cdc_pntr.wpr_gray_reg_dc_n_21 ,\gen_cdc_pntr.wpr_gray_reg_dc_n_22 ,\gen_cdc_pntr.wpr_gray_reg_dc_n_23 }),
        .S({rdp_inst_n_23,\gen_fwft.rdpp1_inst_n_0 ,\gen_fwft.rdpp1_inst_n_1 }),
        .SR(rd_rst_i),
        .count_value_i(count_value_i[1]),
        .\count_value_i_reg[10] ({rdp_inst_n_28,rdp_inst_n_29,rdp_inst_n_30,rdp_inst_n_31}),
        .\count_value_i_reg[6] ({rdp_inst_n_24,rdp_inst_n_25,rdp_inst_n_26,rdp_inst_n_27}),
        .\count_value_i_reg[9] (rd_pntr_ext[9:1]),
        .\dest_graysync_ff_reg[5][11] (wr_pntr_rd_cdc_dc),
        .rd_clk(rd_clk));
  (* DEST_SYNC_FF = "6" *) 
  (* INIT_SYNC_FF = "0" *) 
  (* REG_OUTPUT = "0" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
  (* VERSION = "0" *) 
  (* WIDTH = "12" *) 
  (* XPM_CDC = "GRAY" *) 
  (* XPM_MODULE = "TRUE" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_cdc_gray__parameterized0 \gen_cdc_pntr.wr_pntr_cdc_dc_inst 
       (.dest_clk(rd_clk),
        .dest_out_bin(wr_pntr_rd_cdc_dc),
        .src_clk(wr_clk),
        .src_in_bin(wr_pntr_ext));
  (* DEST_SYNC_FF = "4" *) 
  (* INIT_SYNC_FF = "0" *) 
  (* REG_OUTPUT = "0" *) 
  (* SIM_ASSERT_CHK = "0" *) 
  (* SIM_LOSSLESS_GRAY_CHK = "0" *) 
  (* VERSION = "0" *) 
  (* WIDTH = "11" *) 
  (* XPM_CDC = "GRAY" *) 
  (* XPM_MODULE = "TRUE" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_cdc_gray__1 \gen_cdc_pntr.wr_pntr_cdc_inst 
       (.dest_clk(rd_clk),
        .dest_out_bin(wr_pntr_rd_cdc),
        .src_clk(wr_clk),
        .src_in_bin(wr_pntr_ext[10:0]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hBA)) 
    \gen_fwft.curr_fwft_state[0]_i_1 
       (.I0(\gen_fwft.curr_fwft_state [1]),
        .I1(rd_en),
        .I2(\gen_fwft.curr_fwft_state [0]),
        .O(\gen_fwft.next_fwft_state [0]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h20FF)) 
    \gen_fwft.curr_fwft_state[1]_i_1 
       (.I0(\gen_fwft.curr_fwft_state [1]),
        .I1(rd_en),
        .I2(\gen_fwft.curr_fwft_state [0]),
        .I3(ram_empty_i),
        .O(\gen_fwft.next_fwft_state [1]));
  FDRE #(
    .INIT(1'b0)) 
    \gen_fwft.curr_fwft_state_reg[0] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\gen_fwft.next_fwft_state [0]),
        .Q(\gen_fwft.curr_fwft_state [0]),
        .R(rd_rst_i));
  FDRE #(
    .INIT(1'b0)) 
    \gen_fwft.curr_fwft_state_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\gen_fwft.next_fwft_state [1]),
        .Q(\gen_fwft.curr_fwft_state [1]),
        .R(rd_rst_i));
  LUT4 #(
    .INIT(16'hF320)) 
    \gen_fwft.empty_fwft_i_i_1 
       (.I0(rd_en),
        .I1(\gen_fwft.curr_fwft_state [1]),
        .I2(\gen_fwft.curr_fwft_state [0]),
        .I3(empty),
        .O(\gen_fwft.empty_fwft_i_reg0 ));
  FDSE #(
    .INIT(1'b1)) 
    \gen_fwft.empty_fwft_i_reg 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\gen_fwft.empty_fwft_i_reg0 ),
        .Q(empty),
        .S(rd_rst_i));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_counter_updn \gen_fwft.rdpp1_inst 
       (.DI(\gen_fwft.rdpp1_inst_n_2 ),
        .Q(rd_pntr_ext[1:0]),
        .S({\gen_fwft.rdpp1_inst_n_0 ,\gen_fwft.rdpp1_inst_n_1 }),
        .SR(rd_rst_i),
        .count_value_i(count_value_i),
        .\gen_fwft.curr_fwft_state_reg[1] (\gen_fwft.curr_fwft_state ),
        .ram_empty_i(ram_empty_i),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .\reg_out_i_reg[1] ({\gen_cdc_pntr.wpr_gray_reg_dc_n_22 ,\gen_cdc_pntr.wpr_gray_reg_dc_n_23 }));
  FDSE #(
    .INIT(1'b1)) 
    \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gen_cdc_pntr.rpw_gray_reg_n_13 ),
        .Q(full),
        .S(wr_rst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gen_full_rst_val.ram_full_n_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(xpm_fifo_rst_inst_n_9),
        .Q(full_n),
        .R(1'b0));
  LUT4 #(
    .INIT(16'hBAAA)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe[3]_i_2 
       (.I0(ram_empty_i),
        .I1(rd_en),
        .I2(\gen_fwft.curr_fwft_state [1]),
        .I3(\gen_fwft.curr_fwft_state [0]),
        .O(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe[3]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[0] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(diff_pntr_pe[0]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[0] ),
        .R(rd_rst_i));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(diff_pntr_pe[10]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[10] ),
        .R(rd_rst_i));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(diff_pntr_pe[1]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[1] ),
        .R(rd_rst_i));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[2] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(diff_pntr_pe[2]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[2] ),
        .R(rd_rst_i));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(diff_pntr_pe[3]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[3] ),
        .R(rd_rst_i));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[4] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(diff_pntr_pe[4]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[4] ),
        .R(rd_rst_i));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[5] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(diff_pntr_pe[5]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[5] ),
        .R(rd_rst_i));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[6] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(diff_pntr_pe[6]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[6] ),
        .R(rd_rst_i));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(diff_pntr_pe[7]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[7] ),
        .R(rd_rst_i));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[8] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(diff_pntr_pe[8]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[8] ),
        .R(rd_rst_i));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[9] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(diff_pntr_pe[9]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[9] ),
        .R(rd_rst_i));
  LUT3 #(
    .INIT(8'hB8)) 
    \gen_pf_ic_rc.gpe_ic.prog_empty_i_i_1 
       (.I0(prog_empty),
        .I1(empty),
        .I2(\gen_pf_ic_rc.gpe_ic.prog_empty_i_i_2_n_0 ),
        .O(\gen_pf_ic_rc.gpe_ic.prog_empty_i_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000010)) 
    \gen_pf_ic_rc.gpe_ic.prog_empty_i_i_2 
       (.I0(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[9] ),
        .I1(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[7] ),
        .I2(\gen_pf_ic_rc.gpe_ic.prog_empty_i_i_3_n_0 ),
        .I3(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[6] ),
        .I4(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[8] ),
        .I5(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[10] ),
        .O(\gen_pf_ic_rc.gpe_ic.prog_empty_i_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000015555)) 
    \gen_pf_ic_rc.gpe_ic.prog_empty_i_i_3 
       (.I0(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[4] ),
        .I1(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[1] ),
        .I2(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[2] ),
        .I3(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[0] ),
        .I4(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[3] ),
        .I5(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg_n_0_[5] ),
        .O(\gen_pf_ic_rc.gpe_ic.prog_empty_i_i_3_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \gen_pf_ic_rc.gpe_ic.prog_empty_i_reg 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\gen_pf_ic_rc.gpe_ic.prog_empty_i_i_1_n_0 ),
        .Q(prog_empty),
        .S(rd_rst_i));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[10] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(diff_pntr_pf_q0[10]),
        .Q(diff_pntr_pf_q[10]),
        .R(wr_rst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[11] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(diff_pntr_pf_q0[11]),
        .Q(diff_pntr_pf_q[11]),
        .R(wr_rst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(diff_pntr_pf_q0[4]),
        .Q(diff_pntr_pf_q[4]),
        .R(wr_rst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[5] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(diff_pntr_pf_q0[5]),
        .Q(diff_pntr_pf_q[5]),
        .R(wr_rst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[6] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(diff_pntr_pf_q0[6]),
        .Q(diff_pntr_pf_q[6]),
        .R(wr_rst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[7] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(diff_pntr_pf_q0[7]),
        .Q(diff_pntr_pf_q[7]),
        .R(wr_rst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[8] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(diff_pntr_pf_q0[8]),
        .Q(diff_pntr_pf_q[8]),
        .R(wr_rst_busy));
  FDRE #(
    .INIT(1'b0)) 
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[9] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(diff_pntr_pf_q0[9]),
        .Q(diff_pntr_pf_q[9]),
        .R(wr_rst_busy));
  LUT5 #(
    .INIT(32'hFFFEFFFF)) 
    \gen_pf_ic_rc.gpf_ic.prog_full_i_i_2 
       (.I0(diff_pntr_pf_q[4]),
        .I1(diff_pntr_pf_q[5]),
        .I2(diff_pntr_pf_q[6]),
        .I3(diff_pntr_pf_q[7]),
        .I4(\gen_pf_ic_rc.gpf_ic.prog_full_i_i_3_n_0 ),
        .O(\gen_pf_ic_rc.gpf_ic.prog_full_i_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \gen_pf_ic_rc.gpf_ic.prog_full_i_i_3 
       (.I0(diff_pntr_pf_q[10]),
        .I1(diff_pntr_pf_q[11]),
        .I2(diff_pntr_pf_q[9]),
        .I3(diff_pntr_pf_q[8]),
        .O(\gen_pf_ic_rc.gpf_ic.prog_full_i_i_3_n_0 ));
  FDSE #(
    .INIT(1'b1)) 
    \gen_pf_ic_rc.gpf_ic.prog_full_i_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(rst_d1_inst_n_1),
        .Q(prog_full),
        .S(wr_rst_busy));
  FDSE #(
    .INIT(1'b1)) 
    \gen_pf_ic_rc.ram_empty_i_reg 
       (.C(rd_clk),
        .CE(1'b1),
        .D(ram_empty_i0),
        .Q(ram_empty_i),
        .S(rd_rst_i));
  (* ADDR_WIDTH_A = "11" *) 
  (* ADDR_WIDTH_B = "11" *) 
  (* AUTO_SLEEP_TIME = "0" *) 
  (* BYTE_WRITE_WIDTH_A = "27" *) 
  (* BYTE_WRITE_WIDTH_B = "27" *) 
  (* CLOCKING_MODE = "1" *) 
  (* ECC_MODE = "0" *) 
  (* MAX_NUM_CHAR = "0" *) 
  (* \MEM.ADDRESS_SPACE  *) 
  (* \MEM.ADDRESS_SPACE_BEGIN  = "0" *) 
  (* \MEM.ADDRESS_SPACE_DATA_LSB  = "0" *) 
  (* \MEM.ADDRESS_SPACE_DATA_MSB  = "26" *) 
  (* \MEM.ADDRESS_SPACE_END  = "2047" *) 
  (* \MEM.CORE_MEMORY_WIDTH  = "27" *) 
  (* MEMORY_INIT_FILE = "none" *) 
  (* MEMORY_INIT_PARAM = "" *) 
  (* MEMORY_OPTIMIZATION = "true" *) 
  (* MEMORY_PRIMITIVE = "0" *) 
  (* MEMORY_SIZE = "55296" *) 
  (* MEMORY_TYPE = "1" *) 
  (* MESSAGE_CONTROL = "0" *) 
  (* NUM_CHAR_LOC = "0" *) 
  (* P_ECC_MODE = "no_ecc" *) 
  (* P_ENABLE_BYTE_WRITE_A = "0" *) 
  (* P_ENABLE_BYTE_WRITE_B = "0" *) 
  (* P_MAX_DEPTH_DATA = "2048" *) 
  (* P_MEMORY_OPT = "yes" *) 
  (* P_MEMORY_PRIMITIVE = "auto" *) 
  (* P_MIN_WIDTH_DATA = "27" *) 
  (* P_MIN_WIDTH_DATA_A = "27" *) 
  (* P_MIN_WIDTH_DATA_B = "27" *) 
  (* P_MIN_WIDTH_DATA_ECC = "27" *) 
  (* P_MIN_WIDTH_DATA_LDW = "4" *) 
  (* P_MIN_WIDTH_DATA_SHFT = "27" *) 
  (* P_NUM_COLS_WRITE_A = "1" *) 
  (* P_NUM_COLS_WRITE_B = "1" *) 
  (* P_NUM_ROWS_READ_A = "1" *) 
  (* P_NUM_ROWS_READ_B = "1" *) 
  (* P_NUM_ROWS_WRITE_A = "1" *) 
  (* P_NUM_ROWS_WRITE_B = "1" *) 
  (* P_SDP_WRITE_MODE = "yes" *) 
  (* P_WIDTH_ADDR_LSB_READ_A = "0" *) 
  (* P_WIDTH_ADDR_LSB_READ_B = "0" *) 
  (* P_WIDTH_ADDR_LSB_WRITE_A = "0" *) 
  (* P_WIDTH_ADDR_LSB_WRITE_B = "0" *) 
  (* P_WIDTH_ADDR_READ_A = "11" *) 
  (* P_WIDTH_ADDR_READ_B = "11" *) 
  (* P_WIDTH_ADDR_WRITE_A = "11" *) 
  (* P_WIDTH_ADDR_WRITE_B = "11" *) 
  (* P_WIDTH_COL_WRITE_A = "27" *) 
  (* P_WIDTH_COL_WRITE_B = "27" *) 
  (* READ_DATA_WIDTH_A = "27" *) 
  (* READ_DATA_WIDTH_B = "27" *) 
  (* READ_LATENCY_A = "2" *) 
  (* READ_LATENCY_B = "2" *) 
  (* READ_RESET_VALUE_A = "0" *) 
  (* READ_RESET_VALUE_B = "0" *) 
  (* USE_EMBEDDED_CONSTRAINT = "0" *) 
  (* USE_MEM_INIT = "1" *) 
  (* VERSION = "0" *) 
  (* WAKEUP_TIME = "0" *) 
  (* WRITE_DATA_WIDTH_A = "27" *) 
  (* WRITE_DATA_WIDTH_B = "27" *) 
  (* WRITE_MODE_A = "2" *) 
  (* WRITE_MODE_B = "2" *) 
  (* XPM_MODULE = "TRUE" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_memory_base \gen_sdpram.xpm_memory_base_inst 
       (.addra(wr_pntr_ext[10:0]),
        .addrb(rd_pntr_ext),
        .clka(wr_clk),
        .clkb(rd_clk),
        .dbiterra(\NLW_gen_sdpram.xpm_memory_base_inst_dbiterra_UNCONNECTED ),
        .dbiterrb(\NLW_gen_sdpram.xpm_memory_base_inst_dbiterrb_UNCONNECTED ),
        .dina(din),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(\NLW_gen_sdpram.xpm_memory_base_inst_douta_UNCONNECTED [26:0]),
        .doutb(dout),
        .ena(xpm_fifo_rst_inst_n_10),
        .enb(rdp_inst_n_37),
        .injectdbiterra(1'b0),
        .injectdbiterrb(1'b0),
        .injectsbiterra(1'b0),
        .injectsbiterrb(1'b0),
        .regcea(1'b0),
        .regceb(\gen_fwft.ram_regout_en ),
        .rsta(1'b0),
        .rstb(rd_rst_i),
        .sbiterra(\NLW_gen_sdpram.xpm_memory_base_inst_sbiterra_UNCONNECTED ),
        .sbiterrb(\NLW_gen_sdpram.xpm_memory_base_inst_sbiterrb_UNCONNECTED ),
        .sleep(sleep),
        .wea(1'b0),
        .web(1'b0));
  LUT3 #(
    .INIT(8'hA2)) 
    \gen_sdpram.xpm_memory_base_inst_i_4 
       (.I0(\gen_fwft.curr_fwft_state [1]),
        .I1(\gen_fwft.curr_fwft_state [0]),
        .I2(rd_en),
        .O(\gen_fwft.ram_regout_en ));
  FDRE #(
    .INIT(1'b0)) 
    \gof.overflow_i_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(overflow_i0),
        .Q(overflow),
        .R(1'b0));
  FDRE \grdc.rd_data_count_i_reg[0] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\grdc.diff_wr_rd_pntr_rdc [0]),
        .Q(rd_data_count[0]),
        .R(\grdc.rd_data_count_i0 ));
  FDRE \grdc.rd_data_count_i_reg[10] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\grdc.diff_wr_rd_pntr_rdc [10]),
        .Q(rd_data_count[10]),
        .R(\grdc.rd_data_count_i0 ));
  FDRE \grdc.rd_data_count_i_reg[11] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\grdc.diff_wr_rd_pntr_rdc [11]),
        .Q(rd_data_count[11]),
        .R(\grdc.rd_data_count_i0 ));
  FDRE \grdc.rd_data_count_i_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\grdc.diff_wr_rd_pntr_rdc [1]),
        .Q(rd_data_count[1]),
        .R(\grdc.rd_data_count_i0 ));
  FDRE \grdc.rd_data_count_i_reg[2] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\grdc.diff_wr_rd_pntr_rdc [2]),
        .Q(rd_data_count[2]),
        .R(\grdc.rd_data_count_i0 ));
  FDRE \grdc.rd_data_count_i_reg[3] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\grdc.diff_wr_rd_pntr_rdc [3]),
        .Q(rd_data_count[3]),
        .R(\grdc.rd_data_count_i0 ));
  FDRE \grdc.rd_data_count_i_reg[4] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\grdc.diff_wr_rd_pntr_rdc [4]),
        .Q(rd_data_count[4]),
        .R(\grdc.rd_data_count_i0 ));
  FDRE \grdc.rd_data_count_i_reg[5] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\grdc.diff_wr_rd_pntr_rdc [5]),
        .Q(rd_data_count[5]),
        .R(\grdc.rd_data_count_i0 ));
  FDRE \grdc.rd_data_count_i_reg[6] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\grdc.diff_wr_rd_pntr_rdc [6]),
        .Q(rd_data_count[6]),
        .R(\grdc.rd_data_count_i0 ));
  FDRE \grdc.rd_data_count_i_reg[7] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\grdc.diff_wr_rd_pntr_rdc [7]),
        .Q(rd_data_count[7]),
        .R(\grdc.rd_data_count_i0 ));
  FDRE \grdc.rd_data_count_i_reg[8] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\grdc.diff_wr_rd_pntr_rdc [8]),
        .Q(rd_data_count[8]),
        .R(\grdc.rd_data_count_i0 ));
  FDRE \grdc.rd_data_count_i_reg[9] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\grdc.diff_wr_rd_pntr_rdc [9]),
        .Q(rd_data_count[9]),
        .R(\grdc.rd_data_count_i0 ));
  FDRE #(
    .INIT(1'b0)) 
    \guf.underflow_i_reg 
       (.C(rd_clk),
        .CE(1'b1),
        .D(underflow_i0),
        .Q(underflow),
        .R(1'b0));
  FDRE \gwdc.wr_data_count_i_reg[0] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gwdc.diff_wr_rd_pntr1_out [0]),
        .Q(wr_data_count[0]),
        .R(wr_rst_busy));
  FDRE \gwdc.wr_data_count_i_reg[10] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gwdc.diff_wr_rd_pntr1_out [10]),
        .Q(wr_data_count[10]),
        .R(wr_rst_busy));
  FDRE \gwdc.wr_data_count_i_reg[11] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gwdc.diff_wr_rd_pntr1_out [11]),
        .Q(wr_data_count[11]),
        .R(wr_rst_busy));
  FDRE \gwdc.wr_data_count_i_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gwdc.diff_wr_rd_pntr1_out [1]),
        .Q(wr_data_count[1]),
        .R(wr_rst_busy));
  FDRE \gwdc.wr_data_count_i_reg[2] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gwdc.diff_wr_rd_pntr1_out [2]),
        .Q(wr_data_count[2]),
        .R(wr_rst_busy));
  FDRE \gwdc.wr_data_count_i_reg[3] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gwdc.diff_wr_rd_pntr1_out [3]),
        .Q(wr_data_count[3]),
        .R(wr_rst_busy));
  FDRE \gwdc.wr_data_count_i_reg[4] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gwdc.diff_wr_rd_pntr1_out [4]),
        .Q(wr_data_count[4]),
        .R(wr_rst_busy));
  FDRE \gwdc.wr_data_count_i_reg[5] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gwdc.diff_wr_rd_pntr1_out [5]),
        .Q(wr_data_count[5]),
        .R(wr_rst_busy));
  FDRE \gwdc.wr_data_count_i_reg[6] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gwdc.diff_wr_rd_pntr1_out [6]),
        .Q(wr_data_count[6]),
        .R(wr_rst_busy));
  FDRE \gwdc.wr_data_count_i_reg[7] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gwdc.diff_wr_rd_pntr1_out [7]),
        .Q(wr_data_count[7]),
        .R(wr_rst_busy));
  FDRE \gwdc.wr_data_count_i_reg[8] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gwdc.diff_wr_rd_pntr1_out [8]),
        .Q(wr_data_count[8]),
        .R(wr_rst_busy));
  FDRE \gwdc.wr_data_count_i_reg[9] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gwdc.diff_wr_rd_pntr1_out [9]),
        .Q(wr_data_count[9]),
        .R(wr_rst_busy));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_counter_updn__parameterized0 rdp_inst
       (.DI(rdp_inst_n_32),
        .E(rdp_inst_n_37),
        .Q(rd_pntr_ext),
        .S(rdp_inst_n_23),
        .SR(rd_rst_i),
        .count_value_i(count_value_i),
        .\gen_fwft.curr_fwft_state_reg[1] (\gen_fwft.curr_fwft_state ),
        .\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] ({rdp_inst_n_38,rdp_inst_n_39,rdp_inst_n_40}),
        .\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3] ({rdp_inst_n_33,rdp_inst_n_34,rdp_inst_n_35,rdp_inst_n_36}),
        .\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7] ({rdp_inst_n_41,rdp_inst_n_42,rdp_inst_n_43,rdp_inst_n_44}),
        .\grdc.rd_data_count_i_reg[11] ({rdp_inst_n_28,rdp_inst_n_29,rdp_inst_n_30,rdp_inst_n_31}),
        .\grdc.rd_data_count_i_reg[7] ({rdp_inst_n_24,rdp_inst_n_25,rdp_inst_n_26,rdp_inst_n_27}),
        .ram_empty_i(ram_empty_i),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .\reg_out_i_reg[10] ({\gen_cdc_pntr.wpr_gray_reg_n_12 ,\gen_cdc_pntr.wpr_gray_reg_n_13 ,\gen_cdc_pntr.wpr_gray_reg_n_14 ,\gen_cdc_pntr.wpr_gray_reg_n_15 ,\gen_cdc_pntr.wpr_gray_reg_n_16 ,\gen_cdc_pntr.wpr_gray_reg_n_17 ,\gen_cdc_pntr.wpr_gray_reg_n_18 ,\gen_cdc_pntr.wpr_gray_reg_n_19 ,\gen_cdc_pntr.wpr_gray_reg_n_20 ,\gen_cdc_pntr.wpr_gray_reg_n_21 }),
        .\reg_out_i_reg[11] ({\gen_cdc_pntr.wpr_gray_reg_dc_n_12 ,\gen_cdc_pntr.wpr_gray_reg_dc_n_13 ,\gen_cdc_pntr.wpr_gray_reg_dc_n_14 ,\gen_cdc_pntr.wpr_gray_reg_dc_n_15 ,\gen_cdc_pntr.wpr_gray_reg_dc_n_16 ,\gen_cdc_pntr.wpr_gray_reg_dc_n_17 ,\gen_cdc_pntr.wpr_gray_reg_dc_n_18 ,\gen_cdc_pntr.wpr_gray_reg_dc_n_19 ,\gen_cdc_pntr.wpr_gray_reg_dc_n_20 ,\gen_cdc_pntr.wpr_gray_reg_dc_n_21 ,\gen_cdc_pntr.wpr_gray_reg_dc_n_22 }),
        .src_in_bin(src_in_bin00_out));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_counter_updn__parameterized1 rdpp1_inst
       (.E(rdp_inst_n_37),
        .Q({rdpp1_inst_n_0,rdpp1_inst_n_1,rdpp1_inst_n_2,rdpp1_inst_n_3,rdpp1_inst_n_4,rdpp1_inst_n_5,rdpp1_inst_n_6,rdpp1_inst_n_7,rdpp1_inst_n_8,rdpp1_inst_n_9,rdpp1_inst_n_10}),
        .SR(rd_rst_i),
        .\gen_fwft.curr_fwft_state_reg[1] (\gen_fwft.curr_fwft_state ),
        .ram_empty_i(ram_empty_i),
        .rd_clk(rd_clk),
        .rd_en(rd_en));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_fifo_reg_bit rst_d1_inst
       (.SR(wr_rst_busy),
        .\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg (full),
        .\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4] (\gen_pf_ic_rc.gpf_ic.prog_full_i_i_2_n_0 ),
        .\gen_pf_ic_rc.gpf_ic.prog_full_i_reg (rst_d1_inst_n_1),
        .prog_full(prog_full),
        .rst(rst),
        .rst_d1(rst_d1),
        .wr_clk(wr_clk));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_counter_updn__parameterized0_2 wrp_inst
       (.D(\gwdc.diff_wr_rd_pntr1_out ),
        .Q(wr_pntr_ext),
        .S(xpm_fifo_rst_inst_n_4),
        .SR(wr_rst_busy),
        .ena(xpm_fifo_rst_inst_n_10),
        .\reg_out_i_reg[11] ({\gen_cdc_pntr.rpw_gray_reg_dc_n_0 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_1 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_2 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_3 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_4 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_5 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_6 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_7 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_8 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_9 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_10 ,\gen_cdc_pntr.rpw_gray_reg_dc_n_11 }),
        .wr_clk(wr_clk));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_counter_updn__parameterized1_3 wrpp1_inst
       (.D(diff_pntr_pf_q0),
        .Q(wr_pntr_plus1_pf),
        .S(xpm_fifo_rst_inst_n_3),
        .SR(wr_rst_busy),
        .ena(xpm_fifo_rst_inst_n_10),
        .\reg_out_i_reg[10] (rd_pntr_wr),
        .wr_clk(wr_clk));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_counter_updn__parameterized2 wrpp2_inst
       (.Q({wrpp2_inst_n_0,wrpp2_inst_n_1,wrpp2_inst_n_2,wrpp2_inst_n_3,wrpp2_inst_n_4,wrpp2_inst_n_5,wrpp2_inst_n_6,wrpp2_inst_n_7,wrpp2_inst_n_8,wrpp2_inst_n_9,wrpp2_inst_n_10}),
        .S(xpm_fifo_rst_inst_n_2),
        .SR(wr_rst_busy),
        .ena(xpm_fifo_rst_inst_n_10),
        .wr_clk(wr_clk));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_fifo_rst xpm_fifo_rst_inst
       (.CO(going_full0),
        .Q(wrpp2_inst_n_10),
        .S(xpm_fifo_rst_inst_n_2),
        .SR(wr_rst_busy),
        .\count_value_i_reg[0] (rd_rst_i),
        .\count_value_i_reg[0]_0 (wr_pntr_plus1_pf[1]),
        .\count_value_i_reg[0]_1 (wr_pntr_ext[0]),
        .\count_value_i_reg[3] (xpm_fifo_rst_inst_n_3),
        .\count_value_i_reg[3]_0 (xpm_fifo_rst_inst_n_4),
        .dest_rst(rd_rst_busy),
        .ena(xpm_fifo_rst_inst_n_10),
        .\gen_fwft.curr_fwft_state_reg[1] (\gen_fwft.curr_fwft_state ),
        .\gen_fwft.empty_fwft_i_reg (empty),
        .\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg (full),
        .\gen_pf_ic_rc.gen_full_rst_val.ram_full_n_reg (xpm_fifo_rst_inst_n_9),
        .\grdc.rd_data_count_i_reg[0] (\grdc.rd_data_count_i0 ),
        .overflow_i0(overflow_i0),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .\reg_out_i_reg[9] (leaving_full),
        .rst(rst),
        .rst_d1(rst_d1),
        .underflow_i0(underflow_i0),
        .wr_clk(wr_clk),
        .wr_en(wr_en));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_fifo_reg_bit
   (rst_d1,
    \gen_pf_ic_rc.gpf_ic.prog_full_i_reg ,
    SR,
    wr_clk,
    \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4] ,
    rst,
    \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg ,
    prog_full);
  output rst_d1;
  output \gen_pf_ic_rc.gpf_ic.prog_full_i_reg ;
  input [0:0]SR;
  input wr_clk;
  input \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4] ;
  input rst;
  input \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg ;
  input prog_full;

  wire [0:0]SR;
  wire \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg ;
  wire \gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4] ;
  wire \gen_pf_ic_rc.gpf_ic.prog_full_i_reg ;
  wire prog_full;
  wire rst;
  wire rst_d1;
  wire wr_clk;

  FDRE #(
    .INIT(1'b0)) 
    d_out_reg
       (.C(wr_clk),
        .CE(1'b1),
        .D(SR),
        .Q(rst_d1),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hF3A200A2)) 
    \gen_pf_ic_rc.gpf_ic.prog_full_i_i_1 
       (.I0(\gen_pf_ic_rc.gpf_ic.diff_pntr_pf_q_reg[4] ),
        .I1(rst_d1),
        .I2(rst),
        .I3(\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg ),
        .I4(prog_full),
        .O(\gen_pf_ic_rc.gpf_ic.prog_full_i_reg ));
endmodule

(* ORIG_REF_NAME = "xpm_fifo_reg_bit" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_fifo_reg_bit_4
   (d_out,
    \gen_rst_ic.fifo_wr_rst_i_reg ,
    wr_clk);
  output d_out;
  input \gen_rst_ic.fifo_wr_rst_i_reg ;
  input wr_clk;

  wire d_out;
  wire \gen_rst_ic.fifo_wr_rst_i_reg ;
  wire wr_clk;

  FDRE #(
    .INIT(1'b0)) 
    d_out_reg
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gen_rst_ic.fifo_wr_rst_i_reg ),
        .Q(d_out),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "xpm_fifo_reg_bit" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_fifo_reg_bit_5
   (\gen_rst_ic.fifo_wr_rst_d2 ,
    \gen_rst_ic.fifo_wr_rst_done_reg ,
    d_out,
    wr_clk,
    rst,
    Q,
    \gen_rst_ic.fifo_wr_rst_done ,
    \gen_rst_ic.fifo_rd_rst_done ,
    \gen_rst_ic.fifo_wr_rst_d3 );
  output \gen_rst_ic.fifo_wr_rst_d2 ;
  output \gen_rst_ic.fifo_wr_rst_done_reg ;
  input d_out;
  input wr_clk;
  input rst;
  input [0:0]Q;
  input \gen_rst_ic.fifo_wr_rst_done ;
  input \gen_rst_ic.fifo_rd_rst_done ;
  input \gen_rst_ic.fifo_wr_rst_d3 ;

  wire [0:0]Q;
  wire d_out;
  wire \gen_rst_ic.fifo_rd_rst_done ;
  wire \gen_rst_ic.fifo_wr_rst_d2 ;
  wire \gen_rst_ic.fifo_wr_rst_d3 ;
  wire \gen_rst_ic.fifo_wr_rst_done ;
  wire \gen_rst_ic.fifo_wr_rst_done_reg ;
  wire rst;
  wire wr_clk;

  FDRE #(
    .INIT(1'b0)) 
    d_out_reg
       (.C(wr_clk),
        .CE(1'b1),
        .D(d_out),
        .Q(\gen_rst_ic.fifo_wr_rst_d2 ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hE0F0FFFFE0F0E0F0)) 
    \gen_rst_ic.fifo_wr_rst_done_i_1 
       (.I0(rst),
        .I1(Q),
        .I2(\gen_rst_ic.fifo_wr_rst_done ),
        .I3(\gen_rst_ic.fifo_rd_rst_done ),
        .I4(\gen_rst_ic.fifo_wr_rst_d3 ),
        .I5(\gen_rst_ic.fifo_wr_rst_d2 ),
        .O(\gen_rst_ic.fifo_wr_rst_done_reg ));
endmodule

(* ORIG_REF_NAME = "xpm_fifo_reg_bit" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_fifo_reg_bit_6
   (d_out_reg,
    dest_rst,
    rd_clk);
  output d_out_reg;
  input dest_rst;
  input rd_clk;

  wire d_out_reg;
  wire dest_rst;
  wire rd_clk;

  (* srl_bus_name = "inst/\COUPLER_INST/generate_async_fifo.FIFO_INST/XPM_FIFO_ASYNC_INST/gnuram_async_fifo.xpm_fifo_base_inst /\xpm_fifo_rst_inst/gen_rst_ic.rrst_rd_inst/gen_pipe_bit " *) 
  (* srl_name = "inst/\COUPLER_INST/generate_async_fifo.FIFO_INST/XPM_FIFO_ASYNC_INST/gnuram_async_fifo.xpm_fifo_base_inst /\xpm_fifo_rst_inst/gen_rst_ic.rrst_rd_inst/gen_pipe_bit[1].pipe_bit_inst/d_out_reg_srl2 " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    d_out_reg_srl2
       (.A0(1'b1),
        .A1(1'b0),
        .A2(1'b0),
        .A3(1'b0),
        .CE(1'b1),
        .CLK(rd_clk),
        .D(dest_rst),
        .Q(d_out_reg));
endmodule

(* ORIG_REF_NAME = "xpm_fifo_reg_bit" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_fifo_reg_bit_7
   (\syncstages_ff_reg[0] ,
    underflow_i0,
    \grdc.rd_data_count_i_reg[0] ,
    \count_value_i_reg[0] ,
    \syncstages_ff_reg[3] ,
    rd_clk,
    rd_en,
    \gen_fwft.empty_fwft_i_reg ,
    dest_rst,
    \gen_fwft.curr_fwft_state_reg[1] );
  output \syncstages_ff_reg[0] ;
  output underflow_i0;
  output [0:0]\grdc.rd_data_count_i_reg[0] ;
  output [0:0]\count_value_i_reg[0] ;
  input \syncstages_ff_reg[3] ;
  input rd_clk;
  input rd_en;
  input \gen_fwft.empty_fwft_i_reg ;
  input dest_rst;
  input [1:0]\gen_fwft.curr_fwft_state_reg[1] ;

  wire [0:0]\count_value_i_reg[0] ;
  wire dest_rst;
  wire [1:0]\gen_fwft.curr_fwft_state_reg[1] ;
  wire \gen_fwft.empty_fwft_i_reg ;
  wire [0:0]\grdc.rd_data_count_i_reg[0] ;
  wire rd_clk;
  wire rd_en;
  wire \syncstages_ff_reg[0] ;
  wire \syncstages_ff_reg[3] ;
  wire underflow_i0;

  FDRE #(
    .INIT(1'b0)) 
    d_out_reg
       (.C(rd_clk),
        .CE(1'b1),
        .D(\syncstages_ff_reg[3] ),
        .Q(\syncstages_ff_reg[0] ),
        .R(1'b0));
  LUT2 #(
    .INIT(4'hE)) 
    \gen_sdpram.xpm_memory_base_inst_i_2 
       (.I0(dest_rst),
        .I1(\syncstages_ff_reg[0] ),
        .O(\count_value_i_reg[0] ));
  LUT4 #(
    .INIT(16'hEEEF)) 
    \grdc.rd_data_count_i[11]_i_1 
       (.I0(\syncstages_ff_reg[0] ),
        .I1(dest_rst),
        .I2(\gen_fwft.curr_fwft_state_reg[1] [0]),
        .I3(\gen_fwft.curr_fwft_state_reg[1] [1]),
        .O(\grdc.rd_data_count_i_reg[0] ));
  LUT4 #(
    .INIT(16'hAAA8)) 
    \guf.underflow_i_i_1 
       (.I0(rd_en),
        .I1(\gen_fwft.empty_fwft_i_reg ),
        .I2(dest_rst),
        .I3(\syncstages_ff_reg[0] ),
        .O(underflow_i0));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_fifo_reg_vec
   (CO,
    \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg ,
    Q,
    \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg_0 ,
    \count_value_i_reg[10] ,
    \count_value_i_reg[10]_0 ,
    ena,
    rst_d1,
    rst,
    SR,
    D,
    wr_clk);
  output [0:0]CO;
  output [0:0]\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg ;
  output [10:0]Q;
  output \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg_0 ;
  input [10:0]\count_value_i_reg[10] ;
  input [10:0]\count_value_i_reg[10]_0 ;
  input ena;
  input rst_d1;
  input rst;
  input [0:0]SR;
  input [10:0]D;
  input wr_clk;

  wire [0:0]CO;
  wire [10:0]D;
  wire [10:0]Q;
  wire [0:0]SR;
  wire [10:0]\count_value_i_reg[10] ;
  wire [10:0]\count_value_i_reg[10]_0 ;
  wire ena;
  wire \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_10_n_0 ;
  wire \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_11_n_0 ;
  wire \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_4_n_0 ;
  wire \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_5_n_0 ;
  wire \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_6_n_0 ;
  wire \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_7_n_0 ;
  wire \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_8_n_0 ;
  wire \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_9_n_0 ;
  wire [0:0]\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg ;
  wire \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg_0 ;
  wire \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg_i_2_n_1 ;
  wire \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg_i_2_n_2 ;
  wire \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg_i_2_n_3 ;
  wire \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg_i_3_n_1 ;
  wire \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg_i_3_n_2 ;
  wire \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg_i_3_n_3 ;
  wire rst;
  wire rst_d1;
  wire wr_clk;
  wire [3:0]\NLW_gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg_i_2_O_UNCONNECTED ;
  wire [3:0]\NLW_gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg_i_3_O_UNCONNECTED ;

  LUT5 #(
    .INIT(32'hF8F800F8)) 
    \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_1 
       (.I0(CO),
        .I1(ena),
        .I2(\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg ),
        .I3(rst_d1),
        .I4(rst),
        .O(\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_10 
       (.I0(Q[3]),
        .I1(\count_value_i_reg[10]_0 [3]),
        .I2(\count_value_i_reg[10]_0 [5]),
        .I3(Q[5]),
        .I4(\count_value_i_reg[10]_0 [4]),
        .I5(Q[4]),
        .O(\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_11 
       (.I0(Q[0]),
        .I1(\count_value_i_reg[10]_0 [0]),
        .I2(\count_value_i_reg[10]_0 [2]),
        .I3(Q[2]),
        .I4(\count_value_i_reg[10]_0 [1]),
        .I5(Q[1]),
        .O(\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_11_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_4 
       (.I0(Q[9]),
        .I1(\count_value_i_reg[10] [9]),
        .I2(Q[10]),
        .I3(\count_value_i_reg[10] [10]),
        .O(\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_5 
       (.I0(Q[6]),
        .I1(\count_value_i_reg[10] [6]),
        .I2(\count_value_i_reg[10] [8]),
        .I3(Q[8]),
        .I4(\count_value_i_reg[10] [7]),
        .I5(Q[7]),
        .O(\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_6 
       (.I0(Q[3]),
        .I1(\count_value_i_reg[10] [3]),
        .I2(\count_value_i_reg[10] [5]),
        .I3(Q[5]),
        .I4(\count_value_i_reg[10] [4]),
        .I5(Q[4]),
        .O(\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_7 
       (.I0(Q[0]),
        .I1(\count_value_i_reg[10] [0]),
        .I2(\count_value_i_reg[10] [2]),
        .I3(Q[2]),
        .I4(\count_value_i_reg[10] [1]),
        .I5(Q[1]),
        .O(\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_7_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_8 
       (.I0(Q[9]),
        .I1(\count_value_i_reg[10]_0 [9]),
        .I2(Q[10]),
        .I3(\count_value_i_reg[10]_0 [10]),
        .O(\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_9 
       (.I0(Q[6]),
        .I1(\count_value_i_reg[10]_0 [6]),
        .I2(\count_value_i_reg[10]_0 [8]),
        .I3(Q[8]),
        .I4(\count_value_i_reg[10]_0 [7]),
        .I5(Q[7]),
        .O(\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_9_n_0 ));
  CARRY4 \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg_i_2 
       (.CI(1'b0),
        .CO({CO,\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg_i_2_n_1 ,\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg_i_2_n_2 ,\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg_i_2_n_3 }),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg_i_2_O_UNCONNECTED [3:0]),
        .S({\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_4_n_0 ,\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_5_n_0 ,\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_6_n_0 ,\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_7_n_0 }));
  CARRY4 \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg_i_3 
       (.CI(1'b0),
        .CO({\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg ,\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg_i_3_n_1 ,\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg_i_3_n_2 ,\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg_i_3_n_3 }),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg_i_3_O_UNCONNECTED [3:0]),
        .S({\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_8_n_0 ,\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_9_n_0 ,\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_10_n_0 ,\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_i_11_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[0] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[0]),
        .Q(Q[0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[10] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[10]),
        .Q(Q[10]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[1]),
        .Q(Q[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[2] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[2]),
        .Q(Q[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[3] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[3]),
        .Q(Q[3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[4] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[4]),
        .Q(Q[4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[5] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[5]),
        .Q(Q[5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[6] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[6]),
        .Q(Q[6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[7] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[7]),
        .Q(Q[7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[8] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[8]),
        .Q(Q[8]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[9] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[9]),
        .Q(Q[9]),
        .R(SR));
endmodule

(* ORIG_REF_NAME = "xpm_fifo_reg_vec" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_fifo_reg_vec_0
   (ram_empty_i0,
    D,
    \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] ,
    Q,
    rd_en,
    ram_empty_i,
    DI,
    S,
    \count_value_i_reg[7] ,
    \count_value_i_reg[10] ,
    \count_value_i_reg[10]_0 ,
    \count_value_i_reg[10]_1 ,
    SR,
    \dest_graysync_ff_reg[3][10] ,
    rd_clk);
  output ram_empty_i0;
  output [10:0]D;
  output [9:0]\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] ;
  input [1:0]Q;
  input rd_en;
  input ram_empty_i;
  input [0:0]DI;
  input [3:0]S;
  input [3:0]\count_value_i_reg[7] ;
  input [2:0]\count_value_i_reg[10] ;
  input [10:0]\count_value_i_reg[10]_0 ;
  input [10:0]\count_value_i_reg[10]_1 ;
  input [0:0]SR;
  input [10:0]\dest_graysync_ff_reg[3][10] ;
  input rd_clk;

  wire [10:0]D;
  wire [0:0]DI;
  wire [1:0]Q;
  wire [3:0]S;
  wire [0:0]SR;
  wire [2:0]\count_value_i_reg[10] ;
  wire [10:0]\count_value_i_reg[10]_0 ;
  wire [10:0]\count_value_i_reg[10]_1 ;
  wire [3:0]\count_value_i_reg[7] ;
  wire [10:0]\dest_graysync_ff_reg[3][10] ;
  wire [9:0]\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10]_i_1_n_2 ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10]_i_1_n_3 ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3]_i_1_n_0 ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3]_i_1_n_1 ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3]_i_1_n_2 ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3]_i_1_n_3 ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7]_i_1_n_0 ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7]_i_1_n_1 ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7]_i_1_n_2 ;
  wire \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7]_i_1_n_3 ;
  wire \gen_pf_ic_rc.ram_empty_i_i_10_n_0 ;
  wire \gen_pf_ic_rc.ram_empty_i_i_11_n_0 ;
  wire \gen_pf_ic_rc.ram_empty_i_i_4_n_0 ;
  wire \gen_pf_ic_rc.ram_empty_i_i_5_n_0 ;
  wire \gen_pf_ic_rc.ram_empty_i_i_6_n_0 ;
  wire \gen_pf_ic_rc.ram_empty_i_i_7_n_0 ;
  wire \gen_pf_ic_rc.ram_empty_i_i_8_n_0 ;
  wire \gen_pf_ic_rc.ram_empty_i_i_9_n_0 ;
  wire \gen_pf_ic_rc.ram_empty_i_reg_i_2_n_1 ;
  wire \gen_pf_ic_rc.ram_empty_i_reg_i_2_n_2 ;
  wire \gen_pf_ic_rc.ram_empty_i_reg_i_2_n_3 ;
  wire \gen_pf_ic_rc.ram_empty_i_reg_i_3_n_1 ;
  wire \gen_pf_ic_rc.ram_empty_i_reg_i_3_n_2 ;
  wire \gen_pf_ic_rc.ram_empty_i_reg_i_3_n_3 ;
  wire going_empty0;
  wire leaving_empty;
  wire ram_empty_i;
  wire ram_empty_i0;
  wire rd_clk;
  wire rd_en;
  wire \reg_out_i_reg_n_0_[0] ;
  wire [3:2]\NLW_gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10]_i_1_CO_UNCONNECTED ;
  wire [3:3]\NLW_gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10]_i_1_O_UNCONNECTED ;
  wire [3:0]\NLW_gen_pf_ic_rc.ram_empty_i_reg_i_2_O_UNCONNECTED ;
  wire [3:0]\NLW_gen_pf_ic_rc.ram_empty_i_reg_i_3_O_UNCONNECTED ;

  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10]_i_1 
       (.CI(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7]_i_1_n_0 ),
        .CO({\NLW_gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10]_i_1_CO_UNCONNECTED [3:2],\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10]_i_1_n_2 ,\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [8:7]}),
        .O({\NLW_gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10]_i_1_O_UNCONNECTED [3],D[10:8]}),
        .S({1'b0,\count_value_i_reg[10] }));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3]_i_1 
       (.CI(1'b0),
        .CO({\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3]_i_1_n_0 ,\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3]_i_1_n_1 ,\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3]_i_1_n_2 ,\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3]_i_1_n_3 }),
        .CYINIT(\reg_out_i_reg_n_0_[0] ),
        .DI({\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [2:0],DI}),
        .O(D[3:0]),
        .S(S));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7]_i_1 
       (.CI(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[3]_i_1_n_0 ),
        .CO({\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7]_i_1_n_0 ,\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7]_i_1_n_1 ,\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7]_i_1_n_2 ,\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[7]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [6:3]),
        .O(D[7:4]),
        .S(\count_value_i_reg[7] ));
  LUT6 #(
    .INIT(64'hAAAAFFBFAAAAAAAA)) 
    \gen_pf_ic_rc.ram_empty_i_i_1 
       (.I0(leaving_empty),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(rd_en),
        .I4(ram_empty_i),
        .I5(going_empty0),
        .O(ram_empty_i0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pf_ic_rc.ram_empty_i_i_10 
       (.I0(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [2]),
        .I1(\count_value_i_reg[10]_0 [3]),
        .I2(\count_value_i_reg[10]_0 [5]),
        .I3(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [4]),
        .I4(\count_value_i_reg[10]_0 [4]),
        .I5(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [3]),
        .O(\gen_pf_ic_rc.ram_empty_i_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pf_ic_rc.ram_empty_i_i_11 
       (.I0(\reg_out_i_reg_n_0_[0] ),
        .I1(\count_value_i_reg[10]_0 [0]),
        .I2(\count_value_i_reg[10]_0 [2]),
        .I3(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [1]),
        .I4(\count_value_i_reg[10]_0 [1]),
        .I5(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [0]),
        .O(\gen_pf_ic_rc.ram_empty_i_i_11_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \gen_pf_ic_rc.ram_empty_i_i_4 
       (.I0(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [8]),
        .I1(\count_value_i_reg[10]_1 [9]),
        .I2(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [9]),
        .I3(\count_value_i_reg[10]_1 [10]),
        .O(\gen_pf_ic_rc.ram_empty_i_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pf_ic_rc.ram_empty_i_i_5 
       (.I0(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [5]),
        .I1(\count_value_i_reg[10]_1 [6]),
        .I2(\count_value_i_reg[10]_1 [8]),
        .I3(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [7]),
        .I4(\count_value_i_reg[10]_1 [7]),
        .I5(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [6]),
        .O(\gen_pf_ic_rc.ram_empty_i_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pf_ic_rc.ram_empty_i_i_6 
       (.I0(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [2]),
        .I1(\count_value_i_reg[10]_1 [3]),
        .I2(\count_value_i_reg[10]_1 [5]),
        .I3(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [4]),
        .I4(\count_value_i_reg[10]_1 [4]),
        .I5(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [3]),
        .O(\gen_pf_ic_rc.ram_empty_i_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pf_ic_rc.ram_empty_i_i_7 
       (.I0(\reg_out_i_reg_n_0_[0] ),
        .I1(\count_value_i_reg[10]_1 [0]),
        .I2(\count_value_i_reg[10]_1 [2]),
        .I3(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [1]),
        .I4(\count_value_i_reg[10]_1 [1]),
        .I5(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [0]),
        .O(\gen_pf_ic_rc.ram_empty_i_i_7_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \gen_pf_ic_rc.ram_empty_i_i_8 
       (.I0(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [8]),
        .I1(\count_value_i_reg[10]_0 [9]),
        .I2(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [9]),
        .I3(\count_value_i_reg[10]_0 [10]),
        .O(\gen_pf_ic_rc.ram_empty_i_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \gen_pf_ic_rc.ram_empty_i_i_9 
       (.I0(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [5]),
        .I1(\count_value_i_reg[10]_0 [6]),
        .I2(\count_value_i_reg[10]_0 [8]),
        .I3(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [7]),
        .I4(\count_value_i_reg[10]_0 [7]),
        .I5(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [6]),
        .O(\gen_pf_ic_rc.ram_empty_i_i_9_n_0 ));
  CARRY4 \gen_pf_ic_rc.ram_empty_i_reg_i_2 
       (.CI(1'b0),
        .CO({leaving_empty,\gen_pf_ic_rc.ram_empty_i_reg_i_2_n_1 ,\gen_pf_ic_rc.ram_empty_i_reg_i_2_n_2 ,\gen_pf_ic_rc.ram_empty_i_reg_i_2_n_3 }),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_gen_pf_ic_rc.ram_empty_i_reg_i_2_O_UNCONNECTED [3:0]),
        .S({\gen_pf_ic_rc.ram_empty_i_i_4_n_0 ,\gen_pf_ic_rc.ram_empty_i_i_5_n_0 ,\gen_pf_ic_rc.ram_empty_i_i_6_n_0 ,\gen_pf_ic_rc.ram_empty_i_i_7_n_0 }));
  CARRY4 \gen_pf_ic_rc.ram_empty_i_reg_i_3 
       (.CI(1'b0),
        .CO({going_empty0,\gen_pf_ic_rc.ram_empty_i_reg_i_3_n_1 ,\gen_pf_ic_rc.ram_empty_i_reg_i_3_n_2 ,\gen_pf_ic_rc.ram_empty_i_reg_i_3_n_3 }),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_gen_pf_ic_rc.ram_empty_i_reg_i_3_O_UNCONNECTED [3:0]),
        .S({\gen_pf_ic_rc.ram_empty_i_i_8_n_0 ,\gen_pf_ic_rc.ram_empty_i_i_9_n_0 ,\gen_pf_ic_rc.ram_empty_i_i_10_n_0 ,\gen_pf_ic_rc.ram_empty_i_i_11_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[0] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff_reg[3][10] [0]),
        .Q(\reg_out_i_reg_n_0_[0] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[10] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff_reg[3][10] [10]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [9]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff_reg[3][10] [1]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[2] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff_reg[3][10] [2]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[3] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff_reg[3][10] [3]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[4] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff_reg[3][10] [4]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[5] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff_reg[3][10] [5]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[6] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff_reg[3][10] [6]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[7] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff_reg[3][10] [7]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[8] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff_reg[3][10] [8]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[9] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff_reg[3][10] [9]),
        .Q(\gen_pf_ic_rc.gpe_ic.diff_pntr_pe_reg[10] [8]),
        .R(SR));
endmodule

(* ORIG_REF_NAME = "xpm_fifo_reg_vec" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_fifo_reg_vec__parameterized0
   (Q,
    SR,
    D,
    wr_clk);
  output [11:0]Q;
  input [0:0]SR;
  input [11:0]D;
  input wr_clk;

  wire [11:0]D;
  wire [11:0]Q;
  wire [0:0]SR;
  wire wr_clk;

  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[0] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[0]),
        .Q(Q[0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[10] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[10]),
        .Q(Q[10]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[11] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[11]),
        .Q(Q[11]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[1]),
        .Q(Q[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[2] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[2]),
        .Q(Q[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[3] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[3]),
        .Q(Q[3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[4] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[4]),
        .Q(Q[4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[5] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[5]),
        .Q(Q[5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[6] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[6]),
        .Q(Q[6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[7] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[7]),
        .Q(Q[7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[8] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[8]),
        .Q(Q[8]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[9] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(D[9]),
        .Q(Q[9]),
        .R(SR));
endmodule

(* ORIG_REF_NAME = "xpm_fifo_reg_vec" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_fifo_reg_vec__parameterized0_1
   (D,
    Q,
    DI,
    S,
    \count_value_i_reg[6] ,
    \count_value_i_reg[10] ,
    count_value_i,
    \count_value_i_reg[9] ,
    SR,
    \dest_graysync_ff_reg[5][11] ,
    rd_clk);
  output [11:0]D;
  output [11:0]Q;
  input [1:0]DI;
  input [2:0]S;
  input [3:0]\count_value_i_reg[6] ;
  input [3:0]\count_value_i_reg[10] ;
  input [0:0]count_value_i;
  input [8:0]\count_value_i_reg[9] ;
  input [0:0]SR;
  input [11:0]\dest_graysync_ff_reg[5][11] ;
  input rd_clk;

  wire [11:0]D;
  wire [1:0]DI;
  wire [11:0]Q;
  wire [2:0]S;
  wire [0:0]SR;
  wire [0:0]count_value_i;
  wire [3:0]\count_value_i_reg[10] ;
  wire [3:0]\count_value_i_reg[6] ;
  wire [8:0]\count_value_i_reg[9] ;
  wire [11:0]\dest_graysync_ff_reg[5][11] ;
  wire \grdc.rd_data_count_i[11]_i_3_n_0 ;
  wire \grdc.rd_data_count_i[11]_i_4_n_0 ;
  wire \grdc.rd_data_count_i[11]_i_5_n_0 ;
  wire \grdc.rd_data_count_i[3]_i_2_n_0 ;
  wire \grdc.rd_data_count_i[3]_i_6_n_0 ;
  wire \grdc.rd_data_count_i[7]_i_2_n_0 ;
  wire \grdc.rd_data_count_i[7]_i_3_n_0 ;
  wire \grdc.rd_data_count_i[7]_i_4_n_0 ;
  wire \grdc.rd_data_count_i[7]_i_5_n_0 ;
  wire \grdc.rd_data_count_i_reg[11]_i_2_n_1 ;
  wire \grdc.rd_data_count_i_reg[11]_i_2_n_2 ;
  wire \grdc.rd_data_count_i_reg[11]_i_2_n_3 ;
  wire \grdc.rd_data_count_i_reg[3]_i_1_n_0 ;
  wire \grdc.rd_data_count_i_reg[3]_i_1_n_1 ;
  wire \grdc.rd_data_count_i_reg[3]_i_1_n_2 ;
  wire \grdc.rd_data_count_i_reg[3]_i_1_n_3 ;
  wire \grdc.rd_data_count_i_reg[7]_i_1_n_0 ;
  wire \grdc.rd_data_count_i_reg[7]_i_1_n_1 ;
  wire \grdc.rd_data_count_i_reg[7]_i_1_n_2 ;
  wire \grdc.rd_data_count_i_reg[7]_i_1_n_3 ;
  wire rd_clk;
  wire [3:3]\NLW_grdc.rd_data_count_i_reg[11]_i_2_CO_UNCONNECTED ;

  LUT2 #(
    .INIT(4'h2)) 
    \grdc.rd_data_count_i[11]_i_3 
       (.I0(Q[9]),
        .I1(\count_value_i_reg[9] [8]),
        .O(\grdc.rd_data_count_i[11]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \grdc.rd_data_count_i[11]_i_4 
       (.I0(Q[8]),
        .I1(\count_value_i_reg[9] [7]),
        .O(\grdc.rd_data_count_i[11]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \grdc.rd_data_count_i[11]_i_5 
       (.I0(Q[7]),
        .I1(\count_value_i_reg[9] [6]),
        .O(\grdc.rd_data_count_i[11]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \grdc.rd_data_count_i[3]_i_2 
       (.I0(Q[2]),
        .I1(\count_value_i_reg[9] [1]),
        .O(\grdc.rd_data_count_i[3]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h718E8E71)) 
    \grdc.rd_data_count_i[3]_i_6 
       (.I0(Q[1]),
        .I1(count_value_i),
        .I2(\count_value_i_reg[9] [0]),
        .I3(\count_value_i_reg[9] [1]),
        .I4(Q[2]),
        .O(\grdc.rd_data_count_i[3]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \grdc.rd_data_count_i[7]_i_2 
       (.I0(Q[6]),
        .I1(\count_value_i_reg[9] [5]),
        .O(\grdc.rd_data_count_i[7]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \grdc.rd_data_count_i[7]_i_3 
       (.I0(Q[5]),
        .I1(\count_value_i_reg[9] [4]),
        .O(\grdc.rd_data_count_i[7]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \grdc.rd_data_count_i[7]_i_4 
       (.I0(Q[4]),
        .I1(\count_value_i_reg[9] [3]),
        .O(\grdc.rd_data_count_i[7]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \grdc.rd_data_count_i[7]_i_5 
       (.I0(Q[3]),
        .I1(\count_value_i_reg[9] [2]),
        .O(\grdc.rd_data_count_i[7]_i_5_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \grdc.rd_data_count_i_reg[11]_i_2 
       (.CI(\grdc.rd_data_count_i_reg[7]_i_1_n_0 ),
        .CO({\NLW_grdc.rd_data_count_i_reg[11]_i_2_CO_UNCONNECTED [3],\grdc.rd_data_count_i_reg[11]_i_2_n_1 ,\grdc.rd_data_count_i_reg[11]_i_2_n_2 ,\grdc.rd_data_count_i_reg[11]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,\grdc.rd_data_count_i[11]_i_3_n_0 ,\grdc.rd_data_count_i[11]_i_4_n_0 ,\grdc.rd_data_count_i[11]_i_5_n_0 }),
        .O(D[11:8]),
        .S(\count_value_i_reg[10] ));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \grdc.rd_data_count_i_reg[3]_i_1 
       (.CI(1'b0),
        .CO({\grdc.rd_data_count_i_reg[3]_i_1_n_0 ,\grdc.rd_data_count_i_reg[3]_i_1_n_1 ,\grdc.rd_data_count_i_reg[3]_i_1_n_2 ,\grdc.rd_data_count_i_reg[3]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\grdc.rd_data_count_i[3]_i_2_n_0 ,DI,Q[0]}),
        .O(D[3:0]),
        .S({S[2],\grdc.rd_data_count_i[3]_i_6_n_0 ,S[1:0]}));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \grdc.rd_data_count_i_reg[7]_i_1 
       (.CI(\grdc.rd_data_count_i_reg[3]_i_1_n_0 ),
        .CO({\grdc.rd_data_count_i_reg[7]_i_1_n_0 ,\grdc.rd_data_count_i_reg[7]_i_1_n_1 ,\grdc.rd_data_count_i_reg[7]_i_1_n_2 ,\grdc.rd_data_count_i_reg[7]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({\grdc.rd_data_count_i[7]_i_2_n_0 ,\grdc.rd_data_count_i[7]_i_3_n_0 ,\grdc.rd_data_count_i[7]_i_4_n_0 ,\grdc.rd_data_count_i[7]_i_5_n_0 }),
        .O(D[7:4]),
        .S(\count_value_i_reg[6] ));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[0] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff_reg[5][11] [0]),
        .Q(Q[0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[10] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff_reg[5][11] [10]),
        .Q(Q[10]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[11] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff_reg[5][11] [11]),
        .Q(Q[11]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[1] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff_reg[5][11] [1]),
        .Q(Q[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[2] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff_reg[5][11] [2]),
        .Q(Q[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[3] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff_reg[5][11] [3]),
        .Q(Q[3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[4] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff_reg[5][11] [4]),
        .Q(Q[4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[5] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff_reg[5][11] [5]),
        .Q(Q[5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[6] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff_reg[5][11] [6]),
        .Q(Q[6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[7] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff_reg[5][11] [7]),
        .Q(Q[7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[8] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff_reg[5][11] [8]),
        .Q(Q[8]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \reg_out_i_reg[9] 
       (.C(rd_clk),
        .CE(1'b1),
        .D(\dest_graysync_ff_reg[5][11] [9]),
        .Q(Q[9]),
        .R(SR));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_fifo_rst
   (dest_rst,
    overflow_i0,
    S,
    \count_value_i_reg[3] ,
    \count_value_i_reg[3]_0 ,
    SR,
    underflow_i0,
    \grdc.rd_data_count_i_reg[0] ,
    \count_value_i_reg[0] ,
    \gen_pf_ic_rc.gen_full_rst_val.ram_full_n_reg ,
    ena,
    rd_clk,
    wr_clk,
    wr_en,
    \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg ,
    Q,
    \count_value_i_reg[0]_0 ,
    \count_value_i_reg[0]_1 ,
    rst,
    rd_en,
    \gen_fwft.empty_fwft_i_reg ,
    \gen_fwft.curr_fwft_state_reg[1] ,
    rst_d1,
    CO,
    \reg_out_i_reg[9] );
  output dest_rst;
  output overflow_i0;
  output [0:0]S;
  output [0:0]\count_value_i_reg[3] ;
  output [0:0]\count_value_i_reg[3]_0 ;
  output [0:0]SR;
  output underflow_i0;
  output [0:0]\grdc.rd_data_count_i_reg[0] ;
  output [0:0]\count_value_i_reg[0] ;
  output \gen_pf_ic_rc.gen_full_rst_val.ram_full_n_reg ;
  output ena;
  input rd_clk;
  input wr_clk;
  input wr_en;
  input \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg ;
  input [0:0]Q;
  input [0:0]\count_value_i_reg[0]_0 ;
  input [0:0]\count_value_i_reg[0]_1 ;
  input rst;
  input rd_en;
  input \gen_fwft.empty_fwft_i_reg ;
  input [1:0]\gen_fwft.curr_fwft_state_reg[1] ;
  input rst_d1;
  input [0:0]CO;
  input [0:0]\reg_out_i_reg[9] ;

  wire [0:0]CO;
  wire [0:0]Q;
  wire [0:0]S;
  wire [0:0]SR;
  wire [0:0]\count_value_i_reg[0] ;
  wire [0:0]\count_value_i_reg[0]_0 ;
  wire [0:0]\count_value_i_reg[0]_1 ;
  wire [0:0]\count_value_i_reg[3] ;
  wire [0:0]\count_value_i_reg[3]_0 ;
  wire dest_rst;
  wire ena;
  wire [1:0]\gen_fwft.curr_fwft_state_reg[1] ;
  wire \gen_fwft.empty_fwft_i_reg ;
  wire \gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg ;
  wire \gen_pf_ic_rc.gen_full_rst_val.ram_full_n_reg ;
  wire \gen_rst_ic.fifo_rd_rst_d3 ;
  wire \gen_rst_ic.fifo_rd_rst_d3_wr_d2 ;
  wire \gen_rst_ic.fifo_rd_rst_done ;
  wire \gen_rst_ic.fifo_rd_rst_done_i_1_n_0 ;
  wire \gen_rst_ic.fifo_rd_rst_wr_i ;
  wire \gen_rst_ic.fifo_wr_rst_d2 ;
  wire \gen_rst_ic.fifo_wr_rst_d3 ;
  wire \gen_rst_ic.fifo_wr_rst_done ;
  wire \gen_rst_ic.fifo_wr_rst_i_i_1_n_0 ;
  wire \gen_rst_ic.fifo_wr_rst_i_reg_n_0 ;
  wire \gen_rst_ic.wrst_wr_inst_n_1 ;
  wire [0:0]\grdc.rd_data_count_i_reg[0] ;
  wire overflow_i0;
  wire [1:1]power_on_rst;
  wire \power_on_rst_reg_n_0_[0] ;
  wire rd_clk;
  wire rd_en;
  wire [0:0]\reg_out_i_reg[9] ;
  wire rst;
  wire rst_d1;
  wire underflow_i0;
  wire wr_clk;
  wire wr_en;

  LUT5 #(
    .INIT(32'hFFEF0010)) 
    \count_value_i[3]_i_2 
       (.I0(\gen_rst_ic.fifo_wr_rst_i_reg_n_0 ),
        .I1(\gen_rst_ic.fifo_rd_rst_wr_i ),
        .I2(wr_en),
        .I3(\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg ),
        .I4(Q),
        .O(S));
  LUT5 #(
    .INIT(32'hFFEF0010)) 
    \count_value_i[3]_i_2__0 
       (.I0(\gen_rst_ic.fifo_wr_rst_i_reg_n_0 ),
        .I1(\gen_rst_ic.fifo_rd_rst_wr_i ),
        .I2(wr_en),
        .I3(\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg ),
        .I4(\count_value_i_reg[0]_0 ),
        .O(\count_value_i_reg[3] ));
  LUT5 #(
    .INIT(32'hFFEF0010)) 
    \count_value_i[3]_i_2__1 
       (.I0(\gen_rst_ic.fifo_wr_rst_i_reg_n_0 ),
        .I1(\gen_rst_ic.fifo_rd_rst_wr_i ),
        .I2(wr_en),
        .I3(\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg ),
        .I4(\count_value_i_reg[0]_1 ),
        .O(\count_value_i_reg[3]_0 ));
  LUT6 #(
    .INIT(64'h00000000000B0B0B)) 
    \gen_pf_ic_rc.gen_full_rst_val.ram_full_n_i_1 
       (.I0(rst),
        .I1(rst_d1),
        .I2(SR),
        .I3(CO),
        .I4(ena),
        .I5(\reg_out_i_reg[9] ),
        .O(\gen_pf_ic_rc.gen_full_rst_val.ram_full_n_reg ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rst_ic.fifo_rd_rst_d3_wr_d2_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gen_rst_ic.fifo_rd_rst_wr_i ),
        .Q(\gen_rst_ic.fifo_rd_rst_d3_wr_d2 ),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hEF00FFFFEF00EF00)) 
    \gen_rst_ic.fifo_rd_rst_done_i_1 
       (.I0(rst),
        .I1(power_on_rst),
        .I2(\gen_rst_ic.fifo_wr_rst_done ),
        .I3(\gen_rst_ic.fifo_rd_rst_done ),
        .I4(\gen_rst_ic.fifo_rd_rst_d3_wr_d2 ),
        .I5(\gen_rst_ic.fifo_rd_rst_wr_i ),
        .O(\gen_rst_ic.fifo_rd_rst_done_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rst_ic.fifo_rd_rst_done_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gen_rst_ic.fifo_rd_rst_done_i_1_n_0 ),
        .Q(\gen_rst_ic.fifo_rd_rst_done ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rst_ic.fifo_wr_rst_d3_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gen_rst_ic.fifo_wr_rst_d2 ),
        .Q(\gen_rst_ic.fifo_wr_rst_d3 ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rst_ic.fifo_wr_rst_done_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gen_rst_ic.wrst_wr_inst_n_1 ),
        .Q(\gen_rst_ic.fifo_wr_rst_done ),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hFFFFFF2A)) 
    \gen_rst_ic.fifo_wr_rst_i_i_1 
       (.I0(\gen_rst_ic.fifo_wr_rst_i_reg_n_0 ),
        .I1(\gen_rst_ic.fifo_rd_rst_done ),
        .I2(\gen_rst_ic.fifo_wr_rst_done ),
        .I3(rst),
        .I4(power_on_rst),
        .O(\gen_rst_ic.fifo_wr_rst_i_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \gen_rst_ic.fifo_wr_rst_i_reg 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\gen_rst_ic.fifo_wr_rst_i_i_1_n_0 ),
        .Q(\gen_rst_ic.fifo_wr_rst_i_reg_n_0 ),
        .R(1'b0));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_reg_pipe_bit__parameterized0 \gen_rst_ic.rrst_rd_inst 
       (.\count_value_i_reg[0] (\count_value_i_reg[0] ),
        .dest_rst(dest_rst),
        .\gen_fwft.curr_fwft_state_reg[1] (\gen_fwft.curr_fwft_state_reg[1] ),
        .\gen_fwft.empty_fwft_i_reg (\gen_fwft.empty_fwft_i_reg ),
        .\gen_rst_ic.fifo_rd_rst_d3 (\gen_rst_ic.fifo_rd_rst_d3 ),
        .\grdc.rd_data_count_i_reg[0] (\grdc.rd_data_count_i_reg[0] ),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .underflow_i0(underflow_i0));
  (* DEF_VAL = "1'b0" *) 
  (* DEST_SYNC_FF = "4" *) 
  (* INIT = "0" *) 
  (* INIT_SYNC_FF = "0" *) 
  (* SIM_ASSERT_CHK = "1" *) 
  (* VERSION = "0" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  (* XPM_MODULE = "TRUE" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_cdc_sync_rst \gen_rst_ic.rrst_wr_inst 
       (.dest_clk(wr_clk),
        .dest_rst(\gen_rst_ic.fifo_rd_rst_wr_i ),
        .src_rst(\gen_rst_ic.fifo_rd_rst_d3 ));
  (* DEF_VAL = "1'b0" *) 
  (* DEST_SYNC_FF = "4" *) 
  (* INIT = "0" *) 
  (* INIT_SYNC_FF = "0" *) 
  (* SIM_ASSERT_CHK = "1" *) 
  (* VERSION = "0" *) 
  (* XPM_CDC = "SYNC_RST" *) 
  (* XPM_MODULE = "TRUE" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_cdc_sync_rst__1 \gen_rst_ic.wrst_rd_inst 
       (.dest_clk(rd_clk),
        .dest_rst(dest_rst),
        .src_rst(\gen_rst_ic.fifo_wr_rst_i_reg_n_0 ));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_reg_pipe_bit \gen_rst_ic.wrst_wr_inst 
       (.Q(power_on_rst),
        .\gen_rst_ic.fifo_rd_rst_done (\gen_rst_ic.fifo_rd_rst_done ),
        .\gen_rst_ic.fifo_wr_rst_d2 (\gen_rst_ic.fifo_wr_rst_d2 ),
        .\gen_rst_ic.fifo_wr_rst_d3 (\gen_rst_ic.fifo_wr_rst_d3 ),
        .\gen_rst_ic.fifo_wr_rst_done (\gen_rst_ic.fifo_wr_rst_done ),
        .\gen_rst_ic.fifo_wr_rst_done_reg (\gen_rst_ic.wrst_wr_inst_n_1 ),
        .\gen_rst_ic.fifo_wr_rst_i_reg (\gen_rst_ic.fifo_wr_rst_i_reg_n_0 ),
        .rst(rst),
        .wr_clk(wr_clk));
  LUT4 #(
    .INIT(16'h0004)) 
    \gen_sdpram.xpm_memory_base_inst_i_1 
       (.I0(\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg ),
        .I1(wr_en),
        .I2(\gen_rst_ic.fifo_rd_rst_wr_i ),
        .I3(\gen_rst_ic.fifo_wr_rst_i_reg_n_0 ),
        .O(ena));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hAAA8)) 
    \gof.overflow_i_i_1 
       (.I0(wr_en),
        .I1(\gen_pf_ic_rc.gen_full_rst_val.ram_full_i_reg ),
        .I2(\gen_rst_ic.fifo_wr_rst_i_reg_n_0 ),
        .I3(\gen_rst_ic.fifo_rd_rst_wr_i ),
        .O(overflow_i0));
  FDRE #(
    .INIT(1'b1)) 
    \power_on_rst_reg[0] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(1'b0),
        .Q(\power_on_rst_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \power_on_rst_reg[1] 
       (.C(wr_clk),
        .CE(1'b1),
        .D(\power_on_rst_reg_n_0_[0] ),
        .Q(power_on_rst),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'hE)) 
    wr_rst_busy_INST_0
       (.I0(\gen_rst_ic.fifo_wr_rst_i_reg_n_0 ),
        .I1(\gen_rst_ic.fifo_rd_rst_wr_i ),
        .O(SR));
endmodule

(* ADDR_WIDTH_A = "11" *) (* ADDR_WIDTH_B = "11" *) (* AUTO_SLEEP_TIME = "0" *) 
(* BYTE_WRITE_WIDTH_A = "27" *) (* BYTE_WRITE_WIDTH_B = "27" *) (* CLOCKING_MODE = "1" *) 
(* ECC_MODE = "0" *) (* MAX_NUM_CHAR = "0" *) (* MEMORY_INIT_FILE = "none" *) 
(* MEMORY_INIT_PARAM = "" *) (* MEMORY_OPTIMIZATION = "true" *) (* MEMORY_PRIMITIVE = "0" *) 
(* MEMORY_SIZE = "55296" *) (* MEMORY_TYPE = "1" *) (* MESSAGE_CONTROL = "0" *) 
(* NUM_CHAR_LOC = "0" *) (* P_ECC_MODE = "no_ecc" *) (* P_ENABLE_BYTE_WRITE_A = "0" *) 
(* P_ENABLE_BYTE_WRITE_B = "0" *) (* P_MAX_DEPTH_DATA = "2048" *) (* P_MEMORY_OPT = "yes" *) 
(* P_MEMORY_PRIMITIVE = "auto" *) (* P_MIN_WIDTH_DATA = "27" *) (* P_MIN_WIDTH_DATA_A = "27" *) 
(* P_MIN_WIDTH_DATA_B = "27" *) (* P_MIN_WIDTH_DATA_ECC = "27" *) (* P_MIN_WIDTH_DATA_LDW = "4" *) 
(* P_MIN_WIDTH_DATA_SHFT = "27" *) (* P_NUM_COLS_WRITE_A = "1" *) (* P_NUM_COLS_WRITE_B = "1" *) 
(* P_NUM_ROWS_READ_A = "1" *) (* P_NUM_ROWS_READ_B = "1" *) (* P_NUM_ROWS_WRITE_A = "1" *) 
(* P_NUM_ROWS_WRITE_B = "1" *) (* P_SDP_WRITE_MODE = "yes" *) (* P_WIDTH_ADDR_LSB_READ_A = "0" *) 
(* P_WIDTH_ADDR_LSB_READ_B = "0" *) (* P_WIDTH_ADDR_LSB_WRITE_A = "0" *) (* P_WIDTH_ADDR_LSB_WRITE_B = "0" *) 
(* P_WIDTH_ADDR_READ_A = "11" *) (* P_WIDTH_ADDR_READ_B = "11" *) (* P_WIDTH_ADDR_WRITE_A = "11" *) 
(* P_WIDTH_ADDR_WRITE_B = "11" *) (* P_WIDTH_COL_WRITE_A = "27" *) (* P_WIDTH_COL_WRITE_B = "27" *) 
(* READ_DATA_WIDTH_A = "27" *) (* READ_DATA_WIDTH_B = "27" *) (* READ_LATENCY_A = "2" *) 
(* READ_LATENCY_B = "2" *) (* READ_RESET_VALUE_A = "0" *) (* READ_RESET_VALUE_B = "0" *) 
(* USE_EMBEDDED_CONSTRAINT = "0" *) (* USE_MEM_INIT = "1" *) (* VERSION = "0" *) 
(* WAKEUP_TIME = "0" *) (* WRITE_DATA_WIDTH_A = "27" *) (* WRITE_DATA_WIDTH_B = "27" *) 
(* WRITE_MODE_A = "2" *) (* WRITE_MODE_B = "2" *) (* XPM_MODULE = "TRUE" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_memory_base
   (sleep,
    clka,
    rsta,
    ena,
    regcea,
    wea,
    addra,
    dina,
    injectsbiterra,
    injectdbiterra,
    douta,
    sbiterra,
    dbiterra,
    clkb,
    rstb,
    enb,
    regceb,
    web,
    addrb,
    dinb,
    injectsbiterrb,
    injectdbiterrb,
    doutb,
    sbiterrb,
    dbiterrb);
  input sleep;
  input clka;
  input rsta;
  input ena;
  input regcea;
  input [0:0]wea;
  input [10:0]addra;
  input [26:0]dina;
  input injectsbiterra;
  input injectdbiterra;
  output [26:0]douta;
  output sbiterra;
  output dbiterra;
  input clkb;
  input rstb;
  input enb;
  input regceb;
  input [0:0]web;
  input [10:0]addrb;
  input [26:0]dinb;
  input injectsbiterrb;
  input injectdbiterrb;
  output [26:0]doutb;
  output sbiterrb;
  output dbiterrb;

  wire \<const0> ;
  wire [10:0]addra;
  wire [10:0]addrb;
  wire clka;
  wire clkb;
  wire [26:0]dina;
  wire [26:0]doutb;
  wire ena;
  wire enb;
  wire regceb;
  wire rstb;
  wire sleep;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_0_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_0_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_0_DBITERR_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_0_INJECTDBITERR_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_0_INJECTSBITERR_UNCONNECTED ;
  wire \NLW_gen_wr_a.gen_word_narrow.mem_reg_0_SBITERR_UNCONNECTED ;
  wire [31:0]\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_DOADO_UNCONNECTED ;
  wire [31:16]\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_DOPADOP_UNCONNECTED ;
  wire [3:2]\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_RDADDRECC_UNCONNECTED ;
  wire [15:0]\NLW_gen_wr_a.gen_word_narrow.mem_reg_1_DOADO_UNCONNECTED ;
  wire [15:8]\NLW_gen_wr_a.gen_word_narrow.mem_reg_1_DOBDO_UNCONNECTED ;
  wire [1:0]\NLW_gen_wr_a.gen_word_narrow.mem_reg_1_DOPADOP_UNCONNECTED ;
  wire [1:1]\NLW_gen_wr_a.gen_word_narrow.mem_reg_1_DOPBDOP_UNCONNECTED ;

  assign dbiterra = \<const0> ;
  assign dbiterrb = \<const0> ;
  assign douta[26] = \<const0> ;
  assign douta[25] = \<const0> ;
  assign douta[24] = \<const0> ;
  assign douta[23] = \<const0> ;
  assign douta[22] = \<const0> ;
  assign douta[21] = \<const0> ;
  assign douta[20] = \<const0> ;
  assign douta[19] = \<const0> ;
  assign douta[18] = \<const0> ;
  assign douta[17] = \<const0> ;
  assign douta[16] = \<const0> ;
  assign douta[15] = \<const0> ;
  assign douta[14] = \<const0> ;
  assign douta[13] = \<const0> ;
  assign douta[12] = \<const0> ;
  assign douta[11] = \<const0> ;
  assign douta[10] = \<const0> ;
  assign douta[9] = \<const0> ;
  assign douta[8] = \<const0> ;
  assign douta[7] = \<const0> ;
  assign douta[6] = \<const0> ;
  assign douta[5] = \<const0> ;
  assign douta[4] = \<const0> ;
  assign douta[3] = \<const0> ;
  assign douta[2] = \<const0> ;
  assign douta[1] = \<const0> ;
  assign douta[0] = \<const0> ;
  assign sbiterra = \<const0> ;
  assign sbiterrb = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* \MEM.PORTA.ADDRESS_BEGIN  = "0" *) 
  (* \MEM.PORTA.ADDRESS_END  = "2047" *) 
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p2_d16" *) 
  (* \MEM.PORTA.DATA_LSB  = "0" *) 
  (* \MEM.PORTA.DATA_MSB  = "17" *) 
  (* \MEM.PORTB.ADDRESS_BEGIN  = "0" *) 
  (* \MEM.PORTB.ADDRESS_END  = "2047" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p2_d16" *) 
  (* \MEM.PORTB.DATA_LSB  = "0" *) 
  (* \MEM.PORTB.DATA_MSB  = "17" *) 
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "55296" *) 
  (* RTL_RAM_NAME = "gen_wr_a.gen_word_narrow.mem" *) 
  (* bram_addr_begin = "0" *) 
  (* bram_addr_end = "2047" *) 
  (* bram_slice_begin = "0" *) 
  (* bram_slice_end = "17" *) 
  RAMB36E1 #(
    .DOA_REG(0),
    .DOB_REG(1),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_40(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_41(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_42(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_43(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_44(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_45(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_46(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_47(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_48(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_49(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_4F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_50(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_51(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_52(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_53(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_54(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_55(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_56(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_57(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_58(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_59(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_5F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(18),
    .READ_WIDTH_B(18),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("NO_CHANGE"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(18),
    .WRITE_WIDTH_B(18)) 
    \gen_wr_a.gen_word_narrow.mem_reg_0 
       (.ADDRARDADDR({1'b1,addra,1'b0,1'b0,1'b0,1'b0}),
        .ADDRBWRADDR({1'b1,addrb,1'b0,1'b0,1'b0,1'b0}),
        .CASCADEINA(1'b1),
        .CASCADEINB(1'b1),
        .CASCADEOUTA(\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clkb),
        .DBITERR(\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina[15:0]}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .DIPADIP({1'b0,1'b0,dina[17:16]}),
        .DIPBDIP({1'b0,1'b0,1'b1,1'b1}),
        .DOADO(\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_DOADO_UNCONNECTED [31:0]),
        .DOBDO({\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_DOBDO_UNCONNECTED [31:16],doutb[15:0]}),
        .DOPADOP(\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP({\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_DOPBDOP_UNCONNECTED [3:2],doutb[17:16]}),
        .ECCPARITY(\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena),
        .ENBWREN(enb),
        .INJECTDBITERR(\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_INJECTDBITERR_UNCONNECTED ),
        .INJECTSBITERR(\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_INJECTSBITERR_UNCONNECTED ),
        .RDADDRECC(\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b0),
        .REGCEB(regceb),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(rstb),
        .SBITERR(\NLW_gen_wr_a.gen_word_narrow.mem_reg_0_SBITERR_UNCONNECTED ),
        .WEA({ena,ena,ena,ena}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
  (* \MEM.PORTA.ADDRESS_BEGIN  = "0" *) 
  (* \MEM.PORTA.ADDRESS_END  = "2047" *) 
  (* \MEM.PORTA.DATA_BIT_LAYOUT  = "p1_d8" *) 
  (* \MEM.PORTA.DATA_LSB  = "18" *) 
  (* \MEM.PORTA.DATA_MSB  = "26" *) 
  (* \MEM.PORTB.ADDRESS_BEGIN  = "0" *) 
  (* \MEM.PORTB.ADDRESS_END  = "2047" *) 
  (* \MEM.PORTB.DATA_BIT_LAYOUT  = "p1_d8" *) 
  (* \MEM.PORTB.DATA_LSB  = "18" *) 
  (* \MEM.PORTB.DATA_MSB  = "26" *) 
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "55296" *) 
  (* RTL_RAM_NAME = "gen_wr_a.gen_word_narrow.mem" *) 
  (* bram_addr_begin = "0" *) 
  (* bram_addr_end = "2047" *) 
  (* bram_slice_begin = "18" *) 
  (* bram_slice_end = "26" *) 
  RAMB18E1 #(
    .DOA_REG(0),
    .DOB_REG(1),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(18'h00000),
    .INIT_B(18'h00000),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("RSTREG"),
    .RSTREG_PRIORITY_B("RSTREG"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(18'h00000),
    .SRVAL_B(18'h00000),
    .WRITE_MODE_A("NO_CHANGE"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \gen_wr_a.gen_word_narrow.mem_reg_1 
       (.ADDRARDADDR({addra,1'b0,1'b0,1'b0}),
        .ADDRBWRADDR({addrb,1'b0,1'b0,1'b0}),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clkb),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,dina[25:18]}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .DIPADIP({1'b0,dina[26]}),
        .DIPBDIP({1'b0,1'b1}),
        .DOADO(\NLW_gen_wr_a.gen_word_narrow.mem_reg_1_DOADO_UNCONNECTED [15:0]),
        .DOBDO({\NLW_gen_wr_a.gen_word_narrow.mem_reg_1_DOBDO_UNCONNECTED [15:8],doutb[25:18]}),
        .DOPADOP(\NLW_gen_wr_a.gen_word_narrow.mem_reg_1_DOPADOP_UNCONNECTED [1:0]),
        .DOPBDOP({\NLW_gen_wr_a.gen_word_narrow.mem_reg_1_DOPBDOP_UNCONNECTED [1],doutb[26]}),
        .ENARDEN(ena),
        .ENBWREN(enb),
        .REGCEAREGCE(1'b0),
        .REGCEB(regceb),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(rstb),
        .WEA({ena,ena}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0}));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_reg_pipe_bit
   (\gen_rst_ic.fifo_wr_rst_d2 ,
    \gen_rst_ic.fifo_wr_rst_done_reg ,
    \gen_rst_ic.fifo_wr_rst_i_reg ,
    wr_clk,
    rst,
    Q,
    \gen_rst_ic.fifo_wr_rst_done ,
    \gen_rst_ic.fifo_rd_rst_done ,
    \gen_rst_ic.fifo_wr_rst_d3 );
  output \gen_rst_ic.fifo_wr_rst_d2 ;
  output \gen_rst_ic.fifo_wr_rst_done_reg ;
  input \gen_rst_ic.fifo_wr_rst_i_reg ;
  input wr_clk;
  input rst;
  input [0:0]Q;
  input \gen_rst_ic.fifo_wr_rst_done ;
  input \gen_rst_ic.fifo_rd_rst_done ;
  input \gen_rst_ic.fifo_wr_rst_d3 ;

  wire [0:0]Q;
  wire d_out;
  wire \gen_rst_ic.fifo_rd_rst_done ;
  wire \gen_rst_ic.fifo_wr_rst_d2 ;
  wire \gen_rst_ic.fifo_wr_rst_d3 ;
  wire \gen_rst_ic.fifo_wr_rst_done ;
  wire \gen_rst_ic.fifo_wr_rst_done_reg ;
  wire \gen_rst_ic.fifo_wr_rst_i_reg ;
  wire rst;
  wire wr_clk;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_fifo_reg_bit_4 \gen_pipe_bit[0].pipe_bit_inst 
       (.d_out(d_out),
        .\gen_rst_ic.fifo_wr_rst_i_reg (\gen_rst_ic.fifo_wr_rst_i_reg ),
        .wr_clk(wr_clk));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_fifo_reg_bit_5 \gen_pipe_bit[1].pipe_bit_inst 
       (.Q(Q),
        .d_out(d_out),
        .\gen_rst_ic.fifo_rd_rst_done (\gen_rst_ic.fifo_rd_rst_done ),
        .\gen_rst_ic.fifo_wr_rst_d2 (\gen_rst_ic.fifo_wr_rst_d2 ),
        .\gen_rst_ic.fifo_wr_rst_d3 (\gen_rst_ic.fifo_wr_rst_d3 ),
        .\gen_rst_ic.fifo_wr_rst_done (\gen_rst_ic.fifo_wr_rst_done ),
        .\gen_rst_ic.fifo_wr_rst_done_reg (\gen_rst_ic.fifo_wr_rst_done_reg ),
        .rst(rst),
        .wr_clk(wr_clk));
endmodule

(* ORIG_REF_NAME = "xpm_reg_pipe_bit" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_reg_pipe_bit__parameterized0
   (\gen_rst_ic.fifo_rd_rst_d3 ,
    underflow_i0,
    \grdc.rd_data_count_i_reg[0] ,
    \count_value_i_reg[0] ,
    dest_rst,
    rd_clk,
    rd_en,
    \gen_fwft.empty_fwft_i_reg ,
    \gen_fwft.curr_fwft_state_reg[1] );
  output \gen_rst_ic.fifo_rd_rst_d3 ;
  output underflow_i0;
  output [0:0]\grdc.rd_data_count_i_reg[0] ;
  output [0:0]\count_value_i_reg[0] ;
  input dest_rst;
  input rd_clk;
  input rd_en;
  input \gen_fwft.empty_fwft_i_reg ;
  input [1:0]\gen_fwft.curr_fwft_state_reg[1] ;

  wire [0:0]\count_value_i_reg[0] ;
  wire dest_rst;
  wire [1:0]\gen_fwft.curr_fwft_state_reg[1] ;
  wire \gen_fwft.empty_fwft_i_reg ;
  wire \gen_pipe_bit[1].pipe_bit_inst_n_0 ;
  wire \gen_rst_ic.fifo_rd_rst_d3 ;
  wire [0:0]\grdc.rd_data_count_i_reg[0] ;
  wire rd_clk;
  wire rd_en;
  wire underflow_i0;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_fifo_reg_bit_6 \gen_pipe_bit[1].pipe_bit_inst 
       (.d_out_reg(\gen_pipe_bit[1].pipe_bit_inst_n_0 ),
        .dest_rst(dest_rst),
        .rd_clk(rd_clk));
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_xpm_fifo_reg_bit_7 \gen_pipe_bit[2].pipe_bit_inst 
       (.\count_value_i_reg[0] (\count_value_i_reg[0] ),
        .dest_rst(dest_rst),
        .\gen_fwft.curr_fwft_state_reg[1] (\gen_fwft.curr_fwft_state_reg[1] ),
        .\gen_fwft.empty_fwft_i_reg (\gen_fwft.empty_fwft_i_reg ),
        .\grdc.rd_data_count_i_reg[0] (\grdc.rd_data_count_i_reg[0] ),
        .rd_clk(rd_clk),
        .rd_en(rd_en),
        .\syncstages_ff_reg[0] (\gen_rst_ic.fifo_rd_rst_d3 ),
        .\syncstages_ff_reg[3] (\gen_pipe_bit[1].pipe_bit_inst_n_0 ),
        .underflow_i0(underflow_i0));
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
