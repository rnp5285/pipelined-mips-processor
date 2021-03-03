----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2019 01:16:21 PM
-- Design Name: 
-- Module Name: microprocessor_tb - behav
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity microprocessor_tb is
end microprocessor_tb;

architecture behav of microprocessor_tb is
component microprocessor is
    port (
    clk,rst : in std_logic;
    ALUResult : out std_logic_vector(31 downto 0)); 
end component;
    
    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal ALUResult : std_logic_vector(31 downto 0);
        
    constant delay : time := 50 ns;
begin
  
    mipsy : microprocessor
    port map(clk => clk,
        rst => rst,
        ALUResult => ALUResult);
  
    -- clk process
    clk <= not clk after delay / 2; 
  
    process is begin
    
        wait for delay;
        rst <= '0';
--        jump <= '1';

--        jumpAddr <=x"0000040";  -- fibonacci

        
--        jump <= '0';
        -- 26 & 34
        for i in 0 to 40 loop
            wait for delay;
        end loop;

        wait;
    end process;
end behav;
