LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY OutPort IS PORT (
sel: IN std_logic;
input: IN std_logic_vector(31 DOWNTO 0);
output: OUT std_logic_vector(31 DOWNTO 0)
);
END ENTITY OutPort;

ARCHITECTURE OutPort1 of OutPort IS 
BEGIN
output <= input when sel = '1'
else (Others => 'Z') when sel = '1';
END OutPort1;