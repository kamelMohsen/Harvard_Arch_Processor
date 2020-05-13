LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Execute_DFF_32 IS
PORT( 
d:IN std_logic_vector(31 DOWNTO 0);
clk,rst,en : IN std_logic;
q : OUT std_logic_vector(31 DOWNTO 0)
);
END Execute_DFF_32;

ARCHITECTURE DFF_32_ARCH OF Execute_DFF_32 IS
BEGIN
PROCESS(clk,rst)
BEGIN
IF(rst = '1') THEN
q <= (Others => '0');
ELSIF clk'event and clk = '0' AND en = '1' THEN
q <= d;

END IF;
END PROCESS;
END DFF_32_ARCH;