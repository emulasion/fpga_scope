`define holdoff_periods  19'b1111010000100100000 // 5e5 clock periods (@50MHz = 1ms)
module button_debouncer(clock,
                        button,
                        out);
input clock;
input button;

output out;

reg [18:0] time_count = 0;
reg out = 0;

always @(posedge clock) begin

    if (button) begin
        out = 1;
        time_count = 0; // resets the monostable
    end

    if (out) begin
        if (time_count == `holdoff_periods) begin           
            //out = 0;
            out = button; //fail safer
        end else begin
            time_count = time_count + 1;
        end    
    end
    
end
    
endmodule



