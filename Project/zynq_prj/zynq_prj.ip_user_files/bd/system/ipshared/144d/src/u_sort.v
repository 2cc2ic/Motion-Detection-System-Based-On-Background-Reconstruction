module u_sort
(  
input	clk,
input	rst,
input	ce,    
input  [7:0] data1, data2, data3,  
output reg [7:0] max_data, mid_data, min_data 
); 

always@(posedge clk) 
begin  
	if(!rst)   
		begin   
			max_data <= 0;   
			mid_data <= 0;   
			min_data <= 0;   
		end  
	else if(ce)
		begin
			if(data1 >= data2 && data1 >= data3)    
				max_data <= data1;   
			else if(data2 >= data1 && data2 >= data3)    
				max_data <= data2;   
			else   
				max_data <= data3; 
 
			if((data1 >= data2 && data1 <= data3) || (data1 >= data3 && data1 <= data2))    
				mid_data <= data1;   
			else if((data2 >= data1 && data2 <= data3) || (data2 >= data3 && data2 <= data1))   
				mid_data <= data2;   
			else   
				mid_data <= data3;   
				
			if(data1 <= data2 && data1 <= data3)    
				min_data <= data1;   
			else if(data2 <= data1 && data2 <= data3)    
				min_data <= data2;   
			else    
				min_data <= data3;  
		end
	else	
		begin      
			max_data <= max_data;   
			mid_data <= mid_data;   
			min_data <= min_data;   		
		end 
end 

endmodule