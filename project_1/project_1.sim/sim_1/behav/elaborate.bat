@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto bf012efcabd8415187872d9e023a8601 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip -L xpm --snapshot microprocessor_tb_behav xil_defaultlib.microprocessor_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
