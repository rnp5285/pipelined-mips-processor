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
entity ripplecarry_fa is
    generic(N : integer := 32);
    port (
            a,b : in std_logic_vector(N-1 downto 0); -- addends or minuend/subtrahend
            sum : out std_logic_vector(N-1 downto 0) -- sum or difference
    );
end ripplecarry_fa;

architecture structural of ripplecarry_fa is
    component fa is 
        port(
            a,b,cin : in std_logic;
            sum,cout : out std_logic 
        );
    end component fa;
    
    signal w_cin : std_logic_vector(N downto 0);
    signal w_sum : std_logic_vector(N-1 downto 0);
begin
    w_cin(0) <= '0';    -- initial cin is 0
    add: for i in 0 to N-1 generate
        fa_inst : fa
            port map(
                a => a(i), b => b(i), cin => w_cin(i), sum => w_sum(i), cout => w_cin(i+1));
    end generate add;
        
    sum <= w_sum;
end structural;