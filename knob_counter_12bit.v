module knob_counter_12bit(clk,
                          en,
                          rot_A,
                          rot_B,
                          rot_center,
                          start_value,
                          step,
                          lower_limit,
                          upper_limit,
                          out
                          );

input clk;

input en;

input rot_A;
input rot_B;
input rot_center;

input [11:0] start_value;
input [11:0] step;

input [11:0] lower_limit;
input [11:0] upper_limit;

output [11:0] out;

reg [12:0] count;


assign out = count[11:0];


reg [1:0] status;
reg init = 1;

always @(posedge clk) begin

    if (init) begin
        count = start_value;
        init = 0;
    end
    else begin
        if (en) begin
            if (rot_center) begin
                count = start_value;
            end
            else begin
                if (!rot_A & !rot_B) begin
                    status = 2'b00;
                end else if (status != 2'b10) begin
                    if (!rot_A & rot_B)
                        status = 2'b01;
                    else if (rot_A & !rot_B)
                        status = 2'b11;
                    else if (rot_A & rot_B) begin
                        if (status == 2'b01) begin
                            status = 2'b10;
                            if (count <= (upper_limit - step)) begin
                                count = count + step;
                            end
                        end else if (status == 2'b11) begin
                            status = 2'b10;
                            if (count >= (lower_limit + step)) begin
                                count = count - step;
                            end
                        end
                    end
                end
            end
        end
    end
end


endmodule




