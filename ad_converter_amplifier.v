module ad_converter_amplifier(clk,
                              sampling_clk,
                              amp_spi_clk, // "slow" spi clock for LTC6912-1
                              
                              gain_ch1,
                              gain_ch2,

                              ADC_OUT,

                              SPI_SCK,
                              AD_CONV,
                              SPI_MOSI,
                              AMP_CS,
                              
                              adc_dout_ch_1,
                              adc_dout_ch_2
                              );

input clk;
input sampling_clk;
input amp_spi_clk;

input [3:0] gain_ch1; // gain of amplifier A on LTC6912-1
input [3:0] gain_ch2; // gain of amplifier B on LTC6912-1

input ADC_OUT;

output SPI_SCK;
output AD_CONV;

output reg SPI_MOSI = 0;

output reg AMP_CS;

output reg [13:0] adc_dout_ch_1 = 0;
output reg [13:0] adc_dout_ch_2 = 0;


reg [7:0] old_gains = 0;
reg [7:0] gains_buf = 0;


// AMPLIFIER LOGIC
reg amp_serial_busy = 0;
reg [3:0] gain_bit_cnt = 0;
reg [3:0] holf_off_cnt = 0;
reg old_amp_spi_clk;

wire amp_busy;

// amplifier in use wire
assign amp_busy = (holf_off_cnt != 0);


// select proper SPI_CLK
assign SPI_SCK = amp_busy? amp_spi_clk : clk;


always @(posedge clk) begin
                                    
    if ((old_gains != {gain_ch2, gain_ch1}) && !amp_serial_busy && (holf_off_cnt == 0)) begin
        amp_serial_busy <= 1;
        holf_off_cnt <= 15;
        gains_buf <= {gain_ch2, gain_ch1};
    end
    else if (amp_serial_busy) begin
        // change data on NEGEDGE of spi clock
        // because the amp accept data on rising edge
        if (old_amp_spi_clk && !amp_spi_clk) begin

            if (gain_bit_cnt == 8) begin
                AMP_CS <= 1;
                amp_serial_busy <= 0;
                gain_bit_cnt <= 0;
            end
            else begin
                AMP_CS <= 0;
                gain_bit_cnt <= gain_bit_cnt + 1;
                
                // shift data out
                gains_buf <= gains_buf << 1; 
                // equivalent: 
                // gains_buf <= {gains_buf[6:0], 0};
                SPI_MOSI <= gains_buf[7];
            end
        end
    end

    // hold off counter: does NOT depend on amp_serial_busy flag
    if (old_amp_spi_clk && !amp_spi_clk) begin        
        if (holf_off_cnt > 0) begin
            holf_off_cnt <= holf_off_cnt - 1;
        end
    end
    
    if (holf_off_cnt == 0) begin
        old_gains <= {gain_ch2, gain_ch1};    
    end

    old_amp_spi_clk <= amp_spi_clk;
end



// ADC LOGIC
reg old_sampling_clk;
reg clk_sync_ad_conv = 0;

reg [5:0] adc_serial_cnt = 0;


reg [13:0] buf_adc_dout_ch_1 = 0;
reg [13:0] buf_adc_dout_ch_2 = 0;

always @(posedge clk) begin
    // start sampling sequence at sampling_clk posedge
    if (!amp_busy) begin
        if (!old_sampling_clk && sampling_clk) begin
            adc_serial_cnt <= 0;
            clk_sync_ad_conv <= 1;
            
            adc_dout_ch_1 <= buf_adc_dout_ch_1;
            adc_dout_ch_2 <= buf_adc_dout_ch_2;
        end
        else begin
            if (adc_serial_cnt <= 34) begin
                clk_sync_ad_conv <= 0;
                adc_serial_cnt <= adc_serial_cnt + 1;
            end
        end
    end
    else begin
        adc_serial_cnt <= 0;
        
        adc_dout_ch_1 <= 0;
        adc_dout_ch_2 <= 0;

    end
    
    
    old_sampling_clk <= sampling_clk;
end



assign AD_CONV = clk_sync_ad_conv && clk;

// load data 10 ns after posedge of SPI_SCK
// i.e. at negedge of SPI_SCK
always @(negedge clk) begin
           

    if (adc_serial_cnt >= 3 && adc_serial_cnt <= 16) begin
        // shift data in
        //if (!amp_busy) begin
            buf_adc_dout_ch_1 <= {buf_adc_dout_ch_1[12:0], ADC_OUT};
        //end
    end
    
        if (adc_serial_cnt >= 19 && adc_serial_cnt <= 32) begin
        // shift data in
        //if (!amp_busy) begin
            buf_adc_dout_ch_2 <= {buf_adc_dout_ch_2[12:0], ADC_OUT};  
        //end
    end


end

endmodule
























