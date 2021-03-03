-- --------------------------------------------------------------------------------
-- Company : Rochester Institute of Technology (RIT )
-- Engineer : Rohan Patil (rnp5285@rit.edu)
--
-- Create Date : 2/19/19
-- Design Name : instr_decode
-- Module Name : instr_decode - behavioral
-- Project Name : ex4
-- Target Devices : Basys3
--
-- Description : 32-bit instruction decode  
-- --------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instr_decode is
    port (
            instruction : in std_logic_vector(31 downto 0); -- opcode for instruction being decoded
            regDataA,regDataB : in std_logic_vector(31 downto 0);    -- data from the first/second reg file
            jump : out std_logic;   -- determines whether or not to jump
            jumpAddr : out std_logic_vector(27 downto 0);   -- address to jump to
            valA,valB : out std_logic_vector(31 downto 0);  -- first/second value for ALU to act on
            memWr : out std_logic;  -- tells if writing to memory
            memRd : out std_logic;  -- tells if reading from memory
            aluOP : out std_logic_vector(3 downto 0);   -- opcode specific to ALU
            regIdxA,regIdxB : out std_logic_vector(4 downto 0); -- index to access in first/second reg
            regIdxWb : out std_logic_vector(4 downto 0);    -- reg index for writeback, destination reg
            regEnWb : out std_logic -- determines if register is being written to
            );
             
end instr_decode;

architecture behav of instr_decode is
    -- output signals
    signal Ojump,OmemWr,OmemRd,OregEnWb : std_logic;
    signal OvalA,OvalB : std_logic_vector(31 downto 0);
    signal OjumpAddr : std_logic_vector(27 downto 0);
    signal OaluOP : std_logic_vector(3 downto 0);
    signal OregIdxA,ORegIdxB,oRegIdxWb : std_logic_vector(4 downto 0);
begin
    process(instruction)    
    begin                    
           -- jump only high when performing jump operations.
        OmemWr <= '0';	-- memWr only high when writing to memory (store i-type)
        OmemRd <= '0';	-- memRd only high when reading from memory (load i-type)
        case instruction(31 downto 26) is	-- case opcode
            when "000000" =>    -- R-Type
                Ojump <= '0';
                valA <= regDataA;
                valB <= regDataB;
                OregIdxA <= instruction(25 downto 21);	-- rs
                OregIdxB <= instruction(20 downto 16);	-- rt
                OregIdxWb <= instruction(15 downto 11);	-- rd
                ORegEnWb <= '1';	-- write is high
                case instruction(5 downto 0) is	-- case function, assign OalOP signal
                    when "100000" =>    -- ADD
                        OaluOP <= "0100";
                    when "100100" =>    -- AND
                        OaluOP <= "1010";
                    when "011001" =>    -- MULTIU
                        OaluOP <= "0110";
                    when "100101" =>    -- OR
                        OaluOP <= "1000";
                    when "000000" =>    -- SLL
                        OaluOP <= "1100";
                    when "000011" =>    -- SRA
                        OaluOP <= "1110";
                    when "000010" =>    -- SRL
                        OaluOP <= "1101";
                    when "100011" =>    -- SUB
                        OaluOP <= "0101";
                    when others =>    -- XOR
                        OaluOP <= "1011";              
                end case;   
            -- I-Type
            when "001000" | "001100" | "001101" | "001110" | "001111" | "100011" =>
                Ojump <= '0';    
                valA <= regDataA;
                OregIdxA <= instruction(25 downto 21);	-- rs
                OregIdxWb <= instruction(20 downto 16);	-- rt
                OregEnWb <= '1';
                case instruction(15) is	-- case msb of immm
                    when '1' =>	-- sign extend
                        valB <= x"1111" & instruction(15 downto 0); --immm
                    when others =>
                        valB <= x"0000" & instruction(15 downto 0);
                end case;
				-- assign OaluOP signal
                if instruction(31 downto 26) = "001000" then    -- ADDI
                    OaluOP <= "0100";
                elsif instruction(31 downto 26) = "001100" then -- ANDI
                    OaluOP <= "1010";
                elsif instruction(31 downto 26) = "001101" then -- ORI
                    OaluOP <= "1000";
                elsif instruction(31 downto 26) = "001110" then -- XORI
                    OaluOP <= "1011";      
                elsif instruction(31 downto 26) = "001111" then -- SW,ADD
                    OaluOP <= "0100";
                    OmemWr <= '1';	-- writing to memory
                    OregEnWb <= '0';	-- not writing to a register
                else    -- LW,ADD
                    OaluOP <= "0100";
                    OmemRd <= '1';	-- reading from memory                
                end if;
            -- Jump Type
            when others => --shift left by two, opcode out doesnt matter
                Ojump <= '1';
                OregEnWb <= '0';
                OjumpAddr <=  instruction(25 downto 0) & "00";	-- add two zero bits to 2 most lsb
--                std_logic_vector(shift_left(unsigned(addr),2))
        end case;        
    end process;
	-- instr_decode output / signal assignment
    jump <= Ojump;
    jumpAddr <= OjumpAddr;
--    valA <= OvalA;
--    valB <= OvalB;
    memWr <= OmemWr;
    memRd <= OmemRd;
    aluOP <= OaluOP;
    regIdxA <= OregIdxA;
    regIdxB <= OregIdxB;
    regIdxWb <= OregIdxWb;
    regEnWb <= OregEnWb;
end behav;
