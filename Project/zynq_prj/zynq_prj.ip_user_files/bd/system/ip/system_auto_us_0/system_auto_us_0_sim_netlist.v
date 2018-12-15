// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Tue Nov 20 21:02:02 2018
// Host        : hubbery running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top system_auto_us_0 -prefix
//               system_auto_us_0_ system_auto_us_0_sim_netlist.v
// Design      : system_auto_us_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module system_auto_us_0_axi_dwidth_converter_v2_1_15_a_upsizer
   (\USE_READ.rd_cmd_valid ,
    \USE_RTL_LENGTH.length_counter_q_reg[7] ,
    \USE_RTL_LENGTH.length_counter_q_reg[7]_0 ,
    E,
    D,
    Q,
    \current_word_1_reg[2] ,
    \s_axi_rdata[31] ,
    first_word_reg,
    s_axi_rvalid,
    \M_AXI_RDATA_I_reg[63] ,
    s_ready_i_reg,
    m_axi_arvalid,
    SR,
    out,
    mr_rvalid,
    wrap_buffer_available_reg,
    use_wrap_buffer,
    wrap_buffer_available,
    \USE_RTL_LENGTH.length_counter_q_reg[7]_1 ,
    s_axi_rready,
    \pre_next_word_1_reg[2] ,
    \pre_next_word_1_reg[1] ,
    first_word,
    \pre_next_word_1_reg[2]_0 ,
    \current_word_1_reg[2]_0 ,
    sr_arvalid,
    \USE_RTL_LENGTH.first_mi_word_q ,
    m_axi_arready,
    s_axi_aresetn,
    in);
  output \USE_READ.rd_cmd_valid ;
  output \USE_RTL_LENGTH.length_counter_q_reg[7] ;
  output \USE_RTL_LENGTH.length_counter_q_reg[7]_0 ;
  output [0:0]E;
  output [2:0]D;
  output [12:0]Q;
  output [2:0]\current_word_1_reg[2] ;
  output \s_axi_rdata[31] ;
  output first_word_reg;
  output s_axi_rvalid;
  output [0:0]\M_AXI_RDATA_I_reg[63] ;
  output s_ready_i_reg;
  output m_axi_arvalid;
  input [0:0]SR;
  input out;
  input mr_rvalid;
  input wrap_buffer_available_reg;
  input use_wrap_buffer;
  input wrap_buffer_available;
  input \USE_RTL_LENGTH.length_counter_q_reg[7]_1 ;
  input s_axi_rready;
  input \pre_next_word_1_reg[2] ;
  input \pre_next_word_1_reg[1] ;
  input first_word;
  input [2:0]\pre_next_word_1_reg[2]_0 ;
  input [2:0]\current_word_1_reg[2]_0 ;
  input sr_arvalid;
  input \USE_RTL_LENGTH.first_mi_word_q ;
  input m_axi_arready;
  input s_axi_aresetn;
  input [27:0]in;

  wire [2:0]D;
  wire [0:0]E;
  wire [0:0]\M_AXI_RDATA_I_reg[63] ;
  wire [12:0]Q;
  wire [0:0]SR;
  wire \USE_READ.rd_cmd_valid ;
  wire \USE_RTL_LENGTH.first_mi_word_q ;
  wire \USE_RTL_LENGTH.length_counter_q_reg[7] ;
  wire \USE_RTL_LENGTH.length_counter_q_reg[7]_0 ;
  wire \USE_RTL_LENGTH.length_counter_q_reg[7]_1 ;
  wire cmd_push_block;
  wire cmd_push_block0;
  wire [2:0]\current_word_1_reg[2] ;
  wire [2:0]\current_word_1_reg[2]_0 ;
  wire first_word;
  wire first_word_reg;
  wire [27:0]in;
  wire m_axi_arready;
  wire m_axi_arvalid;
  wire mr_rvalid;
  wire out;
  wire \pre_next_word_1_reg[1] ;
  wire \pre_next_word_1_reg[2] ;
  wire [2:0]\pre_next_word_1_reg[2]_0 ;
  wire s_axi_aresetn;
  wire \s_axi_rdata[31] ;
  wire s_axi_rready;
  wire s_axi_rvalid;
  wire s_ready_i_reg;
  wire sr_arvalid;
  wire use_wrap_buffer;
  wire wrap_buffer_available;
  wire wrap_buffer_available_reg;

  system_auto_us_0_generic_baseblocks_v2_1_0_command_fifo \GEN_CMD_QUEUE.cmd_queue 
       (.D(D),
        .E(E),
        .\M_AXI_RDATA_I_reg[63] (\USE_READ.rd_cmd_valid ),
        .\M_AXI_RDATA_I_reg[63]_0 (\M_AXI_RDATA_I_reg[63] ),
        .Q(Q),
        .SR(SR),
        .\USE_RTL_LENGTH.first_mi_word_q (\USE_RTL_LENGTH.first_mi_word_q ),
        .\USE_RTL_LENGTH.length_counter_q_reg[7] (\USE_RTL_LENGTH.length_counter_q_reg[7] ),
        .\USE_RTL_LENGTH.length_counter_q_reg[7]_0 (\USE_RTL_LENGTH.length_counter_q_reg[7]_0 ),
        .\USE_RTL_LENGTH.length_counter_q_reg[7]_1 (\USE_RTL_LENGTH.length_counter_q_reg[7]_1 ),
        .cmd_push_block(cmd_push_block),
        .cmd_push_block0(cmd_push_block0),
        .\current_word_1_reg[2] (\current_word_1_reg[2] ),
        .\current_word_1_reg[2]_0 (\current_word_1_reg[2]_0 ),
        .first_word(first_word),
        .first_word_reg(first_word_reg),
        .in(in),
        .m_axi_arready(m_axi_arready),
        .m_axi_arvalid(m_axi_arvalid),
        .mr_rvalid(mr_rvalid),
        .out(out),
        .\pre_next_word_1_reg[1] (\pre_next_word_1_reg[1] ),
        .\pre_next_word_1_reg[2] (\pre_next_word_1_reg[2] ),
        .\pre_next_word_1_reg[2]_0 (\pre_next_word_1_reg[2]_0 ),
        .s_axi_aresetn(s_axi_aresetn),
        .\s_axi_rdata[31] (\s_axi_rdata[31] ),
        .s_axi_rready(s_axi_rready),
        .s_axi_rvalid(s_axi_rvalid),
        .s_ready_i_reg(s_ready_i_reg),
        .sr_arvalid(sr_arvalid),
        .use_wrap_buffer(use_wrap_buffer),
        .wrap_buffer_available(wrap_buffer_available),
        .wrap_buffer_available_reg(wrap_buffer_available_reg));
  FDRE #(
    .INIT(1'b0)) 
    cmd_push_block_reg
       (.C(out),
        .CE(1'b1),
        .D(cmd_push_block0),
        .Q(cmd_push_block),
        .R(SR));
endmodule

module system_auto_us_0_axi_dwidth_converter_v2_1_15_axi_upsizer
   (m_axi_arburst,
    m_axi_araddr,
    m_axi_arlen,
    m_axi_rready,
    s_axi_rlast,
    Q,
    s_axi_arready,
    s_axi_rdata,
    s_axi_rvalid,
    m_axi_arvalid,
    s_axi_rresp,
    m_axi_arsize,
    s_axi_rready,
    out,
    m_axi_rlast,
    m_axi_rresp,
    m_axi_rdata,
    D,
    s_axi_arvalid,
    m_axi_arready,
    s_axi_aresetn,
    m_axi_rvalid);
  output [1:0]m_axi_arburst;
  output [31:0]m_axi_araddr;
  output [7:0]m_axi_arlen;
  output m_axi_rready;
  output s_axi_rlast;
  output [15:0]Q;
  output s_axi_arready;
  output [31:0]s_axi_rdata;
  output s_axi_rvalid;
  output m_axi_arvalid;
  output [1:0]s_axi_rresp;
  output [2:0]m_axi_arsize;
  input s_axi_rready;
  input out;
  input m_axi_rlast;
  input [1:0]m_axi_rresp;
  input [63:0]m_axi_rdata;
  input [60:0]D;
  input s_axi_arvalid;
  input m_axi_arready;
  input s_axi_aresetn;
  input m_axi_rvalid;

  wire [60:0]D;
  wire M_AXI_RLAST;
  wire [15:0]Q;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_10 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_11 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_12 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_13 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_14 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_15 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_16 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_17 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_18 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_19 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_20 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_21 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_22 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_23 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_24 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_25 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_26 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_27 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_28 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_29 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_30 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_31 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_32 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_33 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_34 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_35 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_36 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_37 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_38 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_39 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_40 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_41 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_42 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_43 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_44 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_45 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_46 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_47 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_48 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_49 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_5 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_50 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_51 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_52 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_53 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_54 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_55 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_56 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_57 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_58 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_59 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_6 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_60 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_61 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_62 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_63 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_64 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_65 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_66 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_67 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_68 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_7 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_8 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_9 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.read_data_inst_n_1 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.read_data_inst_n_10 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.read_data_inst_n_43 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.read_data_inst_n_47 ;
  wire \USE_READ.gen_non_fifo_r_upsizer.read_data_inst_n_6 ;
  wire [2:2]\USE_READ.rd_cmd_first_word ;
  wire \USE_READ.rd_cmd_fix ;
  wire [2:1]\USE_READ.rd_cmd_next_word ;
  wire \USE_READ.rd_cmd_valid ;
  wire \USE_READ.read_addr_inst_n_1 ;
  wire \USE_READ.read_addr_inst_n_12 ;
  wire \USE_READ.read_addr_inst_n_13 ;
  wire \USE_READ.read_addr_inst_n_14 ;
  wire \USE_READ.read_addr_inst_n_15 ;
  wire \USE_READ.read_addr_inst_n_16 ;
  wire \USE_READ.read_addr_inst_n_17 ;
  wire \USE_READ.read_addr_inst_n_18 ;
  wire \USE_READ.read_addr_inst_n_19 ;
  wire \USE_READ.read_addr_inst_n_2 ;
  wire \USE_READ.read_addr_inst_n_23 ;
  wire \USE_READ.read_addr_inst_n_24 ;
  wire \USE_READ.read_addr_inst_n_27 ;
  wire \USE_READ.read_addr_inst_n_3 ;
  wire \USE_RTL_LENGTH.first_mi_word_q ;
  wire cmd_complete_wrap_i;
  wire [2:0]cmd_first_word_i;
  wire cmd_fix_i;
  wire [2:2]cmd_last_word;
  wire cmd_modified_i;
  wire cmd_packed_wrap_i;
  wire [2:0]current_word_1;
  wire first_word;
  wire [31:0]m_axi_araddr;
  wire [1:0]m_axi_arburst;
  wire [7:0]m_axi_arlen;
  wire m_axi_arready;
  wire [2:0]m_axi_arsize;
  wire m_axi_arvalid;
  wire [63:0]m_axi_rdata;
  wire m_axi_rlast;
  wire m_axi_rready;
  wire [1:0]m_axi_rresp;
  wire m_axi_rvalid;
  wire [1:0]mr_rresp;
  wire mr_rvalid;
  wire [2:0]next_word;
  wire out;
  wire [22:16]p_1_out;
  wire p_7_in;
  wire [2:0]pre_next_word;
  wire [2:0]pre_next_word_1;
  wire s_axi_aresetn;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire [31:0]s_axi_rdata;
  wire s_axi_rlast;
  wire s_axi_rready;
  wire [1:0]s_axi_rresp;
  wire s_axi_rvalid;
  wire si_register_slice_inst_n_0;
  wire si_register_slice_inst_n_1;
  wire si_register_slice_inst_n_17;
  wire si_register_slice_inst_n_18;
  wire si_register_slice_inst_n_19;
  wire si_register_slice_inst_n_20;
  wire si_register_slice_inst_n_21;
  wire si_register_slice_inst_n_22;
  wire sr_arvalid;
  wire use_wrap_buffer;
  wire wrap_buffer_available;

  system_auto_us_0_axi_register_slice_v2_1_15_axi_register_slice \USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst 
       (.E(\USE_READ.read_addr_inst_n_3 ),
        .Q({M_AXI_RLAST,mr_rresp,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_5 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_6 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_7 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_8 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_9 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_10 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_11 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_12 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_13 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_14 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_15 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_16 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_17 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_18 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_19 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_20 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_21 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_22 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_23 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_24 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_25 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_26 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_27 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_28 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_29 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_30 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_31 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_32 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_33 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_34 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_35 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_36 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_37 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_38 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_39 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_40 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_41 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_42 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_43 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_44 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_45 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_46 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_47 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_48 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_49 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_50 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_51 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_52 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_53 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_54 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_55 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_56 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_57 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_58 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_59 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_60 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_61 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_62 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_63 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_64 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_65 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_66 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_67 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_68 }),
        .\aresetn_d_reg[0] (si_register_slice_inst_n_0),
        .\aresetn_d_reg[1] (si_register_slice_inst_n_1),
        .m_axi_rdata(m_axi_rdata),
        .m_axi_rlast(m_axi_rlast),
        .m_axi_rready(m_axi_rready),
        .m_axi_rresp(m_axi_rresp),
        .m_axi_rvalid(m_axi_rvalid),
        .mr_rvalid(mr_rvalid),
        .out(out));
  system_auto_us_0_axi_dwidth_converter_v2_1_15_r_upsizer \USE_READ.gen_non_fifo_r_upsizer.read_data_inst 
       (.D(pre_next_word),
        .E(p_7_in),
        .\M_AXI_RDATA_I_reg[0]_0 (\USE_READ.gen_non_fifo_r_upsizer.read_data_inst_n_1 ),
        .Q({M_AXI_RLAST,mr_rresp,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_5 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_6 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_7 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_8 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_9 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_10 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_11 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_12 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_13 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_14 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_15 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_16 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_17 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_18 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_19 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_20 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_21 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_22 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_23 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_24 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_25 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_26 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_27 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_28 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_29 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_30 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_31 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_32 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_33 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_34 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_35 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_36 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_37 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_38 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_39 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_40 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_41 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_42 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_43 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_44 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_45 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_46 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_47 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_48 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_49 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_50 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_51 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_52 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_53 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_54 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_55 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_56 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_57 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_58 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_59 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_60 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_61 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_62 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_63 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_64 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_65 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_66 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_67 ,\USE_READ.gen_non_fifo_r_upsizer.mi_register_slice_inst_n_68 }),
        .\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[13] (next_word),
        .\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] (\USE_READ.read_addr_inst_n_23 ),
        .\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] ({\USE_READ.rd_cmd_fix ,\USE_READ.rd_cmd_first_word ,\USE_READ.rd_cmd_next_word ,cmd_last_word,\USE_READ.read_addr_inst_n_12 ,\USE_READ.read_addr_inst_n_13 ,\USE_READ.read_addr_inst_n_14 ,\USE_READ.read_addr_inst_n_15 ,\USE_READ.read_addr_inst_n_16 ,\USE_READ.read_addr_inst_n_17 ,\USE_READ.read_addr_inst_n_18 ,\USE_READ.read_addr_inst_n_19 }),
        .\USE_READ.rd_cmd_valid (\USE_READ.rd_cmd_valid ),
        .\USE_RTL_LENGTH.first_mi_word_q (\USE_RTL_LENGTH.first_mi_word_q ),
        .\current_word_1_reg[0]_0 (\USE_READ.read_addr_inst_n_24 ),
        .\current_word_1_reg[2]_0 (pre_next_word_1),
        .first_word(first_word),
        .first_word_reg_0(current_word_1),
        .\m_payload_i_reg[66] (\USE_READ.gen_non_fifo_r_upsizer.read_data_inst_n_47 ),
        .m_valid_i_reg(\USE_READ.read_addr_inst_n_1 ),
        .mr_rvalid(mr_rvalid),
        .out(out),
        .\pre_next_word_1_reg[2]_0 (\USE_READ.gen_non_fifo_r_upsizer.read_data_inst_n_6 ),
        .\pre_next_word_1_reg[2]_1 (\USE_READ.gen_non_fifo_r_upsizer.read_data_inst_n_10 ),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rlast(s_axi_rlast),
        .s_axi_rready(s_axi_rready),
        .s_axi_rresp(s_axi_rresp),
        .use_wrap_buffer(use_wrap_buffer),
        .use_wrap_buffer_reg_0(\USE_READ.read_addr_inst_n_2 ),
        .wrap_buffer_available(wrap_buffer_available),
        .wrap_buffer_available_reg_0(\USE_READ.gen_non_fifo_r_upsizer.read_data_inst_n_43 ));
  system_auto_us_0_axi_dwidth_converter_v2_1_15_a_upsizer \USE_READ.read_addr_inst 
       (.D(pre_next_word),
        .E(\USE_READ.read_addr_inst_n_3 ),
        .\M_AXI_RDATA_I_reg[63] (p_7_in),
        .Q({\USE_READ.rd_cmd_fix ,\USE_READ.rd_cmd_first_word ,\USE_READ.rd_cmd_next_word ,cmd_last_word,\USE_READ.read_addr_inst_n_12 ,\USE_READ.read_addr_inst_n_13 ,\USE_READ.read_addr_inst_n_14 ,\USE_READ.read_addr_inst_n_15 ,\USE_READ.read_addr_inst_n_16 ,\USE_READ.read_addr_inst_n_17 ,\USE_READ.read_addr_inst_n_18 ,\USE_READ.read_addr_inst_n_19 }),
        .SR(\USE_READ.gen_non_fifo_r_upsizer.read_data_inst_n_1 ),
        .\USE_READ.rd_cmd_valid (\USE_READ.rd_cmd_valid ),
        .\USE_RTL_LENGTH.first_mi_word_q (\USE_RTL_LENGTH.first_mi_word_q ),
        .\USE_RTL_LENGTH.length_counter_q_reg[7] (\USE_READ.read_addr_inst_n_1 ),
        .\USE_RTL_LENGTH.length_counter_q_reg[7]_0 (\USE_READ.read_addr_inst_n_2 ),
        .\USE_RTL_LENGTH.length_counter_q_reg[7]_1 (\USE_READ.gen_non_fifo_r_upsizer.read_data_inst_n_43 ),
        .\current_word_1_reg[2] (next_word),
        .\current_word_1_reg[2]_0 (current_word_1),
        .first_word(first_word),
        .first_word_reg(\USE_READ.read_addr_inst_n_24 ),
        .in({cmd_fix_i,cmd_modified_i,cmd_complete_wrap_i,cmd_packed_wrap_i,cmd_first_word_i,p_1_out,si_register_slice_inst_n_17,si_register_slice_inst_n_18,si_register_slice_inst_n_19,si_register_slice_inst_n_20,si_register_slice_inst_n_21,si_register_slice_inst_n_22,m_axi_arlen}),
        .m_axi_arready(m_axi_arready),
        .m_axi_arvalid(m_axi_arvalid),
        .mr_rvalid(mr_rvalid),
        .out(out),
        .\pre_next_word_1_reg[1] (\USE_READ.gen_non_fifo_r_upsizer.read_data_inst_n_10 ),
        .\pre_next_word_1_reg[2] (\USE_READ.gen_non_fifo_r_upsizer.read_data_inst_n_6 ),
        .\pre_next_word_1_reg[2]_0 (pre_next_word_1),
        .s_axi_aresetn(s_axi_aresetn),
        .\s_axi_rdata[31] (\USE_READ.read_addr_inst_n_23 ),
        .s_axi_rready(s_axi_rready),
        .s_axi_rvalid(s_axi_rvalid),
        .s_ready_i_reg(\USE_READ.read_addr_inst_n_27 ),
        .sr_arvalid(sr_arvalid),
        .use_wrap_buffer(use_wrap_buffer),
        .wrap_buffer_available(wrap_buffer_available),
        .wrap_buffer_available_reg(\USE_READ.gen_non_fifo_r_upsizer.read_data_inst_n_47 ));
  system_auto_us_0_axi_register_slice_v2_1_15_axi_register_slice__parameterized0 si_register_slice_inst
       (.D(D),
        .Q(Q),
        .\aresetn_d_reg[1] (si_register_slice_inst_n_0),
        .cmd_push_block_reg(\USE_READ.read_addr_inst_n_27 ),
        .in({cmd_fix_i,cmd_modified_i,cmd_complete_wrap_i,cmd_packed_wrap_i,cmd_first_word_i,p_1_out,si_register_slice_inst_n_17,si_register_slice_inst_n_18,si_register_slice_inst_n_19,si_register_slice_inst_n_20,si_register_slice_inst_n_21,si_register_slice_inst_n_22,m_axi_arlen}),
        .m_axi_araddr(m_axi_araddr),
        .m_axi_arburst(m_axi_arburst),
        .m_axi_arsize(m_axi_arsize),
        .out(out),
        .s_axi_aresetn(\USE_READ.gen_non_fifo_r_upsizer.read_data_inst_n_1 ),
        .s_axi_arready(s_axi_arready),
        .s_axi_arvalid(s_axi_arvalid),
        .s_ready_i_reg(si_register_slice_inst_n_1),
        .sr_arvalid(sr_arvalid));
endmodule

module system_auto_us_0_axi_dwidth_converter_v2_1_15_r_upsizer
   (\USE_RTL_LENGTH.first_mi_word_q ,
    \M_AXI_RDATA_I_reg[0]_0 ,
    first_word,
    s_axi_rlast,
    use_wrap_buffer,
    wrap_buffer_available,
    \pre_next_word_1_reg[2]_0 ,
    \current_word_1_reg[2]_0 ,
    \pre_next_word_1_reg[2]_1 ,
    s_axi_rdata,
    wrap_buffer_available_reg_0,
    first_word_reg_0,
    \m_payload_i_reg[66] ,
    s_axi_rresp,
    m_valid_i_reg,
    Q,
    out,
    \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] ,
    s_axi_rready,
    mr_rvalid,
    \USE_READ.rd_cmd_valid ,
    \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ,
    \current_word_1_reg[0]_0 ,
    s_axi_aresetn,
    use_wrap_buffer_reg_0,
    E,
    D,
    \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[13] );
  output \USE_RTL_LENGTH.first_mi_word_q ;
  output \M_AXI_RDATA_I_reg[0]_0 ;
  output first_word;
  output s_axi_rlast;
  output use_wrap_buffer;
  output wrap_buffer_available;
  output \pre_next_word_1_reg[2]_0 ;
  output [2:0]\current_word_1_reg[2]_0 ;
  output \pre_next_word_1_reg[2]_1 ;
  output [31:0]s_axi_rdata;
  output wrap_buffer_available_reg_0;
  output [2:0]first_word_reg_0;
  output \m_payload_i_reg[66] ;
  output [1:0]s_axi_rresp;
  input m_valid_i_reg;
  input [66:0]Q;
  input out;
  input [12:0]\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] ;
  input s_axi_rready;
  input mr_rvalid;
  input \USE_READ.rd_cmd_valid ;
  input \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ;
  input \current_word_1_reg[0]_0 ;
  input s_axi_aresetn;
  input use_wrap_buffer_reg_0;
  input [0:0]E;
  input [2:0]D;
  input [2:0]\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[13] ;

  wire [2:0]D;
  wire [0:0]E;
  wire [63:0]M_AXI_RDATA_I;
  wire \M_AXI_RDATA_I_reg[0]_0 ;
  wire [66:0]Q;
  wire [2:0]\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[13] ;
  wire \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ;
  wire [12:0]\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] ;
  wire \USE_READ.rd_cmd_valid ;
  wire \USE_RTL_LENGTH.first_mi_word_q ;
  wire \USE_RTL_LENGTH.length_counter_q[0]_i_1_n_0 ;
  wire \USE_RTL_LENGTH.length_counter_q[1]_i_1_n_0 ;
  wire \USE_RTL_LENGTH.length_counter_q[2]_i_1_n_0 ;
  wire \USE_RTL_LENGTH.length_counter_q[3]_i_1_n_0 ;
  wire \USE_RTL_LENGTH.length_counter_q[3]_i_2_n_0 ;
  wire \USE_RTL_LENGTH.length_counter_q[4]_i_1_n_0 ;
  wire \USE_RTL_LENGTH.length_counter_q[5]_i_1_n_0 ;
  wire \USE_RTL_LENGTH.length_counter_q[6]_i_1_n_0 ;
  wire \USE_RTL_LENGTH.length_counter_q[6]_i_2_n_0 ;
  wire \USE_RTL_LENGTH.length_counter_q[7]_i_1_n_0 ;
  wire \USE_RTL_LENGTH.length_counter_q[7]_i_2_n_0 ;
  wire [7:0]\USE_RTL_LENGTH.length_counter_q_reg ;
  wire \current_word_1_reg[0]_0 ;
  wire [2:0]\current_word_1_reg[2]_0 ;
  wire first_word;
  wire [2:0]first_word_reg_0;
  wire \m_payload_i[66]_i_6_n_0 ;
  wire \m_payload_i[66]_i_7_n_0 ;
  wire \m_payload_i[66]_i_8_n_0 ;
  wire \m_payload_i_reg[66] ;
  wire m_valid_i_reg;
  wire mr_rvalid;
  wire out;
  wire p_15_in;
  wire \pre_next_word_1_reg[2]_0 ;
  wire \pre_next_word_1_reg[2]_1 ;
  wire [1:0]rresp_wrap_buffer;
  wire s_axi_aresetn;
  wire [31:0]s_axi_rdata;
  wire s_axi_rlast;
  wire s_axi_rlast_INST_0_i_3_n_0;
  wire s_axi_rlast_INST_0_i_4_n_0;
  wire s_axi_rlast_INST_0_i_5_n_0;
  wire s_axi_rlast_INST_0_i_6_n_0;
  wire s_axi_rready;
  wire [1:0]s_axi_rresp;
  wire use_wrap_buffer;
  wire use_wrap_buffer_i_1_n_0;
  wire use_wrap_buffer_i_2_n_0;
  wire use_wrap_buffer_i_3_n_0;
  wire use_wrap_buffer_reg_0;
  wire wrap_buffer_available;
  wire wrap_buffer_available_i_1_n_0;
  wire wrap_buffer_available_i_2_n_0;
  wire wrap_buffer_available_reg_0;

  FDRE \M_AXI_RDATA_I_reg[0] 
       (.C(out),
        .CE(E),
        .D(Q[0]),
        .Q(M_AXI_RDATA_I[0]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[10] 
       (.C(out),
        .CE(E),
        .D(Q[10]),
        .Q(M_AXI_RDATA_I[10]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[11] 
       (.C(out),
        .CE(E),
        .D(Q[11]),
        .Q(M_AXI_RDATA_I[11]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[12] 
       (.C(out),
        .CE(E),
        .D(Q[12]),
        .Q(M_AXI_RDATA_I[12]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[13] 
       (.C(out),
        .CE(E),
        .D(Q[13]),
        .Q(M_AXI_RDATA_I[13]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[14] 
       (.C(out),
        .CE(E),
        .D(Q[14]),
        .Q(M_AXI_RDATA_I[14]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[15] 
       (.C(out),
        .CE(E),
        .D(Q[15]),
        .Q(M_AXI_RDATA_I[15]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[16] 
       (.C(out),
        .CE(E),
        .D(Q[16]),
        .Q(M_AXI_RDATA_I[16]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[17] 
       (.C(out),
        .CE(E),
        .D(Q[17]),
        .Q(M_AXI_RDATA_I[17]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[18] 
       (.C(out),
        .CE(E),
        .D(Q[18]),
        .Q(M_AXI_RDATA_I[18]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[19] 
       (.C(out),
        .CE(E),
        .D(Q[19]),
        .Q(M_AXI_RDATA_I[19]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[1] 
       (.C(out),
        .CE(E),
        .D(Q[1]),
        .Q(M_AXI_RDATA_I[1]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[20] 
       (.C(out),
        .CE(E),
        .D(Q[20]),
        .Q(M_AXI_RDATA_I[20]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[21] 
       (.C(out),
        .CE(E),
        .D(Q[21]),
        .Q(M_AXI_RDATA_I[21]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[22] 
       (.C(out),
        .CE(E),
        .D(Q[22]),
        .Q(M_AXI_RDATA_I[22]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[23] 
       (.C(out),
        .CE(E),
        .D(Q[23]),
        .Q(M_AXI_RDATA_I[23]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[24] 
       (.C(out),
        .CE(E),
        .D(Q[24]),
        .Q(M_AXI_RDATA_I[24]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[25] 
       (.C(out),
        .CE(E),
        .D(Q[25]),
        .Q(M_AXI_RDATA_I[25]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[26] 
       (.C(out),
        .CE(E),
        .D(Q[26]),
        .Q(M_AXI_RDATA_I[26]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[27] 
       (.C(out),
        .CE(E),
        .D(Q[27]),
        .Q(M_AXI_RDATA_I[27]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[28] 
       (.C(out),
        .CE(E),
        .D(Q[28]),
        .Q(M_AXI_RDATA_I[28]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[29] 
       (.C(out),
        .CE(E),
        .D(Q[29]),
        .Q(M_AXI_RDATA_I[29]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[2] 
       (.C(out),
        .CE(E),
        .D(Q[2]),
        .Q(M_AXI_RDATA_I[2]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[30] 
       (.C(out),
        .CE(E),
        .D(Q[30]),
        .Q(M_AXI_RDATA_I[30]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[31] 
       (.C(out),
        .CE(E),
        .D(Q[31]),
        .Q(M_AXI_RDATA_I[31]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[32] 
       (.C(out),
        .CE(E),
        .D(Q[32]),
        .Q(M_AXI_RDATA_I[32]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[33] 
       (.C(out),
        .CE(E),
        .D(Q[33]),
        .Q(M_AXI_RDATA_I[33]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[34] 
       (.C(out),
        .CE(E),
        .D(Q[34]),
        .Q(M_AXI_RDATA_I[34]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[35] 
       (.C(out),
        .CE(E),
        .D(Q[35]),
        .Q(M_AXI_RDATA_I[35]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[36] 
       (.C(out),
        .CE(E),
        .D(Q[36]),
        .Q(M_AXI_RDATA_I[36]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[37] 
       (.C(out),
        .CE(E),
        .D(Q[37]),
        .Q(M_AXI_RDATA_I[37]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[38] 
       (.C(out),
        .CE(E),
        .D(Q[38]),
        .Q(M_AXI_RDATA_I[38]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[39] 
       (.C(out),
        .CE(E),
        .D(Q[39]),
        .Q(M_AXI_RDATA_I[39]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[3] 
       (.C(out),
        .CE(E),
        .D(Q[3]),
        .Q(M_AXI_RDATA_I[3]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[40] 
       (.C(out),
        .CE(E),
        .D(Q[40]),
        .Q(M_AXI_RDATA_I[40]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[41] 
       (.C(out),
        .CE(E),
        .D(Q[41]),
        .Q(M_AXI_RDATA_I[41]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[42] 
       (.C(out),
        .CE(E),
        .D(Q[42]),
        .Q(M_AXI_RDATA_I[42]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[43] 
       (.C(out),
        .CE(E),
        .D(Q[43]),
        .Q(M_AXI_RDATA_I[43]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[44] 
       (.C(out),
        .CE(E),
        .D(Q[44]),
        .Q(M_AXI_RDATA_I[44]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[45] 
       (.C(out),
        .CE(E),
        .D(Q[45]),
        .Q(M_AXI_RDATA_I[45]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[46] 
       (.C(out),
        .CE(E),
        .D(Q[46]),
        .Q(M_AXI_RDATA_I[46]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[47] 
       (.C(out),
        .CE(E),
        .D(Q[47]),
        .Q(M_AXI_RDATA_I[47]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[48] 
       (.C(out),
        .CE(E),
        .D(Q[48]),
        .Q(M_AXI_RDATA_I[48]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[49] 
       (.C(out),
        .CE(E),
        .D(Q[49]),
        .Q(M_AXI_RDATA_I[49]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[4] 
       (.C(out),
        .CE(E),
        .D(Q[4]),
        .Q(M_AXI_RDATA_I[4]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[50] 
       (.C(out),
        .CE(E),
        .D(Q[50]),
        .Q(M_AXI_RDATA_I[50]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[51] 
       (.C(out),
        .CE(E),
        .D(Q[51]),
        .Q(M_AXI_RDATA_I[51]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[52] 
       (.C(out),
        .CE(E),
        .D(Q[52]),
        .Q(M_AXI_RDATA_I[52]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[53] 
       (.C(out),
        .CE(E),
        .D(Q[53]),
        .Q(M_AXI_RDATA_I[53]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[54] 
       (.C(out),
        .CE(E),
        .D(Q[54]),
        .Q(M_AXI_RDATA_I[54]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[55] 
       (.C(out),
        .CE(E),
        .D(Q[55]),
        .Q(M_AXI_RDATA_I[55]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[56] 
       (.C(out),
        .CE(E),
        .D(Q[56]),
        .Q(M_AXI_RDATA_I[56]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[57] 
       (.C(out),
        .CE(E),
        .D(Q[57]),
        .Q(M_AXI_RDATA_I[57]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[58] 
       (.C(out),
        .CE(E),
        .D(Q[58]),
        .Q(M_AXI_RDATA_I[58]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[59] 
       (.C(out),
        .CE(E),
        .D(Q[59]),
        .Q(M_AXI_RDATA_I[59]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[5] 
       (.C(out),
        .CE(E),
        .D(Q[5]),
        .Q(M_AXI_RDATA_I[5]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[60] 
       (.C(out),
        .CE(E),
        .D(Q[60]),
        .Q(M_AXI_RDATA_I[60]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[61] 
       (.C(out),
        .CE(E),
        .D(Q[61]),
        .Q(M_AXI_RDATA_I[61]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[62] 
       (.C(out),
        .CE(E),
        .D(Q[62]),
        .Q(M_AXI_RDATA_I[62]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[63] 
       (.C(out),
        .CE(E),
        .D(Q[63]),
        .Q(M_AXI_RDATA_I[63]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[6] 
       (.C(out),
        .CE(E),
        .D(Q[6]),
        .Q(M_AXI_RDATA_I[6]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[7] 
       (.C(out),
        .CE(E),
        .D(Q[7]),
        .Q(M_AXI_RDATA_I[7]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[8] 
       (.C(out),
        .CE(E),
        .D(Q[8]),
        .Q(M_AXI_RDATA_I[8]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \M_AXI_RDATA_I_reg[9] 
       (.C(out),
        .CE(E),
        .D(Q[9]),
        .Q(M_AXI_RDATA_I[9]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_1 
       (.I0(s_axi_aresetn),
        .O(\M_AXI_RDATA_I_reg[0]_0 ));
  FDSE \USE_RTL_LENGTH.first_mi_word_q_reg 
       (.C(out),
        .CE(m_valid_i_reg),
        .D(Q[66]),
        .Q(\USE_RTL_LENGTH.first_mi_word_q ),
        .S(\M_AXI_RDATA_I_reg[0]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'h1D)) 
    \USE_RTL_LENGTH.length_counter_q[0]_i_1 
       (.I0(\USE_RTL_LENGTH.length_counter_q_reg [0]),
        .I1(\USE_RTL_LENGTH.first_mi_word_q ),
        .I2(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [0]),
        .O(\USE_RTL_LENGTH.length_counter_q[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT5 #(
    .INIT(32'hCCA533A5)) 
    \USE_RTL_LENGTH.length_counter_q[1]_i_1 
       (.I0(\USE_RTL_LENGTH.length_counter_q_reg [1]),
        .I1(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [1]),
        .I2(\USE_RTL_LENGTH.length_counter_q_reg [0]),
        .I3(\USE_RTL_LENGTH.first_mi_word_q ),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [0]),
        .O(\USE_RTL_LENGTH.length_counter_q[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h56A6)) 
    \USE_RTL_LENGTH.length_counter_q[2]_i_1 
       (.I0(\USE_RTL_LENGTH.length_counter_q[3]_i_2_n_0 ),
        .I1(\USE_RTL_LENGTH.length_counter_q_reg [2]),
        .I2(\USE_RTL_LENGTH.first_mi_word_q ),
        .I3(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [2]),
        .O(\USE_RTL_LENGTH.length_counter_q[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hC3AAC355CCAACCAA)) 
    \USE_RTL_LENGTH.length_counter_q[3]_i_1 
       (.I0(\USE_RTL_LENGTH.length_counter_q_reg [3]),
        .I1(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [3]),
        .I2(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [2]),
        .I3(\USE_RTL_LENGTH.first_mi_word_q ),
        .I4(\USE_RTL_LENGTH.length_counter_q_reg [2]),
        .I5(\USE_RTL_LENGTH.length_counter_q[3]_i_2_n_0 ),
        .O(\USE_RTL_LENGTH.length_counter_q[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT5 #(
    .INIT(32'h00053305)) 
    \USE_RTL_LENGTH.length_counter_q[3]_i_2 
       (.I0(\USE_RTL_LENGTH.length_counter_q_reg [1]),
        .I1(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [1]),
        .I2(\USE_RTL_LENGTH.length_counter_q_reg [0]),
        .I3(\USE_RTL_LENGTH.first_mi_word_q ),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [0]),
        .O(\USE_RTL_LENGTH.length_counter_q[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT4 #(
    .INIT(16'hB847)) 
    \USE_RTL_LENGTH.length_counter_q[4]_i_1 
       (.I0(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [4]),
        .I1(\USE_RTL_LENGTH.first_mi_word_q ),
        .I2(\USE_RTL_LENGTH.length_counter_q_reg [4]),
        .I3(s_axi_rlast_INST_0_i_4_n_0),
        .O(\USE_RTL_LENGTH.length_counter_q[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCCAACCAAC3AAC355)) 
    \USE_RTL_LENGTH.length_counter_q[5]_i_1 
       (.I0(\USE_RTL_LENGTH.length_counter_q_reg [5]),
        .I1(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [5]),
        .I2(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [4]),
        .I3(\USE_RTL_LENGTH.first_mi_word_q ),
        .I4(\USE_RTL_LENGTH.length_counter_q_reg [4]),
        .I5(s_axi_rlast_INST_0_i_4_n_0),
        .O(\USE_RTL_LENGTH.length_counter_q[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hC3AAC355CCAACCAA)) 
    \USE_RTL_LENGTH.length_counter_q[6]_i_1 
       (.I0(\USE_RTL_LENGTH.length_counter_q_reg [6]),
        .I1(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [6]),
        .I2(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [5]),
        .I3(\USE_RTL_LENGTH.first_mi_word_q ),
        .I4(\USE_RTL_LENGTH.length_counter_q_reg [5]),
        .I5(\USE_RTL_LENGTH.length_counter_q[6]_i_2_n_0 ),
        .O(\USE_RTL_LENGTH.length_counter_q[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT4 #(
    .INIT(16'h0151)) 
    \USE_RTL_LENGTH.length_counter_q[6]_i_2 
       (.I0(s_axi_rlast_INST_0_i_4_n_0),
        .I1(\USE_RTL_LENGTH.length_counter_q_reg [4]),
        .I2(\USE_RTL_LENGTH.first_mi_word_q ),
        .I3(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [4]),
        .O(\USE_RTL_LENGTH.length_counter_q[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hC3AAC355CCAACCAA)) 
    \USE_RTL_LENGTH.length_counter_q[7]_i_1 
       (.I0(\USE_RTL_LENGTH.length_counter_q_reg [7]),
        .I1(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [7]),
        .I2(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [6]),
        .I3(\USE_RTL_LENGTH.first_mi_word_q ),
        .I4(\USE_RTL_LENGTH.length_counter_q_reg [6]),
        .I5(\USE_RTL_LENGTH.length_counter_q[7]_i_2_n_0 ),
        .O(\USE_RTL_LENGTH.length_counter_q[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000305050003)) 
    \USE_RTL_LENGTH.length_counter_q[7]_i_2 
       (.I0(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [4]),
        .I1(\USE_RTL_LENGTH.length_counter_q_reg [4]),
        .I2(s_axi_rlast_INST_0_i_4_n_0),
        .I3(\USE_RTL_LENGTH.length_counter_q_reg [5]),
        .I4(\USE_RTL_LENGTH.first_mi_word_q ),
        .I5(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [5]),
        .O(\USE_RTL_LENGTH.length_counter_q[7]_i_2_n_0 ));
  FDRE \USE_RTL_LENGTH.length_counter_q_reg[0] 
       (.C(out),
        .CE(m_valid_i_reg),
        .D(\USE_RTL_LENGTH.length_counter_q[0]_i_1_n_0 ),
        .Q(\USE_RTL_LENGTH.length_counter_q_reg [0]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \USE_RTL_LENGTH.length_counter_q_reg[1] 
       (.C(out),
        .CE(m_valid_i_reg),
        .D(\USE_RTL_LENGTH.length_counter_q[1]_i_1_n_0 ),
        .Q(\USE_RTL_LENGTH.length_counter_q_reg [1]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \USE_RTL_LENGTH.length_counter_q_reg[2] 
       (.C(out),
        .CE(m_valid_i_reg),
        .D(\USE_RTL_LENGTH.length_counter_q[2]_i_1_n_0 ),
        .Q(\USE_RTL_LENGTH.length_counter_q_reg [2]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \USE_RTL_LENGTH.length_counter_q_reg[3] 
       (.C(out),
        .CE(m_valid_i_reg),
        .D(\USE_RTL_LENGTH.length_counter_q[3]_i_1_n_0 ),
        .Q(\USE_RTL_LENGTH.length_counter_q_reg [3]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \USE_RTL_LENGTH.length_counter_q_reg[4] 
       (.C(out),
        .CE(m_valid_i_reg),
        .D(\USE_RTL_LENGTH.length_counter_q[4]_i_1_n_0 ),
        .Q(\USE_RTL_LENGTH.length_counter_q_reg [4]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \USE_RTL_LENGTH.length_counter_q_reg[5] 
       (.C(out),
        .CE(m_valid_i_reg),
        .D(\USE_RTL_LENGTH.length_counter_q[5]_i_1_n_0 ),
        .Q(\USE_RTL_LENGTH.length_counter_q_reg [5]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \USE_RTL_LENGTH.length_counter_q_reg[6] 
       (.C(out),
        .CE(m_valid_i_reg),
        .D(\USE_RTL_LENGTH.length_counter_q[6]_i_1_n_0 ),
        .Q(\USE_RTL_LENGTH.length_counter_q_reg [6]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \USE_RTL_LENGTH.length_counter_q_reg[7] 
       (.C(out),
        .CE(m_valid_i_reg),
        .D(\USE_RTL_LENGTH.length_counter_q[7]_i_1_n_0 ),
        .Q(\USE_RTL_LENGTH.length_counter_q_reg [7]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \current_word_1_reg[0] 
       (.C(out),
        .CE(p_15_in),
        .D(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[13] [0]),
        .Q(first_word_reg_0[0]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \current_word_1_reg[1] 
       (.C(out),
        .CE(p_15_in),
        .D(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[13] [1]),
        .Q(first_word_reg_0[1]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \current_word_1_reg[2] 
       (.C(out),
        .CE(p_15_in),
        .D(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[13] [2]),
        .Q(first_word_reg_0[2]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDSE first_word_reg
       (.C(out),
        .CE(p_15_in),
        .D(s_axi_rlast),
        .Q(first_word),
        .S(\M_AXI_RDATA_I_reg[0]_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \m_payload_i[66]_i_5 
       (.I0(wrap_buffer_available),
        .I1(s_axi_rlast_INST_0_i_6_n_0),
        .I2(\m_payload_i[66]_i_6_n_0 ),
        .I3(\m_payload_i[66]_i_7_n_0 ),
        .I4(\m_payload_i[66]_i_8_n_0 ),
        .I5(s_axi_rlast_INST_0_i_4_n_0),
        .O(\m_payload_i_reg[66] ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[66]_i_6 
       (.I0(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [7]),
        .I1(\USE_RTL_LENGTH.first_mi_word_q ),
        .I2(\USE_RTL_LENGTH.length_counter_q_reg [7]),
        .O(\m_payload_i[66]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[66]_i_7 
       (.I0(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [5]),
        .I1(\USE_RTL_LENGTH.first_mi_word_q ),
        .I2(\USE_RTL_LENGTH.length_counter_q_reg [5]),
        .O(\m_payload_i[66]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[66]_i_8 
       (.I0(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [6]),
        .I1(\USE_RTL_LENGTH.first_mi_word_q ),
        .I2(\USE_RTL_LENGTH.length_counter_q_reg [6]),
        .O(\m_payload_i[66]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'hA888)) 
    \pre_next_word_1[2]_i_1 
       (.I0(s_axi_rready),
        .I1(use_wrap_buffer),
        .I2(mr_rvalid),
        .I3(\USE_READ.rd_cmd_valid ),
        .O(p_15_in));
  LUT4 #(
    .INIT(16'h01FD)) 
    \pre_next_word_1[2]_i_3 
       (.I0(\current_word_1_reg[2]_0 [2]),
        .I1(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [12]),
        .I2(first_word),
        .I3(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [10]),
        .O(\pre_next_word_1_reg[2]_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \pre_next_word_1[2]_i_4 
       (.I0(\current_word_1_reg[2]_0 [1]),
        .I1(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [12]),
        .I2(first_word),
        .I3(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [9]),
        .O(\pre_next_word_1_reg[2]_1 ));
  FDRE \pre_next_word_1_reg[0] 
       (.C(out),
        .CE(p_15_in),
        .D(D[0]),
        .Q(\current_word_1_reg[2]_0 [0]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \pre_next_word_1_reg[1] 
       (.C(out),
        .CE(p_15_in),
        .D(D[1]),
        .Q(\current_word_1_reg[2]_0 [1]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \pre_next_word_1_reg[2] 
       (.C(out),
        .CE(p_15_in),
        .D(D[2]),
        .Q(\current_word_1_reg[2]_0 [2]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \rresp_wrap_buffer_reg[0] 
       (.C(out),
        .CE(E),
        .D(Q[64]),
        .Q(rresp_wrap_buffer[0]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  FDRE \rresp_wrap_buffer_reg[1] 
       (.C(out),
        .CE(E),
        .D(Q[65]),
        .Q(rresp_wrap_buffer[1]),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[0]_INST_0 
       (.I0(M_AXI_RDATA_I[0]),
        .I1(M_AXI_RDATA_I[32]),
        .I2(use_wrap_buffer),
        .I3(Q[0]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[32]),
        .O(s_axi_rdata[0]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[10]_INST_0 
       (.I0(M_AXI_RDATA_I[10]),
        .I1(M_AXI_RDATA_I[42]),
        .I2(use_wrap_buffer),
        .I3(Q[10]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[42]),
        .O(s_axi_rdata[10]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[11]_INST_0 
       (.I0(M_AXI_RDATA_I[11]),
        .I1(M_AXI_RDATA_I[43]),
        .I2(use_wrap_buffer),
        .I3(Q[11]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[43]),
        .O(s_axi_rdata[11]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[12]_INST_0 
       (.I0(M_AXI_RDATA_I[12]),
        .I1(M_AXI_RDATA_I[44]),
        .I2(use_wrap_buffer),
        .I3(Q[12]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[44]),
        .O(s_axi_rdata[12]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[13]_INST_0 
       (.I0(M_AXI_RDATA_I[13]),
        .I1(M_AXI_RDATA_I[45]),
        .I2(use_wrap_buffer),
        .I3(Q[13]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[45]),
        .O(s_axi_rdata[13]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[14]_INST_0 
       (.I0(M_AXI_RDATA_I[14]),
        .I1(M_AXI_RDATA_I[46]),
        .I2(use_wrap_buffer),
        .I3(Q[14]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[46]),
        .O(s_axi_rdata[14]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[15]_INST_0 
       (.I0(M_AXI_RDATA_I[15]),
        .I1(M_AXI_RDATA_I[47]),
        .I2(use_wrap_buffer),
        .I3(Q[15]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[47]),
        .O(s_axi_rdata[15]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[16]_INST_0 
       (.I0(M_AXI_RDATA_I[16]),
        .I1(M_AXI_RDATA_I[48]),
        .I2(use_wrap_buffer),
        .I3(Q[16]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[48]),
        .O(s_axi_rdata[16]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[17]_INST_0 
       (.I0(M_AXI_RDATA_I[17]),
        .I1(M_AXI_RDATA_I[49]),
        .I2(use_wrap_buffer),
        .I3(Q[17]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[49]),
        .O(s_axi_rdata[17]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[18]_INST_0 
       (.I0(M_AXI_RDATA_I[18]),
        .I1(M_AXI_RDATA_I[50]),
        .I2(use_wrap_buffer),
        .I3(Q[18]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[50]),
        .O(s_axi_rdata[18]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[19]_INST_0 
       (.I0(M_AXI_RDATA_I[19]),
        .I1(M_AXI_RDATA_I[51]),
        .I2(use_wrap_buffer),
        .I3(Q[19]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[51]),
        .O(s_axi_rdata[19]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[1]_INST_0 
       (.I0(M_AXI_RDATA_I[1]),
        .I1(M_AXI_RDATA_I[33]),
        .I2(use_wrap_buffer),
        .I3(Q[1]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[33]),
        .O(s_axi_rdata[1]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[20]_INST_0 
       (.I0(M_AXI_RDATA_I[20]),
        .I1(M_AXI_RDATA_I[52]),
        .I2(use_wrap_buffer),
        .I3(Q[20]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[52]),
        .O(s_axi_rdata[20]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[21]_INST_0 
       (.I0(M_AXI_RDATA_I[21]),
        .I1(M_AXI_RDATA_I[53]),
        .I2(use_wrap_buffer),
        .I3(Q[21]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[53]),
        .O(s_axi_rdata[21]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[22]_INST_0 
       (.I0(M_AXI_RDATA_I[22]),
        .I1(M_AXI_RDATA_I[54]),
        .I2(use_wrap_buffer),
        .I3(Q[22]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[54]),
        .O(s_axi_rdata[22]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[23]_INST_0 
       (.I0(M_AXI_RDATA_I[23]),
        .I1(M_AXI_RDATA_I[55]),
        .I2(use_wrap_buffer),
        .I3(Q[23]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[55]),
        .O(s_axi_rdata[23]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[24]_INST_0 
       (.I0(M_AXI_RDATA_I[24]),
        .I1(M_AXI_RDATA_I[56]),
        .I2(use_wrap_buffer),
        .I3(Q[24]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[56]),
        .O(s_axi_rdata[24]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[25]_INST_0 
       (.I0(M_AXI_RDATA_I[25]),
        .I1(M_AXI_RDATA_I[57]),
        .I2(use_wrap_buffer),
        .I3(Q[25]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[57]),
        .O(s_axi_rdata[25]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[26]_INST_0 
       (.I0(M_AXI_RDATA_I[26]),
        .I1(M_AXI_RDATA_I[58]),
        .I2(use_wrap_buffer),
        .I3(Q[26]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[58]),
        .O(s_axi_rdata[26]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[27]_INST_0 
       (.I0(M_AXI_RDATA_I[27]),
        .I1(M_AXI_RDATA_I[59]),
        .I2(use_wrap_buffer),
        .I3(Q[27]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[59]),
        .O(s_axi_rdata[27]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[28]_INST_0 
       (.I0(M_AXI_RDATA_I[28]),
        .I1(M_AXI_RDATA_I[60]),
        .I2(use_wrap_buffer),
        .I3(Q[28]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[60]),
        .O(s_axi_rdata[28]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[29]_INST_0 
       (.I0(M_AXI_RDATA_I[29]),
        .I1(M_AXI_RDATA_I[61]),
        .I2(use_wrap_buffer),
        .I3(Q[29]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[61]),
        .O(s_axi_rdata[29]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[2]_INST_0 
       (.I0(M_AXI_RDATA_I[2]),
        .I1(M_AXI_RDATA_I[34]),
        .I2(use_wrap_buffer),
        .I3(Q[2]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[34]),
        .O(s_axi_rdata[2]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[30]_INST_0 
       (.I0(M_AXI_RDATA_I[30]),
        .I1(M_AXI_RDATA_I[62]),
        .I2(use_wrap_buffer),
        .I3(Q[30]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[62]),
        .O(s_axi_rdata[30]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[31]_INST_0 
       (.I0(M_AXI_RDATA_I[31]),
        .I1(M_AXI_RDATA_I[63]),
        .I2(use_wrap_buffer),
        .I3(Q[31]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[63]),
        .O(s_axi_rdata[31]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[3]_INST_0 
       (.I0(M_AXI_RDATA_I[3]),
        .I1(M_AXI_RDATA_I[35]),
        .I2(use_wrap_buffer),
        .I3(Q[3]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[35]),
        .O(s_axi_rdata[3]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[4]_INST_0 
       (.I0(M_AXI_RDATA_I[4]),
        .I1(M_AXI_RDATA_I[36]),
        .I2(use_wrap_buffer),
        .I3(Q[4]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[36]),
        .O(s_axi_rdata[4]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[5]_INST_0 
       (.I0(M_AXI_RDATA_I[5]),
        .I1(M_AXI_RDATA_I[37]),
        .I2(use_wrap_buffer),
        .I3(Q[5]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[37]),
        .O(s_axi_rdata[5]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[6]_INST_0 
       (.I0(M_AXI_RDATA_I[6]),
        .I1(M_AXI_RDATA_I[38]),
        .I2(use_wrap_buffer),
        .I3(Q[6]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[38]),
        .O(s_axi_rdata[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[7]_INST_0 
       (.I0(M_AXI_RDATA_I[7]),
        .I1(M_AXI_RDATA_I[39]),
        .I2(use_wrap_buffer),
        .I3(Q[7]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[39]),
        .O(s_axi_rdata[7]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[8]_INST_0 
       (.I0(M_AXI_RDATA_I[8]),
        .I1(M_AXI_RDATA_I[40]),
        .I2(use_wrap_buffer),
        .I3(Q[8]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[40]),
        .O(s_axi_rdata[8]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \s_axi_rdata[9]_INST_0 
       (.I0(M_AXI_RDATA_I[9]),
        .I1(M_AXI_RDATA_I[41]),
        .I2(use_wrap_buffer),
        .I3(Q[9]),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] ),
        .I5(Q[41]),
        .O(s_axi_rdata[9]));
  LUT6 #(
    .INIT(64'h0000F100F1000000)) 
    s_axi_rlast_INST_0
       (.I0(wrap_buffer_available),
        .I1(wrap_buffer_available_reg_0),
        .I2(use_wrap_buffer),
        .I3(\current_word_1_reg[0]_0 ),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [8]),
        .I5(s_axi_rlast_INST_0_i_3_n_0),
        .O(s_axi_rlast));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFEEEFE)) 
    s_axi_rlast_INST_0_i_1
       (.I0(s_axi_rlast_INST_0_i_4_n_0),
        .I1(s_axi_rlast_INST_0_i_5_n_0),
        .I2(\USE_RTL_LENGTH.length_counter_q_reg [7]),
        .I3(\USE_RTL_LENGTH.first_mi_word_q ),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [7]),
        .I5(s_axi_rlast_INST_0_i_6_n_0),
        .O(wrap_buffer_available_reg_0));
  LUT4 #(
    .INIT(16'h01FD)) 
    s_axi_rlast_INST_0_i_3
       (.I0(first_word_reg_0[2]),
        .I1(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [12]),
        .I2(first_word),
        .I3(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [11]),
        .O(s_axi_rlast_INST_0_i_3_n_0));
  LUT6 #(
    .INIT(64'hFFBBFCB8FFFFFFFF)) 
    s_axi_rlast_INST_0_i_4
       (.I0(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [2]),
        .I1(\USE_RTL_LENGTH.first_mi_word_q ),
        .I2(\USE_RTL_LENGTH.length_counter_q_reg [2]),
        .I3(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [3]),
        .I4(\USE_RTL_LENGTH.length_counter_q_reg [3]),
        .I5(\USE_RTL_LENGTH.length_counter_q[3]_i_2_n_0 ),
        .O(s_axi_rlast_INST_0_i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT5 #(
    .INIT(32'hFFFACCFA)) 
    s_axi_rlast_INST_0_i_5
       (.I0(\USE_RTL_LENGTH.length_counter_q_reg [6]),
        .I1(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [6]),
        .I2(\USE_RTL_LENGTH.length_counter_q_reg [5]),
        .I3(\USE_RTL_LENGTH.first_mi_word_q ),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [5]),
        .O(s_axi_rlast_INST_0_i_5_n_0));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    s_axi_rlast_INST_0_i_6
       (.I0(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] [4]),
        .I1(\USE_RTL_LENGTH.first_mi_word_q ),
        .I2(\USE_RTL_LENGTH.length_counter_q_reg [4]),
        .O(s_axi_rlast_INST_0_i_6_n_0));
  LUT3 #(
    .INIT(8'hB8)) 
    \s_axi_rresp[0]_INST_0 
       (.I0(rresp_wrap_buffer[0]),
        .I1(use_wrap_buffer),
        .I2(Q[64]),
        .O(s_axi_rresp[0]));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \s_axi_rresp[1]_INST_0 
       (.I0(rresp_wrap_buffer[1]),
        .I1(use_wrap_buffer),
        .I2(Q[65]),
        .O(s_axi_rresp[1]));
  LUT6 #(
    .INIT(64'hBBFBBBBB00F00000)) 
    use_wrap_buffer_i_1
       (.I0(use_wrap_buffer_i_2_n_0),
        .I1(s_axi_rlast),
        .I2(use_wrap_buffer_reg_0),
        .I3(use_wrap_buffer_i_3_n_0),
        .I4(wrap_buffer_available),
        .I5(use_wrap_buffer),
        .O(use_wrap_buffer_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT4 #(
    .INIT(16'h57FF)) 
    use_wrap_buffer_i_2
       (.I0(s_axi_rready),
        .I1(use_wrap_buffer),
        .I2(mr_rvalid),
        .I3(\USE_READ.rd_cmd_valid ),
        .O(use_wrap_buffer_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT4 #(
    .INIT(16'hAABF)) 
    use_wrap_buffer_i_3
       (.I0(wrap_buffer_available_reg_0),
        .I1(\USE_READ.rd_cmd_valid ),
        .I2(mr_rvalid),
        .I3(use_wrap_buffer),
        .O(use_wrap_buffer_i_3_n_0));
  FDRE use_wrap_buffer_reg
       (.C(out),
        .CE(1'b1),
        .D(use_wrap_buffer_i_1_n_0),
        .Q(use_wrap_buffer),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
  LUT5 #(
    .INIT(32'hFEFFAA00)) 
    wrap_buffer_available_i_1
       (.I0(E),
        .I1(wrap_buffer_available_reg_0),
        .I2(wrap_buffer_available_i_2_n_0),
        .I3(use_wrap_buffer_reg_0),
        .I4(wrap_buffer_available),
        .O(wrap_buffer_available_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'h15)) 
    wrap_buffer_available_i_2
       (.I0(use_wrap_buffer),
        .I1(mr_rvalid),
        .I2(\USE_READ.rd_cmd_valid ),
        .O(wrap_buffer_available_i_2_n_0));
  FDRE wrap_buffer_available_reg
       (.C(out),
        .CE(1'b1),
        .D(wrap_buffer_available_i_1_n_0),
        .Q(wrap_buffer_available),
        .R(\M_AXI_RDATA_I_reg[0]_0 ));
endmodule

(* C_AXI_ADDR_WIDTH = "32" *) (* C_AXI_IS_ACLK_ASYNC = "0" *) (* C_AXI_PROTOCOL = "0" *) 
(* C_AXI_SUPPORTS_READ = "1" *) (* C_AXI_SUPPORTS_WRITE = "0" *) (* C_FAMILY = "zynq" *) 
(* C_FIFO_MODE = "0" *) (* C_MAX_SPLIT_BEATS = "16" *) (* C_M_AXI_ACLK_RATIO = "2" *) 
(* C_M_AXI_BYTES_LOG = "3" *) (* C_M_AXI_DATA_WIDTH = "64" *) (* C_PACKING_LEVEL = "1" *) 
(* C_RATIO = "0" *) (* C_RATIO_LOG = "0" *) (* C_SUPPORTS_ID = "0" *) 
(* C_SYNCHRONIZER_STAGE = "3" *) (* C_S_AXI_ACLK_RATIO = "1" *) (* C_S_AXI_BYTES_LOG = "2" *) 
(* C_S_AXI_DATA_WIDTH = "32" *) (* C_S_AXI_ID_WIDTH = "1" *) (* DowngradeIPIdentifiedWarnings = "yes" *) 
(* P_AXI3 = "1" *) (* P_AXI4 = "0" *) (* P_AXILITE = "2" *) 
(* P_CONVERSION = "2" *) (* P_MAX_SPLIT_BEATS = "16" *) 
module system_auto_us_0_axi_dwidth_converter_v2_1_15_top
   (s_axi_aclk,
    s_axi_aresetn,
    s_axi_awid,
    s_axi_awaddr,
    s_axi_awlen,
    s_axi_awsize,
    s_axi_awburst,
    s_axi_awlock,
    s_axi_awcache,
    s_axi_awprot,
    s_axi_awregion,
    s_axi_awqos,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wlast,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bid,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_arid,
    s_axi_araddr,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_arburst,
    s_axi_arlock,
    s_axi_arcache,
    s_axi_arprot,
    s_axi_arregion,
    s_axi_arqos,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rid,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rlast,
    s_axi_rvalid,
    s_axi_rready,
    m_axi_aclk,
    m_axi_aresetn,
    m_axi_awaddr,
    m_axi_awlen,
    m_axi_awsize,
    m_axi_awburst,
    m_axi_awlock,
    m_axi_awcache,
    m_axi_awprot,
    m_axi_awregion,
    m_axi_awqos,
    m_axi_awvalid,
    m_axi_awready,
    m_axi_wdata,
    m_axi_wstrb,
    m_axi_wlast,
    m_axi_wvalid,
    m_axi_wready,
    m_axi_bresp,
    m_axi_bvalid,
    m_axi_bready,
    m_axi_araddr,
    m_axi_arlen,
    m_axi_arsize,
    m_axi_arburst,
    m_axi_arlock,
    m_axi_arcache,
    m_axi_arprot,
    m_axi_arregion,
    m_axi_arqos,
    m_axi_arvalid,
    m_axi_arready,
    m_axi_rdata,
    m_axi_rresp,
    m_axi_rlast,
    m_axi_rvalid,
    m_axi_rready);
  (* keep = "true" *) input s_axi_aclk;
  (* keep = "true" *) input s_axi_aresetn;
  input [0:0]s_axi_awid;
  input [31:0]s_axi_awaddr;
  input [7:0]s_axi_awlen;
  input [2:0]s_axi_awsize;
  input [1:0]s_axi_awburst;
  input [0:0]s_axi_awlock;
  input [3:0]s_axi_awcache;
  input [2:0]s_axi_awprot;
  input [3:0]s_axi_awregion;
  input [3:0]s_axi_awqos;
  input s_axi_awvalid;
  output s_axi_awready;
  input [31:0]s_axi_wdata;
  input [3:0]s_axi_wstrb;
  input s_axi_wlast;
  input s_axi_wvalid;
  output s_axi_wready;
  output [0:0]s_axi_bid;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [0:0]s_axi_arid;
  input [31:0]s_axi_araddr;
  input [7:0]s_axi_arlen;
  input [2:0]s_axi_arsize;
  input [1:0]s_axi_arburst;
  input [0:0]s_axi_arlock;
  input [3:0]s_axi_arcache;
  input [2:0]s_axi_arprot;
  input [3:0]s_axi_arregion;
  input [3:0]s_axi_arqos;
  input s_axi_arvalid;
  output s_axi_arready;
  output [0:0]s_axi_rid;
  output [31:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rlast;
  output s_axi_rvalid;
  input s_axi_rready;
  (* keep = "true" *) input m_axi_aclk;
  (* keep = "true" *) input m_axi_aresetn;
  output [31:0]m_axi_awaddr;
  output [7:0]m_axi_awlen;
  output [2:0]m_axi_awsize;
  output [1:0]m_axi_awburst;
  output [0:0]m_axi_awlock;
  output [3:0]m_axi_awcache;
  output [2:0]m_axi_awprot;
  output [3:0]m_axi_awregion;
  output [3:0]m_axi_awqos;
  output m_axi_awvalid;
  input m_axi_awready;
  output [63:0]m_axi_wdata;
  output [7:0]m_axi_wstrb;
  output m_axi_wlast;
  output m_axi_wvalid;
  input m_axi_wready;
  input [1:0]m_axi_bresp;
  input m_axi_bvalid;
  output m_axi_bready;
  output [31:0]m_axi_araddr;
  output [7:0]m_axi_arlen;
  output [2:0]m_axi_arsize;
  output [1:0]m_axi_arburst;
  output [0:0]m_axi_arlock;
  output [3:0]m_axi_arcache;
  output [2:0]m_axi_arprot;
  output [3:0]m_axi_arregion;
  output [3:0]m_axi_arqos;
  output m_axi_arvalid;
  input m_axi_arready;
  input [63:0]m_axi_rdata;
  input [1:0]m_axi_rresp;
  input m_axi_rlast;
  input m_axi_rvalid;
  output m_axi_rready;

  wire \<const0> ;
  (* RTL_KEEP = "true" *) wire m_axi_aclk;
  wire [31:0]m_axi_araddr;
  wire [1:0]m_axi_arburst;
  wire [3:0]m_axi_arcache;
  (* RTL_KEEP = "true" *) wire m_axi_aresetn;
  wire [7:0]m_axi_arlen;
  wire [0:0]m_axi_arlock;
  wire [2:0]m_axi_arprot;
  wire [3:0]m_axi_arqos;
  wire m_axi_arready;
  wire [3:0]m_axi_arregion;
  wire [2:0]m_axi_arsize;
  wire m_axi_arvalid;
  wire [63:0]m_axi_rdata;
  wire m_axi_rlast;
  wire m_axi_rready;
  wire [1:0]m_axi_rresp;
  wire m_axi_rvalid;
  (* RTL_KEEP = "true" *) wire s_axi_aclk;
  wire [31:0]s_axi_araddr;
  wire [1:0]s_axi_arburst;
  wire [3:0]s_axi_arcache;
  (* RTL_KEEP = "true" *) wire s_axi_aresetn;
  wire [7:0]s_axi_arlen;
  wire [0:0]s_axi_arlock;
  wire [2:0]s_axi_arprot;
  wire [3:0]s_axi_arqos;
  wire s_axi_arready;
  wire [3:0]s_axi_arregion;
  wire [2:0]s_axi_arsize;
  wire s_axi_arvalid;
  wire [31:0]s_axi_rdata;
  wire s_axi_rlast;
  wire s_axi_rready;
  wire [1:0]s_axi_rresp;
  wire s_axi_rvalid;

  assign m_axi_awaddr[31] = \<const0> ;
  assign m_axi_awaddr[30] = \<const0> ;
  assign m_axi_awaddr[29] = \<const0> ;
  assign m_axi_awaddr[28] = \<const0> ;
  assign m_axi_awaddr[27] = \<const0> ;
  assign m_axi_awaddr[26] = \<const0> ;
  assign m_axi_awaddr[25] = \<const0> ;
  assign m_axi_awaddr[24] = \<const0> ;
  assign m_axi_awaddr[23] = \<const0> ;
  assign m_axi_awaddr[22] = \<const0> ;
  assign m_axi_awaddr[21] = \<const0> ;
  assign m_axi_awaddr[20] = \<const0> ;
  assign m_axi_awaddr[19] = \<const0> ;
  assign m_axi_awaddr[18] = \<const0> ;
  assign m_axi_awaddr[17] = \<const0> ;
  assign m_axi_awaddr[16] = \<const0> ;
  assign m_axi_awaddr[15] = \<const0> ;
  assign m_axi_awaddr[14] = \<const0> ;
  assign m_axi_awaddr[13] = \<const0> ;
  assign m_axi_awaddr[12] = \<const0> ;
  assign m_axi_awaddr[11] = \<const0> ;
  assign m_axi_awaddr[10] = \<const0> ;
  assign m_axi_awaddr[9] = \<const0> ;
  assign m_axi_awaddr[8] = \<const0> ;
  assign m_axi_awaddr[7] = \<const0> ;
  assign m_axi_awaddr[6] = \<const0> ;
  assign m_axi_awaddr[5] = \<const0> ;
  assign m_axi_awaddr[4] = \<const0> ;
  assign m_axi_awaddr[3] = \<const0> ;
  assign m_axi_awaddr[2] = \<const0> ;
  assign m_axi_awaddr[1] = \<const0> ;
  assign m_axi_awaddr[0] = \<const0> ;
  assign m_axi_awburst[1] = \<const0> ;
  assign m_axi_awburst[0] = \<const0> ;
  assign m_axi_awcache[3] = \<const0> ;
  assign m_axi_awcache[2] = \<const0> ;
  assign m_axi_awcache[1] = \<const0> ;
  assign m_axi_awcache[0] = \<const0> ;
  assign m_axi_awlen[7] = \<const0> ;
  assign m_axi_awlen[6] = \<const0> ;
  assign m_axi_awlen[5] = \<const0> ;
  assign m_axi_awlen[4] = \<const0> ;
  assign m_axi_awlen[3] = \<const0> ;
  assign m_axi_awlen[2] = \<const0> ;
  assign m_axi_awlen[1] = \<const0> ;
  assign m_axi_awlen[0] = \<const0> ;
  assign m_axi_awlock[0] = \<const0> ;
  assign m_axi_awprot[2] = \<const0> ;
  assign m_axi_awprot[1] = \<const0> ;
  assign m_axi_awprot[0] = \<const0> ;
  assign m_axi_awqos[3] = \<const0> ;
  assign m_axi_awqos[2] = \<const0> ;
  assign m_axi_awqos[1] = \<const0> ;
  assign m_axi_awqos[0] = \<const0> ;
  assign m_axi_awregion[3] = \<const0> ;
  assign m_axi_awregion[2] = \<const0> ;
  assign m_axi_awregion[1] = \<const0> ;
  assign m_axi_awregion[0] = \<const0> ;
  assign m_axi_awsize[2] = \<const0> ;
  assign m_axi_awsize[1] = \<const0> ;
  assign m_axi_awsize[0] = \<const0> ;
  assign m_axi_awvalid = \<const0> ;
  assign m_axi_bready = \<const0> ;
  assign m_axi_wdata[63] = \<const0> ;
  assign m_axi_wdata[62] = \<const0> ;
  assign m_axi_wdata[61] = \<const0> ;
  assign m_axi_wdata[60] = \<const0> ;
  assign m_axi_wdata[59] = \<const0> ;
  assign m_axi_wdata[58] = \<const0> ;
  assign m_axi_wdata[57] = \<const0> ;
  assign m_axi_wdata[56] = \<const0> ;
  assign m_axi_wdata[55] = \<const0> ;
  assign m_axi_wdata[54] = \<const0> ;
  assign m_axi_wdata[53] = \<const0> ;
  assign m_axi_wdata[52] = \<const0> ;
  assign m_axi_wdata[51] = \<const0> ;
  assign m_axi_wdata[50] = \<const0> ;
  assign m_axi_wdata[49] = \<const0> ;
  assign m_axi_wdata[48] = \<const0> ;
  assign m_axi_wdata[47] = \<const0> ;
  assign m_axi_wdata[46] = \<const0> ;
  assign m_axi_wdata[45] = \<const0> ;
  assign m_axi_wdata[44] = \<const0> ;
  assign m_axi_wdata[43] = \<const0> ;
  assign m_axi_wdata[42] = \<const0> ;
  assign m_axi_wdata[41] = \<const0> ;
  assign m_axi_wdata[40] = \<const0> ;
  assign m_axi_wdata[39] = \<const0> ;
  assign m_axi_wdata[38] = \<const0> ;
  assign m_axi_wdata[37] = \<const0> ;
  assign m_axi_wdata[36] = \<const0> ;
  assign m_axi_wdata[35] = \<const0> ;
  assign m_axi_wdata[34] = \<const0> ;
  assign m_axi_wdata[33] = \<const0> ;
  assign m_axi_wdata[32] = \<const0> ;
  assign m_axi_wdata[31] = \<const0> ;
  assign m_axi_wdata[30] = \<const0> ;
  assign m_axi_wdata[29] = \<const0> ;
  assign m_axi_wdata[28] = \<const0> ;
  assign m_axi_wdata[27] = \<const0> ;
  assign m_axi_wdata[26] = \<const0> ;
  assign m_axi_wdata[25] = \<const0> ;
  assign m_axi_wdata[24] = \<const0> ;
  assign m_axi_wdata[23] = \<const0> ;
  assign m_axi_wdata[22] = \<const0> ;
  assign m_axi_wdata[21] = \<const0> ;
  assign m_axi_wdata[20] = \<const0> ;
  assign m_axi_wdata[19] = \<const0> ;
  assign m_axi_wdata[18] = \<const0> ;
  assign m_axi_wdata[17] = \<const0> ;
  assign m_axi_wdata[16] = \<const0> ;
  assign m_axi_wdata[15] = \<const0> ;
  assign m_axi_wdata[14] = \<const0> ;
  assign m_axi_wdata[13] = \<const0> ;
  assign m_axi_wdata[12] = \<const0> ;
  assign m_axi_wdata[11] = \<const0> ;
  assign m_axi_wdata[10] = \<const0> ;
  assign m_axi_wdata[9] = \<const0> ;
  assign m_axi_wdata[8] = \<const0> ;
  assign m_axi_wdata[7] = \<const0> ;
  assign m_axi_wdata[6] = \<const0> ;
  assign m_axi_wdata[5] = \<const0> ;
  assign m_axi_wdata[4] = \<const0> ;
  assign m_axi_wdata[3] = \<const0> ;
  assign m_axi_wdata[2] = \<const0> ;
  assign m_axi_wdata[1] = \<const0> ;
  assign m_axi_wdata[0] = \<const0> ;
  assign m_axi_wlast = \<const0> ;
  assign m_axi_wstrb[7] = \<const0> ;
  assign m_axi_wstrb[6] = \<const0> ;
  assign m_axi_wstrb[5] = \<const0> ;
  assign m_axi_wstrb[4] = \<const0> ;
  assign m_axi_wstrb[3] = \<const0> ;
  assign m_axi_wstrb[2] = \<const0> ;
  assign m_axi_wstrb[1] = \<const0> ;
  assign m_axi_wstrb[0] = \<const0> ;
  assign m_axi_wvalid = \<const0> ;
  assign s_axi_awready = \<const0> ;
  assign s_axi_bid[0] = \<const0> ;
  assign s_axi_bresp[1] = \<const0> ;
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_bvalid = \<const0> ;
  assign s_axi_rid[0] = \<const0> ;
  assign s_axi_wready = \<const0> ;
  GND GND
       (.G(\<const0> ));
  system_auto_us_0_axi_dwidth_converter_v2_1_15_axi_upsizer \gen_upsizer.gen_full_upsizer.axi_upsizer_inst 
       (.D({s_axi_arregion,s_axi_arqos,s_axi_arlock,s_axi_arlen,s_axi_arcache,s_axi_arburst,s_axi_arsize,s_axi_arprot,s_axi_araddr}),
        .Q({m_axi_arregion,m_axi_arqos,m_axi_arlock,m_axi_arcache,m_axi_arprot}),
        .m_axi_araddr(m_axi_araddr),
        .m_axi_arburst(m_axi_arburst),
        .m_axi_arlen(m_axi_arlen),
        .m_axi_arready(m_axi_arready),
        .m_axi_arsize(m_axi_arsize),
        .m_axi_arvalid(m_axi_arvalid),
        .m_axi_rdata(m_axi_rdata),
        .m_axi_rlast(m_axi_rlast),
        .m_axi_rready(m_axi_rready),
        .m_axi_rresp(m_axi_rresp),
        .m_axi_rvalid(m_axi_rvalid),
        .out(s_axi_aclk),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arready(s_axi_arready),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rlast(s_axi_rlast),
        .s_axi_rready(s_axi_rready),
        .s_axi_rresp(s_axi_rresp),
        .s_axi_rvalid(s_axi_rvalid));
endmodule

module system_auto_us_0_axi_register_slice_v2_1_15_axi_register_slice
   (m_axi_rready,
    mr_rvalid,
    Q,
    out,
    m_axi_rlast,
    m_axi_rresp,
    m_axi_rdata,
    m_axi_rvalid,
    E,
    \aresetn_d_reg[1] ,
    \aresetn_d_reg[0] );
  output m_axi_rready;
  output mr_rvalid;
  output [66:0]Q;
  input out;
  input m_axi_rlast;
  input [1:0]m_axi_rresp;
  input [63:0]m_axi_rdata;
  input m_axi_rvalid;
  input [0:0]E;
  input \aresetn_d_reg[1] ;
  input \aresetn_d_reg[0] ;

  wire [0:0]E;
  wire [66:0]Q;
  wire \aresetn_d_reg[0] ;
  wire \aresetn_d_reg[1] ;
  wire [63:0]m_axi_rdata;
  wire m_axi_rlast;
  wire m_axi_rready;
  wire [1:0]m_axi_rresp;
  wire m_axi_rvalid;
  wire mr_rvalid;
  wire out;

  system_auto_us_0_axi_register_slice_v2_1_15_axic_register_slice__parameterized2 \r.r_pipe 
       (.E(E),
        .Q(Q),
        .\aresetn_d_reg[0] (\aresetn_d_reg[0] ),
        .\aresetn_d_reg[1] (\aresetn_d_reg[1] ),
        .m_axi_rdata(m_axi_rdata),
        .m_axi_rlast(m_axi_rlast),
        .m_axi_rready(m_axi_rready),
        .m_axi_rresp(m_axi_rresp),
        .m_axi_rvalid(m_axi_rvalid),
        .mr_rvalid(mr_rvalid),
        .out(out));
endmodule

(* ORIG_REF_NAME = "axi_register_slice_v2_1_15_axi_register_slice" *) 
module system_auto_us_0_axi_register_slice_v2_1_15_axi_register_slice__parameterized0
   (\aresetn_d_reg[1] ,
    s_ready_i_reg,
    sr_arvalid,
    in,
    m_axi_arburst,
    m_axi_araddr,
    s_axi_arready,
    Q,
    m_axi_arsize,
    s_axi_aresetn,
    out,
    cmd_push_block_reg,
    s_axi_arvalid,
    D);
  output \aresetn_d_reg[1] ;
  output s_ready_i_reg;
  output sr_arvalid;
  output [27:0]in;
  output [1:0]m_axi_arburst;
  output [31:0]m_axi_araddr;
  output s_axi_arready;
  output [15:0]Q;
  output [2:0]m_axi_arsize;
  input s_axi_aresetn;
  input out;
  input cmd_push_block_reg;
  input s_axi_arvalid;
  input [60:0]D;

  wire [60:0]D;
  wire [15:0]Q;
  wire \aresetn_d_reg[1] ;
  wire cmd_push_block_reg;
  wire [27:0]in;
  wire [31:0]m_axi_araddr;
  wire [1:0]m_axi_arburst;
  wire [2:0]m_axi_arsize;
  wire out;
  wire s_axi_aresetn;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire s_ready_i_reg;
  wire sr_arvalid;

  system_auto_us_0_axi_register_slice_v2_1_15_axic_register_slice \ar.ar_pipe 
       (.D(D),
        .Q(Q),
        .\aresetn_d_reg[1]_0 (\aresetn_d_reg[1] ),
        .cmd_push_block_reg(cmd_push_block_reg),
        .in(in),
        .m_axi_araddr(m_axi_araddr),
        .m_axi_arburst(m_axi_arburst),
        .m_axi_arsize(m_axi_arsize),
        .out(out),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arready(s_axi_arready),
        .s_axi_arvalid(s_axi_arvalid),
        .s_ready_i_reg_0(s_ready_i_reg),
        .sr_arvalid(sr_arvalid));
endmodule

module system_auto_us_0_axi_register_slice_v2_1_15_axic_register_slice
   (\aresetn_d_reg[1]_0 ,
    s_ready_i_reg_0,
    sr_arvalid,
    in,
    m_axi_arburst,
    m_axi_araddr,
    s_axi_arready,
    Q,
    m_axi_arsize,
    s_axi_aresetn,
    out,
    cmd_push_block_reg,
    s_axi_arvalid,
    D);
  output \aresetn_d_reg[1]_0 ;
  output s_ready_i_reg_0;
  output sr_arvalid;
  output [27:0]in;
  output [1:0]m_axi_arburst;
  output [31:0]m_axi_araddr;
  output s_axi_arready;
  output [15:0]Q;
  output [2:0]m_axi_arsize;
  input s_axi_aresetn;
  input out;
  input cmd_push_block_reg;
  input s_axi_arvalid;
  input [60:0]D;

  wire [60:0]D;
  wire [15:0]Q;
  wire \USE_READ.read_addr_inst/access_need_extra_word__3 ;
  wire [1:1]\USE_READ.read_addr_inst/cmd_mask_i__5 ;
  wire [2:0]\USE_READ.read_addr_inst/mi_word_intra_len ;
  wire \USE_READ.read_addr_inst/p_5_in ;
  wire \USE_READ.read_addr_inst/upsized_length1__0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][18]_srl32_i_2_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][19]_srl32_i_2_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][22]_srl32_i_2_n_0 ;
  wire \aresetn_d_reg[1]_0 ;
  wire cmd_push_block_reg;
  wire [27:0]in;
  wire [31:0]m_axi_araddr;
  wire \m_axi_araddr[2]_INST_0_i_2_n_0 ;
  wire \m_axi_araddr[2]_INST_0_i_5_n_0 ;
  wire \m_axi_araddr[2]_INST_0_i_6_n_0 ;
  wire \m_axi_araddr[2]_INST_0_i_7_n_0 ;
  wire \m_axi_araddr[2]_INST_0_i_8_n_0 ;
  wire [1:0]m_axi_arburst;
  wire \m_axi_arlen[0]_INST_0_i_10_n_0 ;
  wire \m_axi_arlen[0]_INST_0_i_12_n_0 ;
  wire \m_axi_arlen[0]_INST_0_i_13_n_0 ;
  wire \m_axi_arlen[0]_INST_0_i_14_n_0 ;
  wire \m_axi_arlen[0]_INST_0_i_1_n_0 ;
  wire \m_axi_arlen[0]_INST_0_i_5_n_0 ;
  wire \m_axi_arlen[0]_INST_0_i_6_n_0 ;
  wire \m_axi_arlen[0]_INST_0_i_7_n_0 ;
  wire \m_axi_arlen[0]_INST_0_i_8_n_0 ;
  wire \m_axi_arlen[5]_INST_0_i_1_n_0 ;
  wire \m_axi_arlen[6]_INST_0_i_1_n_0 ;
  wire \m_axi_arlen[6]_INST_0_i_3_n_0 ;
  wire \m_axi_arlen[7]_INST_0_i_11_n_0 ;
  wire \m_axi_arlen[7]_INST_0_i_12_n_0 ;
  wire \m_axi_arlen[7]_INST_0_i_13_n_0 ;
  wire \m_axi_arlen[7]_INST_0_i_14_n_0 ;
  wire \m_axi_arlen[7]_INST_0_i_15_n_0 ;
  wire \m_axi_arlen[7]_INST_0_i_16_n_0 ;
  wire \m_axi_arlen[7]_INST_0_i_17_n_0 ;
  wire \m_axi_arlen[7]_INST_0_i_18_n_0 ;
  wire \m_axi_arlen[7]_INST_0_i_19_n_0 ;
  wire \m_axi_arlen[7]_INST_0_i_3_n_0 ;
  wire \m_axi_arlen[7]_INST_0_i_6_n_0 ;
  wire \m_axi_arlen[7]_INST_0_i_7_n_0 ;
  wire \m_axi_arlen[7]_INST_0_i_8_n_0 ;
  wire \m_axi_arlen[7]_INST_0_i_9_n_0 ;
  wire [2:0]m_axi_arsize;
  wire \m_payload_i[31]_i_1_n_0 ;
  wire m_valid_i_i_1_n_0;
  wire out;
  wire s_axi_aresetn;
  wire [7:0]s_axi_arlen_ii;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire s_ready_i_i_1_n_0;
  wire s_ready_i_reg_0;
  wire [2:0]sr_araddr;
  wire [1:0]sr_arburst;
  wire [2:0]sr_arsize;
  wire sr_arvalid;
  wire [6:0]upsized_length;

  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT3 #(
    .INIT(8'h02)) 
    \USE_RTL_FIFO.data_srl_reg[31][10]_srl32_i_1 
       (.I0(sr_arsize[1]),
        .I1(sr_arsize[2]),
        .I2(sr_arsize[0]),
        .O(in[10]));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \USE_RTL_FIFO.data_srl_reg[31][16]_srl32_i_1 
       (.I0(sr_araddr[2]),
        .I1(in[13]),
        .O(in[14]));
  LUT6 #(
    .INIT(64'h10C010C010C0D000)) 
    \USE_RTL_FIFO.data_srl_reg[31][17]_srl32_i_1 
       (.I0(\USE_READ.read_addr_inst/p_5_in ),
        .I1(s_axi_arlen_ii[0]),
        .I2(in[8]),
        .I3(sr_araddr[0]),
        .I4(sr_arburst[1]),
        .I5(sr_arburst[0]),
        .O(in[15]));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT4 #(
    .INIT(16'h9060)) 
    \USE_RTL_FIFO.data_srl_reg[31][18]_srl32_i_1 
       (.I0(\m_axi_arlen[0]_INST_0_i_6_n_0 ),
        .I1(sr_araddr[1]),
        .I2(\USE_RTL_FIFO.data_srl_reg[31][18]_srl32_i_2_n_0 ),
        .I3(\m_axi_arlen[0]_INST_0_i_7_n_0 ),
        .O(in[16]));
  LUT6 #(
    .INIT(64'h00000000FFFFFBFF)) 
    \USE_RTL_FIFO.data_srl_reg[31][18]_srl32_i_2 
       (.I0(sr_arburst[0]),
        .I1(sr_arburst[1]),
        .I2(\m_axi_araddr[2]_INST_0_i_5_n_0 ),
        .I3(\m_axi_araddr[2]_INST_0_i_6_n_0 ),
        .I4(\USE_READ.read_addr_inst/cmd_mask_i__5 ),
        .I5(\m_axi_arlen[0]_INST_0_i_14_n_0 ),
        .O(\USE_RTL_FIFO.data_srl_reg[31][18]_srl32_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hA1A1A151525252A2)) 
    \USE_RTL_FIFO.data_srl_reg[31][19]_srl32_i_1 
       (.I0(sr_araddr[2]),
        .I1(\USE_READ.read_addr_inst/p_5_in ),
        .I2(\m_axi_araddr[2]_INST_0_i_8_n_0 ),
        .I3(sr_arburst[0]),
        .I4(sr_arburst[1]),
        .I5(\USE_RTL_FIFO.data_srl_reg[31][19]_srl32_i_2_n_0 ),
        .O(in[17]));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT4 #(
    .INIT(16'h088F)) 
    \USE_RTL_FIFO.data_srl_reg[31][19]_srl32_i_2 
       (.I0(sr_araddr[1]),
        .I1(\USE_RTL_FIFO.data_srl_reg[31][18]_srl32_i_2_n_0 ),
        .I2(\m_axi_arlen[0]_INST_0_i_7_n_0 ),
        .I3(\m_axi_arlen[0]_INST_0_i_6_n_0 ),
        .O(\USE_RTL_FIFO.data_srl_reg[31][19]_srl32_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000500000001)) 
    \USE_RTL_FIFO.data_srl_reg[31][20]_srl32_i_1 
       (.I0(sr_araddr[0]),
        .I1(\USE_READ.read_addr_inst/p_5_in ),
        .I2(sr_arsize[0]),
        .I3(sr_arsize[1]),
        .I4(sr_arsize[2]),
        .I5(s_axi_arlen_ii[0]),
        .O(in[18]));
  LUT6 #(
    .INIT(64'h8882888288828888)) 
    \USE_RTL_FIFO.data_srl_reg[31][21]_srl32_i_1 
       (.I0(\USE_RTL_FIFO.data_srl_reg[31][18]_srl32_i_2_n_0 ),
        .I1(sr_araddr[1]),
        .I2(sr_arsize[2]),
        .I3(sr_arsize[1]),
        .I4(sr_arsize[0]),
        .I5(sr_araddr[0]),
        .O(in[19]));
  LUT6 #(
    .INIT(64'h10EFEF1000000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][22]_srl32_i_1 
       (.I0(sr_arsize[0]),
        .I1(sr_arsize[2]),
        .I2(sr_arsize[1]),
        .I3(\USE_RTL_FIFO.data_srl_reg[31][22]_srl32_i_2_n_0 ),
        .I4(sr_araddr[2]),
        .I5(in[13]),
        .O(in[20]));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT5 #(
    .INIT(32'h02020200)) 
    \USE_RTL_FIFO.data_srl_reg[31][22]_srl32_i_2 
       (.I0(sr_araddr[1]),
        .I1(sr_arsize[2]),
        .I2(sr_arsize[1]),
        .I3(sr_arsize[0]),
        .I4(sr_araddr[0]),
        .O(\USE_RTL_FIFO.data_srl_reg[31][22]_srl32_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFEF000000000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][23]_srl32_i_1 
       (.I0(\m_axi_araddr[2]_INST_0_i_7_n_0 ),
        .I1(\m_axi_araddr[2]_INST_0_i_5_n_0 ),
        .I2(\m_axi_araddr[2]_INST_0_i_6_n_0 ),
        .I3(s_axi_arlen_ii[0]),
        .I4(in[8]),
        .I5(sr_araddr[0]),
        .O(in[21]));
  LUT2 #(
    .INIT(4'h8)) 
    \USE_RTL_FIFO.data_srl_reg[31][24]_srl32_i_1 
       (.I0(sr_araddr[1]),
        .I1(\USE_RTL_FIFO.data_srl_reg[31][18]_srl32_i_2_n_0 ),
        .O(in[22]));
  LUT6 #(
    .INIT(64'hFFFFFBFF00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][25]_srl32_i_1 
       (.I0(sr_arburst[0]),
        .I1(sr_arburst[1]),
        .I2(\m_axi_araddr[2]_INST_0_i_5_n_0 ),
        .I3(\m_axi_araddr[2]_INST_0_i_6_n_0 ),
        .I4(\m_axi_araddr[2]_INST_0_i_8_n_0 ),
        .I5(sr_araddr[2]),
        .O(in[23]));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \USE_RTL_FIFO.data_srl_reg[31][26]_srl32_i_1 
       (.I0(in[26]),
        .I1(\m_axi_araddr[2]_INST_0_i_2_n_0 ),
        .O(in[24]));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \USE_RTL_FIFO.data_srl_reg[31][27]_srl32_i_1 
       (.I0(\USE_READ.read_addr_inst/p_5_in ),
        .I1(in[26]),
        .O(in[25]));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \USE_RTL_FIFO.data_srl_reg[31][29]_srl32_i_1 
       (.I0(sr_arburst[1]),
        .I1(sr_arburst[0]),
        .O(in[27]));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT3 #(
    .INIT(8'h02)) 
    \USE_RTL_FIFO.data_srl_reg[31][9]_srl32_i_1 
       (.I0(sr_arsize[0]),
        .I1(sr_arsize[1]),
        .I2(sr_arsize[2]),
        .O(in[9]));
  FDRE #(
    .INIT(1'b0)) 
    \aresetn_d_reg[0] 
       (.C(out),
        .CE(1'b1),
        .D(1'b1),
        .Q(\aresetn_d_reg[1]_0 ),
        .R(s_axi_aresetn));
  FDRE #(
    .INIT(1'b0)) 
    \aresetn_d_reg[1] 
       (.C(out),
        .CE(1'b1),
        .D(\aresetn_d_reg[1]_0 ),
        .Q(s_ready_i_reg_0),
        .R(s_axi_aresetn));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT5 #(
    .INIT(32'h4FFF0000)) 
    \m_axi_araddr[0]_INST_0 
       (.I0(\USE_READ.read_addr_inst/p_5_in ),
        .I1(\m_axi_araddr[2]_INST_0_i_2_n_0 ),
        .I2(in[26]),
        .I3(in[11]),
        .I4(sr_araddr[0]),
        .O(m_axi_araddr[0]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFF8FFFFF)) 
    \m_axi_araddr[0]_INST_0_i_1 
       (.I0(s_axi_arlen_ii[0]),
        .I1(in[8]),
        .I2(\m_axi_araddr[2]_INST_0_i_6_n_0 ),
        .I3(\m_axi_araddr[2]_INST_0_i_5_n_0 ),
        .I4(sr_arburst[1]),
        .I5(sr_arburst[0]),
        .O(in[11]));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT5 #(
    .INIT(32'h4FFF0000)) 
    \m_axi_araddr[1]_INST_0 
       (.I0(\USE_READ.read_addr_inst/p_5_in ),
        .I1(\m_axi_araddr[2]_INST_0_i_2_n_0 ),
        .I2(in[26]),
        .I3(in[12]),
        .I4(sr_araddr[1]),
        .O(m_axi_araddr[1]));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT5 #(
    .INIT(32'hFFFFFBFF)) 
    \m_axi_araddr[1]_INST_0_i_1 
       (.I0(\USE_READ.read_addr_inst/cmd_mask_i__5 ),
        .I1(\m_axi_araddr[2]_INST_0_i_6_n_0 ),
        .I2(\m_axi_araddr[2]_INST_0_i_5_n_0 ),
        .I3(sr_arburst[1]),
        .I4(sr_arburst[0]),
        .O(in[12]));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT5 #(
    .INIT(32'h03020002)) 
    \m_axi_araddr[1]_INST_0_i_2 
       (.I0(s_axi_arlen_ii[1]),
        .I1(sr_arsize[2]),
        .I2(sr_arsize[1]),
        .I3(sr_arsize[0]),
        .I4(s_axi_arlen_ii[0]),
        .O(\USE_READ.read_addr_inst/cmd_mask_i__5 ));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT5 #(
    .INIT(32'h4FFF0000)) 
    \m_axi_araddr[2]_INST_0 
       (.I0(\USE_READ.read_addr_inst/p_5_in ),
        .I1(\m_axi_araddr[2]_INST_0_i_2_n_0 ),
        .I2(in[26]),
        .I3(in[13]),
        .I4(sr_araddr[2]),
        .O(m_axi_araddr[2]));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT4 #(
    .INIT(16'h0400)) 
    \m_axi_araddr[2]_INST_0_i_1 
       (.I0(sr_arburst[0]),
        .I1(sr_arburst[1]),
        .I2(\m_axi_araddr[2]_INST_0_i_5_n_0 ),
        .I3(\m_axi_araddr[2]_INST_0_i_6_n_0 ),
        .O(\USE_READ.read_addr_inst/p_5_in ));
  LUT6 #(
    .INIT(64'hAEAEAEAEAEAEAEFF)) 
    \m_axi_araddr[2]_INST_0_i_2 
       (.I0(\m_axi_araddr[2]_INST_0_i_7_n_0 ),
        .I1(\m_axi_araddr[2]_INST_0_i_6_n_0 ),
        .I2(\m_axi_araddr[2]_INST_0_i_5_n_0 ),
        .I3(sr_araddr[2]),
        .I4(sr_araddr[1]),
        .I5(sr_araddr[0]),
        .O(\m_axi_araddr[2]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0F000F000F000E00)) 
    \m_axi_araddr[2]_INST_0_i_3 
       (.I0(s_axi_arlen_ii[2]),
        .I1(\m_axi_araddr[2]_INST_0_i_5_n_0 ),
        .I2(in[27]),
        .I3(Q[4]),
        .I4(s_axi_arlen_ii[0]),
        .I5(s_axi_arlen_ii[1]),
        .O(in[26]));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT5 #(
    .INIT(32'hFFFFFBFF)) 
    \m_axi_araddr[2]_INST_0_i_4 
       (.I0(\m_axi_araddr[2]_INST_0_i_8_n_0 ),
        .I1(\m_axi_araddr[2]_INST_0_i_6_n_0 ),
        .I2(\m_axi_araddr[2]_INST_0_i_5_n_0 ),
        .I3(sr_arburst[1]),
        .I4(sr_arburst[0]),
        .O(in[13]));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \m_axi_araddr[2]_INST_0_i_5 
       (.I0(s_axi_arlen_ii[6]),
        .I1(s_axi_arlen_ii[4]),
        .I2(s_axi_arlen_ii[3]),
        .I3(s_axi_arlen_ii[7]),
        .I4(s_axi_arlen_ii[5]),
        .O(\m_axi_araddr[2]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h0101010F010501FF)) 
    \m_axi_araddr[2]_INST_0_i_6 
       (.I0(s_axi_arlen_ii[1]),
        .I1(s_axi_arlen_ii[0]),
        .I2(s_axi_arlen_ii[2]),
        .I3(sr_arsize[2]),
        .I4(sr_arsize[1]),
        .I5(sr_arsize[0]),
        .O(\m_axi_araddr[2]_INST_0_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT2 #(
    .INIT(4'hB)) 
    \m_axi_araddr[2]_INST_0_i_7 
       (.I0(sr_arburst[0]),
        .I1(sr_arburst[1]),
        .O(\m_axi_araddr[2]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h000F00CA000000CA)) 
    \m_axi_araddr[2]_INST_0_i_8 
       (.I0(s_axi_arlen_ii[2]),
        .I1(s_axi_arlen_ii[0]),
        .I2(sr_arsize[1]),
        .I3(sr_arsize[2]),
        .I4(sr_arsize[0]),
        .I5(s_axi_arlen_ii[1]),
        .O(\m_axi_araddr[2]_INST_0_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT3 #(
    .INIT(8'hF8)) 
    \m_axi_arburst[0]_INST_0 
       (.I0(\USE_READ.read_addr_inst/p_5_in ),
        .I1(in[26]),
        .I2(sr_arburst[0]),
        .O(m_axi_arburst[0]));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT3 #(
    .INIT(8'h70)) 
    \m_axi_arburst[1]_INST_0 
       (.I0(\USE_READ.read_addr_inst/p_5_in ),
        .I1(in[26]),
        .I2(sr_arburst[1]),
        .O(m_axi_arburst[1]));
  LUT6 #(
    .INIT(64'h11110555EEEEFAAA)) 
    \m_axi_arlen[0]_INST_0 
       (.I0(\m_axi_arlen[0]_INST_0_i_1_n_0 ),
        .I1(s_axi_arlen_ii[0]),
        .I2(s_axi_arlen_ii[3]),
        .I3(in[8]),
        .I4(\USE_READ.read_addr_inst/upsized_length1__0 ),
        .I5(\USE_READ.read_addr_inst/access_need_extra_word__3 ),
        .O(in[0]));
  LUT6 #(
    .INIT(64'h0000000A00000C00)) 
    \m_axi_arlen[0]_INST_0_i_1 
       (.I0(s_axi_arlen_ii[2]),
        .I1(s_axi_arlen_ii[1]),
        .I2(\USE_READ.read_addr_inst/upsized_length1__0 ),
        .I3(sr_arsize[1]),
        .I4(sr_arsize[2]),
        .I5(sr_arsize[0]),
        .O(\m_axi_arlen[0]_INST_0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT5 #(
    .INIT(32'hE0E0E000)) 
    \m_axi_arlen[0]_INST_0_i_10 
       (.I0(s_axi_arlen_ii[1]),
        .I1(s_axi_arlen_ii[0]),
        .I2(Q[4]),
        .I3(sr_arburst[0]),
        .I4(sr_arburst[1]),
        .O(\m_axi_arlen[0]_INST_0_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h00000000000000E0)) 
    \m_axi_arlen[0]_INST_0_i_11 
       (.I0(sr_arburst[1]),
        .I1(sr_arburst[0]),
        .I2(s_axi_arlen_ii[0]),
        .I3(sr_arsize[0]),
        .I4(sr_arsize[1]),
        .I5(sr_arsize[2]),
        .O(\USE_READ.read_addr_inst/mi_word_intra_len [0]));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT4 #(
    .INIT(16'hFFFD)) 
    \m_axi_arlen[0]_INST_0_i_12 
       (.I0(sr_araddr[0]),
        .I1(sr_arsize[0]),
        .I2(sr_arsize[1]),
        .I3(sr_arsize[2]),
        .O(\m_axi_arlen[0]_INST_0_i_12_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT4 #(
    .INIT(16'h0100)) 
    \m_axi_arlen[0]_INST_0_i_13 
       (.I0(sr_arsize[0]),
        .I1(sr_arsize[1]),
        .I2(sr_arsize[2]),
        .I3(s_axi_arlen_ii[0]),
        .O(\m_axi_arlen[0]_INST_0_i_13_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \m_axi_arlen[0]_INST_0_i_14 
       (.I0(sr_arsize[1]),
        .I1(sr_arsize[2]),
        .O(\m_axi_arlen[0]_INST_0_i_14_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \m_axi_arlen[0]_INST_0_i_2 
       (.I0(sr_arsize[2]),
        .I1(sr_arsize[1]),
        .I2(sr_arsize[0]),
        .O(in[8]));
  LUT6 #(
    .INIT(64'hFF0FFF0FFF0FFF1F)) 
    \m_axi_arlen[0]_INST_0_i_3 
       (.I0(s_axi_arlen_ii[1]),
        .I1(s_axi_arlen_ii[0]),
        .I2(Q[4]),
        .I3(in[27]),
        .I4(\m_axi_araddr[2]_INST_0_i_5_n_0 ),
        .I5(s_axi_arlen_ii[2]),
        .O(\USE_READ.read_addr_inst/upsized_length1__0 ));
  LUT6 #(
    .INIT(64'hAAAA022A022A0000)) 
    \m_axi_arlen[0]_INST_0_i_4 
       (.I0(\m_axi_arlen[0]_INST_0_i_5_n_0 ),
        .I1(\m_axi_arlen[0]_INST_0_i_6_n_0 ),
        .I2(\m_axi_arlen[0]_INST_0_i_7_n_0 ),
        .I3(\m_axi_arlen[0]_INST_0_i_8_n_0 ),
        .I4(\USE_READ.read_addr_inst/mi_word_intra_len [2]),
        .I5(in[23]),
        .O(\USE_READ.read_addr_inst/access_need_extra_word__3 ));
  LUT6 #(
    .INIT(64'h00000000FEAA0000)) 
    \m_axi_arlen[0]_INST_0_i_5 
       (.I0(\m_axi_arlen[0]_INST_0_i_10_n_0 ),
        .I1(\m_axi_araddr[2]_INST_0_i_5_n_0 ),
        .I2(s_axi_arlen_ii[2]),
        .I3(Q[4]),
        .I4(sr_arburst[0]),
        .I5(sr_arburst[1]),
        .O(\m_axi_arlen[0]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFBAFFFFFFBF)) 
    \m_axi_arlen[0]_INST_0_i_6 
       (.I0(in[27]),
        .I1(s_axi_arlen_ii[0]),
        .I2(sr_arsize[0]),
        .I3(sr_arsize[1]),
        .I4(sr_arsize[2]),
        .I5(s_axi_arlen_ii[1]),
        .O(\m_axi_arlen[0]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hDDDDDDDDDDDDDFDD)) 
    \m_axi_arlen[0]_INST_0_i_7 
       (.I0(\USE_READ.read_addr_inst/mi_word_intra_len [0]),
        .I1(\m_axi_arlen[0]_INST_0_i_12_n_0 ),
        .I2(\m_axi_arlen[0]_INST_0_i_13_n_0 ),
        .I3(\m_axi_araddr[2]_INST_0_i_6_n_0 ),
        .I4(\m_axi_araddr[2]_INST_0_i_5_n_0 ),
        .I5(\m_axi_araddr[2]_INST_0_i_7_n_0 ),
        .O(\m_axi_arlen[0]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAABAFFFFFFFF)) 
    \m_axi_arlen[0]_INST_0_i_8 
       (.I0(\m_axi_arlen[0]_INST_0_i_14_n_0 ),
        .I1(\USE_READ.read_addr_inst/cmd_mask_i__5 ),
        .I2(\m_axi_araddr[2]_INST_0_i_6_n_0 ),
        .I3(\m_axi_araddr[2]_INST_0_i_5_n_0 ),
        .I4(\m_axi_araddr[2]_INST_0_i_7_n_0 ),
        .I5(sr_araddr[1]),
        .O(\m_axi_arlen[0]_INST_0_i_8_n_0 ));
  LUT3 #(
    .INIT(8'hA8)) 
    \m_axi_arlen[0]_INST_0_i_9 
       (.I0(\m_axi_araddr[2]_INST_0_i_8_n_0 ),
        .I1(sr_arburst[0]),
        .I2(sr_arburst[1]),
        .O(\USE_READ.read_addr_inst/mi_word_intra_len [2]));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \m_axi_arlen[1]_INST_0 
       (.I0(\m_axi_arlen[5]_INST_0_i_1_n_0 ),
        .I1(upsized_length[1]),
        .O(in[1]));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT3 #(
    .INIT(8'hD2)) 
    \m_axi_arlen[2]_INST_0 
       (.I0(upsized_length[1]),
        .I1(\m_axi_arlen[5]_INST_0_i_1_n_0 ),
        .I2(upsized_length[2]),
        .O(in[2]));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT4 #(
    .INIT(16'hDF20)) 
    \m_axi_arlen[3]_INST_0 
       (.I0(upsized_length[2]),
        .I1(\m_axi_arlen[5]_INST_0_i_1_n_0 ),
        .I2(upsized_length[1]),
        .I3(upsized_length[3]),
        .O(in[3]));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT5 #(
    .INIT(32'hDFFF2000)) 
    \m_axi_arlen[4]_INST_0 
       (.I0(upsized_length[1]),
        .I1(\m_axi_arlen[5]_INST_0_i_1_n_0 ),
        .I2(upsized_length[2]),
        .I3(upsized_length[3]),
        .I4(upsized_length[4]),
        .O(in[4]));
  LUT6 #(
    .INIT(64'hF7FFFFFF08000000)) 
    \m_axi_arlen[5]_INST_0 
       (.I0(upsized_length[3]),
        .I1(upsized_length[2]),
        .I2(\m_axi_arlen[5]_INST_0_i_1_n_0 ),
        .I3(upsized_length[1]),
        .I4(upsized_length[4]),
        .I5(upsized_length[5]),
        .O(in[5]));
  LUT6 #(
    .INIT(64'h5757575755777777)) 
    \m_axi_arlen[5]_INST_0_i_1 
       (.I0(\USE_READ.read_addr_inst/access_need_extra_word__3 ),
        .I1(\m_axi_arlen[0]_INST_0_i_1_n_0 ),
        .I2(s_axi_arlen_ii[0]),
        .I3(s_axi_arlen_ii[3]),
        .I4(in[8]),
        .I5(\USE_READ.read_addr_inst/upsized_length1__0 ),
        .O(\m_axi_arlen[5]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFEA40)) 
    \m_axi_arlen[5]_INST_0_i_2 
       (.I0(\USE_READ.read_addr_inst/upsized_length1__0 ),
        .I1(in[8]),
        .I2(s_axi_arlen_ii[4]),
        .I3(s_axi_arlen_ii[1]),
        .I4(\m_axi_arlen[7]_INST_0_i_9_n_0 ),
        .O(upsized_length[1]));
  LUT6 #(
    .INIT(64'hF7FFFFFF08000000)) 
    \m_axi_arlen[6]_INST_0 
       (.I0(upsized_length[5]),
        .I1(upsized_length[4]),
        .I2(\m_axi_arlen[6]_INST_0_i_1_n_0 ),
        .I3(upsized_length[2]),
        .I4(upsized_length[3]),
        .I5(upsized_length[6]),
        .O(in[6]));
  LUT5 #(
    .INIT(32'h1F1F1FFF)) 
    \m_axi_arlen[6]_INST_0_i_1 
       (.I0(\m_axi_arlen[6]_INST_0_i_3_n_0 ),
        .I1(\m_axi_arlen[0]_INST_0_i_1_n_0 ),
        .I2(\USE_READ.read_addr_inst/access_need_extra_word__3 ),
        .I3(\m_axi_arlen[7]_INST_0_i_9_n_0 ),
        .I4(\m_axi_arlen[7]_INST_0_i_8_n_0 ),
        .O(\m_axi_arlen[6]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFEA40)) 
    \m_axi_arlen[6]_INST_0_i_2 
       (.I0(\USE_READ.read_addr_inst/upsized_length1__0 ),
        .I1(in[8]),
        .I2(s_axi_arlen_ii[5]),
        .I3(s_axi_arlen_ii[2]),
        .I4(\m_axi_arlen[7]_INST_0_i_11_n_0 ),
        .O(upsized_length[2]));
  LUT6 #(
    .INIT(64'hAAAAAAAA0000000C)) 
    \m_axi_arlen[6]_INST_0_i_3 
       (.I0(s_axi_arlen_ii[0]),
        .I1(s_axi_arlen_ii[3]),
        .I2(sr_arsize[0]),
        .I3(sr_arsize[1]),
        .I4(sr_arsize[2]),
        .I5(\USE_READ.read_addr_inst/upsized_length1__0 ),
        .O(\m_axi_arlen[6]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h08000000F7FFFFFF)) 
    \m_axi_arlen[7]_INST_0 
       (.I0(upsized_length[6]),
        .I1(upsized_length[3]),
        .I2(\m_axi_arlen[7]_INST_0_i_3_n_0 ),
        .I3(upsized_length[4]),
        .I4(upsized_length[5]),
        .I5(\m_axi_arlen[7]_INST_0_i_6_n_0 ),
        .O(in[7]));
  LUT6 #(
    .INIT(64'hA0A0A0A0A0A0ACA0)) 
    \m_axi_arlen[7]_INST_0_i_1 
       (.I0(s_axi_arlen_ii[6]),
        .I1(s_axi_arlen_ii[7]),
        .I2(\USE_READ.read_addr_inst/upsized_length1__0 ),
        .I3(sr_arsize[1]),
        .I4(sr_arsize[2]),
        .I5(sr_arsize[0]),
        .O(upsized_length[6]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFF8F8F8)) 
    \m_axi_arlen[7]_INST_0_i_10 
       (.I0(\m_axi_arlen[7]_INST_0_i_16_n_0 ),
        .I1(s_axi_arlen_ii[3]),
        .I2(\m_axi_arlen[7]_INST_0_i_17_n_0 ),
        .I3(\m_axi_arlen[7]_INST_0_i_18_n_0 ),
        .I4(s_axi_arlen_ii[1]),
        .I5(\m_axi_arlen[7]_INST_0_i_19_n_0 ),
        .O(upsized_length[0]));
  LUT6 #(
    .INIT(64'h0000000A00000C00)) 
    \m_axi_arlen[7]_INST_0_i_11 
       (.I0(s_axi_arlen_ii[4]),
        .I1(s_axi_arlen_ii[3]),
        .I2(\USE_READ.read_addr_inst/upsized_length1__0 ),
        .I3(sr_arsize[1]),
        .I4(sr_arsize[2]),
        .I5(sr_arsize[0]),
        .O(\m_axi_arlen[7]_INST_0_i_11_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAA0000000C)) 
    \m_axi_arlen[7]_INST_0_i_12 
       (.I0(s_axi_arlen_ii[2]),
        .I1(s_axi_arlen_ii[5]),
        .I2(sr_arsize[0]),
        .I3(sr_arsize[1]),
        .I4(sr_arsize[2]),
        .I5(\USE_READ.read_addr_inst/upsized_length1__0 ),
        .O(\m_axi_arlen[7]_INST_0_i_12_n_0 ));
  LUT6 #(
    .INIT(64'h0000000A00000C00)) 
    \m_axi_arlen[7]_INST_0_i_13 
       (.I0(s_axi_arlen_ii[6]),
        .I1(s_axi_arlen_ii[5]),
        .I2(\USE_READ.read_addr_inst/upsized_length1__0 ),
        .I3(sr_arsize[1]),
        .I4(sr_arsize[2]),
        .I5(sr_arsize[0]),
        .O(\m_axi_arlen[7]_INST_0_i_13_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT3 #(
    .INIT(8'hEF)) 
    \m_axi_arlen[7]_INST_0_i_14 
       (.I0(sr_arsize[0]),
        .I1(sr_arsize[2]),
        .I2(sr_arsize[1]),
        .O(\m_axi_arlen[7]_INST_0_i_14_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT3 #(
    .INIT(8'hEF)) 
    \m_axi_arlen[7]_INST_0_i_15 
       (.I0(sr_arsize[2]),
        .I1(sr_arsize[1]),
        .I2(sr_arsize[0]),
        .O(\m_axi_arlen[7]_INST_0_i_15_n_0 ));
  LUT6 #(
    .INIT(64'h2222222220202000)) 
    \m_axi_arlen[7]_INST_0_i_16 
       (.I0(in[8]),
        .I1(in[27]),
        .I2(Q[4]),
        .I3(s_axi_arlen_ii[2]),
        .I4(\m_axi_araddr[2]_INST_0_i_5_n_0 ),
        .I5(\m_axi_arlen[0]_INST_0_i_10_n_0 ),
        .O(\m_axi_arlen[7]_INST_0_i_16_n_0 ));
  LUT3 #(
    .INIT(8'hB0)) 
    \m_axi_arlen[7]_INST_0_i_17 
       (.I0(in[27]),
        .I1(Q[4]),
        .I2(s_axi_arlen_ii[0]),
        .O(\m_axi_arlen[7]_INST_0_i_17_n_0 ));
  LUT6 #(
    .INIT(64'h0000000055554440)) 
    \m_axi_arlen[7]_INST_0_i_18 
       (.I0(in[27]),
        .I1(Q[4]),
        .I2(s_axi_arlen_ii[2]),
        .I3(\m_axi_araddr[2]_INST_0_i_5_n_0 ),
        .I4(\m_axi_arlen[0]_INST_0_i_10_n_0 ),
        .I5(\m_axi_arlen[7]_INST_0_i_14_n_0 ),
        .O(\m_axi_arlen[7]_INST_0_i_18_n_0 ));
  LUT5 #(
    .INIT(32'h00540000)) 
    \m_axi_arlen[7]_INST_0_i_19 
       (.I0(\m_axi_arlen[7]_INST_0_i_15_n_0 ),
        .I1(\m_axi_arlen[0]_INST_0_i_10_n_0 ),
        .I2(Q[4]),
        .I3(in[27]),
        .I4(s_axi_arlen_ii[2]),
        .O(\m_axi_arlen[7]_INST_0_i_19_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFEA40)) 
    \m_axi_arlen[7]_INST_0_i_2 
       (.I0(\USE_READ.read_addr_inst/upsized_length1__0 ),
        .I1(in[8]),
        .I2(s_axi_arlen_ii[6]),
        .I3(s_axi_arlen_ii[3]),
        .I4(\m_axi_arlen[7]_INST_0_i_7_n_0 ),
        .O(upsized_length[3]));
  LUT6 #(
    .INIT(64'h1FFF1FFF1FFFFFFF)) 
    \m_axi_arlen[7]_INST_0_i_3 
       (.I0(\m_axi_arlen[7]_INST_0_i_8_n_0 ),
        .I1(\m_axi_arlen[7]_INST_0_i_9_n_0 ),
        .I2(\USE_READ.read_addr_inst/access_need_extra_word__3 ),
        .I3(upsized_length[0]),
        .I4(\m_axi_arlen[7]_INST_0_i_11_n_0 ),
        .I5(\m_axi_arlen[7]_INST_0_i_12_n_0 ),
        .O(\m_axi_arlen[7]_INST_0_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT5 #(
    .INIT(32'hFFFFEA40)) 
    \m_axi_arlen[7]_INST_0_i_4 
       (.I0(\USE_READ.read_addr_inst/upsized_length1__0 ),
        .I1(in[8]),
        .I2(s_axi_arlen_ii[7]),
        .I3(s_axi_arlen_ii[4]),
        .I4(\m_axi_arlen[7]_INST_0_i_13_n_0 ),
        .O(upsized_length[4]));
  LUT6 #(
    .INIT(64'hFFFF00004F444F44)) 
    \m_axi_arlen[7]_INST_0_i_5 
       (.I0(\m_axi_arlen[7]_INST_0_i_14_n_0 ),
        .I1(s_axi_arlen_ii[6]),
        .I2(\m_axi_arlen[7]_INST_0_i_15_n_0 ),
        .I3(s_axi_arlen_ii[7]),
        .I4(s_axi_arlen_ii[5]),
        .I5(\USE_READ.read_addr_inst/upsized_length1__0 ),
        .O(upsized_length[5]));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \m_axi_arlen[7]_INST_0_i_6 
       (.I0(\USE_READ.read_addr_inst/upsized_length1__0 ),
        .I1(s_axi_arlen_ii[7]),
        .O(\m_axi_arlen[7]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h0000000A00000C00)) 
    \m_axi_arlen[7]_INST_0_i_7 
       (.I0(s_axi_arlen_ii[5]),
        .I1(s_axi_arlen_ii[4]),
        .I2(\USE_READ.read_addr_inst/upsized_length1__0 ),
        .I3(sr_arsize[1]),
        .I4(sr_arsize[2]),
        .I5(sr_arsize[0]),
        .O(\m_axi_arlen[7]_INST_0_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAA0000000C)) 
    \m_axi_arlen[7]_INST_0_i_8 
       (.I0(s_axi_arlen_ii[1]),
        .I1(s_axi_arlen_ii[4]),
        .I2(sr_arsize[0]),
        .I3(sr_arsize[1]),
        .I4(sr_arsize[2]),
        .I5(\USE_READ.read_addr_inst/upsized_length1__0 ),
        .O(\m_axi_arlen[7]_INST_0_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h0000000A00000C00)) 
    \m_axi_arlen[7]_INST_0_i_9 
       (.I0(s_axi_arlen_ii[3]),
        .I1(s_axi_arlen_ii[2]),
        .I2(\USE_READ.read_addr_inst/upsized_length1__0 ),
        .I3(sr_arsize[1]),
        .I4(sr_arsize[2]),
        .I5(sr_arsize[0]),
        .O(\m_axi_arlen[7]_INST_0_i_9_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \m_axi_arsize[0]_INST_0 
       (.I0(in[26]),
        .I1(sr_arsize[0]),
        .O(m_axi_arsize[0]));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \m_axi_arsize[1]_INST_0 
       (.I0(in[26]),
        .I1(sr_arsize[1]),
        .O(m_axi_arsize[1]));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \m_axi_arsize[2]_INST_0 
       (.I0(sr_arsize[2]),
        .I1(in[26]),
        .O(m_axi_arsize[2]));
  LUT1 #(
    .INIT(2'h1)) 
    \m_payload_i[31]_i_1 
       (.I0(sr_arvalid),
        .O(\m_payload_i[31]_i_1_n_0 ));
  FDRE \m_payload_i_reg[0] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[0]),
        .Q(sr_araddr[0]),
        .R(1'b0));
  FDRE \m_payload_i_reg[10] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[10]),
        .Q(m_axi_araddr[10]),
        .R(1'b0));
  FDRE \m_payload_i_reg[11] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[11]),
        .Q(m_axi_araddr[11]),
        .R(1'b0));
  FDRE \m_payload_i_reg[12] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[12]),
        .Q(m_axi_araddr[12]),
        .R(1'b0));
  FDRE \m_payload_i_reg[13] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[13]),
        .Q(m_axi_araddr[13]),
        .R(1'b0));
  FDRE \m_payload_i_reg[14] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[14]),
        .Q(m_axi_araddr[14]),
        .R(1'b0));
  FDRE \m_payload_i_reg[15] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[15]),
        .Q(m_axi_araddr[15]),
        .R(1'b0));
  FDRE \m_payload_i_reg[16] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[16]),
        .Q(m_axi_araddr[16]),
        .R(1'b0));
  FDRE \m_payload_i_reg[17] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[17]),
        .Q(m_axi_araddr[17]),
        .R(1'b0));
  FDRE \m_payload_i_reg[18] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[18]),
        .Q(m_axi_araddr[18]),
        .R(1'b0));
  FDRE \m_payload_i_reg[19] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[19]),
        .Q(m_axi_araddr[19]),
        .R(1'b0));
  FDRE \m_payload_i_reg[1] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[1]),
        .Q(sr_araddr[1]),
        .R(1'b0));
  FDRE \m_payload_i_reg[20] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[20]),
        .Q(m_axi_araddr[20]),
        .R(1'b0));
  FDRE \m_payload_i_reg[21] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[21]),
        .Q(m_axi_araddr[21]),
        .R(1'b0));
  FDRE \m_payload_i_reg[22] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[22]),
        .Q(m_axi_araddr[22]),
        .R(1'b0));
  FDRE \m_payload_i_reg[23] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[23]),
        .Q(m_axi_araddr[23]),
        .R(1'b0));
  FDRE \m_payload_i_reg[24] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[24]),
        .Q(m_axi_araddr[24]),
        .R(1'b0));
  FDRE \m_payload_i_reg[25] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[25]),
        .Q(m_axi_araddr[25]),
        .R(1'b0));
  FDRE \m_payload_i_reg[26] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[26]),
        .Q(m_axi_araddr[26]),
        .R(1'b0));
  FDRE \m_payload_i_reg[27] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[27]),
        .Q(m_axi_araddr[27]),
        .R(1'b0));
  FDRE \m_payload_i_reg[28] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[28]),
        .Q(m_axi_araddr[28]),
        .R(1'b0));
  FDRE \m_payload_i_reg[29] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[29]),
        .Q(m_axi_araddr[29]),
        .R(1'b0));
  FDRE \m_payload_i_reg[2] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[2]),
        .Q(sr_araddr[2]),
        .R(1'b0));
  FDRE \m_payload_i_reg[30] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[30]),
        .Q(m_axi_araddr[30]),
        .R(1'b0));
  FDRE \m_payload_i_reg[31] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[31]),
        .Q(m_axi_araddr[31]),
        .R(1'b0));
  FDRE \m_payload_i_reg[32] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[32]),
        .Q(Q[0]),
        .R(1'b0));
  FDRE \m_payload_i_reg[33] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[33]),
        .Q(Q[1]),
        .R(1'b0));
  FDRE \m_payload_i_reg[34] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[34]),
        .Q(Q[2]),
        .R(1'b0));
  FDRE \m_payload_i_reg[35] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[35]),
        .Q(sr_arsize[0]),
        .R(1'b0));
  FDRE \m_payload_i_reg[36] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[36]),
        .Q(sr_arsize[1]),
        .R(1'b0));
  FDRE \m_payload_i_reg[37] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[37]),
        .Q(sr_arsize[2]),
        .R(1'b0));
  FDRE \m_payload_i_reg[38] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[38]),
        .Q(sr_arburst[0]),
        .R(1'b0));
  FDRE \m_payload_i_reg[39] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[39]),
        .Q(sr_arburst[1]),
        .R(1'b0));
  FDRE \m_payload_i_reg[3] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[3]),
        .Q(m_axi_araddr[3]),
        .R(1'b0));
  FDRE \m_payload_i_reg[40] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[40]),
        .Q(Q[3]),
        .R(1'b0));
  FDRE \m_payload_i_reg[41] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[41]),
        .Q(Q[4]),
        .R(1'b0));
  FDRE \m_payload_i_reg[42] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[42]),
        .Q(Q[5]),
        .R(1'b0));
  FDRE \m_payload_i_reg[43] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[43]),
        .Q(Q[6]),
        .R(1'b0));
  FDRE \m_payload_i_reg[44] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[44]),
        .Q(s_axi_arlen_ii[0]),
        .R(1'b0));
  FDRE \m_payload_i_reg[45] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[45]),
        .Q(s_axi_arlen_ii[1]),
        .R(1'b0));
  FDRE \m_payload_i_reg[46] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[46]),
        .Q(s_axi_arlen_ii[2]),
        .R(1'b0));
  FDRE \m_payload_i_reg[47] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[47]),
        .Q(s_axi_arlen_ii[3]),
        .R(1'b0));
  FDRE \m_payload_i_reg[48] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[48]),
        .Q(s_axi_arlen_ii[4]),
        .R(1'b0));
  FDRE \m_payload_i_reg[49] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[49]),
        .Q(s_axi_arlen_ii[5]),
        .R(1'b0));
  FDRE \m_payload_i_reg[4] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[4]),
        .Q(m_axi_araddr[4]),
        .R(1'b0));
  FDRE \m_payload_i_reg[50] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[50]),
        .Q(s_axi_arlen_ii[6]),
        .R(1'b0));
  FDRE \m_payload_i_reg[51] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[51]),
        .Q(s_axi_arlen_ii[7]),
        .R(1'b0));
  FDRE \m_payload_i_reg[52] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[52]),
        .Q(Q[7]),
        .R(1'b0));
  FDRE \m_payload_i_reg[54] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[53]),
        .Q(Q[8]),
        .R(1'b0));
  FDRE \m_payload_i_reg[55] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[54]),
        .Q(Q[9]),
        .R(1'b0));
  FDRE \m_payload_i_reg[56] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[55]),
        .Q(Q[10]),
        .R(1'b0));
  FDRE \m_payload_i_reg[57] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[56]),
        .Q(Q[11]),
        .R(1'b0));
  FDRE \m_payload_i_reg[58] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[57]),
        .Q(Q[12]),
        .R(1'b0));
  FDRE \m_payload_i_reg[59] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[58]),
        .Q(Q[13]),
        .R(1'b0));
  FDRE \m_payload_i_reg[5] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[5]),
        .Q(m_axi_araddr[5]),
        .R(1'b0));
  FDRE \m_payload_i_reg[60] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[59]),
        .Q(Q[14]),
        .R(1'b0));
  FDRE \m_payload_i_reg[61] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[60]),
        .Q(Q[15]),
        .R(1'b0));
  FDRE \m_payload_i_reg[6] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[6]),
        .Q(m_axi_araddr[6]),
        .R(1'b0));
  FDRE \m_payload_i_reg[7] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[7]),
        .Q(m_axi_araddr[7]),
        .R(1'b0));
  FDRE \m_payload_i_reg[8] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[8]),
        .Q(m_axi_araddr[8]),
        .R(1'b0));
  FDRE \m_payload_i_reg[9] 
       (.C(out),
        .CE(\m_payload_i[31]_i_1_n_0 ),
        .D(D[9]),
        .Q(m_axi_araddr[9]),
        .R(1'b0));
  LUT4 #(
    .INIT(16'hB100)) 
    m_valid_i_i_1
       (.I0(s_axi_arready),
        .I1(cmd_push_block_reg),
        .I2(s_axi_arvalid),
        .I3(s_ready_i_reg_0),
        .O(m_valid_i_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    m_valid_i_reg
       (.C(out),
        .CE(1'b1),
        .D(m_valid_i_i_1_n_0),
        .Q(sr_arvalid),
        .R(1'b0));
  LUT5 #(
    .INIT(32'hDD5F0000)) 
    s_ready_i_i_1
       (.I0(s_ready_i_reg_0),
        .I1(cmd_push_block_reg),
        .I2(s_axi_arvalid),
        .I3(sr_arvalid),
        .I4(\aresetn_d_reg[1]_0 ),
        .O(s_ready_i_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    s_ready_i_reg
       (.C(out),
        .CE(1'b1),
        .D(s_ready_i_i_1_n_0),
        .Q(s_axi_arready),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "axi_register_slice_v2_1_15_axic_register_slice" *) 
module system_auto_us_0_axi_register_slice_v2_1_15_axic_register_slice__parameterized2
   (m_axi_rready,
    mr_rvalid,
    Q,
    out,
    m_axi_rlast,
    m_axi_rresp,
    m_axi_rdata,
    m_axi_rvalid,
    E,
    \aresetn_d_reg[1] ,
    \aresetn_d_reg[0] );
  output m_axi_rready;
  output mr_rvalid;
  output [66:0]Q;
  input out;
  input m_axi_rlast;
  input [1:0]m_axi_rresp;
  input [63:0]m_axi_rdata;
  input m_axi_rvalid;
  input [0:0]E;
  input \aresetn_d_reg[1] ;
  input \aresetn_d_reg[0] ;

  wire [0:0]E;
  wire [66:0]Q;
  wire \aresetn_d_reg[0] ;
  wire \aresetn_d_reg[1] ;
  wire [63:0]m_axi_rdata;
  wire m_axi_rlast;
  wire m_axi_rready;
  wire [1:0]m_axi_rresp;
  wire m_axi_rvalid;
  wire m_valid_i_i_1__0_n_0;
  wire mr_rvalid;
  wire out;
  wire s_ready_i_i_1_n_0;
  wire [66:0]skid_buffer;
  wire \skid_buffer_reg_n_0_[0] ;
  wire \skid_buffer_reg_n_0_[10] ;
  wire \skid_buffer_reg_n_0_[11] ;
  wire \skid_buffer_reg_n_0_[12] ;
  wire \skid_buffer_reg_n_0_[13] ;
  wire \skid_buffer_reg_n_0_[14] ;
  wire \skid_buffer_reg_n_0_[15] ;
  wire \skid_buffer_reg_n_0_[16] ;
  wire \skid_buffer_reg_n_0_[17] ;
  wire \skid_buffer_reg_n_0_[18] ;
  wire \skid_buffer_reg_n_0_[19] ;
  wire \skid_buffer_reg_n_0_[1] ;
  wire \skid_buffer_reg_n_0_[20] ;
  wire \skid_buffer_reg_n_0_[21] ;
  wire \skid_buffer_reg_n_0_[22] ;
  wire \skid_buffer_reg_n_0_[23] ;
  wire \skid_buffer_reg_n_0_[24] ;
  wire \skid_buffer_reg_n_0_[25] ;
  wire \skid_buffer_reg_n_0_[26] ;
  wire \skid_buffer_reg_n_0_[27] ;
  wire \skid_buffer_reg_n_0_[28] ;
  wire \skid_buffer_reg_n_0_[29] ;
  wire \skid_buffer_reg_n_0_[2] ;
  wire \skid_buffer_reg_n_0_[30] ;
  wire \skid_buffer_reg_n_0_[31] ;
  wire \skid_buffer_reg_n_0_[32] ;
  wire \skid_buffer_reg_n_0_[33] ;
  wire \skid_buffer_reg_n_0_[34] ;
  wire \skid_buffer_reg_n_0_[35] ;
  wire \skid_buffer_reg_n_0_[36] ;
  wire \skid_buffer_reg_n_0_[37] ;
  wire \skid_buffer_reg_n_0_[38] ;
  wire \skid_buffer_reg_n_0_[39] ;
  wire \skid_buffer_reg_n_0_[3] ;
  wire \skid_buffer_reg_n_0_[40] ;
  wire \skid_buffer_reg_n_0_[41] ;
  wire \skid_buffer_reg_n_0_[42] ;
  wire \skid_buffer_reg_n_0_[43] ;
  wire \skid_buffer_reg_n_0_[44] ;
  wire \skid_buffer_reg_n_0_[45] ;
  wire \skid_buffer_reg_n_0_[46] ;
  wire \skid_buffer_reg_n_0_[47] ;
  wire \skid_buffer_reg_n_0_[48] ;
  wire \skid_buffer_reg_n_0_[49] ;
  wire \skid_buffer_reg_n_0_[4] ;
  wire \skid_buffer_reg_n_0_[50] ;
  wire \skid_buffer_reg_n_0_[51] ;
  wire \skid_buffer_reg_n_0_[52] ;
  wire \skid_buffer_reg_n_0_[53] ;
  wire \skid_buffer_reg_n_0_[54] ;
  wire \skid_buffer_reg_n_0_[55] ;
  wire \skid_buffer_reg_n_0_[56] ;
  wire \skid_buffer_reg_n_0_[57] ;
  wire \skid_buffer_reg_n_0_[58] ;
  wire \skid_buffer_reg_n_0_[59] ;
  wire \skid_buffer_reg_n_0_[5] ;
  wire \skid_buffer_reg_n_0_[60] ;
  wire \skid_buffer_reg_n_0_[61] ;
  wire \skid_buffer_reg_n_0_[62] ;
  wire \skid_buffer_reg_n_0_[63] ;
  wire \skid_buffer_reg_n_0_[64] ;
  wire \skid_buffer_reg_n_0_[65] ;
  wire \skid_buffer_reg_n_0_[66] ;
  wire \skid_buffer_reg_n_0_[6] ;
  wire \skid_buffer_reg_n_0_[7] ;
  wire \skid_buffer_reg_n_0_[8] ;
  wire \skid_buffer_reg_n_0_[9] ;

  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[0]_i_1 
       (.I0(m_axi_rdata[0]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[0] ),
        .O(skid_buffer[0]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[10]_i_1 
       (.I0(m_axi_rdata[10]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[10] ),
        .O(skid_buffer[10]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[11]_i_1 
       (.I0(m_axi_rdata[11]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[11] ),
        .O(skid_buffer[11]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[12]_i_1 
       (.I0(m_axi_rdata[12]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[12] ),
        .O(skid_buffer[12]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[13]_i_1 
       (.I0(m_axi_rdata[13]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[13] ),
        .O(skid_buffer[13]));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[14]_i_1 
       (.I0(m_axi_rdata[14]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[14] ),
        .O(skid_buffer[14]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[15]_i_1 
       (.I0(m_axi_rdata[15]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[15] ),
        .O(skid_buffer[15]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[16]_i_1 
       (.I0(m_axi_rdata[16]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[16] ),
        .O(skid_buffer[16]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[17]_i_1 
       (.I0(m_axi_rdata[17]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[17] ),
        .O(skid_buffer[17]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[18]_i_1 
       (.I0(m_axi_rdata[18]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[18] ),
        .O(skid_buffer[18]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[19]_i_1 
       (.I0(m_axi_rdata[19]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[19] ),
        .O(skid_buffer[19]));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[1]_i_1 
       (.I0(m_axi_rdata[1]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[1] ),
        .O(skid_buffer[1]));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[20]_i_1 
       (.I0(m_axi_rdata[20]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[20] ),
        .O(skid_buffer[20]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[21]_i_1 
       (.I0(m_axi_rdata[21]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[21] ),
        .O(skid_buffer[21]));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[22]_i_1 
       (.I0(m_axi_rdata[22]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[22] ),
        .O(skid_buffer[22]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[23]_i_1 
       (.I0(m_axi_rdata[23]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[23] ),
        .O(skid_buffer[23]));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[24]_i_1 
       (.I0(m_axi_rdata[24]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[24] ),
        .O(skid_buffer[24]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[25]_i_1 
       (.I0(m_axi_rdata[25]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[25] ),
        .O(skid_buffer[25]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[26]_i_1 
       (.I0(m_axi_rdata[26]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[26] ),
        .O(skid_buffer[26]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[27]_i_1 
       (.I0(m_axi_rdata[27]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[27] ),
        .O(skid_buffer[27]));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[28]_i_1 
       (.I0(m_axi_rdata[28]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[28] ),
        .O(skid_buffer[28]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[29]_i_1 
       (.I0(m_axi_rdata[29]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[29] ),
        .O(skid_buffer[29]));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[2]_i_1 
       (.I0(m_axi_rdata[2]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[2] ),
        .O(skid_buffer[2]));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[30]_i_1 
       (.I0(m_axi_rdata[30]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[30] ),
        .O(skid_buffer[30]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[31]_i_1__0 
       (.I0(m_axi_rdata[31]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[31] ),
        .O(skid_buffer[31]));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[32]_i_1 
       (.I0(m_axi_rdata[32]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[32] ),
        .O(skid_buffer[32]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[33]_i_1 
       (.I0(m_axi_rdata[33]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[33] ),
        .O(skid_buffer[33]));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[34]_i_1 
       (.I0(m_axi_rdata[34]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[34] ),
        .O(skid_buffer[34]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[35]_i_1 
       (.I0(m_axi_rdata[35]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[35] ),
        .O(skid_buffer[35]));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[36]_i_1 
       (.I0(m_axi_rdata[36]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[36] ),
        .O(skid_buffer[36]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[37]_i_1 
       (.I0(m_axi_rdata[37]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[37] ),
        .O(skid_buffer[37]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[38]_i_1 
       (.I0(m_axi_rdata[38]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[38] ),
        .O(skid_buffer[38]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[39]_i_1 
       (.I0(m_axi_rdata[39]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[39] ),
        .O(skid_buffer[39]));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[3]_i_1 
       (.I0(m_axi_rdata[3]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[3] ),
        .O(skid_buffer[3]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[40]_i_1 
       (.I0(m_axi_rdata[40]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[40] ),
        .O(skid_buffer[40]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[41]_i_1 
       (.I0(m_axi_rdata[41]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[41] ),
        .O(skid_buffer[41]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[42]_i_1 
       (.I0(m_axi_rdata[42]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[42] ),
        .O(skid_buffer[42]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[43]_i_1 
       (.I0(m_axi_rdata[43]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[43] ),
        .O(skid_buffer[43]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[44]_i_1 
       (.I0(m_axi_rdata[44]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[44] ),
        .O(skid_buffer[44]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[45]_i_1 
       (.I0(m_axi_rdata[45]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[45] ),
        .O(skid_buffer[45]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[46]_i_1 
       (.I0(m_axi_rdata[46]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[46] ),
        .O(skid_buffer[46]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[47]_i_1 
       (.I0(m_axi_rdata[47]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[47] ),
        .O(skid_buffer[47]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[48]_i_1 
       (.I0(m_axi_rdata[48]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[48] ),
        .O(skid_buffer[48]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[49]_i_1 
       (.I0(m_axi_rdata[49]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[49] ),
        .O(skid_buffer[49]));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[4]_i_1 
       (.I0(m_axi_rdata[4]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[4] ),
        .O(skid_buffer[4]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[50]_i_1 
       (.I0(m_axi_rdata[50]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[50] ),
        .O(skid_buffer[50]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[51]_i_1 
       (.I0(m_axi_rdata[51]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[51] ),
        .O(skid_buffer[51]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[52]_i_1 
       (.I0(m_axi_rdata[52]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[52] ),
        .O(skid_buffer[52]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[53]_i_1 
       (.I0(m_axi_rdata[53]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[53] ),
        .O(skid_buffer[53]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[54]_i_1 
       (.I0(m_axi_rdata[54]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[54] ),
        .O(skid_buffer[54]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[55]_i_1 
       (.I0(m_axi_rdata[55]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[55] ),
        .O(skid_buffer[55]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[56]_i_1 
       (.I0(m_axi_rdata[56]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[56] ),
        .O(skid_buffer[56]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[57]_i_1 
       (.I0(m_axi_rdata[57]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[57] ),
        .O(skid_buffer[57]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[58]_i_1 
       (.I0(m_axi_rdata[58]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[58] ),
        .O(skid_buffer[58]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[59]_i_1 
       (.I0(m_axi_rdata[59]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[59] ),
        .O(skid_buffer[59]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[5]_i_1 
       (.I0(m_axi_rdata[5]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[5] ),
        .O(skid_buffer[5]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[60]_i_1 
       (.I0(m_axi_rdata[60]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[60] ),
        .O(skid_buffer[60]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[61]_i_1 
       (.I0(m_axi_rdata[61]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[61] ),
        .O(skid_buffer[61]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[62]_i_1 
       (.I0(m_axi_rdata[62]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[62] ),
        .O(skid_buffer[62]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[63]_i_1 
       (.I0(m_axi_rdata[63]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[63] ),
        .O(skid_buffer[63]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[64]_i_1 
       (.I0(m_axi_rresp[0]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[64] ),
        .O(skid_buffer[64]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[65]_i_1 
       (.I0(m_axi_rresp[1]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[65] ),
        .O(skid_buffer[65]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[66]_i_2 
       (.I0(m_axi_rlast),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[66] ),
        .O(skid_buffer[66]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[6]_i_1 
       (.I0(m_axi_rdata[6]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[6] ),
        .O(skid_buffer[6]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[7]_i_1 
       (.I0(m_axi_rdata[7]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[7] ),
        .O(skid_buffer[7]));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[8]_i_1 
       (.I0(m_axi_rdata[8]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[8] ),
        .O(skid_buffer[8]));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \m_payload_i[9]_i_1 
       (.I0(m_axi_rdata[9]),
        .I1(m_axi_rready),
        .I2(\skid_buffer_reg_n_0_[9] ),
        .O(skid_buffer[9]));
  FDRE \m_payload_i_reg[0] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[0]),
        .Q(Q[0]),
        .R(1'b0));
  FDRE \m_payload_i_reg[10] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[10]),
        .Q(Q[10]),
        .R(1'b0));
  FDRE \m_payload_i_reg[11] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[11]),
        .Q(Q[11]),
        .R(1'b0));
  FDRE \m_payload_i_reg[12] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[12]),
        .Q(Q[12]),
        .R(1'b0));
  FDRE \m_payload_i_reg[13] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[13]),
        .Q(Q[13]),
        .R(1'b0));
  FDRE \m_payload_i_reg[14] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[14]),
        .Q(Q[14]),
        .R(1'b0));
  FDRE \m_payload_i_reg[15] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[15]),
        .Q(Q[15]),
        .R(1'b0));
  FDRE \m_payload_i_reg[16] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[16]),
        .Q(Q[16]),
        .R(1'b0));
  FDRE \m_payload_i_reg[17] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[17]),
        .Q(Q[17]),
        .R(1'b0));
  FDRE \m_payload_i_reg[18] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[18]),
        .Q(Q[18]),
        .R(1'b0));
  FDRE \m_payload_i_reg[19] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[19]),
        .Q(Q[19]),
        .R(1'b0));
  FDRE \m_payload_i_reg[1] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[1]),
        .Q(Q[1]),
        .R(1'b0));
  FDRE \m_payload_i_reg[20] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[20]),
        .Q(Q[20]),
        .R(1'b0));
  FDRE \m_payload_i_reg[21] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[21]),
        .Q(Q[21]),
        .R(1'b0));
  FDRE \m_payload_i_reg[22] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[22]),
        .Q(Q[22]),
        .R(1'b0));
  FDRE \m_payload_i_reg[23] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[23]),
        .Q(Q[23]),
        .R(1'b0));
  FDRE \m_payload_i_reg[24] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[24]),
        .Q(Q[24]),
        .R(1'b0));
  FDRE \m_payload_i_reg[25] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[25]),
        .Q(Q[25]),
        .R(1'b0));
  FDRE \m_payload_i_reg[26] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[26]),
        .Q(Q[26]),
        .R(1'b0));
  FDRE \m_payload_i_reg[27] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[27]),
        .Q(Q[27]),
        .R(1'b0));
  FDRE \m_payload_i_reg[28] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[28]),
        .Q(Q[28]),
        .R(1'b0));
  FDRE \m_payload_i_reg[29] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[29]),
        .Q(Q[29]),
        .R(1'b0));
  FDRE \m_payload_i_reg[2] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[2]),
        .Q(Q[2]),
        .R(1'b0));
  FDRE \m_payload_i_reg[30] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[30]),
        .Q(Q[30]),
        .R(1'b0));
  FDRE \m_payload_i_reg[31] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[31]),
        .Q(Q[31]),
        .R(1'b0));
  FDRE \m_payload_i_reg[32] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[32]),
        .Q(Q[32]),
        .R(1'b0));
  FDRE \m_payload_i_reg[33] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[33]),
        .Q(Q[33]),
        .R(1'b0));
  FDRE \m_payload_i_reg[34] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[34]),
        .Q(Q[34]),
        .R(1'b0));
  FDRE \m_payload_i_reg[35] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[35]),
        .Q(Q[35]),
        .R(1'b0));
  FDRE \m_payload_i_reg[36] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[36]),
        .Q(Q[36]),
        .R(1'b0));
  FDRE \m_payload_i_reg[37] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[37]),
        .Q(Q[37]),
        .R(1'b0));
  FDRE \m_payload_i_reg[38] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[38]),
        .Q(Q[38]),
        .R(1'b0));
  FDRE \m_payload_i_reg[39] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[39]),
        .Q(Q[39]),
        .R(1'b0));
  FDRE \m_payload_i_reg[3] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[3]),
        .Q(Q[3]),
        .R(1'b0));
  FDRE \m_payload_i_reg[40] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[40]),
        .Q(Q[40]),
        .R(1'b0));
  FDRE \m_payload_i_reg[41] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[41]),
        .Q(Q[41]),
        .R(1'b0));
  FDRE \m_payload_i_reg[42] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[42]),
        .Q(Q[42]),
        .R(1'b0));
  FDRE \m_payload_i_reg[43] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[43]),
        .Q(Q[43]),
        .R(1'b0));
  FDRE \m_payload_i_reg[44] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[44]),
        .Q(Q[44]),
        .R(1'b0));
  FDRE \m_payload_i_reg[45] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[45]),
        .Q(Q[45]),
        .R(1'b0));
  FDRE \m_payload_i_reg[46] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[46]),
        .Q(Q[46]),
        .R(1'b0));
  FDRE \m_payload_i_reg[47] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[47]),
        .Q(Q[47]),
        .R(1'b0));
  FDRE \m_payload_i_reg[48] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[48]),
        .Q(Q[48]),
        .R(1'b0));
  FDRE \m_payload_i_reg[49] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[49]),
        .Q(Q[49]),
        .R(1'b0));
  FDRE \m_payload_i_reg[4] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[4]),
        .Q(Q[4]),
        .R(1'b0));
  FDRE \m_payload_i_reg[50] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[50]),
        .Q(Q[50]),
        .R(1'b0));
  FDRE \m_payload_i_reg[51] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[51]),
        .Q(Q[51]),
        .R(1'b0));
  FDRE \m_payload_i_reg[52] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[52]),
        .Q(Q[52]),
        .R(1'b0));
  FDRE \m_payload_i_reg[53] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[53]),
        .Q(Q[53]),
        .R(1'b0));
  FDRE \m_payload_i_reg[54] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[54]),
        .Q(Q[54]),
        .R(1'b0));
  FDRE \m_payload_i_reg[55] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[55]),
        .Q(Q[55]),
        .R(1'b0));
  FDRE \m_payload_i_reg[56] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[56]),
        .Q(Q[56]),
        .R(1'b0));
  FDRE \m_payload_i_reg[57] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[57]),
        .Q(Q[57]),
        .R(1'b0));
  FDRE \m_payload_i_reg[58] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[58]),
        .Q(Q[58]),
        .R(1'b0));
  FDRE \m_payload_i_reg[59] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[59]),
        .Q(Q[59]),
        .R(1'b0));
  FDRE \m_payload_i_reg[5] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[5]),
        .Q(Q[5]),
        .R(1'b0));
  FDRE \m_payload_i_reg[60] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[60]),
        .Q(Q[60]),
        .R(1'b0));
  FDRE \m_payload_i_reg[61] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[61]),
        .Q(Q[61]),
        .R(1'b0));
  FDRE \m_payload_i_reg[62] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[62]),
        .Q(Q[62]),
        .R(1'b0));
  FDRE \m_payload_i_reg[63] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[63]),
        .Q(Q[63]),
        .R(1'b0));
  FDRE \m_payload_i_reg[64] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[64]),
        .Q(Q[64]),
        .R(1'b0));
  FDRE \m_payload_i_reg[65] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[65]),
        .Q(Q[65]),
        .R(1'b0));
  FDRE \m_payload_i_reg[66] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[66]),
        .Q(Q[66]),
        .R(1'b0));
  FDRE \m_payload_i_reg[6] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[6]),
        .Q(Q[6]),
        .R(1'b0));
  FDRE \m_payload_i_reg[7] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[7]),
        .Q(Q[7]),
        .R(1'b0));
  FDRE \m_payload_i_reg[8] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[8]),
        .Q(Q[8]),
        .R(1'b0));
  FDRE \m_payload_i_reg[9] 
       (.C(out),
        .CE(E),
        .D(skid_buffer[9]),
        .Q(Q[9]),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hDF00)) 
    m_valid_i_i_1__0
       (.I0(m_axi_rready),
        .I1(m_axi_rvalid),
        .I2(E),
        .I3(\aresetn_d_reg[1] ),
        .O(m_valid_i_i_1__0_n_0));
  FDRE #(
    .INIT(1'b0)) 
    m_valid_i_reg
       (.C(out),
        .CE(1'b1),
        .D(m_valid_i_i_1__0_n_0),
        .Q(mr_rvalid),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hF200)) 
    s_ready_i_i_1
       (.I0(m_axi_rready),
        .I1(m_axi_rvalid),
        .I2(E),
        .I3(\aresetn_d_reg[0] ),
        .O(s_ready_i_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    s_ready_i_reg
       (.C(out),
        .CE(1'b1),
        .D(s_ready_i_i_1_n_0),
        .Q(m_axi_rready),
        .R(1'b0));
  FDRE \skid_buffer_reg[0] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[0]),
        .Q(\skid_buffer_reg_n_0_[0] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[10] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[10]),
        .Q(\skid_buffer_reg_n_0_[10] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[11] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[11]),
        .Q(\skid_buffer_reg_n_0_[11] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[12] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[12]),
        .Q(\skid_buffer_reg_n_0_[12] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[13] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[13]),
        .Q(\skid_buffer_reg_n_0_[13] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[14] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[14]),
        .Q(\skid_buffer_reg_n_0_[14] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[15] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[15]),
        .Q(\skid_buffer_reg_n_0_[15] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[16] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[16]),
        .Q(\skid_buffer_reg_n_0_[16] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[17] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[17]),
        .Q(\skid_buffer_reg_n_0_[17] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[18] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[18]),
        .Q(\skid_buffer_reg_n_0_[18] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[19] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[19]),
        .Q(\skid_buffer_reg_n_0_[19] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[1] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[1]),
        .Q(\skid_buffer_reg_n_0_[1] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[20] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[20]),
        .Q(\skid_buffer_reg_n_0_[20] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[21] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[21]),
        .Q(\skid_buffer_reg_n_0_[21] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[22] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[22]),
        .Q(\skid_buffer_reg_n_0_[22] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[23] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[23]),
        .Q(\skid_buffer_reg_n_0_[23] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[24] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[24]),
        .Q(\skid_buffer_reg_n_0_[24] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[25] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[25]),
        .Q(\skid_buffer_reg_n_0_[25] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[26] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[26]),
        .Q(\skid_buffer_reg_n_0_[26] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[27] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[27]),
        .Q(\skid_buffer_reg_n_0_[27] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[28] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[28]),
        .Q(\skid_buffer_reg_n_0_[28] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[29] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[29]),
        .Q(\skid_buffer_reg_n_0_[29] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[2] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[2]),
        .Q(\skid_buffer_reg_n_0_[2] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[30] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[30]),
        .Q(\skid_buffer_reg_n_0_[30] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[31] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[31]),
        .Q(\skid_buffer_reg_n_0_[31] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[32] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[32]),
        .Q(\skid_buffer_reg_n_0_[32] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[33] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[33]),
        .Q(\skid_buffer_reg_n_0_[33] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[34] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[34]),
        .Q(\skid_buffer_reg_n_0_[34] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[35] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[35]),
        .Q(\skid_buffer_reg_n_0_[35] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[36] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[36]),
        .Q(\skid_buffer_reg_n_0_[36] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[37] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[37]),
        .Q(\skid_buffer_reg_n_0_[37] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[38] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[38]),
        .Q(\skid_buffer_reg_n_0_[38] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[39] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[39]),
        .Q(\skid_buffer_reg_n_0_[39] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[3] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[3]),
        .Q(\skid_buffer_reg_n_0_[3] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[40] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[40]),
        .Q(\skid_buffer_reg_n_0_[40] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[41] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[41]),
        .Q(\skid_buffer_reg_n_0_[41] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[42] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[42]),
        .Q(\skid_buffer_reg_n_0_[42] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[43] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[43]),
        .Q(\skid_buffer_reg_n_0_[43] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[44] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[44]),
        .Q(\skid_buffer_reg_n_0_[44] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[45] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[45]),
        .Q(\skid_buffer_reg_n_0_[45] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[46] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[46]),
        .Q(\skid_buffer_reg_n_0_[46] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[47] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[47]),
        .Q(\skid_buffer_reg_n_0_[47] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[48] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[48]),
        .Q(\skid_buffer_reg_n_0_[48] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[49] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[49]),
        .Q(\skid_buffer_reg_n_0_[49] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[4] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[4]),
        .Q(\skid_buffer_reg_n_0_[4] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[50] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[50]),
        .Q(\skid_buffer_reg_n_0_[50] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[51] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[51]),
        .Q(\skid_buffer_reg_n_0_[51] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[52] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[52]),
        .Q(\skid_buffer_reg_n_0_[52] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[53] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[53]),
        .Q(\skid_buffer_reg_n_0_[53] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[54] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[54]),
        .Q(\skid_buffer_reg_n_0_[54] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[55] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[55]),
        .Q(\skid_buffer_reg_n_0_[55] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[56] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[56]),
        .Q(\skid_buffer_reg_n_0_[56] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[57] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[57]),
        .Q(\skid_buffer_reg_n_0_[57] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[58] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[58]),
        .Q(\skid_buffer_reg_n_0_[58] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[59] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[59]),
        .Q(\skid_buffer_reg_n_0_[59] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[5] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[5]),
        .Q(\skid_buffer_reg_n_0_[5] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[60] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[60]),
        .Q(\skid_buffer_reg_n_0_[60] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[61] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[61]),
        .Q(\skid_buffer_reg_n_0_[61] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[62] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[62]),
        .Q(\skid_buffer_reg_n_0_[62] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[63] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[63]),
        .Q(\skid_buffer_reg_n_0_[63] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[64] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rresp[0]),
        .Q(\skid_buffer_reg_n_0_[64] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[65] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rresp[1]),
        .Q(\skid_buffer_reg_n_0_[65] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[66] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rlast),
        .Q(\skid_buffer_reg_n_0_[66] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[6] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[6]),
        .Q(\skid_buffer_reg_n_0_[6] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[7] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[7]),
        .Q(\skid_buffer_reg_n_0_[7] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[8] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[8]),
        .Q(\skid_buffer_reg_n_0_[8] ),
        .R(1'b0));
  FDRE \skid_buffer_reg[9] 
       (.C(out),
        .CE(m_axi_rready),
        .D(m_axi_rdata[9]),
        .Q(\skid_buffer_reg_n_0_[9] ),
        .R(1'b0));
endmodule

module system_auto_us_0_generic_baseblocks_v2_1_0_command_fifo
   (\M_AXI_RDATA_I_reg[63] ,
    \USE_RTL_LENGTH.length_counter_q_reg[7] ,
    \USE_RTL_LENGTH.length_counter_q_reg[7]_0 ,
    E,
    D,
    Q,
    \current_word_1_reg[2] ,
    \s_axi_rdata[31] ,
    first_word_reg,
    s_axi_rvalid,
    \M_AXI_RDATA_I_reg[63]_0 ,
    s_ready_i_reg,
    cmd_push_block0,
    m_axi_arvalid,
    SR,
    out,
    mr_rvalid,
    wrap_buffer_available_reg,
    use_wrap_buffer,
    wrap_buffer_available,
    \USE_RTL_LENGTH.length_counter_q_reg[7]_1 ,
    s_axi_rready,
    \pre_next_word_1_reg[2] ,
    \pre_next_word_1_reg[1] ,
    first_word,
    \pre_next_word_1_reg[2]_0 ,
    \current_word_1_reg[2]_0 ,
    cmd_push_block,
    sr_arvalid,
    \USE_RTL_LENGTH.first_mi_word_q ,
    m_axi_arready,
    s_axi_aresetn,
    in);
  output \M_AXI_RDATA_I_reg[63] ;
  output \USE_RTL_LENGTH.length_counter_q_reg[7] ;
  output \USE_RTL_LENGTH.length_counter_q_reg[7]_0 ;
  output [0:0]E;
  output [2:0]D;
  output [12:0]Q;
  output [2:0]\current_word_1_reg[2] ;
  output \s_axi_rdata[31] ;
  output first_word_reg;
  output s_axi_rvalid;
  output [0:0]\M_AXI_RDATA_I_reg[63]_0 ;
  output s_ready_i_reg;
  output cmd_push_block0;
  output m_axi_arvalid;
  input [0:0]SR;
  input out;
  input mr_rvalid;
  input wrap_buffer_available_reg;
  input use_wrap_buffer;
  input wrap_buffer_available;
  input \USE_RTL_LENGTH.length_counter_q_reg[7]_1 ;
  input s_axi_rready;
  input \pre_next_word_1_reg[2] ;
  input \pre_next_word_1_reg[1] ;
  input first_word;
  input [2:0]\pre_next_word_1_reg[2]_0 ;
  input [2:0]\current_word_1_reg[2]_0 ;
  input cmd_push_block;
  input sr_arvalid;
  input \USE_RTL_LENGTH.first_mi_word_q ;
  input m_axi_arready;
  input s_axi_aresetn;
  input [27:0]in;

  wire [2:0]D;
  wire [0:0]E;
  wire \M_AXI_RDATA_I_reg[63] ;
  wire [0:0]\M_AXI_RDATA_I_reg[63]_0 ;
  wire [12:0]Q;
  wire [0:0]SR;
  wire \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ;
  wire \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_3_n_0 ;
  wire \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_4_n_0 ;
  wire \USE_READ.rd_cmd_complete_wrap ;
  wire [1:0]\USE_READ.rd_cmd_first_word ;
  wire [2:0]\USE_READ.rd_cmd_mask ;
  wire \USE_READ.rd_cmd_modified ;
  wire [0:0]\USE_READ.rd_cmd_next_word ;
  wire [2:2]\USE_READ.rd_cmd_offset ;
  wire \USE_READ.rd_cmd_packed_wrap ;
  wire \USE_RTL_ADDR.addr_q ;
  wire \USE_RTL_ADDR.addr_q[0]_i_1_n_0 ;
  wire \USE_RTL_ADDR.addr_q[1]_i_1_n_0 ;
  wire \USE_RTL_ADDR.addr_q[2]_i_1_n_0 ;
  wire \USE_RTL_ADDR.addr_q[3]_i_1_n_0 ;
  wire \USE_RTL_ADDR.addr_q[4]_i_2_n_0 ;
  wire \USE_RTL_ADDR.addr_q[4]_i_3_n_0 ;
  wire [4:0]\USE_RTL_ADDR.addr_q_reg__0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][0]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][10]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][11]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][12]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][13]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][16]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][17]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][18]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][19]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][1]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][20]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][21]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][22]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][23]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][24]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][25]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][26]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][27]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][28]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][29]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][2]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][3]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][4]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][5]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][6]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][7]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][8]_srl32_n_0 ;
  wire \USE_RTL_FIFO.data_srl_reg[31][9]_srl32_n_0 ;
  wire \USE_RTL_LENGTH.first_mi_word_q ;
  wire \USE_RTL_LENGTH.length_counter_q_reg[7] ;
  wire \USE_RTL_LENGTH.length_counter_q_reg[7]_0 ;
  wire \USE_RTL_LENGTH.length_counter_q_reg[7]_1 ;
  wire \USE_RTL_VALID_WRITE.buffer_Full_q ;
  wire \USE_RTL_VALID_WRITE.buffer_Full_q_i_1_n_0 ;
  wire \USE_RTL_VALID_WRITE.buffer_Full_q_i_2_n_0 ;
  wire [1:0]cmd_last_word;
  wire cmd_push_block;
  wire cmd_push_block0;
  wire [2:0]cmd_step;
  wire [2:0]\current_word_1_reg[2] ;
  wire [2:0]\current_word_1_reg[2]_0 ;
  wire data_Exists_I;
  wire data_Exists_I_i_2_n_0;
  wire first_word;
  wire first_word_reg;
  wire [27:0]in;
  wire m_axi_arready;
  wire m_axi_arvalid;
  wire \m_payload_i[66]_i_3_n_0 ;
  wire \m_payload_i[66]_i_4_n_0 ;
  wire mr_rvalid;
  wire next_Data_Exists;
  wire out;
  wire \pre_next_word_1[1]_i_2_n_0 ;
  wire \pre_next_word_1[2]_i_5_n_0 ;
  wire \pre_next_word_1_reg[1] ;
  wire \pre_next_word_1_reg[2] ;
  wire [2:0]\pre_next_word_1_reg[2]_0 ;
  wire s_axi_aresetn;
  wire \s_axi_rdata[31] ;
  wire s_axi_rlast_INST_0_i_7_n_0;
  wire s_axi_rready;
  wire s_axi_rvalid;
  wire s_ready_i_reg;
  wire sr_arvalid;
  wire use_wrap_buffer;
  wire valid_Write;
  wire wrap_buffer_available;
  wire wrap_buffer_available_reg;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][0]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][10]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][11]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][12]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][13]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][16]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][17]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][18]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][19]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][1]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][20]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][21]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][22]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][23]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][24]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][25]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][26]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][27]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][28]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][29]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][2]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][3]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][4]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][5]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][6]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][7]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][8]_srl32_Q31_UNCONNECTED ;
  wire \NLW_USE_RTL_FIFO.data_srl_reg[31][9]_srl32_Q31_UNCONNECTED ;

  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT5 #(
    .INIT(32'h00800000)) 
    \M_AXI_RDATA_I[63]_i_1 
       (.I0(mr_rvalid),
        .I1(\M_AXI_RDATA_I_reg[63] ),
        .I2(\USE_RTL_LENGTH.first_mi_word_q ),
        .I3(use_wrap_buffer),
        .I4(\USE_READ.rd_cmd_packed_wrap ),
        .O(\M_AXI_RDATA_I_reg[63]_0 ));
  LUT6 #(
    .INIT(64'h00005501FFFFFFFF)) 
    \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2 
       (.I0(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_3_n_0 ),
        .I1(wrap_buffer_available),
        .I2(\USE_RTL_LENGTH.length_counter_q_reg[7]_1 ),
        .I3(use_wrap_buffer),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_4_n_0 ),
        .I5(\M_AXI_RDATA_I_reg[63] ),
        .O(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT4 #(
    .INIT(16'h07FF)) 
    \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_3 
       (.I0(\M_AXI_RDATA_I_reg[63] ),
        .I1(mr_rvalid),
        .I2(use_wrap_buffer),
        .I3(s_axi_rready),
        .O(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h01FDFE02FFFFFFFF)) 
    \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_4 
       (.I0(\current_word_1_reg[2]_0 [2]),
        .I1(Q[12]),
        .I2(first_word),
        .I3(Q[11]),
        .I4(Q[8]),
        .I5(first_word_reg),
        .O(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_4_n_0 ));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[0] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][0]_srl32_n_0 ),
        .Q(Q[0]),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[10] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][10]_srl32_n_0 ),
        .Q(cmd_step[2]),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[11] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][11]_srl32_n_0 ),
        .Q(\USE_READ.rd_cmd_mask [0]),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[12] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][12]_srl32_n_0 ),
        .Q(\USE_READ.rd_cmd_mask [1]),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[13] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][13]_srl32_n_0 ),
        .Q(\USE_READ.rd_cmd_mask [2]),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[16] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][16]_srl32_n_0 ),
        .Q(\USE_READ.rd_cmd_offset ),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[17] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][17]_srl32_n_0 ),
        .Q(cmd_last_word[0]),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[18] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][18]_srl32_n_0 ),
        .Q(cmd_last_word[1]),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[19] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][19]_srl32_n_0 ),
        .Q(Q[8]),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[1] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][1]_srl32_n_0 ),
        .Q(Q[1]),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[20] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][20]_srl32_n_0 ),
        .Q(\USE_READ.rd_cmd_next_word ),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[21] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][21]_srl32_n_0 ),
        .Q(Q[9]),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[22] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][22]_srl32_n_0 ),
        .Q(Q[10]),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[23] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][23]_srl32_n_0 ),
        .Q(\USE_READ.rd_cmd_first_word [0]),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[24] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][24]_srl32_n_0 ),
        .Q(\USE_READ.rd_cmd_first_word [1]),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[25] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][25]_srl32_n_0 ),
        .Q(Q[11]),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[26] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][26]_srl32_n_0 ),
        .Q(\USE_READ.rd_cmd_packed_wrap ),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[27] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][27]_srl32_n_0 ),
        .Q(\USE_READ.rd_cmd_complete_wrap ),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[28] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][28]_srl32_n_0 ),
        .Q(\USE_READ.rd_cmd_modified ),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[29] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][29]_srl32_n_0 ),
        .Q(Q[12]),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[2] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][2]_srl32_n_0 ),
        .Q(Q[2]),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[3] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][3]_srl32_n_0 ),
        .Q(Q[3]),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[4] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][4]_srl32_n_0 ),
        .Q(Q[4]),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[5] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][5]_srl32_n_0 ),
        .Q(Q[5]),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[6] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][6]_srl32_n_0 ),
        .Q(Q[6]),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[7] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][7]_srl32_n_0 ),
        .Q(Q[7]),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[8] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][8]_srl32_n_0 ),
        .Q(cmd_step[0]),
        .R(SR));
  FDRE \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q_reg[9] 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(\USE_RTL_FIFO.data_srl_reg[31][9]_srl32_n_0 ),
        .Q(cmd_step[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_VALID_Q_reg 
       (.C(out),
        .CE(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .D(data_Exists_I),
        .Q(\M_AXI_RDATA_I_reg[63] ),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \USE_RTL_ADDR.addr_q[0]_i_1 
       (.I0(\USE_RTL_ADDR.addr_q_reg__0 [0]),
        .O(\USE_RTL_ADDR.addr_q[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAA9A55555565)) 
    \USE_RTL_ADDR.addr_q[1]_i_1 
       (.I0(\USE_RTL_ADDR.addr_q_reg__0 [0]),
        .I1(cmd_push_block),
        .I2(sr_arvalid),
        .I3(\USE_RTL_VALID_WRITE.buffer_Full_q ),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .I5(\USE_RTL_ADDR.addr_q_reg__0 [1]),
        .O(\USE_RTL_ADDR.addr_q[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT5 #(
    .INIT(32'hBF40F40B)) 
    \USE_RTL_ADDR.addr_q[2]_i_1 
       (.I0(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .I1(valid_Write),
        .I2(\USE_RTL_ADDR.addr_q_reg__0 [0]),
        .I3(\USE_RTL_ADDR.addr_q_reg__0 [2]),
        .I4(\USE_RTL_ADDR.addr_q_reg__0 [1]),
        .O(\USE_RTL_ADDR.addr_q[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hDFFF2000FFBA0045)) 
    \USE_RTL_ADDR.addr_q[3]_i_1 
       (.I0(\USE_RTL_ADDR.addr_q_reg__0 [1]),
        .I1(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .I2(valid_Write),
        .I3(\USE_RTL_ADDR.addr_q_reg__0 [0]),
        .I4(\USE_RTL_ADDR.addr_q_reg__0 [3]),
        .I5(\USE_RTL_ADDR.addr_q_reg__0 [2]),
        .O(\USE_RTL_ADDR.addr_q[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h80808080800C8080)) 
    \USE_RTL_ADDR.addr_q[4]_i_1 
       (.I0(data_Exists_I_i_2_n_0),
        .I1(data_Exists_I),
        .I2(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .I3(\USE_RTL_VALID_WRITE.buffer_Full_q ),
        .I4(sr_arvalid),
        .I5(cmd_push_block),
        .O(\USE_RTL_ADDR.addr_q ));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAA9)) 
    \USE_RTL_ADDR.addr_q[4]_i_2 
       (.I0(\USE_RTL_ADDR.addr_q_reg__0 [4]),
        .I1(\USE_RTL_ADDR.addr_q_reg__0 [3]),
        .I2(\USE_RTL_ADDR.addr_q_reg__0 [1]),
        .I3(\USE_RTL_ADDR.addr_q[4]_i_3_n_0 ),
        .I4(\USE_RTL_ADDR.addr_q_reg__0 [0]),
        .I5(\USE_RTL_ADDR.addr_q_reg__0 [2]),
        .O(\USE_RTL_ADDR.addr_q[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h8888888880808088)) 
    \USE_RTL_ADDR.addr_q[4]_i_3 
       (.I0(valid_Write),
        .I1(\M_AXI_RDATA_I_reg[63] ),
        .I2(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_4_n_0 ),
        .I3(use_wrap_buffer),
        .I4(wrap_buffer_available_reg),
        .I5(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_3_n_0 ),
        .O(\USE_RTL_ADDR.addr_q[4]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \USE_RTL_ADDR.addr_q_reg[0] 
       (.C(out),
        .CE(\USE_RTL_ADDR.addr_q ),
        .D(\USE_RTL_ADDR.addr_q[0]_i_1_n_0 ),
        .Q(\USE_RTL_ADDR.addr_q_reg__0 [0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \USE_RTL_ADDR.addr_q_reg[1] 
       (.C(out),
        .CE(\USE_RTL_ADDR.addr_q ),
        .D(\USE_RTL_ADDR.addr_q[1]_i_1_n_0 ),
        .Q(\USE_RTL_ADDR.addr_q_reg__0 [1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \USE_RTL_ADDR.addr_q_reg[2] 
       (.C(out),
        .CE(\USE_RTL_ADDR.addr_q ),
        .D(\USE_RTL_ADDR.addr_q[2]_i_1_n_0 ),
        .Q(\USE_RTL_ADDR.addr_q_reg__0 [2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \USE_RTL_ADDR.addr_q_reg[3] 
       (.C(out),
        .CE(\USE_RTL_ADDR.addr_q ),
        .D(\USE_RTL_ADDR.addr_q[3]_i_1_n_0 ),
        .Q(\USE_RTL_ADDR.addr_q_reg__0 [3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \USE_RTL_ADDR.addr_q_reg[4] 
       (.C(out),
        .CE(\USE_RTL_ADDR.addr_q ),
        .D(\USE_RTL_ADDR.addr_q[4]_i_2_n_0 ),
        .Q(\USE_RTL_ADDR.addr_q_reg__0 [4]),
        .R(SR));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][0]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][0]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[0]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][0]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][0]_srl32_Q31_UNCONNECTED ));
  LUT3 #(
    .INIT(8'h04)) 
    \USE_RTL_FIFO.data_srl_reg[31][0]_srl32_i_1 
       (.I0(\USE_RTL_VALID_WRITE.buffer_Full_q ),
        .I1(sr_arvalid),
        .I2(cmd_push_block),
        .O(valid_Write));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][10]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][10]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[10]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][10]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][10]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][11]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][11]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[11]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][11]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][11]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][12]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][12]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[12]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][12]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][12]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][13]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][13]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[13]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][13]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][13]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][16]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][16]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[14]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][16]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][16]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][17]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][17]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[15]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][17]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][17]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][18]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][18]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[16]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][18]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][18]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][19]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][19]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[17]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][19]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][19]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][1]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][1]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[1]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][1]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][1]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][20]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][20]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[18]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][20]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][20]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][21]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][21]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[19]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][21]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][21]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][22]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][22]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[20]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][22]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][22]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][23]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][23]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[21]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][23]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][23]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][24]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][24]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[22]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][24]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][24]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][25]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][25]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[23]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][25]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][25]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][26]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][26]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[24]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][26]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][26]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][27]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][27]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[25]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][27]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][27]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][28]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][28]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[26]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][28]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][28]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][29]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][29]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[27]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][29]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][29]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][2]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][2]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[2]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][2]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][2]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][3]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][3]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[3]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][3]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][3]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][4]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][4]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[4]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][4]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][4]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][5]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][5]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[5]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][5]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][5]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][6]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][6]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[6]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][6]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][6]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][7]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][7]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[7]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][7]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][7]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][8]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][8]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[8]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][8]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][8]_srl32_Q31_UNCONNECTED ));
  (* srl_bus_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31] " *) 
  (* srl_name = "inst/\gen_upsizer.gen_full_upsizer.axi_upsizer_inst/USE_READ.read_addr_inst/GEN_CMD_QUEUE.cmd_queue/USE_RTL_FIFO.data_srl_reg[31][9]_srl32 " *) 
  SRLC32E #(
    .INIT(32'h00000000)) 
    \USE_RTL_FIFO.data_srl_reg[31][9]_srl32 
       (.A(\USE_RTL_ADDR.addr_q_reg__0 ),
        .CE(valid_Write),
        .CLK(out),
        .D(in[9]),
        .Q(\USE_RTL_FIFO.data_srl_reg[31][9]_srl32_n_0 ),
        .Q31(\NLW_USE_RTL_FIFO.data_srl_reg[31][9]_srl32_Q31_UNCONNECTED ));
  LUT2 #(
    .INIT(4'h8)) 
    \USE_RTL_LENGTH.first_mi_word_q_i_1 
       (.I0(\USE_RTL_LENGTH.length_counter_q_reg[7]_0 ),
        .I1(mr_rvalid),
        .O(\USE_RTL_LENGTH.length_counter_q_reg[7] ));
  LUT6 #(
    .INIT(64'h00000000FFFF0001)) 
    \USE_RTL_LENGTH.first_mi_word_q_i_2 
       (.I0(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_4_n_0 ),
        .I1(use_wrap_buffer),
        .I2(\USE_RTL_LENGTH.length_counter_q_reg[7]_1 ),
        .I3(wrap_buffer_available),
        .I4(\m_payload_i[66]_i_4_n_0 ),
        .I5(\m_payload_i[66]_i_3_n_0 ),
        .O(\USE_RTL_LENGTH.length_counter_q_reg[7]_0 ));
  LUT6 #(
    .INIT(64'h00FFFFFF00040000)) 
    \USE_RTL_VALID_WRITE.buffer_Full_q_i_1 
       (.I0(cmd_push_block),
        .I1(sr_arvalid),
        .I2(\USE_RTL_VALID_WRITE.buffer_Full_q_i_2_n_0 ),
        .I3(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .I4(data_Exists_I),
        .I5(\USE_RTL_VALID_WRITE.buffer_Full_q ),
        .O(\USE_RTL_VALID_WRITE.buffer_Full_q_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT5 #(
    .INIT(32'hFF7FFFFF)) 
    \USE_RTL_VALID_WRITE.buffer_Full_q_i_2 
       (.I0(\USE_RTL_ADDR.addr_q_reg__0 [2]),
        .I1(\USE_RTL_ADDR.addr_q_reg__0 [1]),
        .I2(\USE_RTL_ADDR.addr_q_reg__0 [4]),
        .I3(\USE_RTL_ADDR.addr_q_reg__0 [0]),
        .I4(\USE_RTL_ADDR.addr_q_reg__0 [3]),
        .O(\USE_RTL_VALID_WRITE.buffer_Full_q_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \USE_RTL_VALID_WRITE.buffer_Full_q_reg 
       (.C(out),
        .CE(1'b1),
        .D(\USE_RTL_VALID_WRITE.buffer_Full_q_i_1_n_0 ),
        .Q(\USE_RTL_VALID_WRITE.buffer_Full_q ),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT4 #(
    .INIT(16'h00D0)) 
    cmd_push_block_i_1
       (.I0(\USE_RTL_VALID_WRITE.buffer_Full_q ),
        .I1(cmd_push_block),
        .I2(sr_arvalid),
        .I3(m_axi_arready),
        .O(cmd_push_block0));
  LUT5 #(
    .INIT(32'h888A8880)) 
    \current_word_1[0]_i_1 
       (.I0(\USE_READ.rd_cmd_mask [0]),
        .I1(\USE_READ.rd_cmd_next_word ),
        .I2(first_word),
        .I3(Q[12]),
        .I4(\pre_next_word_1_reg[2]_0 [0]),
        .O(\current_word_1_reg[2] [0]));
  LUT5 #(
    .INIT(32'h888A8880)) 
    \current_word_1[1]_i_1 
       (.I0(\USE_READ.rd_cmd_mask [1]),
        .I1(Q[9]),
        .I2(first_word),
        .I3(Q[12]),
        .I4(\pre_next_word_1_reg[2]_0 [1]),
        .O(\current_word_1_reg[2] [1]));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT5 #(
    .INIT(32'h888A8880)) 
    \current_word_1[2]_i_1 
       (.I0(\USE_READ.rd_cmd_mask [2]),
        .I1(Q[10]),
        .I2(first_word),
        .I3(Q[12]),
        .I4(\pre_next_word_1_reg[2]_0 [2]),
        .O(\current_word_1_reg[2] [2]));
  LUT6 #(
    .INIT(64'hC4C4C4C4C4CFC4C4)) 
    data_Exists_I_i_1
       (.I0(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_2_n_0 ),
        .I1(data_Exists_I),
        .I2(data_Exists_I_i_2_n_0),
        .I3(\USE_RTL_VALID_WRITE.buffer_Full_q ),
        .I4(sr_arvalid),
        .I5(cmd_push_block),
        .O(next_Data_Exists));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    data_Exists_I_i_2
       (.I0(\USE_RTL_ADDR.addr_q_reg__0 [2]),
        .I1(\USE_RTL_ADDR.addr_q_reg__0 [1]),
        .I2(\USE_RTL_ADDR.addr_q_reg__0 [3]),
        .I3(\USE_RTL_ADDR.addr_q_reg__0 [0]),
        .I4(\USE_RTL_ADDR.addr_q_reg__0 [4]),
        .O(data_Exists_I_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    data_Exists_I_reg
       (.C(out),
        .CE(1'b1),
        .D(next_Data_Exists),
        .Q(data_Exists_I),
        .R(SR));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'h8A)) 
    m_axi_arvalid_INST_0
       (.I0(sr_arvalid),
        .I1(cmd_push_block),
        .I2(\USE_RTL_VALID_WRITE.buffer_Full_q ),
        .O(m_axi_arvalid));
  LUT6 #(
    .INIT(64'h44444454FFFFFFFF)) 
    \m_payload_i[66]_i_1 
       (.I0(\m_payload_i[66]_i_3_n_0 ),
        .I1(\m_payload_i[66]_i_4_n_0 ),
        .I2(wrap_buffer_available_reg),
        .I3(use_wrap_buffer),
        .I4(\USE_FF_OUT.USE_RTL_OUTPUT_PIPELINE.M_MESG_Q[29]_i_4_n_0 ),
        .I5(mr_rvalid),
        .O(E));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \m_payload_i[66]_i_3 
       (.I0(s_axi_rready),
        .I1(\M_AXI_RDATA_I_reg[63] ),
        .O(\m_payload_i[66]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hDDDDDDDDDDDDDDDF)) 
    \m_payload_i[66]_i_4 
       (.I0(\USE_READ.rd_cmd_modified ),
        .I1(Q[12]),
        .I2(\current_word_1_reg[2] [1]),
        .I3(\current_word_1_reg[2] [0]),
        .I4(\USE_READ.rd_cmd_complete_wrap ),
        .I5(\current_word_1_reg[2] [2]),
        .O(\m_payload_i[66]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0002AAA2AAA80008)) 
    \pre_next_word_1[0]_i_1 
       (.I0(\USE_READ.rd_cmd_mask [0]),
        .I1(\pre_next_word_1_reg[2]_0 [0]),
        .I2(Q[12]),
        .I3(first_word),
        .I4(\USE_READ.rd_cmd_next_word ),
        .I5(cmd_step[0]),
        .O(D[0]));
  LUT6 #(
    .INIT(64'h8882228222288828)) 
    \pre_next_word_1[1]_i_1 
       (.I0(\USE_READ.rd_cmd_mask [1]),
        .I1(cmd_step[1]),
        .I2(Q[9]),
        .I3(\pre_next_word_1[1]_i_2_n_0 ),
        .I4(\pre_next_word_1_reg[2]_0 [1]),
        .I5(\pre_next_word_1[2]_i_5_n_0 ),
        .O(D[1]));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \pre_next_word_1[1]_i_2 
       (.I0(Q[12]),
        .I1(first_word),
        .O(\pre_next_word_1[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h2828288228828282)) 
    \pre_next_word_1[2]_i_2 
       (.I0(\USE_READ.rd_cmd_mask [2]),
        .I1(cmd_step[2]),
        .I2(\pre_next_word_1_reg[2] ),
        .I3(cmd_step[1]),
        .I4(\pre_next_word_1_reg[1] ),
        .I5(\pre_next_word_1[2]_i_5_n_0 ),
        .O(D[2]));
  LUT5 #(
    .INIT(32'h888A8880)) 
    \pre_next_word_1[2]_i_5 
       (.I0(cmd_step[0]),
        .I1(\USE_READ.rd_cmd_next_word ),
        .I2(first_word),
        .I3(Q[12]),
        .I4(\pre_next_word_1_reg[2]_0 [0]),
        .O(\pre_next_word_1[2]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h00005457)) 
    \s_axi_rdata[31]_INST_0_i_1 
       (.I0(Q[11]),
        .I1(first_word),
        .I2(Q[12]),
        .I3(\current_word_1_reg[2]_0 [2]),
        .I4(\USE_READ.rd_cmd_offset ),
        .O(\s_axi_rdata[31] ));
  LUT6 #(
    .INIT(64'h00000000FE0201FD)) 
    s_axi_rlast_INST_0_i_2
       (.I0(\current_word_1_reg[2]_0 [0]),
        .I1(Q[12]),
        .I2(first_word),
        .I3(\USE_READ.rd_cmd_first_word [0]),
        .I4(cmd_last_word[0]),
        .I5(s_axi_rlast_INST_0_i_7_n_0),
        .O(first_word_reg));
  LUT5 #(
    .INIT(32'h6665666A)) 
    s_axi_rlast_INST_0_i_7
       (.I0(cmd_last_word[1]),
        .I1(\USE_READ.rd_cmd_first_word [1]),
        .I2(first_word),
        .I3(Q[12]),
        .I4(\current_word_1_reg[2]_0 [1]),
        .O(s_axi_rlast_INST_0_i_7_n_0));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'hF8)) 
    s_axi_rvalid_INST_0
       (.I0(\M_AXI_RDATA_I_reg[63] ),
        .I1(mr_rvalid),
        .I2(use_wrap_buffer),
        .O(s_axi_rvalid));
  LUT4 #(
    .INIT(16'hB000)) 
    s_ready_i_i_2
       (.I0(cmd_push_block),
        .I1(\USE_RTL_VALID_WRITE.buffer_Full_q ),
        .I2(m_axi_arready),
        .I3(s_axi_aresetn),
        .O(s_ready_i_reg));
endmodule

(* CHECK_LICENSE_TYPE = "system_auto_us_0,axi_dwidth_converter_v2_1_15_top,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* X_CORE_INFO = "axi_dwidth_converter_v2_1_15_top,Vivado 2017.4" *) 
(* NotValidForBitStream *)
module system_auto_us_0
   (s_axi_aclk,
    s_axi_aresetn,
    s_axi_araddr,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_arburst,
    s_axi_arlock,
    s_axi_arcache,
    s_axi_arprot,
    s_axi_arregion,
    s_axi_arqos,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rlast,
    s_axi_rvalid,
    s_axi_rready,
    m_axi_araddr,
    m_axi_arlen,
    m_axi_arsize,
    m_axi_arburst,
    m_axi_arlock,
    m_axi_arcache,
    m_axi_arprot,
    m_axi_arregion,
    m_axi_arqos,
    m_axi_arvalid,
    m_axi_arready,
    m_axi_rdata,
    m_axi_rresp,
    m_axi_rlast,
    m_axi_rvalid,
    m_axi_rready);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 SI_CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME SI_CLK, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN system_processing_system7_0_0_FCLK_CLK0, ASSOCIATED_BUSIF S_AXI:M_AXI, ASSOCIATED_RESET S_AXI_ARESETN" *) input s_axi_aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 SI_RST RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME SI_RST, POLARITY ACTIVE_LOW, TYPE INTERCONNECT" *) input s_axi_aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARADDR" *) input [31:0]s_axi_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARLEN" *) input [7:0]s_axi_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARSIZE" *) input [2:0]s_axi_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARBURST" *) input [1:0]s_axi_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARLOCK" *) input [0:0]s_axi_arlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARCACHE" *) input [3:0]s_axi_arcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARPROT" *) input [2:0]s_axi_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARREGION" *) input [3:0]s_axi_arregion;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARQOS" *) input [3:0]s_axi_arqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARVALID" *) input s_axi_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARREADY" *) output s_axi_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RDATA" *) output [31:0]s_axi_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RRESP" *) output [1:0]s_axi_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RLAST" *) output s_axi_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RVALID" *) output s_axi_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RREADY" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXI, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_ONLY, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 0, HAS_BRESP 0, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 16, PHASE 0.000, CLK_DOMAIN system_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0" *) input s_axi_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARADDR" *) output [31:0]m_axi_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARLEN" *) output [7:0]m_axi_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARSIZE" *) output [2:0]m_axi_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARBURST" *) output [1:0]m_axi_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARLOCK" *) output [0:0]m_axi_arlock;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARCACHE" *) output [3:0]m_axi_arcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARPROT" *) output [2:0]m_axi_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARREGION" *) output [3:0]m_axi_arregion;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARQOS" *) output [3:0]m_axi_arqos;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARVALID" *) output m_axi_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI ARREADY" *) input m_axi_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI RDATA" *) input [63:0]m_axi_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI RRESP" *) input [1:0]m_axi_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI RLAST" *) input m_axi_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI RVALID" *) input m_axi_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M_AXI RREADY" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXI, DATA_WIDTH 64, PROTOCOL AXI4, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_ONLY, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 0, HAS_BRESP 0, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 8, PHASE 0.000, CLK_DOMAIN system_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0" *) output m_axi_rready;

  wire [31:0]m_axi_araddr;
  wire [1:0]m_axi_arburst;
  wire [3:0]m_axi_arcache;
  wire [7:0]m_axi_arlen;
  wire [0:0]m_axi_arlock;
  wire [2:0]m_axi_arprot;
  wire [3:0]m_axi_arqos;
  wire m_axi_arready;
  wire [3:0]m_axi_arregion;
  wire [2:0]m_axi_arsize;
  wire m_axi_arvalid;
  wire [63:0]m_axi_rdata;
  wire m_axi_rlast;
  wire m_axi_rready;
  wire [1:0]m_axi_rresp;
  wire m_axi_rvalid;
  wire s_axi_aclk;
  wire [31:0]s_axi_araddr;
  wire [1:0]s_axi_arburst;
  wire [3:0]s_axi_arcache;
  wire s_axi_aresetn;
  wire [7:0]s_axi_arlen;
  wire [0:0]s_axi_arlock;
  wire [2:0]s_axi_arprot;
  wire [3:0]s_axi_arqos;
  wire s_axi_arready;
  wire [3:0]s_axi_arregion;
  wire [2:0]s_axi_arsize;
  wire s_axi_arvalid;
  wire [31:0]s_axi_rdata;
  wire s_axi_rlast;
  wire s_axi_rready;
  wire [1:0]s_axi_rresp;
  wire s_axi_rvalid;
  wire NLW_inst_m_axi_awvalid_UNCONNECTED;
  wire NLW_inst_m_axi_bready_UNCONNECTED;
  wire NLW_inst_m_axi_wlast_UNCONNECTED;
  wire NLW_inst_m_axi_wvalid_UNCONNECTED;
  wire NLW_inst_s_axi_awready_UNCONNECTED;
  wire NLW_inst_s_axi_bvalid_UNCONNECTED;
  wire NLW_inst_s_axi_wready_UNCONNECTED;
  wire [31:0]NLW_inst_m_axi_awaddr_UNCONNECTED;
  wire [1:0]NLW_inst_m_axi_awburst_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_awcache_UNCONNECTED;
  wire [7:0]NLW_inst_m_axi_awlen_UNCONNECTED;
  wire [0:0]NLW_inst_m_axi_awlock_UNCONNECTED;
  wire [2:0]NLW_inst_m_axi_awprot_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_awqos_UNCONNECTED;
  wire [3:0]NLW_inst_m_axi_awregion_UNCONNECTED;
  wire [2:0]NLW_inst_m_axi_awsize_UNCONNECTED;
  wire [63:0]NLW_inst_m_axi_wdata_UNCONNECTED;
  wire [7:0]NLW_inst_m_axi_wstrb_UNCONNECTED;
  wire [0:0]NLW_inst_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_inst_s_axi_bresp_UNCONNECTED;
  wire [0:0]NLW_inst_s_axi_rid_UNCONNECTED;

  (* C_AXI_ADDR_WIDTH = "32" *) 
  (* C_AXI_IS_ACLK_ASYNC = "0" *) 
  (* C_AXI_PROTOCOL = "0" *) 
  (* C_AXI_SUPPORTS_READ = "1" *) 
  (* C_AXI_SUPPORTS_WRITE = "0" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_FIFO_MODE = "0" *) 
  (* C_MAX_SPLIT_BEATS = "16" *) 
  (* C_M_AXI_ACLK_RATIO = "2" *) 
  (* C_M_AXI_BYTES_LOG = "3" *) 
  (* C_M_AXI_DATA_WIDTH = "64" *) 
  (* C_PACKING_LEVEL = "1" *) 
  (* C_RATIO = "0" *) 
  (* C_RATIO_LOG = "0" *) 
  (* C_SUPPORTS_ID = "0" *) 
  (* C_SYNCHRONIZER_STAGE = "3" *) 
  (* C_S_AXI_ACLK_RATIO = "1" *) 
  (* C_S_AXI_BYTES_LOG = "2" *) 
  (* C_S_AXI_DATA_WIDTH = "32" *) 
  (* C_S_AXI_ID_WIDTH = "1" *) 
  (* DowngradeIPIdentifiedWarnings = "yes" *) 
  (* P_AXI3 = "1" *) 
  (* P_AXI4 = "0" *) 
  (* P_AXILITE = "2" *) 
  (* P_CONVERSION = "2" *) 
  (* P_MAX_SPLIT_BEATS = "16" *) 
  system_auto_us_0_axi_dwidth_converter_v2_1_15_top inst
       (.m_axi_aclk(1'b0),
        .m_axi_araddr(m_axi_araddr),
        .m_axi_arburst(m_axi_arburst),
        .m_axi_arcache(m_axi_arcache),
        .m_axi_aresetn(1'b0),
        .m_axi_arlen(m_axi_arlen),
        .m_axi_arlock(m_axi_arlock),
        .m_axi_arprot(m_axi_arprot),
        .m_axi_arqos(m_axi_arqos),
        .m_axi_arready(m_axi_arready),
        .m_axi_arregion(m_axi_arregion),
        .m_axi_arsize(m_axi_arsize),
        .m_axi_arvalid(m_axi_arvalid),
        .m_axi_awaddr(NLW_inst_m_axi_awaddr_UNCONNECTED[31:0]),
        .m_axi_awburst(NLW_inst_m_axi_awburst_UNCONNECTED[1:0]),
        .m_axi_awcache(NLW_inst_m_axi_awcache_UNCONNECTED[3:0]),
        .m_axi_awlen(NLW_inst_m_axi_awlen_UNCONNECTED[7:0]),
        .m_axi_awlock(NLW_inst_m_axi_awlock_UNCONNECTED[0]),
        .m_axi_awprot(NLW_inst_m_axi_awprot_UNCONNECTED[2:0]),
        .m_axi_awqos(NLW_inst_m_axi_awqos_UNCONNECTED[3:0]),
        .m_axi_awready(1'b0),
        .m_axi_awregion(NLW_inst_m_axi_awregion_UNCONNECTED[3:0]),
        .m_axi_awsize(NLW_inst_m_axi_awsize_UNCONNECTED[2:0]),
        .m_axi_awvalid(NLW_inst_m_axi_awvalid_UNCONNECTED),
        .m_axi_bready(NLW_inst_m_axi_bready_UNCONNECTED),
        .m_axi_bresp({1'b0,1'b0}),
        .m_axi_bvalid(1'b0),
        .m_axi_rdata(m_axi_rdata),
        .m_axi_rlast(m_axi_rlast),
        .m_axi_rready(m_axi_rready),
        .m_axi_rresp(m_axi_rresp),
        .m_axi_rvalid(m_axi_rvalid),
        .m_axi_wdata(NLW_inst_m_axi_wdata_UNCONNECTED[63:0]),
        .m_axi_wlast(NLW_inst_m_axi_wlast_UNCONNECTED),
        .m_axi_wready(1'b0),
        .m_axi_wstrb(NLW_inst_m_axi_wstrb_UNCONNECTED[7:0]),
        .m_axi_wvalid(NLW_inst_m_axi_wvalid_UNCONNECTED),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_arburst(s_axi_arburst),
        .s_axi_arcache(s_axi_arcache),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arid(1'b0),
        .s_axi_arlen(s_axi_arlen),
        .s_axi_arlock(s_axi_arlock),
        .s_axi_arprot(s_axi_arprot),
        .s_axi_arqos(s_axi_arqos),
        .s_axi_arready(s_axi_arready),
        .s_axi_arregion(s_axi_arregion),
        .s_axi_arsize(s_axi_arsize),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b1}),
        .s_axi_awcache({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awid(1'b0),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlock(1'b0),
        .s_axi_awprot({1'b0,1'b0,1'b0}),
        .s_axi_awqos({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_inst_s_axi_awready_UNCONNECTED),
        .s_axi_awregion({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_inst_s_axi_bid_UNCONNECTED[0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_inst_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_inst_s_axi_bvalid_UNCONNECTED),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rid(NLW_inst_s_axi_rid_UNCONNECTED[0]),
        .s_axi_rlast(s_axi_rlast),
        .s_axi_rready(s_axi_rready),
        .s_axi_rresp(s_axi_rresp),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b1),
        .s_axi_wready(NLW_inst_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b1,1'b1,1'b1,1'b1}),
        .s_axi_wvalid(1'b0));
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
