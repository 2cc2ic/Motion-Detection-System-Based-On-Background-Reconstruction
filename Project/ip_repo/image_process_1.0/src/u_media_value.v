module u_media_value
(
	input clk,
	input rst,
	input ce,
	input [7:0] data11,data12,data13,data21,data22,data23,data31,data32,data33,
	output [7:0] final_media_data
);

wire [7:0] max_data1, mid_data1, min_data1; 
wire [7:0] max_data2, mid_data2, min_data2;
wire [7:0] max_data3, mid_data3, min_data3;
wire [7:0] max_min_data, mid_mid_data, min_max_data; 

u_sort unit0 
(  
.clk  (clk),  
.rst  (rst), 
.ce   (ce),   
.data1  (data11),   
.data2  (data12),   
.data3  (data13),    
.max_data (max_data1),  
.mid_data (mid_data1),  
.min_data (min_data1) 
); 

u_sort unit1
(  
.clk  (clk),  
.rst  (rst),  
.ce   (ce),   
.data1  (data21),   
.data2  (data22),   
.data3  (data23),    
.max_data (max_data2),  
.mid_data (mid_data2),  
.min_data (min_data2) 
); 

u_sort unit2
(  
.clk  (clk),  
.rst  (rst),  
.ce   (ce),   
.data1  (data31),   
.data2  (data32),   
.data3  (data33),    
.max_data (max_data3),  
.mid_data (mid_data3),  
.min_data (min_data3) 
); 

u_sort unit3
(  
.clk  (clk),  
.rst  (rst), 
.ce   (ce),    
.data1  (max_data1),   
.data2  (max_data2),   
.data3  (max_data3),    
.max_data (),  
.mid_data (),  
.min_data (max_min_data) 
); 
 
u_sort unit4
(  
.clk  (clk),  
.rst  (rst), 
.ce   (ce),    
.data1  (mid_data1),   
.data2  (mid_data2),   
.data3  (mid_data3),    
.max_data (),  
.mid_data (mid_mid_data),  
.min_data () 
); 
 
u_sort unit5
(  
.clk  (clk), 
.rst  (rst), 
.ce   (ce),    
.data1  (min_data1),   
.data2  (min_data2),   
.data3  (min_data3),    
.max_data (min_max_data),  
.mid_data (),  
.min_data ()
);

u_sort unit6
(  
.clk  (clk),  
.rst  (rst),  
.ce   (ce),   
.data1  (max_min_data),   
.data2  (mid_mid_data),   
.data3  (min_max_data),    
.max_data (),  
.mid_data (final_media_data),  
.min_data   () 
);

endmodule