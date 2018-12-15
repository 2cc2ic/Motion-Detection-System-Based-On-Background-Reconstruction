`timescale 1 ns/ 1 ps

module tb_top;

parameter FAST_PERIOD =  40  ;//�?个时钟周�?

//产生时钟信号
reg Clock ;
initial
begin
Clock = 0;
forever  begin
         # (FAST_PERIOD/2) Clock = ~ Clock ;
         end
end

//产生复位信号
reg Rst_n ;
initial
begin
Rst_n = 1;
# FAST_PERIOD Rst_n = 0;
# FAST_PERIOD Rst_n = 1;
end


initial
begin
  
end

reg [31:0] din;

wire [31:0] dout;
wire out_valid,in_ready;
wire last;

always @(posedge Clock)
begin
	if(!Rst_n)
		din<=3000;
	else
		din<=din;
end

image_process_v1_0  #
(
.C_M00_AXIS_TDATA_WIDTH(32),
.C_M00_AXIS_START_COUNT(32),
.C_S00_AXIS_TDATA_WIDTH(32)
) unit_top (
.m00_axis_aclk(Clock),
.m00_axis_aresetn(Rst_n),
.m00_axis_tvalid(out_valid),
.m00_axis_tdata(dout),
.m00_axis_tstrb(),
.m00_axis_tlast(last),
.m00_axis_tready(1'b1),

.s00_axis_aclk(Clock),
.s00_axis_aresetn(Rst_n),
.s00_axis_tready(in_ready),
.s00_axis_tdata(din),
.s00_axis_tstrb(),
.s00_axis_tlast(),
.s00_axis_tvalid(1'b1)
);
endmodule
