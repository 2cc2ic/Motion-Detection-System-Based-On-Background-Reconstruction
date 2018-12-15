vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/smartconnect_v1_0
vlib riviera/axi_protocol_checker_v2_0_1
vlib riviera/axi_vip_v1_1_1
vlib riviera/processing_system7_vip_v1_0_3
vlib riviera/lib_cdc_v1_0_2
vlib riviera/proc_sys_reset_v5_0_12
vlib riviera/lib_pkg_v1_0_2
vlib riviera/fifo_generator_v13_2_1
vlib riviera/lib_fifo_v1_0_10
vlib riviera/lib_srl_fifo_v1_0_2
vlib riviera/axi_datamover_v5_1_17
vlib riviera/axi_sg_v4_1_8
vlib riviera/axi_dma_v7_1_16
vlib riviera/xlconcat_v2_1_1
vlib riviera/v_vid_in_axi4s_v4_0_7
vlib riviera/xlconstant_v1_1_3
vlib riviera/axi_lite_ipif_v3_0_4
vlib riviera/v_tc_v6_1_12
vlib riviera/v_axi4s_vid_out_v4_0_8
vlib riviera/interrupt_control_v3_1_4
vlib riviera/axi_gpio_v2_0_17
vlib riviera/xbip_utils_v3_0_8
vlib riviera/c_reg_fd_v12_0_4
vlib riviera/c_mux_bit_v12_0_4
vlib riviera/c_shift_ram_v12_0_11
vlib riviera/generic_baseblocks_v2_1_0
vlib riviera/axi_register_slice_v2_1_15
vlib riviera/axi_data_fifo_v2_1_14
vlib riviera/axi_crossbar_v2_1_16
vlib riviera/axi_protocol_converter_v2_1_15
vlib riviera/axi_clock_converter_v2_1_14
vlib riviera/blk_mem_gen_v8_4_1
vlib riviera/axi_dwidth_converter_v2_1_15

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap smartconnect_v1_0 riviera/smartconnect_v1_0
vmap axi_protocol_checker_v2_0_1 riviera/axi_protocol_checker_v2_0_1
vmap axi_vip_v1_1_1 riviera/axi_vip_v1_1_1
vmap processing_system7_vip_v1_0_3 riviera/processing_system7_vip_v1_0_3
vmap lib_cdc_v1_0_2 riviera/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_12 riviera/proc_sys_reset_v5_0_12
vmap lib_pkg_v1_0_2 riviera/lib_pkg_v1_0_2
vmap fifo_generator_v13_2_1 riviera/fifo_generator_v13_2_1
vmap lib_fifo_v1_0_10 riviera/lib_fifo_v1_0_10
vmap lib_srl_fifo_v1_0_2 riviera/lib_srl_fifo_v1_0_2
vmap axi_datamover_v5_1_17 riviera/axi_datamover_v5_1_17
vmap axi_sg_v4_1_8 riviera/axi_sg_v4_1_8
vmap axi_dma_v7_1_16 riviera/axi_dma_v7_1_16
vmap xlconcat_v2_1_1 riviera/xlconcat_v2_1_1
vmap v_vid_in_axi4s_v4_0_7 riviera/v_vid_in_axi4s_v4_0_7
vmap xlconstant_v1_1_3 riviera/xlconstant_v1_1_3
vmap axi_lite_ipif_v3_0_4 riviera/axi_lite_ipif_v3_0_4
vmap v_tc_v6_1_12 riviera/v_tc_v6_1_12
vmap v_axi4s_vid_out_v4_0_8 riviera/v_axi4s_vid_out_v4_0_8
vmap interrupt_control_v3_1_4 riviera/interrupt_control_v3_1_4
vmap axi_gpio_v2_0_17 riviera/axi_gpio_v2_0_17
vmap xbip_utils_v3_0_8 riviera/xbip_utils_v3_0_8
vmap c_reg_fd_v12_0_4 riviera/c_reg_fd_v12_0_4
vmap c_mux_bit_v12_0_4 riviera/c_mux_bit_v12_0_4
vmap c_shift_ram_v12_0_11 riviera/c_shift_ram_v12_0_11
vmap generic_baseblocks_v2_1_0 riviera/generic_baseblocks_v2_1_0
vmap axi_register_slice_v2_1_15 riviera/axi_register_slice_v2_1_15
vmap axi_data_fifo_v2_1_14 riviera/axi_data_fifo_v2_1_14
vmap axi_crossbar_v2_1_16 riviera/axi_crossbar_v2_1_16
vmap axi_protocol_converter_v2_1_15 riviera/axi_protocol_converter_v2_1_15
vmap axi_clock_converter_v2_1_14 riviera/axi_clock_converter_v2_1_14
vmap blk_mem_gen_v8_4_1 riviera/blk_mem_gen_v8_4_1
vmap axi_dwidth_converter_v2_1_15 riviera/axi_dwidth_converter_v2_1_15

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"D:/xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/xilinx/Vivado/2017.4/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"D:/xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"D:/xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work smartconnect_v1_0  -sv2k12 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/sc_util_v1_0_vl_rfs.sv" \

vlog -work axi_protocol_checker_v2_0_1  -sv2k12 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/3b24/hdl/axi_protocol_checker_v2_0_vl_rfs.sv" \

vlog -work axi_vip_v1_1_1  -sv2k12 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/a16a/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_3  -sv2k12 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../bd/system/ip/system_processing_system7_0_0/sim/system_processing_system7_0_0.v" \

vcom -work lib_cdc_v1_0_2 -93 \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_12 -93 \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/f86a/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/system/ip/system_rst_processing_system7_0_50M_0/sim/system_rst_processing_system7_0_50M_0.vhd" \

vcom -work lib_pkg_v1_0_2 -93 \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/0513/hdl/lib_pkg_v1_0_rfs.vhd" \

vlog -work fifo_generator_v13_2_1  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/5c35/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_1 -93 \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/5c35/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_1  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/5c35/hdl/fifo_generator_v13_2_rfs.v" \

vcom -work lib_fifo_v1_0_10 -93 \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/f10a/hdl/lib_fifo_v1_0_rfs.vhd" \

vcom -work lib_srl_fifo_v1_0_2 -93 \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/51ce/hdl/lib_srl_fifo_v1_0_rfs.vhd" \

vcom -work axi_datamover_v5_1_17 -93 \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/71f3/hdl/axi_datamover_v5_1_vh_rfs.vhd" \

vcom -work axi_sg_v4_1_8 -93 \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/5f94/hdl/axi_sg_v4_1_rfs.vhd" \

vcom -work axi_dma_v7_1_16 -93 \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/bf8c/hdl/axi_dma_v7_1_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/system/ip/system_axi_dma_0_0/sim/system_axi_dma_0_0.vhd" \

vlog -work xlconcat_v2_1_1  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/2f66/hdl/xlconcat_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../bd/system/ip/system_xlconcat_0_0/sim/system_xlconcat_0_0.v" \

vlog -work v_vid_in_axi4s_v4_0_7  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/f931/hdl/v_vid_in_axi4s_v4_0_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../bd/system/ip/system_v_vid_in_axi4s_0_0/sim/system_v_vid_in_axi4s_0_0.v" \

vlog -work xlconstant_v1_1_3  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/0750/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../bd/system/ip/system_xlconstant_0_0/sim/system_xlconstant_0_0.v" \

vcom -work axi_lite_ipif_v3_0_4 -93 \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/cced/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work v_tc_v6_1_12 -93 \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/6694/hdl/v_tc_v6_1_vh_rfs.vhd" \

vlog -work v_axi4s_vid_out_v4_0_8  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/fc47/hdl/v_axi4s_vid_out_v4_0_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../bd/system/ip/system_v_axi4s_vid_out_0_0/sim/system_v_axi4s_vid_out_0_0.v" \

vcom -work xil_defaultlib -93 \
"../../../bd/system/ip/system_v_tc_0_0/sim/system_v_tc_0_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../bd/system/ip/system_clk_wiz_0_0/system_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/system/ip/system_clk_wiz_0_0/system_clk_wiz_0_0.v" \

vcom -work interrupt_control_v3_1_4 -93 \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/8e66/hdl/interrupt_control_v3_1_vh_rfs.vhd" \

vcom -work axi_gpio_v2_0_17 -93 \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/c450/hdl/axi_gpio_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/system/ip/system_axi_gpio_0_0/sim/system_axi_gpio_0_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/3d58/IPSRC/cmos_decode_v1.v" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/3d58/IPSRC/count_reset_v1.v" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/3d58/IPSRC/OV_Sensor_ML.v" \
"../../../bd/system/ip/system_OV_Sensor_ML_0_2/sim/system_OV_Sensor_ML_0_2.v" \

vcom -work xil_defaultlib -93 \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/d277/IPSRC/TMDSEncoder.vhd" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/d277/IPSRC/SerializerN_1.vhd" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/d277/IPSRC/DVITransmitter.vhd" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/d277/IPSRC/hdmi_tx.vhd" \
"../../../bd/system/ip/system_HDMI_FPGA_ML_0_0/sim/system_HDMI_FPGA_ML_0_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../bd/system/ip/system_image_process_0_0/src/fifo_block_av_gen/sim/fifo_block_av_gen.v" \

vcom -work xbip_utils_v3_0_8 -93 \
"../../../../zynq_prj.srcs/sources_1/bd/system/ip/system_image_process_0_0/src/line_shift_register_1/hdl/xbip_utils_v3_0_vh_rfs.vhd" \

vcom -work c_reg_fd_v12_0_4 -93 \
"../../../../zynq_prj.srcs/sources_1/bd/system/ip/system_image_process_0_0/src/line_shift_register_1/hdl/c_reg_fd_v12_0_vh_rfs.vhd" \

vcom -work c_mux_bit_v12_0_4 -93 \
"../../../../zynq_prj.srcs/sources_1/bd/system/ip/system_image_process_0_0/src/line_shift_register_1/hdl/c_mux_bit_v12_0_vh_rfs.vhd" \

vcom -work c_shift_ram_v12_0_11 -93 \
"../../../../zynq_prj.srcs/sources_1/bd/system/ip/system_image_process_0_0/src/line_shift_register_1/hdl/c_shift_ram_v12_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/system/ip/system_image_process_0_0/src/line_shift_register_1/sim/line_shift_register.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
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

vlog -work generic_baseblocks_v2_1_0  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_15  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/3ed1/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work axi_data_fifo_v2_1_14  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/9909/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_16  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/c631/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../bd/system/ip/system_xbar_0/sim/system_xbar_0.v" \
"../../../bd/system/ip/system_xbar_1/sim/system_xbar_1.v" \
"../../../bd/system/sim/system.v" \

vlog -work axi_protocol_converter_v2_1_15  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ff69/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../bd/system/ip/system_auto_pc_1/sim/system_auto_pc_1.v" \
"../../../bd/system/ip/system_auto_pc_0/sim/system_auto_pc_0.v" \

vlog -work axi_clock_converter_v2_1_14  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/445f/hdl/axi_clock_converter_v2_1_vl_rfs.v" \

vlog -work blk_mem_gen_v8_4_1  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/67d8/simulation/blk_mem_gen_v8_4.v" \

vlog -work axi_dwidth_converter_v2_1_15  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1cdc/hdl/axi_dwidth_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/ec67/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/02c8/hdl/verilog" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/1313/hdl" "+incdir+../../../../zynq_prj.srcs/sources_1/bd/system/ipshared/4868" "+incdir+D:/xilinx/Vivado/2017.4/data/xilinx_vip/include" \
"../../../bd/system/ip/system_auto_us_1/sim/system_auto_us_1.v" \
"../../../bd/system/ip/system_auto_us_0/sim/system_auto_us_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

