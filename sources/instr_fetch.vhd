-- --------------------------------------------------------------------------------
-- Company : Rochester Institute of Technology (RIT )
-- Engineer : Rohan Patil (rnp5285@rit.edu)
--
-- Create Date : 2/19/19
-- Design Name : instr_fetch
-- Module Name : instr_fetch - structural
-- Project Name : ex3
-- Target Devices : Basys3
--
-- Description :  instruction fetch module resembling the entirety of the fetch stage  
-- --------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity instr_fetch is
    port (
            jumpAddr,pcSrc : in std_logic_vector(27 downto 0);
            jump,clk,rst : in std_logic;
            pcNext : out std_logic_vector(27 downto 0);
            instruction : out std_logic_vector(31 downto 0)
    );
end instr_fetch;

architecture structural of instr_fetch is
    -- component declaration
    component instr_mem is
        port (
                addr : in std_logic_vector(27 downto 0);
                dout : out std_logic_vector(31 downto 0)
        );
    end component;
    component mux is
        port (
                jump : in std_logic;
                jumpAddr,pcSrc : in std_logic_vector (27 downto 0);
                pcAddr : out std_logic_vector (27 downto 0)
        );
    end component;
    component adder is
        port (
                addr : in std_logic_vector(27 downto 0);
                pcNext : out std_logic_vector(27 downto 0)
        );
    end component;
    component pc_reg is
        port (
                clk,rst : in std_logic;
                pcAddr : in std_logic_vector(27 downto 0);
                addr : out std_logic_vector(27 downto 0)
        );
    end component;
    -- signal declaration to connect components
    signal muxO : std_logic_vector(27 downto 0);
    signal pc_regO : std_logic_vector(27 downto 0);
    signal pcadd4 : std_logic_vector(27 downto 0);
begin
    -- mux, pc, adder, and memory instances
    mux_comp : mux
        port map (jumpAddr => jumpAddr, pcSrc => pcSrc, jump => jump, pcAddr => muxO);
    pc_reg_comp : pc_reg
        port map (clk => clk, rst => rst, pcAddr => muxO, addr => pc_regO);
    adder_comp : adder
        port map (addr => pc_regO, pcNext => pcNext);
    instr_mem_comp : instr_mem
        port map (addr => pc_regO, dout => instruction);
end structural;