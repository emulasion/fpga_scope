module main(CLK_50M,
            
            SW[3:0],
            
            BTN_EAST,
            BTN_SOUTH,
            BTN_NORTH,
            BTN_WEST,
            
            ROT_CENTER,
            ROT_A,
            ROT_B,
            
            LED[7:0],
            
            VGA_R[3:0],
            VGA_G[3:0],
            VGA_B[3:0],
            VGA_HSYNC,
            VGA_VSYNC
            );


// 50 MHz CLOCK
input CLK_50M;

// mechanical switches
input [3:0] SW;

// buttons
input BTN_EAST;
input BTN_SOUTH;
input BTN_NORTH;
input BTN_WEST;

// rotary knob (encoder)
inout ROT_A;
input ROT_B;
input ROT_CENTER;

// debug leds 
output [7:0] LED;

// vga output ports
output [3:0] VGA_R;
output [3:0] VGA_G;
output [3:0] VGA_B;

output VGA_HSYNC;
output VGA_VSYNC;



// VGA 25 MHz clock
wire clk_25M;

freq_divider_24b vga_clk_div(.clock_in(CLK_50M),
                             .N(24'd2),
                             .clock_out(clk_25M),
                             .run_flag(1'b1));


vga_test vga_test(.clk(clk_50M),
                  .rst(0),
                  .HSYNC(VGA_HSYNC),
                  .VSYNC(VGA_VSYNC),
                  .R(VGA_R),
                  .G(VGA_G),
                  .B(VGA_B)
                  );


assign LED = 8'b01010101;
                           
endmodule





















