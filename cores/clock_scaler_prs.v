// CLOCK SCALET PAUSE / RESUME / STOP
module clock_scaler_prs(clock_in,
                        scaling_factor,
                        clock_out,
                        pause_resume, //"edge triggered" pause/resume(and start) 
                        stop
                        ); 
                    
input clock_in;
input [29:0] scaling_factor;
input pause_resume;
input stop;

output clock_out;

reg clock_out = 0;
reg [31:0] count = 0;

reg run_flag;
reg old_pause_resume;

always @(posedge clock_in) begin
    if (stop) begin
        run_flag = 0;
        count = 0;
        clock_out = 0;
    end
    
    if (!old_pause_resume & pause_resume) begin
        run_flag = !run_flag;
    end

    if (run_flag) begin
        if (count == (scaling_factor - 1)) begin
            count = 0;
            clock_out = ~clock_out;
        end else begin
            count = count + 1;
        end
    end
    
    old_pause_resume = pause_resume;
end   

endmodule
