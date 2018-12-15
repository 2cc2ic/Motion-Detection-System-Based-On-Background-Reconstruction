module u_average_value
(
	input clk,
	input rst,
	input ce,
	input [7:0] data11,data12,data21,data22,
	output reg [9:0] average_value
);

reg [8:0] av_buffer1,av_buffer2;

always @(posedge clk)
begin
	if(!rst)
		begin
		av_buffer1<=0;
		av_buffer2<=0;
		average_value<=0;
		end
	else if(ce)
		begin
		av_buffer1<=data11+data12;
		av_buffer2<=data21+data22;
		average_value<=av_buffer1+av_buffer2;
		end
	else
		begin
		av_buffer1<=av_buffer1;
		av_buffer2<=av_buffer2;
		average_value<=average_value;
		end
end 


endmodule