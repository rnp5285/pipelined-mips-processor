-- --------------------------------------------------------------------------------
-- Company : Rochester Institute of Technology (RIT )
-- Engineer : Rohan Patil (rnp5285@rit.edu)
--
-- Create Date : 1/15/19
-- Design Name : srlN
-- Module Name : srlN - behavioral
-- Project Name : ex1
-- Target Devices : Basys3
--
-- Description : N-bit logical right shift (SRL ) unit
-- --------------------------------------------------------------------------------
library IEEE ;
use IEEE . STD_LOGIC_1164 .ALL ;
use IEEE . STD_LOGIC_UNSIGNED .ALL;
use IEEE . NUMERIC_STD .ALL;
entity srlN is
    GENERIC (N : integer := 32); --bit width
    PORT (
            a : in std_logic_vector (N -1 downto 0);
            shift_amt : in std_logic_vector (N -1 downto 0);
            y : out std_logic_vector (N -1 downto 0)
    );
end srlN ;
architecture behavioral of srlN is
begin
    process (A, SHIFT_AMT ) is
        variable int_shamt : integer ;
    begin
        int_shamt := to_integer ( unsigned ( SHIFT_AMT ));
        for i in 0 to N-1 loop
            if (int_shamt <= N - 1) then
                Y(i) <= A(int_shamt );
                int_shamt := int_shamt + 1;
            else
                Y(i) <= '0'; -- replace new bits with 0
                int_shamt := int_shamt + 1;
            end if;
        end loop ;
    end process ;
end behavioral ;