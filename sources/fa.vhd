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
entity fa is
    port(
        a,b,cin : in std_logic;
        sum,cout : out std_logic 
    );
end fa;

architecture dataflow of fa is
begin
    sum <= a xor b xor cin;
    cout <= ((a xor b) and cin) or (a and b);
end dataflow;