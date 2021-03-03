-- --------------------------------------------------------------------------------
-- Company : Rochester Institute of Technology (RIT )
-- Engineer : Rohan Patil (rnp5285@rit.edu)
--
-- Create Date : 1/15/19
-- Design Name : sraN
-- Module Name : sraN - behavioral
-- Project Name : ex1
-- Target Devices : Basys3
--
-- Description : N-bit arithmetic right shift (SRA ) unit
-- --------------------------------------------------------------------------------
library IEEE ;
use IEEE . STD_LOGIC_1164 .ALL ;
use IEEE . STD_LOGIC_UNSIGNED .ALL;
use IEEE . NUMERIC_STD .ALL;
entity sraN is
    generic (N : integer := 32); --bit width
    port (
            a : in std_logic_vector (N -1 downto 0);
            shift_amt : in std_logic_vector (N -1 downto 0);
            y : out std_logic_vector (N -1 downto 0)
    );
end sraN ;
architecture behavioral of sraN is
begin
    process (A, SHIFT_AMT ) is
        variable int_shamt : integer ;
    begin
        int_shamt := to_integer ( unsigned ( SHIFT_AMT ));
        for i in N -1 downto 0 loop
            if (i + int_shamt <= N-1) then
                Y(i) <= A(i + int_shamt );
            else
                Y(i) <= A(N-1);
            end if;
        end loop ;
    end process ;
end behavioral ;