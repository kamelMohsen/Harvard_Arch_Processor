LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY	MEM_BITFF IS
	PORT
	( d,clk,rst,enable : IN std_logic; q : OUT std_logic);
	END
MEM_BITFF;

ARCHITECTURE MEM_BITFF_ARCH OF MEM_BITFF IS
BEGIN
	PROCESS(clk,rst)
	BEGIN
		IF (rst = '1') THEN 
			q <= '1';
		ELSIF clk'event and clk = '0' THEN
			IF enable ='1' THEN
				q<=d;
			END IF;
		END IF;
	END PROCESS;
END MEM_BITFF_ARCH;