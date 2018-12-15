module gray_shift
(
	input clk,
	input rst,
	input ce,
	input [23:0] rgb,
	output [7:0] gray
);

wire [7:0] red;
wire [7:0] green;
wire [7:0] blue;

reg [15:0] gray_r,gray_g,gray_b;
reg [7:0] gray;
wire [15:0] gray_w;

assign red = rgb[23:16];
assign green = rgb[15:8];
assign blue = rgb[7:0];

assign gray_w = gray_r + gray_g + gray_b;

always@(posedge clk)
begin
    if(!rst)
		begin
			gray_r <= 0;
			gray_g <= 0;
			gray_b <= 0;
		end
    else if(ce)
		begin
			gray_r <= (red <<6) + (red <<3) + (red <<2) + red     ;
			gray_g <= (green<<7) + (green<<4) + (green<<2) + green;
			gray_b <= (blue <<4) + (blue <<3) + (blue <<2) + 1'b1 ;
		end
	
	else
		begin
			gray_r <= gray_r;
			gray_g <= gray_g;
			gray_b <= gray_b;
		end
end

always@(posedge clk)
begin
    if(!rst)
        gray <= 0;
    else if(ce)
		gray <= gray_w[15:8];
	else
		gray <= gray;
end

endmodule