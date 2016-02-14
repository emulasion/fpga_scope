
// frequency by N divider

module freq_divider_24b(clock_in,
                        N,
                        clock_out,
                        run_flag);
                    
input clock_in;
input [23:0] N;
input run_flag;

output reg clock_out = 0;

reg [23:0] count = 0;



always @(posedge clock_in) begin
    if (run_flag) begin
        if (count == ((N >> 2)- 1)) begin
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
