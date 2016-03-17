module gpu_frame_layer(row,
                       col,
                       on_frame
                       );
input [9:0] row;
input [9:0] col;

output on_frame;

assign on_frame =
(col >= 200 && col <= 700 && row == 500) |
(row >= 100 && row <= 500 && col == 200) |
(col >= 200 && col <= 700 && row == 100) |
(row >= 100 && row <= 500 && col == 700) |
(row >= 100 && row <= 500 && col == 450) |
(col >= 200 && col <= 700 && row == 300)
;

endmodule
