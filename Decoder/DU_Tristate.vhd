LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY DECODER_Tristate IS 
	PORT( INP : IN std_logic_vector(31 DOWNTO 0);
	      EN : IN std_logic; 
	      OUTP : OUT std_logic_vector(31 DOWNTO 0));
END DECODER_Tristate;

ARCHITECTURE DECODER_Tristate_ARCH OF DECODER_Tristate IS
BEGIN
	PROCESS(EN,INP)
	BEGIN
		IF(EN='0') THEN
			OUTP <= (OTHERS=>'Z');
		ELSIF EN='1' THEN
			OUTP <= INP;
		END IF;
	END PROCESS;
END DECODER_Tristate_ARCH;
