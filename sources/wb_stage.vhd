-- --------------------------------------------------------------------------------
-- Company : Rochester Institute of Technology (RIT )
-- Engineer : Rohan Patil (rnp5285@rit.edu)
--
-- Create Date : 3/19/19
-- Design Name : wb_stage
-- Module Name : wb_stage - behavioral
-- Project Name : ex6
-- Target Devices : Basys3
--
-- Description : verilog translated writeback stage - redirects signals back into previous stages  
-- --------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity wb_stage is
        port (
            MemWbIdx : in std_logic_vector(4 downto 0); -- writeback idx
            MemWr,MemRd : in std_logic; -- bit that determines to write / data was read
            RegData,MemData : in std_logic_vector(31 downto 0); -- data passed in from reg / from memory
            WbData : out std_logic_vector(31 downto 0); -- data to be written back 
            WbIdx : out std_logic_vector(4 downto 0);   -- writeback idx
            WbEn : out std_logic);  -- bit that determines if anything was written back            
end wb_stage;

architecture behav of wb_stage is
begin
    process(MemData,MemRd,RegData)
    begin
        if MemRd = '1' then
            WbData <= MemData;  -- if data was read, data from memory passed to write back
        else
            WbData <= RegData;  -- else data from register passed to write bacl
        end if;           
    end process;
--    WbData <= RegData;
    WbIdx <= MemWbIdx;  -- tied to respective inputs 
    WbEn <= not MemWr;
end behav;
