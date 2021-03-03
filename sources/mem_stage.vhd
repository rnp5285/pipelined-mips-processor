-- --------------------------------------------------------------------------------
-- Company : Rochester Institute of Technology (RIT )
-- Engineer : Rohan Patil (rnp5285@rit.edu)
--
-- Create Date : 3/19/19
-- Design Name : mem_stage
-- Module Name : mem_stage - structural
-- Project Name : ex6
-- Target Devices : Basys3
--
-- Description : memory stage using data memory  
-- --------------------------------------------------------------------------------

library IEEE ;
use IEEE . STD_LOGIC_1164 .ALL ;
use IEEE . STD_LOGIC_UNSIGNED .ALL;
use IEEE . NUMERIC_STD .ALL;

entity mem_stage is
    generic (
            N : integer := 32;
            M : integer := 5);
    port (
            clk : in std_logic;
            ALUResult,MemWrData : in std_logic_vector(N-1 downto 0);    -- result of ALU from execute, data to be written to data_mem // last 10 bits of aluresult is addr
            ExMemWr,ExMemRd : in std_logic; -- write/read bit from execute, passes to wb stage
            ExMemWbIdx : in std_logic_vector(M-1 downto 0); -- wb idx from execute, passes to wb stage
            RegData,MemData : out std_logic_vector(N-1 downto 0);   -- reg data from exec, data retrieved from data_mem
            MemWr,MemRd : out std_logic;    -- mem write/read bit
            WbIdx : out std_logic_vector(M-1 downto 0));    -- writeback idx
end mem_stage;

architecture structural of mem_stage is
    component data_mem is
        generic (
                width : integer := 32;  -- width of each section of memory
                addr_space : integer := 10);    -- number of bits available for addressing
        port (
                clk,w_en : in std_logic;    -- clock, write enable
                addr : in std_logic_vector(addr_space-1 downto 0);  -- address to write/read from
                d_in : in std_logic_vector(width-1 downto 0);   -- data to be written to mem
                d_out : out std_logic_vector(width-1 downto 0));    -- data being read from addr            
    end component;
begin        
    data_mem_comp : data_mem
        generic map(
                width => 32, 
                addr_space => 10)
        port map(
                clk => clk,
                w_en => ExMemWr,
                addr => ALUResult(9 downto 0),  -- address is last 10 bits of ALUResult
                d_in => MemWrData, 
                d_out => MemData);
        MemWr <= ExMemWr;   -- these inputs are directly tied to respective outputs for memory stage
        MemRd <= ExMemRd;
        WbIdx <= ExMemWbIdx;
        RegData <= ALUResult;
end structural;