`timescale 1 ns / 1 ps

module image_process_v1_0 #
(
	// Users to add parameters here
     
	// User parameters ends
	// Do not modify the parameters beyond this line


	// Parameters of Axi Master Bus Interface M00_AXIS
	parameter integer C_M00_AXIS_TDATA_WIDTH	= 32,
	parameter integer C_M00_AXIS_START_COUNT	= 32,

	// Parameters of Axi Slave Bus Interface S00_AXIS
	parameter integer C_S00_AXIS_TDATA_WIDTH	= 32
)
(
	// Users to add ports here
    
        
	// User ports ends
	// Do not modify the ports beyond this line


	// Ports of Axi Master Bus Interface M00_AXIS
	input wire  m00_axis_aclk,
	input wire  m00_axis_aresetn,
	output reg  m00_axis_tvalid,
	output wire [C_M00_AXIS_TDATA_WIDTH-1 : 0] m00_axis_tdata,
	output wire [(C_M00_AXIS_TDATA_WIDTH/8)-1 : 0] m00_axis_tstrb,
	output wire  m00_axis_tlast,
	input wire  m00_axis_tready,

	// Ports of Axi Slave Bus Interface S00_AXIS
	input wire  s00_axis_aclk,
	input wire  s00_axis_aresetn,
	output reg  s00_axis_tready,
	input wire [C_S00_AXIS_TDATA_WIDTH-1 : 0] s00_axis_tdata,
	input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1 : 0] s00_axis_tstrb,
	input wire  s00_axis_tlast,
	input wire  s00_axis_tvalid
);

wire ce;
	
wire [7:0] gray_r;
wire [7:0] gray_data0;
wire [7:0] gray_data1;
wire [7:0] gray_data2;	

wire rnext,wnext;

wire [7:0] data11,data12,data13,data21,data22,data23,data31,data32,data33;
wire [7:0] media_value;
wire [23:0] data_out;
wire signal_empty,signal_full,signal_almost_empty,signal_almost_full;

reg [9:0] cnt;

wire [9:0] average_value;
wire [7:0] av_din0,av_din1;
wire [7:0] av_11,av_12,av_21,av_22;
wire [23:0] threshold_data;

assign rnext = s00_axis_tready && s00_axis_tvalid;
assign wnext = m00_axis_tvalid && m00_axis_tready;
assign ce = rnext;
assign m00_axis_tdata = {8'd0, data_out};

always @(posedge m00_axis_aclk)
begin
	if(!m00_axis_aresetn)
		cnt<=0;
	else if(cnt==639 && wnext)
		cnt<=0;
	else if( (cnt!=639) && wnext)
		cnt<=cnt+1;
	else 
		cnt<=cnt;
end

assign m00_axis_tlast = wnext && (cnt==639);

always @(posedge m00_axis_aclk)
begin
	if(!m00_axis_aresetn)
		m00_axis_tvalid<=1'b0;
	else if(signal_empty)
		m00_axis_tvalid<=1'b0;
	else if( signal_almost_empty && wnext )
		m00_axis_tvalid<=1'b0;
	else if( (!signal_empty) && (!m00_axis_tvalid) && m00_axis_tready )
		m00_axis_tvalid<=1'b1;
	else 
		m00_axis_tvalid<=1'b1;
end

always @(posedge m00_axis_aclk)
begin
	if(!m00_axis_aresetn)
		s00_axis_tready<=1'b0;
	else if(signal_full)
		s00_axis_tready<=1'b0;
	else if( signal_almost_full && rnext )
		s00_axis_tready<=1'b0;
	else if( (!signal_full) && (!s00_axis_tready) && s00_axis_tvalid )
		s00_axis_tready<=1'b1;
	else 
		s00_axis_tready<=1'b1;
end

gray_shift unit_gray_shift 
(
.clk(m00_axis_aclk),
.rst(m00_axis_aresetn),
.ce(ce),
.rgb(s00_axis_tdata[23:0]),
.gray(gray_r)
);

line_shift_register unit_line_shift_register_0
(
.D(gray_r),
.CLK(m00_axis_aclk),
.CE(ce),
.Q(gray_data0)
);

line_shift_register unit_line_shift_register_1
(
.D(gray_data0),
.CLK(m00_axis_aclk),
.CE(ce),
.Q(gray_data1)
);

line_shift_register unit_line_shift_register_2
(
.D(gray_data1),
.CLK(m00_axis_aclk),
.CE(ce),
.Q(gray_data2)
);

u_3_3_matrix unit_3_3_matrix
(
.clk(m00_axis_aclk),
.rst(m00_axis_aresetn),
.ce(ce),
.data_line_0(gray_data0),
.data_line_1(gray_data1),
.data_line_2(gray_data2),
.data11(data11),
.data12(data12),
.data13(data13),
.data21(data21),
.data22(data22),
.data23(data23),
.data31(data31),
.data32(data32),
.data33(data33)
);

u_media_value unit_media_value
(
.clk(m00_axis_aclk),
.rst(m00_axis_aresetn),
.ce(ce),
.data11(data11),
.data12(data12),
.data13(data13),
.data21(data21),
.data22(data22),
.data23(data23),
.data31(data31),
.data32(data32),
.data33(data33),
.final_media_data(media_value)
);
reg fifo_wr_valid,av_valid;
reg [11:0] valid_cnt;

always @(posedge m00_axis_aclk)
begin
	if(!m00_axis_aresetn)
		valid_cnt<=0;
    else if(rnext)
        valid_cnt<=valid_cnt+1;
	else 
		valid_cnt<=valid_cnt;
end

always @(posedge m00_axis_aclk)
begin
	if(!m00_axis_aresetn)
		av_valid<=1'b0;
	else if(valid_cnt==2570)
		av_valid<=1'b1;
	else 
		av_valid<=av_valid;
end

always @(posedge m00_axis_aclk)
begin
	if(!m00_axis_aresetn)
		fifo_wr_valid<=1'b0;
	else if(valid_cnt==2575)
		fifo_wr_valid<=1'b1;
	else 
		fifo_wr_valid<=fifo_wr_valid;
end

line_shift_register unit_line_average_0
(
.D(media_value),
.CLK(m00_axis_aclk),
.CE(ce),
.Q(av_din0)
);

line_shift_register unit_line_average_1
(
.D(av_din0),
.CLK(m00_axis_aclk),
.CE(ce),
.Q(av_din1)
);

u_2_2_matrix unit_2_2_matrix
(
.clk(m00_axis_aclk),
.rst(m00_axis_aresetn),
.ce(ce),
.data_line_0(av_din0),
.data_line_1(av_din1),
.data11(av_11),
.data12(av_12),
.data21(av_21),
.data22(av_22)
);

u_average_value unit_average_value
(
.clk(m00_axis_aclk),
.rst(m00_axis_aresetn),
.ce(ce),
.data11(av_11),
.data12(av_12),
.data21(av_21),
.data22(av_22),
.average_value(average_value)
);


u_block_value_generator unit_block_value_generator_av
(
.clk(m00_axis_aclk),
.rst(m00_axis_aresetn),
.ce(ce && av_valid),
.average_value(average_value),
.gray_int(av_22),
.threshold_data(threshold_data)
);

fifo unit_fifo_0
(
.clk(m00_axis_aclk),
.srst(!m00_axis_aresetn),
.din(threshold_data), 
.wr_en(ce && fifo_wr_valid),
.rd_en(wnext),
.dout(data_out),
.full(signal_full),
.almost_full(signal_almost_full),
.empty(signal_empty),
.almost_empty(signal_almost_empty),
.data_count()
);
endmodule
