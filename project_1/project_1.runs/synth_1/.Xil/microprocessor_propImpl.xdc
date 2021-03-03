set_property SRC_FILE_INFO {cfile:c:/Users/rohan/Documents/dsd2/proj1/project_1/project_1.srcs/sources_1/ip/clk_wiz_1/clk_wiz_1.xdc rfile:../../../project_1.srcs/sources_1/ip/clk_wiz_1/clk_wiz_1.xdc id:1 order:EARLY scoped_inst:your_instance_name/inst} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.1
