LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Execute_OutPort IS PORT (
en: IN std_logic;
input1: IN std_logic_vector(31 DOWNTO 0);
clk: IN std_logic;
output1: OUT std_logic_vector(31 DOWNTO 0)
);
END ENTITY Execute_OutPort;

ARCHITECTURE Execute_OutPort_ARCH of Execute_OutPort IS 

COMPONENT Execute_DFF_32 IS PORT( 
d:IN std_logic_vector(31 DOWNTO 0);
clk,rst,en : IN std_logic;
q : OUT std_logic_vector(31 DOWNTO 0)
);
END COMPONENT;


BEGIN
Outport_reg: Execute_DFF_32 PORT MAP(input1, clk,'0',en,output1);
END Execute_OutPort_ARCH;