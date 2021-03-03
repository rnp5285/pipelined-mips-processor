-- --------------------------------------------------------------------------------
-- Company : Rochester Institute of Technology (RIT )
-- Engineer : Rohan Patil (rnp5285@rit.edu)
--
-- Create Date : 1/15/19
-- Design Name : andN
-- Module Name : andN - dataflow
-- Project Name : ex1
-- Target Devices : Basys3
--
-- Description : N-bit bitwise AND unit
-- --------------------------------------------------------------------------------
library IEEE ;
use IEEE . STD_LOGIC_1164 .ALL ;
entity andN is
    generic (N : integer := 32); --bit width
    port (
            a,b : in std_logic_vector (N -1 downto 0);
            y : out std_logic_vector (N -1 downto 0)
    );
end andN ;
architecture dataflow of andN is
begin
   y <= a and b;
end dataflow ;