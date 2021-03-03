----------------------------------------------------------------------------------
-- Company:  Rochester Institute of Technology
-- Engineer: Thomas Guerin (tgg7337@rit.edu)
--
-- Create Date:    17:04:50 02/26/2015
-- Modified Date:  17:33:47 04/19/2018
-- Design Name:
-- Module Name:    register_file - Behavioral
-- Project Name:   lab02
-- Target Devices: Xilinx Spartan 6
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_file is
	PORT (
		rst, clk, we : IN STD_LOGIC;
		rd1, rd2, wr : IN STD_LOGIC_VECTOR(4 downto 0);
		din          : IN STD_LOGIC_VECTOR(31 downto 0);

		out1, out2   : OUT STD_LOGIC_VECTOR(31 downto 0)
	);
end register_file;

architecture reg_arch of register_file is
    type vec_array is array(0 to 31) of std_logic_vector(31 downto 0);
    signal reg_array : vec_array;

begin

    write_proc: process(rst, clk) is
    begin
        -- asynchronous reset
        if rst = '1' then
            for i in 0 to 31 loop
                reg_array(i) <= (others => '0');
            end loop;
        else
            if clk'event and clk='0' then
                -- write when enabled
                if we = '1' and wr /= "00000" then
                    reg_array(to_integer(unsigned(wr))) <= din;
                end if;
            end if;
        end if;
    end process;

    -- read registers asynchronously (rd=0 always returns 0)
    out1 <= (others => '0') when rd1 = "00000" else reg_array(to_integer(unsigned(rd1)));
    out2 <= (others => '0') when rd2 = "00000" else reg_array(to_integer(unsigned(rd2)));

end reg_arch;
