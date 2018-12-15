module u_block_value_generator
(
	input clk,
	input rst,
	input ce,
	input [9:0] average_value,
	input [7:0] gray_int,
	output reg [23:0] threshold_data
);

reg [9:0] x1_ns,x2_ns;
reg [8:0] y1_ns,y2_ns;
reg [9:0] x1_cs,x2_cs;
reg [8:0] y1_cs,y2_cs;

reg [9:0] cnt_x;
reg [8:0] cnt_y;

reg [10:0] cnt;
reg [16:0] bf_cnt;

reg [9:0] value_generated,bf_generated;

reg wr;
wire rd;
wire [9:0] fifo_gen,fifo_gen_bf;

reg backframe_rd_valid;
wire [9:0] back_pixel;
reg [9:0] sub_data1,sub_data2;
reg [9:0] abs_data;

reg [7:0] gray_bf_0,gray_bf_1,gray_bf_2;

assign rd = (cnt>=640) && ce;

always @(posedge clk)
begin
    if(!rst)
        wr<=0;
    else 
        wr<=(cnt<640) && ce;
end

always @(posedge clk)
begin
	if(!rst)
		cnt<=0;
	else if( ce && (cnt==1279) )
		cnt<=0;
	else if( ce && (cnt!=1279) )
		cnt<=cnt+1;
	else
	   cnt<=cnt;
end

always @(posedge clk)
begin
	if(!rst)
		bf_cnt<=0;
	else if( (cnt[0]==0) && (cnt<640) && ce && (bf_cnt==76799) )
		bf_cnt<=76800;
	else if( (cnt[0]==0) && (cnt<640) && ce && (bf_cnt<76799) )
		bf_cnt<=bf_cnt+1;
	else
	    bf_cnt<=bf_cnt;
end

always @(posedge clk)
begin
    if(!rst)
        backframe_rd_valid<=0;
    else if( ce && (bf_cnt==76799) )
        backframe_rd_valid<=1;
    else
        backframe_rd_valid<=backframe_rd_valid;
end

fifo_block_av_gen unit_fifo_block_av_gen
(
.clk(clk),
.srst(!rst),
.din(value_generated),
.wr_en(wr),
.rd_en(rd),
.dout(fifo_gen),
.data_count()
);

fifo_block_av_gen unit_fifo_block_bf_gen
(
.clk(clk),
.srst(!rst),
.din(bf_generated),
.wr_en(wr),
.rd_en(rd),
.dout(fifo_gen_bf),
.data_count()
);

fifo_backframe unit_fifo_backframe
(
.clk(clk),
.srst(!rst),
.din(average_value), 
.wr_en( (cnt[0]==0) && (cnt<640) && ce),
.rd_en( (cnt[0]==0) && (cnt<640) && ce && backframe_rd_valid),
.dout(back_pixel),
.data_count()
);

always @(posedge clk)
begin
	if(!rst)
		value_generated<=0;
	else if( (cnt[0]==0) && (cnt<640) && ce ) 
		value_generated<=average_value;
	else if( (cnt[0]==1) && (cnt<640) && ce )
		value_generated<=value_generated;
	else if( (cnt>=640) && ce )
		value_generated<=fifo_gen;	
	else
		value_generated<=value_generated;
end

always @(posedge clk)
begin
    if(!rst)
        gray_bf_0<=0;
    else if(ce)
        gray_bf_0<=gray_int;
    else
        gray_bf_0<=gray_bf_0;
end

always @(posedge clk)
begin
	if(!rst)
		bf_generated<=0;
	else if( (cnt[0]==0) && (cnt<640) && ce ) 
		bf_generated<=back_pixel;
	else if( (cnt[0]==1) && (cnt<640) && ce )
		bf_generated<=bf_generated;
	else if( (cnt>=640) && ce )
		bf_generated<=fifo_gen_bf;	
	else
		bf_generated<=bf_generated;
end

always @(posedge clk)
begin
    if(!rst)
        begin
            sub_data1<=0;
            sub_data2<=0;
        end
    else if(ce)
        begin
            sub_data1<=value_generated;
            sub_data2<=bf_generated;
        end
    else
        begin
            sub_data1<=sub_data1;
            sub_data2<=sub_data2;
        end
end

always @(posedge clk)
begin
    if(!rst)
        gray_bf_1<=0;
    else if(ce)
        gray_bf_1<=gray_bf_0;
    else
        gray_bf_1<=gray_bf_1;
end

always @(posedge clk)
begin
    if(!rst)
        abs_data<=0;
    else if(ce)
        begin
            if(sub_data1>sub_data2)
                abs_data<=sub_data1-sub_data2;
            else
                abs_data<=sub_data2-sub_data1;
        end
    else
        abs_data<=abs_data;
end

always @(posedge clk)
begin
    if(!rst)
        gray_bf_2<=0;
    else if(ce)
        gray_bf_2<=gray_bf_1;
    else
        gray_bf_2<=gray_bf_2;
end

reg [7:0] gray_buffer;
wire gray_1bit_end;

assign gray_1bit_end = (sub_data1[2] || sub_data1[1]);

always @(posedge clk)
begin
    if(!rst)
        gray_buffer<=0;
    else if(ce)
        gray_buffer<={sub_data1[9:3],gray_1bit_end};
    else
        gray_buffer<=gray_buffer;
end


reg ce_buf;
reg ce_0,ce_1;

always @(posedge clk)
begin
    if(!rst)
        begin
        ce_0<=0;
        ce_1<=0;
        ce_buf<=0;
        end
    else
        begin
        ce_0<=ce;
        ce_1<=ce_0;
        ce_buf<=ce_1;
        end
end

always  @(posedge clk)
begin
    if(!rst)
        cnt_x<=0;
    else if(cnt_x<639 && ce_buf)
        cnt_x<=cnt_x+1;
    else if(cnt_x==639 && ce_buf)
        cnt_x<=0;
    else
        cnt_x<=cnt_x;
end

always  @(posedge clk)
begin
    if(!rst)
        cnt_y<=0;
    else if(cnt_y<479 && ce_buf && cnt_x==639)
        cnt_y<=cnt_y+1;
    else if(cnt_y==479 && ce_buf && cnt_x==639)
        cnt_y<=0;
    else
        cnt_y<=cnt_y;
end

always @(posedge clk)
begin
    if(!rst)
        begin
            x1_cs<=0;
            x2_cs<=0;
            y1_cs<=0;
            y2_cs<=0;
        end
     else if(cnt_y==479 && ce_buf && cnt_x==639)
        begin
            x1_cs<=x1_ns;
            x2_cs<=x2_ns;
            y1_cs<=y1_ns;
            y2_cs<=y2_ns;      
        end
     else
        begin
            x1_cs<=x1_cs;
            x2_cs<=x2_cs;
            y1_cs<=y1_cs;
            y2_cs<=y2_cs;   
        end
end

always @(posedge clk)
begin
    if(!rst)
        x1_ns<=0;
    else if(cnt_y==479 && ce_buf && cnt_x==639)
        x1_ns<=639;
    else if(cnt_x<x1_ns && (abs_data>70) && ce_buf && (cnt_x>5) && (cnt_x<634))
        x1_ns<=cnt_x;
    else
        x1_ns<=x1_ns;
end         

always @(posedge clk)
begin
    if(!rst)
        x2_ns<=0;
    else if(cnt_y==479 && ce_buf && cnt_x==639)
        x2_ns<=0;
    else if(cnt_x>x2_ns && (abs_data>70) && ce_buf && (cnt_x>5) && (cnt_x<634))
        x2_ns<=cnt_x;
    else
        x2_ns<=x2_ns;
end         

always @(posedge clk)
begin
    if(!rst)
        y1_ns<=0;
    else if(cnt_y==479 && ce_buf && cnt_x==639)
        y1_ns<=469;
    else if(cnt_y<y1_ns && (abs_data>70) && ce_buf  && (cnt_y>5) && (cnt_y<474))
        y1_ns<=cnt_y;
    else
        y1_ns<=y1_ns;
end  

always @(posedge clk)
begin
    if(!rst)
        y2_ns<=0;
    else if(cnt_y==479 && ce_buf && cnt_x==639)
        y2_ns<=0;
    else if(cnt_y>y2_ns && (abs_data>70) && ce_buf && (cnt_y>5) && (cnt_y<474)  )
        y2_ns<=cnt_y;
    else
        y2_ns<=y2_ns;
end  

always @(posedge clk)
begin
    if(!rst)
        threshold_data<=0;
    else if(ce)
        begin
            if( (cnt_x<10) ||(cnt_x>629) || (cnt_y<10) || (cnt_y>469) )
                threshold_data<=24'd0;
            if(abs_data>70)
                threshold_data<={8'd255,8'd0,8'd0};
            else if(cnt_y==y1_cs && cnt_x<=x2_cs && cnt_x>=x1_cs)
                threshold_data<={8'd0,8'd0,8'd255};
            else if(cnt_y==y2_cs && cnt_x<=x2_cs && cnt_x>=x1_cs)
                threshold_data<={8'd0,8'd0,8'd255};          
            else if(cnt_x==x1_cs && cnt_y<y2_cs && cnt_y>y1_cs)
                threshold_data<={8'd0,8'd0,8'd255};            
            else if(cnt_x==x2_cs && cnt_y<y2_cs && cnt_y>y1_cs)
                threshold_data<={8'd0,8'd0,8'd255};              
            else 
                threshold_data<={gray_bf_2,gray_bf_2,gray_bf_2};
        end
    else
        threshold_data<=threshold_data;
end

endmodule
