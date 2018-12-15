module u_2_2_matrix
(
	input clk,
	input rst,
	input ce,
	input [7:0] data_line_0,data_line_1,
	output reg [7:0] data11,data12,data21,data22
);

always @(posedge clk)
begin
	if(!rst)
		begin
			data11<=0;
			data12<=0;
			data21<=0;
			data22<=0;
		end
	else if(ce)
		begin
			data11<=data_line_0;
			data12<=data_line_1;
			data21<=data11;
			data22<=data12;
		end
	else
		begin
			data11<=data11;
			data12<=data12;
			data21<=data21;
			data22<=data22;
		end
end


endmodule