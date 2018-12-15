`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: milinker corperation
// WEB:www.milinker.com
// BBS:www.osrc.cn
// Engineer:.
// Create Date:    07:28:50 09/04/2015 
// Design Name: 	 cmos_decode_v1
// Module Name:    cmos_decode_v1
// Project Name: 	 cmos_decode_v1
// Target Devices: XC6SLX25-FTG256 Mis603
// Tool versions:  ISE14.7
// Description: 	 cmos_decode_v1.
// Revision: 		 V1.0
// Additional Comments: 
//1) _i PIN input  
//2) _o PIN output
//3) _n PIN active low
//4) _dg debug signal 
//5) _r  reg delay
//6) _s state machine
//////////////////////////////////////////////////////////////////////////////
module cmos_decode_v1(
	//system signal.
	input cmos_clk_i,//cmos senseor clock.
	input rst_n_i,//system reset.active low.
	//cmos sensor hardware interface.
	input cmos_pclk_i,//input pixel clock.
	input cmos_href_i,//input pixel hs signal.
	input cmos_vsync_i,//input pixel vs signal.
	input[7:0]cmos_data_i,//data.
	output cmos_xclk_o,//output clock to cmos sensor.
	//user interface.
	output hs_o,//hs signal.
	output vs_o,//vs signal.
	output de_o,//data enable.
	output [15:0]rgb565_o,//data output
	output  clk_date_o
    );
parameter[5:0]CMOS_FRAME_WAITCNT = 4'd15;

reg[4:0] rst_n_reg = 5'd0;
//reset signal deal with.
always@(posedge cmos_clk_i)
begin
	rst_n_reg <= {rst_n_reg[3:0],rst_n_i};
end

reg[1:0]vsync_d;
reg[1:0]href_d;
wire vsync_start;
wire vsync_end;
//vs signal deal with.
always@(posedge cmos_pclk_i)
begin
	vsync_d <= {vsync_d[0],cmos_vsync_i};
	href_d  <= {href_d[0],cmos_href_i};
end

assign vsync_start =  vsync_d[1]&(!vsync_d[0]);
assign vsync_end   = (!vsync_d[1])&vsync_d[0];

reg[6:0]cmos_fps;
//frame count.
always@(posedge cmos_pclk_i)
begin
	if(!rst_n_reg[4])
		begin
		cmos_fps <= 7'd0;
		end
	else if(vsync_start)
		begin
		cmos_fps <= cmos_fps + 7'd1;
		end
	else if(cmos_fps >= CMOS_FRAME_WAITCNT)
		begin
		cmos_fps <= CMOS_FRAME_WAITCNT;
		end
end
//wait frames and output enable.
reg out_en;
always@(posedge cmos_pclk_i)
begin
	if(!rst_n_reg[4])
		begin
		out_en <= 1'b0;
		end
	else if(cmos_fps >= CMOS_FRAME_WAITCNT)
		begin
		out_en <= 1'b1;
		end
	else
		begin
		out_en <= out_en;
		end
end

//output data 8bit changed into 16bit in rgb565.
reg	[7:0] cmos_data_d0;
reg	[15:0]cmos_rgb565_d0;
reg	byte_flag;
always@(posedge cmos_pclk_i)
begin
	if(!rst_n_reg[4])
		begin
		cmos_data_d0 <= 8'd0;
		byte_flag <= 0;
		cmos_rgb565_d0 <= 16'd0;
		end
	else if(cmos_href_i)
		begin
		byte_flag <= ~byte_flag;
		cmos_data_d0 <= cmos_data_i;
		if(byte_flag == 1'b1)
			cmos_rgb565_d0 <= {cmos_data_d0, cmos_data_i};	//MSB -> LSB
		else
			cmos_rgb565_d0 <= cmos_rgb565_d0;
		end
	else
		begin
		cmos_data_d0 <= 8'd0;
		byte_flag <= 0;
		cmos_rgb565_d0 <= cmos_rgb565_d0;
		end
end

assign rgb565_o = (out_en & cmos_href_i) ? cmos_rgb565_d0 : 16'd0;

reg clk_date_o =0 ;
always@(posedge cmos_pclk_i)
    clk_date_o <= ~clk_date_o;

reg	byte_flag_r0;
reg byte_flag_r1;
always@(posedge cmos_pclk_i)
begin
	if(!rst_n_reg[4])
		begin
		byte_flag_r0 <= 0;
		byte_flag_r1 <= 0;
		end
	else
		byte_flag_r0 <= byte_flag;
		byte_flag_r1 <= byte_flag_r0;
end
assign	de_o = out_en ? (byte_flag_r1|byte_flag_r0) : 1'b0;
assign	vs_o = out_en ? vsync_d[1] : 1'b0;
assign	hs_o = out_en ? href_d[1] : 1'b0;

assign cmos_xclk_o = cmos_clk_i;	

endmodule
