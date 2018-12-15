set_property IOSTANDARD TMDS_33 [get_ports HDMI_CLK_P]
set_property IOSTANDARD TMDS_33 [get_ports HDMI_D0_P]
set_property IOSTANDARD TMDS_33 [get_ports HDMI_D1_P]
set_property IOSTANDARD TMDS_33 [get_ports HDMI_D2_P]

set_property PACKAGE_PIN L16 [get_ports HDMI_CLK_P]
set_property PACKAGE_PIN K17 [get_ports HDMI_D0_P]
set_property PACKAGE_PIN K19 [get_ports HDMI_D1_P]
set_property PACKAGE_PIN J18 [get_ports HDMI_D2_P]

set_property PACKAGE_PIN V10 [get_ports iic_0_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports iic_0_scl_io]
set_property PULLUP true [get_ports iic_0_scl_io]

set_property PACKAGE_PIN W10 [get_ports iic_0_sda_io]
set_property IOSTANDARD LVCMOS33 [get_ports iic_0_sda_io]
set_property PULLUP true [get_ports iic_0_sda_io]

set_property -dict {PACKAGE_PIN W18 IOSTANDARD LVCMOS33} [get_ports {cmos_data_i[0]}]
set_property -dict {PACKAGE_PIN V6 IOSTANDARD LVCMOS33} [get_ports {cmos_data_i[1]}]
set_property -dict {PACKAGE_PIN W19 IOSTANDARD LVCMOS33} [get_ports {cmos_data_i[2]}]
set_property -dict {PACKAGE_PIN Y6 IOSTANDARD LVCMOS33} [get_ports {cmos_data_i[3]}]
set_property -dict {PACKAGE_PIN Y18 IOSTANDARD LVCMOS33} [get_ports {cmos_data_i[4]}]
set_property -dict {PACKAGE_PIN C20 IOSTANDARD LVCMOS33} [get_ports {cmos_data_i[5]}]
set_property -dict {PACKAGE_PIN U7 IOSTANDARD LVCMOS33} [get_ports {cmos_data_i[6]}]
set_property -dict {PACKAGE_PIN W6 IOSTANDARD LVCMOS33} [get_ports {cmos_data_i[7]}]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets cmos_pclk_i_IBUF]

set_property -dict {PACKAGE_PIN V8 IOSTANDARD LVCMOS33} [get_ports cmos_xclk_o]
set_property -dict {PACKAGE_PIN Y7 IOSTANDARD LVCMOS33} [get_ports cmos_pclk_i]

set_property -dict {PACKAGE_PIN F20 IOSTANDARD LVCMOS33} [get_ports cmos_vsync_i]
set_property -dict {PACKAGE_PIN U8 IOSTANDARD LVCMOS33} [get_ports cmos_href_i]
