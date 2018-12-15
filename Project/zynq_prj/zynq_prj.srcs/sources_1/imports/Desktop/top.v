
`timescale 1 ps / 1 ps

module top
   (DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    cmos_data_i,
    cmos_href_i,
    cmos_pclk_i,
    cmos_vsync_i,
    cmos_xclk_o,
    
    iic_0_scl_io,
    iic_0_sda_io,
    
    HDMI_CLK_N,
    HDMI_CLK_P,
    HDMI_D0_N,
    HDMI_D0_P,
    HDMI_D1_N,
    HDMI_D1_P,
    HDMI_D2_N,
    HDMI_D2_P
    );
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  input [7:0]cmos_data_i;
  input cmos_href_i;
  input cmos_pclk_i;
  input cmos_vsync_i;
  output cmos_xclk_o;
  
  inout iic_0_scl_io;
  inout iic_0_sda_io;

  output HDMI_CLK_N;
  output HDMI_CLK_P;
  output HDMI_D0_N;
  output HDMI_D0_P;
  output HDMI_D1_N;
  output HDMI_D1_P;
  output HDMI_D2_N;
  output HDMI_D2_P;

  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FCLK_CLK0;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire [7:0]cmos_data_i;
  wire cmos_href_i;
  wire cmos_pclk_i;
  wire cmos_vsync_i;
  wire cmos_xclk_o;
  wire [0:0]gpio_0_tri_i_0;
  wire [1:1]gpio_0_tri_i_1;
  wire [0:0]gpio_0_tri_io_0;
  wire [1:1]gpio_0_tri_io_1;
  wire [0:0]gpio_0_tri_o_0;
  wire [1:1]gpio_0_tri_o_1;
  wire [0:0]gpio_0_tri_t_0;
  wire [1:1]gpio_0_tri_t_1;
  wire [0:0]gpio_rtl_tri_i_0;
  wire [0:0]gpio_rtl_tri_io_0;
  wire [0:0]gpio_rtl_tri_o_0;
  wire [0:0]gpio_rtl_tri_t_0;
  wire m_axis_mm2s_tvalid;
  wire m_axis_video_tlast;
  wire m_axis_video_tvalid;
  wire s_axis_s2mm_tlast;
  wire s_axis_s2mm_tready;
  wire s_axis_video_tlast;
  wire s_axis_video_tready;
  wire s_axis_video_tuser;
  wire vid_io_rst_i;

wire pclk_i;
BUFG buf_pclk_i
(
.O(pclk_i),
.I(cmos_pclk_i)
);

reg [10:0] vid_out_v_cnt;
reg [10:0] vid_out_h_cnt;

reg [10:0] vid_in_v_cnt;

parameter VID_OUT_HS = 11'd639;
parameter VID_OUT_VS = 11'd479;

parameter VID_IN_VS = 11'd479;

always@(posedge FCLK_CLK0)
	begin
	   if(!gpio_rtl_tri_o_0)
	     vid_out_v_cnt <= 11'd0; 
	   else
	      if(m_axis_mm2s_tvalid & s_axis_video_tready & (vid_out_h_cnt == VID_OUT_HS))
		     if(vid_out_v_cnt != VID_OUT_VS)
		        vid_out_v_cnt <= vid_out_v_cnt + 1'b1;
			 else 
			    vid_out_v_cnt <= 11'd0;
		  else 
		     vid_out_v_cnt <= vid_out_v_cnt;
	end
	
always@(posedge FCLK_CLK0)
	begin
	   if(!gpio_rtl_tri_o_0)
	     vid_out_h_cnt <= 11'd0; 
	   else
	      if(m_axis_mm2s_tvalid & s_axis_video_tready)	    
		     if(vid_out_h_cnt != VID_OUT_HS)
		        vid_out_h_cnt <= vid_out_h_cnt + 1'b1;
			 else 
			    vid_out_h_cnt <= 11'd0;
		  else 
		     vid_out_h_cnt <= vid_out_h_cnt;
	end

always@(posedge FCLK_CLK0)
	begin
	   if(!gpio_rtl_tri_o_0)
	     vid_in_v_cnt <= 11'd0; 
	   else
	      if(m_axis_video_tvalid & s_axis_s2mm_tready & m_axis_video_tlast)	    
		     if(vid_in_v_cnt != VID_IN_VS)
		        vid_in_v_cnt <= vid_in_v_cnt + 1'b1;
			 else 
			    vid_in_v_cnt <= 11'd0;
		  else 
		        vid_in_v_cnt <= vid_in_v_cnt;
	end

assign s_axis_video_tuser = m_axis_mm2s_tvalid & s_axis_video_tready & (vid_out_h_cnt == 11'd0) & (vid_out_v_cnt == 11'd0);	//vid out user
assign s_axis_video_tlast = m_axis_mm2s_tvalid & s_axis_video_tready & (vid_out_h_cnt == VID_OUT_HS);//vid out last signal

assign s_axis_s2mm_tlast = m_axis_video_tvalid & s_axis_s2mm_tready & m_axis_video_tlast &(vid_in_v_cnt == VID_IN_VS);// dma in last signal


  IOBUF iic_0_scl_iobuf
       (.I(iic_0_scl_o),
        .IO(iic_0_scl_io),
        .O(iic_0_scl_i),
        .T(iic_0_scl_t));
  IOBUF iic_0_sda_iobuf
       (.I(iic_0_sda_o),
        .IO(iic_0_sda_io),
        .O(iic_0_sda_i),
        .T(iic_0_sda_t));
  system system_i
       (.DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FCLK_CLK0(FCLK_CLK0),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .IIC_0_scl_i(iic_0_scl_i),
        .IIC_0_scl_o(iic_0_scl_o),
        .IIC_0_scl_t(iic_0_scl_t),
        .IIC_0_sda_i(iic_0_sda_i),
        .IIC_0_sda_o(iic_0_sda_o),
        .IIC_0_sda_t(iic_0_sda_t),
        .cmos_data_i(cmos_data_i),
        .cmos_href_i(cmos_href_i),
        .cmos_pclk_i(pclk_i),
        .cmos_vsync_i(cmos_vsync_i),
        .cmos_xclk_o(cmos_xclk_o),
        .gpio_rtl_tri_i(gpio_rtl_tri_i_0),
        .gpio_rtl_tri_o(gpio_rtl_tri_o_0),
        .gpio_rtl_tri_t(gpio_rtl_tri_t_0),
        .m_axis_mm2s_tvalid(m_axis_mm2s_tvalid),
        .m_axis_video_tlast(m_axis_video_tlast),
        .m_axis_video_tvalid(m_axis_video_tvalid),
        .s_axis_s2mm_tlast(s_axis_s2mm_tlast),
        .s_axis_s2mm_tready(s_axis_s2mm_tready),
        .s_axis_video_tlast(s_axis_video_tlast),
        .s_axis_video_tready(s_axis_video_tready),
        .s_axis_video_tuser(s_axis_video_tuser),
        .vid_io_rst_i(~gpio_rtl_tri_o_0),
        
        .HDMI_CLK_N(HDMI_CLK_N),
        .HDMI_CLK_P(HDMI_CLK_P),
        .HDMI_D0_N(HDMI_D0_N),
        .HDMI_D0_P(HDMI_D0_P),
        .HDMI_D1_N(HDMI_D1_N),
        .HDMI_D1_P(HDMI_D1_P),
        .HDMI_D2_N(HDMI_D2_N),
        .HDMI_D2_P(HDMI_D2_P)
        );
endmodule

