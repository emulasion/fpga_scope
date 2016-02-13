module clock_scaler(clock_in,
                    scaling_factor,
                    clock_out,
                    run_flag);
                    
input clock_in;
input [29:0] scaling_factor;
input run_flag;

output clock_out;

reg clock_out = 0;
reg [29:0] count = 0;



always @(posedge clock_in) begin
    if (run_flag) begin
        if (count == (scaling_factor - 1)) begin
            count = 0;
            clock_out = ~clock_out;
        end else begin
            count = count + 1;
        end
    end else begin
        count = 0;
        clock_out = 0;
    end
end   

endmodule
