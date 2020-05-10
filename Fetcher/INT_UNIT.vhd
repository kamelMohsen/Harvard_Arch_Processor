LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY INT_UNIT IS
	GENERIC(Data_Width : INTEGER := 32); 
	PORT (INT_SIG, clk: IN STD_LOGIC;
	Change_to_INT_Commands: OUT STD_LOGIC;
	Instruction : OUT  STD_LOGIC_VECTOR(Data_Width - 1 DOWNTO 0);
	Reset : IN STD_LOGIC);
END ENTITY INT_UNIT;

--THIS UNIT DOES THE FOLLOWING WHEN THE INT SIGNAL IS INITIATED 
--FIRST IT PRODUCES NOP INSTRUCTION FOR 5 CLOCK CYCLES
--THEN IT PRODUCES THE INT INSTRUCTIONS WHICH TAKES 3 CYCLES 
--SO IN TOTAL THE INT SIGNAL WILL TAKE 8 CLOCK CYCLES TO COMPLETE
--THE WAY IT FUNCTION IS THAT IT TAKES CONTROL OVER THE PIPELINE FETCHING UNIT 
--USING THE INT SIGNAL AS AN INPUT IN THIS UNIT AND AS A SELECTOR FOR THE MUX WHICH HOLDS THE NORMAL INSTRUCTION THAT COMES FORM INSTRUCTION MEMORY 
--MAKING THE CHANGE_TO_INT COMMAND IS THE MUX SELECTOR AND PC STALLER IS THE WAY THAT ENSURES THE STALL OF PIPELINE FOR 8 CLOCK CYCLES
--THE EXPECTED OUTPUT IS THAT THE UNIT WILL PRODUCE 32 BIT OF ZEROS FOR 5 CLOCK CYCLES
--THEN AFTER THAT IT WILL PRODUCE THE CUSTOM INSTRUCTION TO PUSH FLAGS
--THEN AFTER THAT IT WILL PRODUCE THE CUSTOM INSTRUCTION TO POP M[3] & M[2]
--THEN AFTER THAT IT WILL PRODUCE THE CUSTOM INSTRUCTION TO PUSH PC

ARCHITECTURE INT OF INT_UNIT IS
	SIGNAL Count : INTEGER RANGE 0 TO 7;

BEGIN	
	
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