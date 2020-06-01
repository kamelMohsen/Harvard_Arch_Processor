LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY	BOB_BITFF IS
	PORT
	( d,clk,rst,enable : IN std_logic; q : OUT std_logic);
	END
BOB_BITFF;

ARCHITECTURE BOB_BITFF_ARCH OF BOB_BITFF IS
BEGIN
	PROCESS(clk,rst)
	BEGIN
		IF (rst = '1') THEN 
			q <= '0';
		ELSIF clk'event and clk = '1' THEN
			IF enable ='1' THEN
				q<=d;
			END IF;
		END IF;
	END PROCESS;
END BOB_BITFF_ARCH;