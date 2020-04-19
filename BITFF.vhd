LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY	bitFF IS
	PORT
	( d,clk,rst,enable : IN std_logic; q : OUT std_logic);
	END
bitFF;

ARCHITECTURE ModelBitFF OF bitFF IS
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
END ModelBitFF;