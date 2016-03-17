module vga_800x600_72Hz_intf(vga_clk,
                             reset,
                             ch1_disp_sig,
                             ch2_disp_sig,
                             plot_vectors,
                             h_sync,
                             v_sync,
                             row,
                             col,
                             memcpy_window,
                             displ_mem_rd_addr,
                             R,
                             G,
                             B,
                             trig_time
                             );


// timing parameters
// horizontal timing
localparam HD = 800; // horizontal display area
localparam HF = 56;  // front porch (right border)
localparam HB = 64;  // back porch (left border)
localparam HR = 120; // HSYNC pulse width
// vertical timing
localparam VD = 600; // vertical display area
localparam VF = 37;  // front porch (bottom border)
localparam VB = 23;  // back porch (top border)
localparam VR = 6;   // VSYNC pulse width

                                 
input vga_clk;
input reset;

input signed [8:0] ch1_disp_sig;
input signed [8:0] ch2_disp_sig;

input plot_vectors;

output h_sync;
output v_sync;

output reg [10:0] col;
output reg [9:0] row; 

output memcpy_window;

output [8:0] displ_mem_rd_addr;

output [3:0] R;
output [3:0] G;
output [3:0] B;

input [8:0] trig_time;

assign memcpy_window = (row == 1) && col <500;
                    
always@(posedge vga_clk) begin

    if(col == (HD+HF+HB+HR-1)) begin
        col <= 0;
        if(row == (VD+VF+VB+VR-1))
            row <= 0;
        else
            row <= row + 1;
    end
    else
        col <= col + 1;    
end


assign h_sync = col >= (HD+HF) & col <= (HD+HF+HR-1);    

assign v_sync = row >= (VD+VF) & row <= (VD+VF+VR-1);

assign on_screen_flag = col <= 799 & row <= 599;


// GPU LOGIC
gpu_800x600 scope_gpu(.vga_clk(vga_clk),
                      .on_screen_flag(on_screen_flag),
                      .row(row),
                      .col(col),
                      .ch1_disp_sig(ch1_disp_sig),
                      .ch2_disp_sig(ch2_disp_sig),
                      .plot_vectors(plot_vectors),
                      .displ_mem_rd_addr(displ_mem_rd_addr),
                      .R(R),
                      .G(G),
                      .B(B),
                      .trig_time(trig_time)
                      );
 
endmodule

