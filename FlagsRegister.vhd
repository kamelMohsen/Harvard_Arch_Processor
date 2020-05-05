LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY FlagsRegister IS PORT(
    NegativeInput, CarryInput, ZeroInput: IN std_logic;
    DataMemoryInput: IN std_logic_vector(2 DOWNTO 0);
    SETC_CLRC, RETI: IN std_logic_vector;
    ZeroOutput, NegativeOutput, CarryOutput: OUT std_logic;
    MainOutput: OUT std_logic_vector(2 DOWNTO 0)
);
END ENTITY FlagsRegister;


ARCHITECTURE arch1 OF FlagsRegister IS 
begin
    
    end arch1;