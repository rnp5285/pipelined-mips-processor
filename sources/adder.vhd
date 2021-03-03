-- --------------------------------------------------------------------------------
-- Company : Rochester Institute of Technology (RIT )
-- Engineer : Rohan Patil (rnp5285@rit.edu)
--
-- Create Date : 2/19/19
-- Design Name : adder
-- Module Name : adder - behavioral
-- Project Name : ex3
-- Target Devices : Basys3
--
-- Description : adder incrementing program counter by 1
-- --------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE . STD_LOGIC_UNSIGNED .ALL;
use IEEE . NUMERIC_STD .ALL;

entity adder is
    port (
            addr : in std_logic_vector(27 downto 0);
            pcNext : out std_logic_vector(27 downto 0)
    );
end adder;

architecture behav of adder is
begin
    -- adds 4 to the address and converts it back to std_logic_vector
    pcNext <= std_logic_vector(to_unsigned(to_integer(unsigned(addr)) + 4, 28));
end behav;
