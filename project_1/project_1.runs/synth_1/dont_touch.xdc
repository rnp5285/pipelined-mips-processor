# This file is automatically generated.
# It contains project source information necessary for synthesis and implementation.

# IP: ip/clk_wiz_1/clk_wiz_1.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==clk_wiz_1 || ORIG_REF_NAME==clk_wiz_1}]

# XDC: ip/clk_wiz_1/clk_wiz_1_board.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==clk_wiz_1 || ORIG_REF_NAME==clk_wiz_1}] {/inst }]/inst ]]

# XDC: ip/clk_wiz_1/clk_wiz_1.xdc
#dup# set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==clk_wiz_1 || ORIG_REF_NAME==clk_wiz_1}] {/inst }]/inst ]]

# XDC: ip/clk_wiz_1/clk_wiz_1_ooc.xdc