-- --------------------------------------------------------------------------------
-- Company : Rochester Institute of Technology (RIT )
-- Engineer : Rohan Patil (rnp5285@rit.edu)
--
-- Create Date : 1/15/19
-- Design Name : xorN
-- Module Name : xorN - dataflow
-- Project Name : ex1
-- Target Devices : Basys3
--
-- Description : N-bit bitwise AND unit
-- --------------------------------------------------------------------------------
library IEEE ;
use IEEE . STD_LOGIC_1164 .ALL ;
entity xorN is
    GENERIC (N : integer := 32); --bit width
    PORT (
            A : in std_logic_vector (N -1 downto 0);
            B : in std_logic_vector (N -1 downto 0);
            Y : out std_logic_vector (N -1 downto 0)
    );
end xorN ;
architecture dataflow of xorN is
begin
    Y <= A xor B;
end dataflow ;