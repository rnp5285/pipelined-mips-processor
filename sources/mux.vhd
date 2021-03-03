----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/05/2019 06:26:49 PM
-- Design Name: 
-- Module Name: mux - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux is
--  Port ( );
    port (
            jump : in std_logic;
            jumpAddr,pcSrc : in std_logic_vector (27 downto 0);
            pcAddr : out std_logic_vector (27 downto 0)
    );
end mux;

architecture Behavioral of mux is
begin
    pcAddr <= jumpAddr when (jump = '1') else PCSrc;
end Behavioral;
