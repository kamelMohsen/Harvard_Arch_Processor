LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY DECODER_mux IS 
	Generic ( n : Integer:=3);
	PORT ( Rsrc,Rdst : IN std_logic_vector (n-1 DOWNTO 0);
	       S : IN  std_logic;
	       OUT1 : OUT std_logic_vector (n-1 DOWNTO 0));
END DECODER_mux;


ARCHITECTURE DECODER_mux_ARCH OF DECODER_mux is
	BEGIN
		
  OUT1 <= 	Rsrc when S = '1'
	else	Rdst when S = '0';


END DECODER_mux_ARCH;
