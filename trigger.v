

module trigger(clk,
               en,
               sample,
               upper_thresh,
               lower_thresh,
               slope_type,
               single_shot_mode,
               single_shot_reset,
               out,
               single_shot_waiting
               );
               
input clk;
input en;
input signed [13:0] sample;
input signed [13:0] upper_thresh;
input signed [13:0] lower_thresh;
input slope_type;

input single_shot_mode;
input single_shot_reset;

output reg out;
output reg single_shot_waiting = 1;


reg signed [13:0] old_sample;               


               
always @(posedge clk) begin
    if (en) begin
        if (single_shot_mode) begin
            if (single_shot_reset) begin
                single_shot_waiting <= 1;
                out <= !slope_type;
            end 
            else if (single_shot_waiting) begin
                
                if (sample >= upper_thresh && old_sample < upper_thresh) begin
                    out <= slope_type;
                    single_shot_waiting <= 0;
                end
                
                if (sample <= lower_thresh && old_sample > lower_thresh) begin
                    out <= !slope_type;
                    single_shot_waiting <= 0;
                end
                
            end
        end
        // not in single shot mode
        else begin
            single_shot_waiting <= 0;
            if (sample >= upper_thresh && old_sample < upper_thresh) begin
                out <= slope_type;
            end
            
            if (sample <= lower_thresh && old_sample > lower_thresh) begin
                out <= !slope_type;
            end
        
        end
        
    end
    
    else begin
        out <= 0; // keep low if enable is low
    end

    old_sample <= sample; 
end


endmodule 
