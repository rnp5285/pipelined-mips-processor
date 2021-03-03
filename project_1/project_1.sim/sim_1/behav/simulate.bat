@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xsim microprocessor_tb_behav -key {Behavioral:sim_1:Functional:microprocessor_tb} -tclbatch microprocessor_tb.tcl -view C:/Users/rohan/Documents/dsd2/proj1/project_1/microprocessor_tb_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
