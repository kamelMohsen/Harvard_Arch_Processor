LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY DECODER_Register IS 
	PORT( WriteData1,WriteData2 : IN std_logic_vector(31 DOWNTO 0);
	      CLK,RST : IN std_logic; 
	      EnData1,EnData2: IN std_logic;
	      Q : OUT std_logic_vector(31 DOWNTO 0));
END DECODER_Register;

ARCHITECTURE DECODER_Register_ARCH OF DECODER_Register IS
BEGIN
	PROCESS(CLK,RST)
	BEGIN
		IF(RST = '1') THEN
			Q <= (OTHERS=>'0');
		ELSIF falling_edge(CLK) THEN
			IF EnData1='1' THEN
				Q <= WriteData1;
			ELSIF  EnData2='1' THEN
				Q <= WriteData2;
			END IF;
		END IF;
	END PROCESS;
END DECODER_Register_ARCH;
