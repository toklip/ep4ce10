create_clock -period 25 [get_ports clk_40m]

create_generated_clock -name clk_160k -source [get_ports clk_40m] -divide_by 250 [get_registers {r160k[7]}]
create_generated_clock -name clk_800hz -source [get_registers {r160k[7]}] -divide_by 200 [get_registers {r800hz[7]}]

set_output_delay -clock [get_clocks clk_800hz] 0.5 [get_ports led*]

derive_clock_uncertainty
