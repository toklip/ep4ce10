create_clock -period 25 [get_ports clk_40m]

derive_pll_clocks

set pll_128k [get_clocks {pll_inst*clk[0]}]
set clk_128k [get_clock_info -name $pll_128k]
create_generated_clock -name clk_500hz -source $clk_128k -divide_by 256 [get_registers {r500hz[7]}]

set_output_delay -clock [get_clocks clk_500hz] 0.5 [get_ports led*]

derive_clock_uncertainty
