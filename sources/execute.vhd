----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/05/2019 04:27:27 PM
-- Design Name: 
-- Module Name: execute - behav
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity execute is
--  Port ( );
    generic(N : integer := 32);
    port (
            ALUOp : in std_logic_vector(3 downto 0);
            IdExA,IdExB : in std_logic_vector(N-1 downto 0);
            IdExWbIdx : in std_logic_vector(4 downto 0);
            IdExWbEn,IdExMemRd,IdExMemWr :  in std_logic;
            MemWrData : out std_logic_vector(N-1 downto 0);
            ALUResult : out std_logic_vector(N-1 downto 0);
            ExMemWbIdx : out std_logic_vector(4 downto 0);
            ExMemWbEn,ExMemRd,ExMemWr : out std_logic         
    );
end execute;

architecture behav of execute is
    component ALU is
    generic(M : integer := 32);
    port (
            in1,in2 : in std_logic_vector(M-1 downto 0); -- inputs to ALU
            control : in std_logic_vector(3 downto 0);
            out1 : out std_logic_vector(M-1 downto 0)
    );    
    end component;
    signal outs : std_logic_vector(N-1 downto 0);
begin
    ExMemWbIdx <= IdExWbIdx;
    ExMemWbEn <= IdExWbEn;
    ExMemRd <= IdExMemRd;
    ExMemWr <= IdExMemWr;
    ALUResult <= outs;
    alu_inst : ALU
    generic map(M => N)
    port map(in1 => IdExA, in2 => IdExB, control => ALUOp, out1 => outs);
    
    process(IdExB,outs,IdExMemWr)
    begin
        if IdExMemWr = '1' then -- fix
            MemWrData <= IdExB;
        else
            MemWrData <= outs;
        end if;
    end process;
end behav;
