module gpu_800x600(vga_clk,
                   on_screen_flag,
                   row,
                   col,
                   ch1_disp_sig,
                   ch2_disp_sig,
                   plot_vectors,
                   displ_mem_rd_addr,
                   R,
                   G,
                   B,
                   trig_time
                   );

input [8:0] trig_time;

input vga_clk;
input on_screen_flag;                   

input [9:0] row;
input [10:0] col;

input signed [8:0] ch1_disp_sig;
input signed [8:0] ch2_disp_sig;

input plot_vectors;

output reg [8:0] displ_mem_rd_addr;

output reg [3:0] R;
output reg [3:0] G;
output reg [3:0] B;


wire on_chars = 0;

wire on_char1 = 0;
wire on_char2 = 0;
wire on_char3 = 0;
wire on_char4 = 0;

gpu_char_logic char_test1(.char_addr(0),
                         .row(row - 100),
                         .col(col - 97),
                         .col_offset(0),
                         .row_offset(0),
                         .on_char(on_char1)
                         );
                    
gpu_char_logic char_test2(.char_addr(1),
                         .row(row - 100),
                         .col(col - 106),
                         .col_offset(0),
                         .row_offset(0),
                         .on_char(on_char2)
                         );

gpu_char_logic char_test3(.char_addr(2),
                         .row(row - 100),
                         .col(col - 112),
                         .col_offset(0),
                         .row_offset(0),
                         .on_char(on_char3)
                         );
                    
gpu_char_logic char_test4(.char_addr(3),
                         .row(row - 100),
                         .col(col - 118),
                         .col_offset(0),
                         .row_offset(0),
                         .on_char(on_char4)
                         );
                  
assign on_chars = on_char1 || on_char2 || on_char3 || on_char4;



// grid frame logic
wire on_frame;
gpu_frame_layer frame_layer(.row(row),
                            .col(col),
                            .on_frame(on_frame)
                            );
// grid logic                    
wire on_grid;
gpu_grid_layer grid_layer(.row(row),
                          .col(col),
                          .on_grid(on_grid)
                          );


reg signed [9:0] old_ch1_disp_sig = 0;
reg signed [9:0] ch1_disp_max = 0;
reg signed [9:0] ch1_disp_min = 0;

reg signed [9:0] old_ch2_disp_sig = 0;
reg signed [9:0] ch2_disp_max = 0;
reg signed [9:0] ch2_disp_min = 0;


reg display_ch1;
reg display_aa_ch1; // antialiasing

reg display_ch2;
reg display_aa_ch2; // antialiasing

always @ (posedge vga_clk) begin
    
    
    displ_mem_rd_addr <= col - 199;
    
    // evaluate plot vectors
    old_ch1_disp_sig <= ch1_disp_sig;
    ch1_disp_min = 300 - ((ch1_disp_sig >= old_ch1_disp_sig) ? ch1_disp_sig : old_ch1_disp_sig);
    ch1_disp_max = 300 - ((ch1_disp_sig <= old_ch1_disp_sig) ? ch1_disp_sig : old_ch1_disp_sig);
    
    old_ch2_disp_sig <= ch2_disp_sig;
    ch2_disp_min = 300 - ((ch2_disp_sig >= old_ch2_disp_sig) ? ch2_disp_sig : old_ch2_disp_sig);
    ch2_disp_max = 300 - ((ch2_disp_sig <= old_ch2_disp_sig) ? ch2_disp_sig : old_ch2_disp_sig);
    
    // channel 1 final logic
    display_ch1 <= plot_vectors? ((col > 200 && col < 700) && row == 300 - ch1_disp_sig ) :
                                 ((col > 200 && col < 700) && (row >= ch1_disp_min) 
                                                           && (row <= ch1_disp_max));
                                                           
        
    display_aa_ch1 <= plot_vectors?   0 :
                                      ( (col > 200 && col < 700) &&
                                        ((row == 300 - (ch1_disp_sig + 1)) || (row == 300 - (ch1_disp_sig - 1)))
                                       );

                                                           
    // channel 2 final logic
    display_ch2 <= plot_vectors? ((col > 200 && col < 700) && row == 300 - ch2_disp_sig ) :
                                 ((col > 200 && col < 700) && (row >= ch2_disp_min) 
                                                           && (row <= ch2_disp_max));
                                                           
        
    display_aa_ch2 <= plot_vectors?   0 :
                                      ( (col > 200 && col < 700) &&
                                        ((row == 300 - (ch2_disp_sig + 1)) || (row == 300 - (ch2_disp_sig - 1)))
                                       );
                                  
    if (on_screen_flag) begin

        // GRAPHICS LAYERS
        if (on_chars) begin
            R <= 4'b1111;
            G <= 4'b1111;
            B <= 4'b1111;    
        end
        
        // CHANNEL 1 layer
        else if (display_ch1) begin
            R <= 4'b1111;
            G <= 4'b1111;
            B <= 4'b0000;
        end
        //channel 1 anti aliasing layer
        else if (display_aa_ch1) begin
            R <= 4'b0111;
            G <= 4'b0111;
            B <= 4'b0000;
        end
        
        // CHANNEL 2 layer
        else if (display_ch2) begin
            R <= 4'b0000;
            G <= 4'b1111;
            B <= 4'b0000;
        end
        // CHANNEL 2 anti aliasing layer
        else if (display_aa_ch2) begin
            R <= 4'b0000;
            G <= 4'b0111;
            B <= 4'b0000;
        end
        // horizontal trigger position
        else if (col  == (trig_time + 193) && row < 100) begin
            R <= 4'b0111;
            G <= 4'b0111;
            B <= 4'b0000;
        end

        else if (on_frame) begin
            R <= 4'b0100;
            G <= 4'b0100;
            B <= 4'b0100;
        end
        else if (on_grid) begin
            R <= 4'b0010;
            G <= 4'b0010;
            B <= 4'b0010;
        end
        else begin // background (default) color
            R <= 4'b0000;
            G <= 4'b0000;
            B <= 4'b0000;
        end
        
        // ********************
    end else begin // default: black offscreen signal
        R <= 4'b0000;
        G <= 4'b0000;
        B <= 4'b0000;    
    end
   
end                                   
                     
                     
endmodule                     
                     
                     

















                     
