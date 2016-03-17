module gpu_grid_layer(row,
                      col,
                      on_grid
                      );
input [9:0] row;
input [9:0] col;

output on_grid;

assign on_grid = 
(row >= 100 && row <= 500 && col == 250) |
(row >= 100 && row <= 500 && col == 300) |
(row >= 100 && row <= 500 && col == 350) |
(row >= 100 && row <= 500 && col == 400) |
(row >= 100 && row <= 500 && col == 500) |
(row >= 100 && row <= 500 && col == 550) |
(row >= 100 && row <= 500 && col == 600) |
(row >= 100 && row <= 500 && col == 650) |
(col >= 200 && col <= 700 && row == 450) |
(col >= 200 && col <= 700 && row == 400) |
(col >= 200 && col <= 700 && row == 350) |
(col >= 200 && col <= 700 && row == 250) |
(col >= 200 && col <= 700 && row == 200) |
(col >= 200 && col <= 700 && row == 150)
;

endmodule
