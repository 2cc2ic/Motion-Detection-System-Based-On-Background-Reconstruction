connect -url tcp:127.0.0.1:3121
source D:/360Downloads/project/prj_move/S03_CH03_AXI_DMA_OV7725_HDMI/Miz_sys/Miz_sys.sdk/system_wrapper_hw_platform_0/ps7_init.tcl
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent JTAG-HS1 210249854657"} -index 0
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent JTAG-HS1 210249854657" && level==0} -index 1
fpga -file D:/360Downloads/project/prj_move/S03_CH03_AXI_DMA_OV7725_HDMI/Miz_sys/Miz_sys.sdk/system_wrapper_hw_platform_0/system_wrapper.bit
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent JTAG-HS1 210249854657"} -index 0
loadhw -hw D:/360Downloads/project/prj_move/S03_CH03_AXI_DMA_OV7725_HDMI/Miz_sys/Miz_sys.sdk/system_wrapper_hw_platform_0/system.hdf -mem-ranges [list {0x40000000 0xbfffffff}]
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent JTAG-HS1 210249854657"} -index 0
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent JTAG-HS1 210249854657"} -index 0
dow D:/360Downloads/project/prj_move/S03_CH03_AXI_DMA_OV7725_HDMI/Miz_sys/Miz_sys.sdk/dma/Debug/dma.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent JTAG-HS1 210249854657"} -index 0
con
