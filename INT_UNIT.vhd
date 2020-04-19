LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY INT_UNIT IS
	GENERIC(Data_Width : INTEGER := 32); 
	PORT (INT_SIG, clk: IN STD_LOGIC;
	Change_to_INT_Commands: OUT STD_LOGIC;
	Instruction : OUT  STD_LOGIC_VECTOR(Data_Width - 1 DOWNTO 0)
	);
END ENTITY INT_UNIT;


ARCHITECTURE INT OF INT_UNIT IS
	SIGNAL Count : INTEGER RANGE 0 TO 7;

BEGIN	
	Instruction <= (others => '0');
	
	PROCESS(clk, INT_SIG, Count) IS
	BEGIN
		IF FALLING_EDGE(clk) THEN

			IF INT_SIG = '1' OR NOT (Count = 0) THEN 
				IF Count = 7 THEN 
					Count <= 0; 
				END IF;
				IF Count = 0 THEN
					Count <= Count + 1;
					Change_to_INT_Commands <= '1';
					Instruction <= (others => '0');
				ELSIF Count = 1 THEN	
					Count <= Count + 1;
					Instruction <= (others => '0');
				ELSIF Count = 2 THEN	
					Count <= Count + 1;
					Instruction <= (others => '0');
				ELSIF Count = 3 THEN	
					Count <= Count + 1;
					Instruction <= (others => '0');
				ELSIF Count = 4 THEN	
					Count <= Count + 1;
					Instruction <= (others => '0');
				ELSIF Count = 5 THEN	
					Count <= Count + 1;
					Instruction <= (others => '0');
				ELSIF Count = 6 THEN	
					Count <= Count + 1;
					Instruction <= (others => '0');
				ELSIF Count = 7 THEN	
					Instruction <= X"00000001" ;

				END IF;
				IF Count = 7 THEN
					Count <= 0;
				END IF;
			END IF;

			IF INT_SIG = '0' AND Count = 0 THEN
				Change_to_INT_Commands <= '0';
			END IF;		
		END IF;

	END PROCESS;     
END INT;