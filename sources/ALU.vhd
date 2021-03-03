----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2019 07:04:33 PM
-- Design Name: 
-- Module Name: ALU - structural
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
--  Port ( );
    generic (M : integer := 32);
    port (
            in1,in2 : in std_logic_vector(M-1 downto 0); -- inputs to ALU
            control : in std_logic_vector(3 downto 0);
            out1 : out std_logic_vector(M-1 downto 0)
    );
end ALU;

architecture structural of ALU is
    -- Declare and gate component
    component andN is
        generic (N : integer := 32); -- bit width
        port (
                a,b : in std_logic_vector (N-1 downto 0);
                y : out std_logic_vector (N-1 downto 0)
        );
    end component ;
    component notN is
        generic (N : integer := 32); --bit width
        port (
                a : in std_logic_vector (N -1 downto 0);
                y : out std_logic_vector (N -1 downto 0)
        );
    end component;
-- Declare the or gate component
    component orN is
        generic ( N : integer := 32); -- bit width
        port (
                a,b : in std_logic_vector (N -1 downto 0);
                y : out std_logic_vector (N -1 downto 0)
        );
    end component ;
    
    component sllN is
        generic (N : integer := 32); --bit width
        port (
                a : in std_logic_vector (N -1 downto 0);
                shift_amt : in std_logic_vector (N -1 downto 0);
                y : out std_logic_vector (N -1 downto 0)
        );
    end component;
    
-- declare the xor gate component    
    component xorN is
        generic ( N : integer := 32); -- bit width
        port (
                a : in std_logic_vector (N -1 downto 0);
                b : in std_logic_vector (N -1 downto 0);
                y : out std_logic_vector (N -1 downto 0)
        );
    end component ;
-- declare the shift right arithmetic component    
    component sraN is
        generic ( N : integer := 32); -- bit width
        port (
                a : in std_logic_vector (N -1 downto 0);
                shift_amt : in std_logic_vector (N -1 downto 0);
                y : out std_logic_vector (N -1 downto 0)
        );
    end component ;
-- declare the shift right logical component    
    component srlN is
        generic ( N : integer := 32); -- bit width
        port (
                a : in std_logic_vector (N -1 downto 0);
                shift_amt : in std_logic_vector (N -1 downto 0);
                y : out std_logic_vector (N -1 downto 0)
        );
    end component ;
    
    component ripplecarry_fa is
        generic(N : integer := 32);
        port (
                a,b : in std_logic_vector(N-1 downto 0); -- addends or minuend/subtrahend
                sum : out std_logic_vector(N-1 downto 0) -- sum or difference
        );
    end component;
    component multU is 
    generic(N : integer := 16);
    port (
            a,b : in std_logic_vector(N-1 downto 0); -- first / second factors
            product : out std_logic_vector(N*2-1 downto 0));
    end component;
    
    signal add_result : std_logic_vector(M-1 downto 0);
    signal sub_result : std_logic_vector(M-1 downto 0);
    signal mult_result : std_logic_vector(M-1 downto 0);
    signal and_result : std_logic_vector(M-1 downto 0);
    signal or_result : std_logic_vector(M-1 downto 0);
    signal xor_result : std_logic_vector(M-1 downto 0);
    signal sra_result : std_logic_vector(M-1 downto 0);
    signal srl_result : std_logic_vector(M-1 downto 0);
    signal sll_result : std_logic_vector(M-1 downto 0);
    signal two_comp : std_logic_vector(M-1 downto 0);
    signal in2_not : std_logic_vector(M-1 downto 0);
    
begin
    in2_not <= not in2 + 1;
    two_comp <= std_logic_vector(in2_not);  -- handle subtraction
    -- instantiante components w generic and port maps
    rcfs_comp : ripplecarry_fa
        generic map(N => M)
        port map(a=> in1, b => two_comp, sum => sub_result);
    rcfa_comp : ripplecarry_fa
        generic map(N => M)
        port map(a => in1, b => in2, sum => add_result);
    and_comp : andN
        generic map(N => M)
        port map(a => in1, b => in2, y => and_result);
    or_comp : orN
        generic map(N => M)
        port map(a => in1, b => in2, y => or_result);
    xor_comp : xorN
        generic map(N => M)
        port map(a => in1, b => in2, y => xor_result);
    sll_comp : sllN
        generic map(N => M)
        port map(a => in1, shift_amt => in2, y => sll_result);
    sra_comp : sraN
        generic map(N => M)
        port map(a => in1, shift_amt => in2, y => sra_result);
    srl_comp : srlN
        generic map(N => M)
        port map(a => in1, shift_amt => in2, y => srl_result);
    mult_comp : multU
        generic map(N => M/2)
        port map(a => in1(M/2-1 downto 0), b => in2(M/2-1 downto 0), product => mult_result);
        
    with control select out1 <=
        add_result when "0100",
        sub_result when "0101",
        and_result when "1010",
        mult_result when "0110",
        or_result when "1000",
        xor_result when "1011",
        sll_result when "1100",
        sra_result when "1110",
        srl_result when "1101",
        (others => '0') when others;
end structural;
