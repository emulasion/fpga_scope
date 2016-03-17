module counter_16b(clk,
                   reset,
                   ena,
                   modulus,
                   count
                   );

                        
input clk;
input reset;
input ena;

input [15:0] modulus;

output reg [15:0] count;

always @(posedge clk or posedge reset)
begin
	if (reset) 
		count <= 0;		
	else if (ena)
	    if (count == modulus) begin
	        count <= 0;
	    end
	    else begin 
		    count <= count + 1;
	    end
end


endmodule                                                   
