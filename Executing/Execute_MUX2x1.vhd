LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Execute_MUX2x1 IS
	GENERIC(Data_Width : INTEGER := 32); 
	PORT ( Input0, Input1 :IN STD_LOGIC_VECTOR(Data_Width - 1 DOWNTO 0); 
	Sel: IN STD_LOGIC;
	Output : OUT  STD_LOGIC_VECTOR(Data_Width - 1 DOWNTO 0)
	);
END ENTITY Execute_MUX2x1;


ARCHITECTURE Execute_MUX_ARCH OF Execute_MUX2x1 IS
BEGIN
	Output <= Input0 WHEN Sel ='0'  
	ELSE Input1 WHEN Sel ='1';             
END Execute_MUX_ARCH;