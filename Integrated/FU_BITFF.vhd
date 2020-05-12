LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY	FU_BITFF IS
	PORT
	( d,clk,rst,enable : IN std_logic; q : OUT std_logic);
	END
FU_BITFF;

ARCHITECTURE FU_BITFF_ARCH OF FU_BITFF IS
BEGIN
	PROCESS(clk,rst)
	BEGIN
		IF (rst = '1') THEN 
			q <= '0';
		ELSIF clk'event and clk = '0' THEN
			IF enable ='0' THEN
				q<=d;
			END IF;
		END IF;
	END PROCESS;
END FU_BITFF_ARCH;