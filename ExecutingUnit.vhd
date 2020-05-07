LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ExecutingUnit IS PORT(
PC: IN std_logic_vector(31 DOWNTO 0);
Read1: IN std_logic_vector(31 DOWNTO 0);
Read2: IN std_logic_vector(31 DOWNTO 0);
Zero_Two:IN std_logic_vector(2 DOWNTO 0);
Three_Eight:IN std_logic_vector(6 DOWNTO 0);
Six_Eight:IN std_logic_vector(2 DOWNTO 0);
Zero_Four:IN std_logic_vector(4 DOWNTO 0);
Sixteen_ThirtyOne:IN std_logic_vector(16 DOWNTO 0)
);


ARCHITECTURE exec OF ExecutingUnit IS 
BEGIN



END exec;