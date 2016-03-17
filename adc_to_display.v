`define DISPLAY_HEIGHT 201

module adc_to_display(//clk,
                      adc_sample,
                      display_shift,
                      V_div_mode,
                      display_sig,
                      ceil_overflow,
                      floor_overflow
                      );
                       
//input clk;
input signed [13:0] adc_sample;
input [2:0]  V_div_mode;
input signed [13:0]  display_shift;

                       
output reg signed [8:0] display_sig;

output reg ceil_overflow;      
output reg floor_overflow;                  
                       
reg signed [13:0] scaled_adc_sample;


always @* begin//(posedge clk) begin
    
    scaled_adc_sample <= adc_sample >>> V_div_mode;
    
    // check if in window
    if (scaled_adc_sample >= `DISPLAY_HEIGHT) begin 
        display_sig <= `DISPLAY_HEIGHT;
        ceil_overflow  <= 1;
        floor_overflow <= 0;
    end
    else if(scaled_adc_sample <= -(`DISPLAY_HEIGHT)) begin
        display_sig <= -(`DISPLAY_HEIGHT);
        ceil_overflow  <= 0;
        floor_overflow <= 1;   
    end
    else begin
        display_sig <= {scaled_adc_sample[13], scaled_adc_sample[7:0]};
        ceil_overflow  <= 0;
        floor_overflow <= 0; 
    
    end


end

endmodule


























