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
            VGA_B[3:0]
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





                           
endmodule
