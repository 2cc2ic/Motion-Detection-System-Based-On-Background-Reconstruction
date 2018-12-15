-makelib ies_lib/xil_defaultlib -sv \
  "D:/xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/xilinx/Vivado/2017.4/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
  "D:/xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/axi_infrastructure_v1_1_0 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \
-endlib
-makelib ies_lib/smartconnect_v1_0 -sv \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/sc_util_v1_0_vl_rfs.sv" \
-endlib
-makelib ies_lib/axi_protocol_checker_v2_0_1 -sv \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/3b24/hdl/axi_protocol_checker_v2_0_vl_rfs.sv" \
-endlib
-makelib ies_lib/axi_vip_v1_1_1 -sv \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/a16a/hdl/axi_vip_v1_1_vl_rfs.sv" \
-endlib
-makelib ies_lib/processing_system7_vip_v1_0_3 -sv \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/system/ip/system_processing_system7_0_0/sim/system_processing_system7_0_0.v" \
-endlib
-makelib ies_lib/lib_cdc_v1_0_2 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \
-endlib
-makelib ies_lib/proc_sys_reset_v5_0_12 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/f86a/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/system/ip/system_rst_processing_system7_0_50M_0/sim/system_rst_processing_system7_0_50M_0.vhd" \
-endlib
-makelib ies_lib/lib_pkg_v1_0_2 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/0513/hdl/lib_pkg_v1_0_rfs.vhd" \
-endlib
-makelib ies_lib/fifo_generator_v13_2_1 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/5c35/simulation/fifo_generator_vlog_beh.v" \
-endlib
-makelib ies_lib/fifo_generator_v13_2_1 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/5c35/hdl/fifo_generator_v13_2_rfs.vhd" \
-endlib
-makelib ies_lib/fifo_generator_v13_2_1 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/5c35/hdl/fifo_generator_v13_2_rfs.v" \
-endlib
-makelib ies_lib/lib_fifo_v1_0_10 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/f10a/hdl/lib_fifo_v1_0_rfs.vhd" \
-endlib
-makelib ies_lib/lib_srl_fifo_v1_0_2 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/51ce/hdl/lib_srl_fifo_v1_0_rfs.vhd" \
-endlib
-makelib ies_lib/axi_datamover_v5_1_17 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/71f3/hdl/axi_datamover_v5_1_vh_rfs.vhd" \
-endlib
-makelib ies_lib/axi_sg_v4_1_8 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/5f94/hdl/axi_sg_v4_1_rfs.vhd" \
-endlib
-makelib ies_lib/axi_dma_v7_1_16 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/bf8c/hdl/axi_dma_v7_1_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/system/ip/system_axi_dma_0_0/sim/system_axi_dma_0_0.vhd" \
-endlib
-makelib ies_lib/xlconcat_v2_1_1 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/2f66/hdl/xlconcat_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/system/ip/system_xlconcat_0_0/sim/system_xlconcat_0_0.v" \
-endlib
-makelib ies_lib/v_vid_in_axi4s_v4_0_7 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/f931/hdl/v_vid_in_axi4s_v4_0_vl_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/system/ip/system_v_vid_in_axi4s_0_0/sim/system_v_vid_in_axi4s_0_0.v" \
-endlib
-makelib ies_lib/xlconstant_v1_1_3 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/0750/hdl/xlconstant_v1_1_vl_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/system/ip/system_xlconstant_0_0/sim/system_xlconstant_0_0.v" \
-endlib
-makelib ies_lib/axi_lite_ipif_v3_0_4 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/cced/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/v_tc_v6_1_12 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/6694/hdl/v_tc_v6_1_vh_rfs.vhd" \
-endlib
-makelib ies_lib/v_axi4s_vid_out_v4_0_8 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/fc47/hdl/v_axi4s_vid_out_v4_0_vl_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/system/ip/system_v_axi4s_vid_out_0_0/sim/system_v_axi4s_vid_out_0_0.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/system/ip/system_v_tc_0_0/sim/system_v_tc_0_0.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/system/ip/system_clk_wiz_0_0/system_clk_wiz_0_0_clk_wiz.v" \
  "../../../bd/system/ip/system_clk_wiz_0_0/system_clk_wiz_0_0.v" \
-endlib
-makelib ies_lib/interrupt_control_v3_1_4 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/8e66/hdl/interrupt_control_v3_1_vh_rfs.vhd" \
-endlib
-makelib ies_lib/axi_gpio_v2_0_17 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/c450/hdl/axi_gpio_v2_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/system/ip/system_axi_gpio_0_0/sim/system_axi_gpio_0_0.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/3d58/IPSRC/cmos_decode_v1.v" \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/3d58/IPSRC/count_reset_v1.v" \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/3d58/IPSRC/OV_Sensor_ML.v" \
  "../../../bd/system/ip/system_OV_Sensor_ML_0_2/sim/system_OV_Sensor_ML_0_2.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/d277/IPSRC/TMDSEncoder.vhd" \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/d277/IPSRC/SerializerN_1.vhd" \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/d277/IPSRC/DVITransmitter.vhd" \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/d277/IPSRC/hdmi_tx.vhd" \
  "../../../bd/system/ip/system_HDMI_FPGA_ML_0_0/sim/system_HDMI_FPGA_ML_0_0.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/system/ip/system_image_process_0_0/src/fifo_block_av_gen/sim/fifo_block_av_gen.v" \
-endlib
-makelib ies_lib/xbip_utils_v3_0_8 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ip/system_image_process_0_0/src/line_shift_register_1/hdl/xbip_utils_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/c_reg_fd_v12_0_4 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ip/system_image_process_0_0/src/line_shift_register_1/hdl/c_reg_fd_v12_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/c_mux_bit_v12_0_4 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ip/system_image_process_0_0/src/line_shift_register_1/hdl/c_mux_bit_v12_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/c_shift_ram_v12_0_11 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ip/system_image_process_0_0/src/line_shift_register_1/hdl/c_shift_ram_v12_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/system/ip/system_image_process_0_0/src/line_shift_register_1/sim/line_shift_register.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/system/ip/system_image_process_0_0/src/fifo_backframe/sim/fifo_backframe.v" \
  "../../../bd/system/ip/system_image_process_0_0/src/fifo_1/sim/fifo.v" \
  "../../../bd/system/ipshared/144d/src/gray_shift.v" \
  "../../../bd/system/ipshared/144d/src/u_2_2_matrix.v" \
  "../../../bd/system/ipshared/144d/src/u_average_value.v" \
  "../../../bd/system/ipshared/144d/src/u_block_value_generator.v" \
  "../../../bd/system/ipshared/144d/src/u_3_3_matrix.v" \
  "../../../bd/system/ipshared/144d/src/u_media_value.v" \
  "../../../bd/system/ipshared/144d/src/u_sort.v" \
  "../../../bd/system/ipshared/144d/hdl/image_process_v1_0.v" \
  "../../../bd/system/ip/system_image_process_0_0/sim/system_image_process_0_0.v" \
-endlib
-makelib ies_lib/generic_baseblocks_v2_1_0 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/axi_register_slice_v2_1_15 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/3ed1/hdl/axi_register_slice_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/axi_data_fifo_v2_1_14 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/9909/hdl/axi_data_fifo_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/axi_crossbar_v2_1_16 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/c631/hdl/axi_crossbar_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/system/ip/system_xbar_0/sim/system_xbar_0.v" \
  "../../../bd/system/ip/system_xbar_1/sim/system_xbar_1.v" \
  "../../../bd/system/sim/system.v" \
-endlib
-makelib ies_lib/axi_protocol_converter_v2_1_15 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ff69/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/system/ip/system_auto_pc_1/sim/system_auto_pc_1.v" \
  "../../../bd/system/ip/system_auto_pc_0/sim/system_auto_pc_0.v" \
-endlib
-makelib ies_lib/axi_clock_converter_v2_1_14 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/445f/hdl/axi_clock_converter_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/blk_mem_gen_v8_4_1 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/67d8/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib ies_lib/axi_dwidth_converter_v2_1_15 \
  "../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1cdc/hdl/axi_dwidth_converter_v2_1_vl_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/system/ip/system_auto_us_1/sim/system_auto_us_1.v" \
  "../../../bd/system/ip/system_auto_us_0/sim/system_auto_us_0.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

