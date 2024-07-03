# Set I/O standard and location for each port
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports led]

# Set location for each port (update these based on your specific FPGA board)
set_property PACKAGE_PIN L16 [get_ports clk]  # Example pin for clk
set_property PACKAGE_PIN N17 [get_ports rst]  # Example pin for rst
set_property PACKAGE_PIN P17 [get_ports led]  # Example pin for led

