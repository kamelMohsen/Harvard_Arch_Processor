LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY DECODER_WriteDecoder IS 
	PORT( INP : IN std_logic_vector(2 DOWNTO 0);
	      Enable,CLK: IN std_logic;
	      OUTP : OUT std_logic_vector(7 DOWNTO 0));
END DECODER_WriteDecoder;

ARCHITECTURE DECODER_writeDecoder_ARCH OF DECODER_WriteDecoder IS
BEGIN
	PROCESS(CLK,Enable)
	BEGIN
		IF Enable='0' THEN 
			OUTP <= (OTHERS=>'0');
		ELSIF Enable='1' THEN
			IF    (INP="000") THEN
			OUTP <= "00000001";
			ELSIF (INP="001") THEN
			OUTP <= "00000010";
			ELSIF (INP="010") THEN
			OUTP <= "00000100";
			ELSIF (INP="011") THEN
			OUTP <= "00001000";
			ELSIF (INP="100") THEN
			OUTP <= "00010000";
			ELSIF (INP="101") THEN
			OUTP <= "00100000";
			ELSIF (INP="110") THEN
			OUTP <= "01000000";
			ELSIF (INP="111") THEN
			OUTP <= "10000000";
			END IF;
		END IF;
	END PROCESS;

	
END DECODER_writeDecoder_ARCH;
