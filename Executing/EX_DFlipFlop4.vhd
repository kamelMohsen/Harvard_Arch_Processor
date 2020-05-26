LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Execute_DFF_4 IS
PORT( 
d:IN std_logic_vector(3 DOWNTO 0);
clk,rst,en : IN std_logic;
q : OUT std_logic_vector(3 DOWNTO 0)
);
END Execute_DFF_4;

ARCHITECTURE DFF_4_ARCH OF Execute_DFF_4 IS
BEGIN
PROCESS(clk,rst)
BEGIN
IF(rst = '1') THEN
q <= (Others => '0');
ELSIF clk'event and clk = '0' then
   IF en = '1' THEN
        q <= d;
    END IF;
END IF;
END PROCESS;
END DFF_4_ARCH;