`timescale 1ns / 1ps


module vga_sync(clk, //Clock in 25MHz
                rst,
                Vsync,
                Hsync,
                Blank,
                Pixel_x, // PIXEL "address" (x,y counters)
                Pixel_y //
                );

input clk;
input rst;


output reg Vsync;
output reg Hsync;
output reg Blank;

output [9:0]Pixel_x;
output [9:0]Pixel_y;

reg [9:0]Pixel_x = 0;
reg [9:0]Pixel_y = 0;


reg [9:0]h_count = 0;      //count to 799
reg [9:0]v_count = 0;      //count to 524

reg [9:0] count_display = 0;

wire h_end;
wire v_end;
wire tc_count_displ;

parameter h_count_rst_value = 799;
parameter v_count_rst_value = 524;

always@(posedge clk) begin

    if(h_count == h_count_rst_value) begin
        h_count <= 0;
        if(v_count == v_count_rst_value)
            v_count <= 0;
        else
            v_count <= v_count+1;
    end
    else
        h_count <= h_count+1;
        

    if(h_count <= 640)
        Pixel_x <= Pixel_x + 1;
    else
        Pixel_x <= 0;


    if(rst == 1'b1)
    Pixel_y <= 10'h000;
    else
      if(Blank == 1'b0)
         Pixel_y <= 10'h000;
      else
         Pixel_y <= v_count;
         
         
    Hsync <= (h_count >= 648 && h_count <= 744);
    Vsync <= (v_count >= 488 && v_count <= 489);
    
    Blank <= (h_count <= 639 && v_count <= 479)? 1'b1:1'b0;


end 




 
endmodule
