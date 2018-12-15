module u_3_3_matrix
(
	input clk,
	input rst,
	input ce,
	input [7:0] data_line_0,data_line_1,data_line_2,
	output reg [7:0] data11,data12,data13,data21,data22,data23,data31,data32,data33
);

always @(posedge clk)
begin
	if(!rst)
		begin
			data11<=0;
			data12<=0;
			data13<=0;
			data21<=0;
			data22<=0;
			data23<=0;
			data31<=0;
			data32<=0;
			data33<=0;
		end
	else if(ce)
		begin
			data11<=data_line_0;
			data12<=data_line_1;
			data13<=data_line_2;
			data21<=data11;
			data22<=data12;
			data23<=data13;
			data31<=data21;
			data32<=data22;
			data33<=data23;		
		end
	else
		begin
			data11<=data11;
			data12<=data12;
			data13<=data13;
			data21<=data21;
			data22<=data22;
			data23<=data23;
			data31<=data31;
			data32<=data32;
			data33<=data33;		
		end
end


endmodule