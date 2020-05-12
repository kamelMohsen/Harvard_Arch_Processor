LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY DECODER_WriteEnable IS 
	PORT( INP : IN std_logic_vector(1 DOWNTO 0);
	      OutpDec2,OutpDec1 : OUT std_logic);
END DECODER_WriteEnable;

ARCHITECTURE DECODER_WriteEnable_ARCH OF DECODER_WriteEnable IS
BEGIN
	OutpDec2 <=     '0' WHEN  (INP="00") OR (INP="11") OR (INP="01")

			ELSE '1' WHEN (INP="10");

	OutpDec1 <=     '0' WHEN  (INP="00") OR (INP="11")

			ELSE '1' WHEN (INP="01") OR (INP="10");
			
			


					
END DECODER_WriteEnable_ARCH;
