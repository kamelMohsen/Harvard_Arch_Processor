LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ZeroExtender IS PORT (
    INST: IN std_logic_vector(31 DOWNTO 16);
    BufferOut, AluOut: OUT std_logic_vector(31 DOWNTO 0)
);
END ENTITY ZeroExtender;

ARCHITECTURE arch1 OF ZeroExtender IS 
begin
    BufferOut <= "0000000000000000" & INST;
    AluOut <= "0000000000000000" & INST;
end arch1;