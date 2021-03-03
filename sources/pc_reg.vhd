-- --------------------------------------------------------------------------------
-- Company : Rochester Institute of Technology (RIT )
-- Engineer : Rohan Patil (rnp5285@rit.edu)
--
-- Create Date : 2/19/19
-- Design Name : pc_reg
-- Module Name : pc_reg - behavioral
-- Project Name : ex3
-- Target Devices : Basys3
--
-- Description :  program counter register that holds the address of instruction being executed  
-- --------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pc_reg is
    port (
            clk,rst : in std_logic;
            pcAddr : in std_logic_vector(27 downto 0);
            addr : out std_logic_vector(27 downto 0)
    );
end pc_reg;

architecture behav of pc_reg is
    -- output signal
    signal addrO : std_logic_vector(27 downto 0);
begin
    process(clk,rst,pcAddr)
    begin
        if rst = '1' then   -- reset active high
            addrO <= (others => '0');
        else
            if rising_edge(clk) then
                addrO <= pcAddr;    -- rising_edge output
            end if;
        end if;
    end process;
    addr <= addrO;  -- output assignment
end behav;
