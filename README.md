# fpga_scope

Here's the verilog code for a simple digital oscilloscope with the following specs:

- 2 analog channels
- up to 1 Mhz sampling rate
- 14 bit A/D converter resolution
- VGA display output (800x600 @72Hz)

this design has been implemented on a Xilinx Spartan-3AN Starter Kit (http://www.xilinx.com/products/boards-and-kits/hw-spar3an-sk-uni-g.html). Although the top-level verilog module (main.v) uses the specific Spartan-3AN Starter Kit I/O pin names, this design can be easily adapted for most FPGAs. Additional modifications are needed if one uses any ADC other than Linear Technology's LTC1407A-1.


How to make stuff work on a Xilinx Spartan-3AN Starter Kit: 

1) get a Xilinx Spartan-3AN Starter Kit.

2) Download & install Xilinx ISE (http://www.xilinx.com/products/design-tools/ise-design-suite.html)

3) create a new .xise project and add all source files included in this repo. At this poin Xilinx ISE should automatically set 
"main.v" as the top-level module (if not do it manually).

5) connect a VGA monitor to the VGA port of the kit board. 

4) feed some analog signals to the adc ports.

6) enjoy.

