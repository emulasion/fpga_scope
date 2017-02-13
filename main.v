// FPGA SCOPE REV 1.0

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
            VGA_VSYNC,
            
            ADC_OUT,
            SPI_SCK,
            AD_CONV,
            SPI_MOSI,
            AMP_CS,
            AMP_SHDN,
            );


//// PORTS

// 50 MHz CLOCK
input CLK_50M;

// mechanical switches
input [3:0] SW;

// push buttons
input BTN_EAST;
input BTN_SOUTH;
input BTN_NORTH;
input BTN_WEST;

// rotary knob (encoder)
input ROT_A;
input ROT_B;
input ROT_CENTER;

// debug leds 
output reg [7:0] LED;

// vga output ports
output [3:0] VGA_R;
output [3:0] VGA_G;
output [3:0] VGA_B;

output VGA_HSYNC;
output VGA_VSYNC;


// adc and amplifier I/O
input ADC_OUT;

output SPI_SCK;
output AD_CONV;
output SPI_MOSI;
output AMP_SHDN;
output AMP_CS;

assign AMP_SHDN = 0;

wire [13:0] adc_dout_ch_1;
wire [13:0] adc_dout_ch_2;





//// BUTTONS AND KNOB SCOPE INTERFACE

// debounce knob rot signals
wire deb_rot_A;
wire deb_rot_B;
wire deb_rot_center;

// debounce knob inputs
button_debouncer deb_A(.clock(CLK_50M),
                       .button(ROT_A),
                       .holdoff_periods(24'd50000),
                       .out(deb_rot_A)
                       );
                      
button_debouncer deb_B(.clock(CLK_50M),
                       .button(ROT_B),
                       .holdoff_periods(24'd50000),
                       .out(deb_rot_B)
                       );
                       
button_debouncer deb_cntr(.clock(CLK_50M),
                          .button(ROT_CENTER),
                          .holdoff_periods(24'd1_000_000),
                          .out(deb_rot_center)
                          );

// debounce board push buttons
wire deb_btn_east;
wire deb_btn_south;
wire deb_btn_north;
wire deb_btn_west;

button_debouncer deb_east (.clock(CLK_50M),
                           .button(BTN_EAST),
                           .holdoff_periods(24'd1_000_000),
                           .out(deb_btn_east)
                           );
                              
button_debouncer deb_south(.clock(CLK_50M),
                           .button(BTN_SOUTH),
                           .holdoff_periods(24'd1_000_000),
                           .out(deb_btn_south)
                           ); 
                                                           
button_debouncer deb_north(.clock(CLK_50M),
                           .button(BTN_NORTH),
                           .holdoff_periods(24'd1_000_000),
                           .out(deb_btn_north)
                           );
                              
button_debouncer deb_west(.clock(CLK_50M),
                           .button(BTN_WEST),
                           .holdoff_periods(24'd1_000_000),
                           .out(deb_btn_west)
                           );

// select vertical V per div
// 0 to 7                                                                                                            
wire [11:0] ch1_vert_mode;
wire [11:0] ch2_vert_mode;

knob_counter_12bit vert_knb1(.clk(CLK_50M),
                             .en(SW[0] && deb_btn_south),
                             .rot_A(deb_rot_A),
                             .rot_B(deb_rot_B),
                             .rot_center(deb_rot_center),
                             .start_value(0),
                             .step(1),
                             .lower_limit(0),
                             .upper_limit(7),
                             .out(ch1_vert_mode)
                             );
                           
knob_counter_12bit vert_knb2(.clk(CLK_50M),
                             .en(!SW[0] && deb_btn_south),
                             .rot_A(deb_rot_A),
                             .rot_B(deb_rot_B),
                             .rot_center(deb_rot_center),
                             .start_value(0),
                             .step(1),
                             .lower_limit(0),
                             .upper_limit(7),
                             .out(ch2_vert_mode)
                             );
                             
// vertical modes: equivalent amp gain
reg [3:0] ch1_amp_gain_id = 1;
reg [3:0] ch2_amp_gain_id = 1;

always @(posedge CLK_50M) begin
    case (ch1_vert_mode)
        0 : ch1_amp_gain_id <= 1;
        1 : ch1_amp_gain_id <= 1;
        2 : ch1_amp_gain_id <= 2;
        3 : ch1_amp_gain_id <= 3;
        4 : ch1_amp_gain_id <= 4;
        5 : ch1_amp_gain_id <= 5;
        6 : ch1_amp_gain_id <= 6;
        7 : ch1_amp_gain_id <= 7;
    endcase
end 

always @(posedge CLK_50M) begin
    case (ch2_vert_mode)
        0 : ch2_amp_gain_id <= 1;
        1 : ch2_amp_gain_id <= 1;
        2 : ch2_amp_gain_id <= 2;
        3 : ch2_amp_gain_id <= 3;
        4 : ch2_amp_gain_id <= 4;
        5 : ch2_amp_gain_id <= 5;
        6 : ch2_amp_gain_id <= 6;
        7 : ch2_amp_gain_id <= 7;
    endcase
end

// signal processor shift: # of bits
reg [3:0] ch1_shift_n_bits;
reg [3:0] ch2_shift_n_bits;

always @(posedge CLK_50M) begin
    ch1_shift_n_bits <= (ch1_vert_mode == 0) ? 5 : 4;
    ch2_shift_n_bits <= (ch2_vert_mode == 0) ? 5 : 4;
end


                           
// select horizontal
// 0 to 13
wire [11:0] horiz_mode;
knob_counter_12bit horz_knb1(.clk(CLK_50M),
                             .en(deb_btn_east),
                             .rot_A(deb_rot_A),
                             .rot_B(deb_rot_B),
                             .rot_center(deb_rot_center),
                             .start_value(0),
                             .step(1),
                             .lower_limit(0),
                             .upper_limit(13),
                             .out(horiz_mode)
                             );
                             
                             
reg [23:0] sampl_clk_scaling = 1;                             
always @(posedge CLK_50M) begin
    case (horiz_mode)
        0  : sampl_clk_scaling <= 24'd50;       // 0.00005 s/ mode
        1  : sampl_clk_scaling <= 24'd100;      // 0.0001 s/ mode
        2  : sampl_clk_scaling <= 24'd200;      // 0.0002 s/ mode
        3  : sampl_clk_scaling <= 24'd500;      // 0.0005 s/ mode
        4  : sampl_clk_scaling <= 24'd1000;     // 0.001 s/ mode
        5  : sampl_clk_scaling <= 24'd2000;     // 0.002 s/ mode
        6  : sampl_clk_scaling <= 24'd5000;     // 0.005 s/ mode
        7  : sampl_clk_scaling <= 24'd10000;    // 0.01 s/ mode
        8  : sampl_clk_scaling <= 24'd20000;    // 0.02 s/ mode
        9  : sampl_clk_scaling <= 24'd50000;    // 0.05 s/ mode
        10 : sampl_clk_scaling <= 24'd100000;   // 0.1  s/ mode
        11 : sampl_clk_scaling <= 24'd200000;   // 0.2  s/ mode
        12 : sampl_clk_scaling <= 24'd500000;   // 0.5  s/ mode
        13 : sampl_clk_scaling <= 24'd1000000;  // 1  s/ mode
    endcase
end


//// CLOCKS
// sampling clock (max 1MHZ)                       
wire sampling_clk;
freq_divider_24b sampl_clk_cnt(.clock_in(CLK_50M),
                               //.N(24'd50), // 1 MHz   sampling clock
                               .N(sampl_clk_scaling),
                               .clock_out(sampling_clk),
                               .run_flag(1)
                               );
                               
                               
// amplifier interface clock: fixed at 5MHz                               
wire amp_spi_clk;
freq_divider_24b spi_clk_cnt(.clock_in(CLK_50M),
                              .N(24'd10), //   5 MHz sampling clock
                              .clock_out(amp_spi_clk),
                              .run_flag(1)
                              );                               
                             
//// ANALOG CAPTURE LOGIC                                                          
ad_converter_amplifier adc_amp(.clk(CLK_50M),
                               .sampling_clk(sampling_clk),
                               .amp_spi_clk(amp_spi_clk), // "slow" spi clock for LTC6912-1
                              
                               .gain_ch1(ch1_amp_gain_id),
                               .gain_ch2(ch2_amp_gain_id),

                               .ADC_OUT(ADC_OUT),

                               .SPI_SCK(SPI_SCK), 
                               .AD_CONV(AD_CONV),
                               .SPI_MOSI(SPI_MOSI),
                               .AMP_CS(AMP_CS),
                              
                               .adc_dout_ch_1(adc_dout_ch_1),
                               .adc_dout_ch_2(adc_dout_ch_2)
                               );


//// SCOPE STATE MACHINE      
reg [2:0] acq_state = 0;

wire trig_out;
reg old_trig_out = 0;

wire pre_fifo_full;
wire pre_fifo_empty;

wire pst_fifo_full;
wire pst_fifo_empty;

wire [31:0] pre_fifo_dout;
wire [31:0] pst_fifo_dout;
wire [31:0] fifos_out_mux;

wire single_shot_reset;
button_debouncer ss_deb(.clock(CLK_50M),
                        .button(BTN_EAST),
                        .holdoff_periods(24'd1_000_000),
                        .out(single_shot_reset)
                        );
                        
wire force_trigger;
button_debouncer ft_deb(.clock(CLK_50M),
                        .button(BTN_WEST),
                        .holdoff_periods(24'd1_000_000),
                        .out(force_trigger)
                        );
        
        
always @(posedge CLK_50M) begin

    if ((acq_state == 0) && pre_fifo_full) begin
        acq_state <= 1;
    end
    
    else if ((acq_state == 1) && ((!old_trig_out && trig_out) || force_trigger)) begin
        acq_state <= 2;
    end
    
    else if ((acq_state == 2) && pst_fifo_full) begin
        acq_state <= 3;
    end
    
    else if ((acq_state == 3) && pre_fifo_empty) begin
        acq_state <= 4;
    end
    
    else if ((acq_state == 4) && pst_fifo_empty) begin
        acq_state <= 5;
    end
    
    else if (acq_state == 5) begin
        acq_state <= 0;
    end
    
    
    old_trig_out <= trig_out;
end
                 
 
wire [15:0] displ_mem_wr_addr;
wire [8:0] displ_mem_rd_addr;
wire [27:0] displ_mem_dout;

fifo_32x512 pre_trig_samples_fifo(.rst(acq_state == 5),
                                  .wr_clk(sampling_clk),
                                  .rd_clk( (acq_state == 3) ? CLK_50M : sampling_clk),
                                  .din({4'd0, adc_dout_ch_2, adc_dout_ch_1}),
                                  .wr_en( acq_state < 2),
                                  .rd_en(  (acq_state == 3)? 1 : pre_fifo_full),
                                  .prog_empty_thresh(1),
                                  .prog_full_thresh(250),//trigger_delay[8:0]),
                                  .dout(pre_fifo_dout),
                                  .prog_full(pre_fifo_full),
                                  .prog_empty(pre_fifo_empty)
                                  );

                                  
fifo_fwft_32x512 pst_trig_samples_fifo(.rst(acq_state == 5),
                                  .wr_clk(sampling_clk),
                                  .rd_clk(CLK_50M),
                                  .din({4'd0, adc_dout_ch_2, adc_dout_ch_1}),
                                  .wr_en(acq_state == 2),
                                  .rd_en(acq_state == 4),
                                  .prog_empty_thresh(0), // don't care
                                  .prog_full_thresh(510), //TODO: trim when pst is not fully used
                                  .dout(pst_fifo_dout),
                                  .prog_full(pst_fifo_full),
                                  .empty(pst_fifo_empty)
                                  );
                                  
assign fifos_out_mux = (acq_state == 3) ? pre_fifo_dout : pst_fifo_dout;



                       
//// TRIGGER
wire trigger_ss_waiting;
trigger trigger(.clk(sampling_clk),
                .en(1), // acq_state == 1 is checked in state change if          
                .sample(adc_dout_ch_1),
                
                .upper_thresh(0),
                .lower_thresh(-64),
                
                .slope_type(SW[1]),
                
                .single_shot_mode(SW[2]),
                .single_shot_reset(single_shot_reset),
                
                .single_shot_waiting(trigger_ss_waiting),
                
                .out(trig_out)
                );


//// DIPLAY MEMORY
counter_16b mem_cpy_cnt(.clk(CLK_50M),
                        .reset(acq_state == 5),
                        .ena( ((acq_state == 3) || (acq_state == 4)) && (displ_mem_wr_addr <= 500) ),
                        .modulus(511),
                        .count(displ_mem_wr_addr)
                        );





blk_mem_28x512 display_mem(// port a
                           .clka(CLK_50M),
                           .ena(1),
                           .wea(((acq_state == 3) || (acq_state == 4)) && (displ_mem_wr_addr <= 500)),
                           .addra(displ_mem_wr_addr[8:0]- 1),
                           .dina(fifos_out_mux[27:0]),
                           // port b
                           .clkb(CLK_50M),
                           .enb(1),
                           .addrb(displ_mem_rd_addr),
                           .doutb(displ_mem_dout)
                           );  


///// SIGNAL PROCESSORS (adc to display)
wire [8:0] ch1_disp_sig;
wire [8:0] ch2_disp_sig;

wire [10:0] col;
wire [9:0] row;


adc_to_display ch1_disp_proc(//.clk(CLK_50M),
                             .adc_sample(displ_mem_dout[13:0]),
                             //.display_shift,
                             .V_div_mode(ch1_shift_n_bits),
                             .display_sig(ch1_disp_sig)
                             //.ceil_overflow(ch1_ceil_overflow),
                             //.floor_overflow(ch1_floor_overflow)
                             );
                            
adc_to_display ch2_disp_proc(//.clk(CLK_50M),
                             .adc_sample(displ_mem_dout[27:14]),
                             //.display_shift,
                             .V_div_mode(ch2_shift_n_bits),
                             .display_sig(ch2_disp_sig)
                             //.ceil_overflow(ch2_ceil_overflow),
                             //.floor_overflow(ch2_floor_overflow)
                             );


//// VGA INTERFACE
vga_800x600_72Hz_intf vga_ctrl(.vga_clk(CLK_50M),
                               .reset(0), // useless
                               .ch1_disp_sig(ch1_disp_sig),
                               .ch2_disp_sig(ch2_disp_sig),
                               .plot_vectors(SW[3]),
                               .h_sync(VGA_HSYNC),
                               .v_sync(VGA_VSYNC),
                               .row(row),
                               .col(col),
                               //.memcpy_window(memcpy_window),
                               .displ_mem_rd_addr(displ_mem_rd_addr),
                               .R(VGA_R),
                               .G(VGA_G),
                               .B(VGA_B),
                               .trig_time(250)//trigger_delay[8:0])
                               );



//// LED INTERFACE
always @* begin
    LED <= {4'b0, SW};
end




endmodule




















