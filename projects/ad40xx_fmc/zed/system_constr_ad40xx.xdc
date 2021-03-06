
# ad40xx_fmc SPI interface

set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS25 IOB TRUE} [get_ports ad40xx_spi_sdo]       ; ## H07  FMC_LPC_LA02_P
set_property -dict {PACKAGE_PIN N19 IOSTANDARD LVCMOS25 IOB TRUE} [get_ports ad40xx_spi_sdi]       ; ## D08  FMC_LPC_LA01_CC_P
set_property -dict {PACKAGE_PIN M19 IOSTANDARD LVCMOS25 IOB TRUE} [get_ports ad40xx_spi_sclk]      ; ## G06  FMC_LPC_LA00_CC_P
set_property -dict {PACKAGE_PIN M20 IOSTANDARD LVCMOS25 IOB TRUE} [get_ports ad40xx_spi_cs]        ; ## G07  FMC_LPC_LA00_CC_N

set_property -dict {PACKAGE_PIN P22 IOSTANDARD LVCMOS25} [get_ports ad40xx_amp_pd]        ; ## G10  FMC_LPC_LA03_N

## There is a multi-cycle path between the axi_spi_engine's SDO_FIFO and the
# execution's shift register, because we load new data into the shift register
# in every DATA_WIDTH's x 2 cycle. (worst case scenario)
# Set a multi-cycle delay of 2 spi_clk cycle, slightly over constraining the path.
set_multicycle_path 2 -setup -from [get_cells -hierarchical -filter {NAME=~*/i_sdo_fifo/i_mem/m_ram_reg}] -to [get_pins -hierarchical -filter {NAME=~*/data_sdo_shift_reg[*]/D}]
set_multicycle_path 1 -hold  -from [get_cells -hierarchical -filter {NAME=~*/i_sdo_fifo/i_mem/m_ram_reg}] -to [get_pins -hierarchical -filter {NAME=~*/data_sdo_shift_reg[*]/D}]

