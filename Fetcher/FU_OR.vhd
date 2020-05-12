LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY FU_OR IS
 	PORT ( Input0, Input1 :IN STD_LOGIC; 
	Output0: OUT STD_LOGIC
	);
END ENTITY FU_OR;


ARCHITECTURE FU_OR_ARCH OF FU_OR IS
BEGIN
	Output0 <= '1' WHEN Input0 ='1' OR Input1 ='1'  
	ELSE '0' ;             
END FU_OR_ARCH;