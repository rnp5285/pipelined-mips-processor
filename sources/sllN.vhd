-- --------------------------------------------------------------------------------
-- Company : Rochester Institute of Technology (RIT )
-- Engineer : Rohan Patil (rnp5285@rit.edu)
--
-- Create Date : 1/17/18
-- Design Name : sllN
-- Module Name : sllN - behavioral
-- Project Name : ex1
-- Target Devices : Basys3
--
-- Description : N-bit logical left shift (SLL ) unit
-- --------------------------------------------------------------------------------
library IEEE ;
use IEEE . STD_LOGIC_1164 .ALL ;
use IEEE . STD_LOGIC_UNSIGNED .ALL;
use IEEE . NUMERIC_STD .ALL;
entity sllN is
    generic (N : integer := 32); --bit width
	port (
            a : in std_logic_vector (N -1 downto 0);
            shift_amt : in std_logic_vector (N -1 downto 0);
            y : out std_logic_vector (N -1 downto 0)
	);
end sllN ;
architecture behavioral of sllN is
begin
	process (A, SHIFT_AMT ) is
		variable int_shamt : integer ;
	begin
		int_shamt := to_integer ( unsigned ( SHIFT_AMT ));
		for i in N -1 downto 0 loop
			if (i - int_shamt >= 0) then
				Y(i) <= A(i - int_shamt );
			else
				Y(i) <= '0';
			end if;
		end loop ;
	end process ;
end behavioral ;