--This file is missing: 1- Carry Flag
--                      2- Stall 
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY ALU IS PORT(
    Rsrc1, Rsrc2: IN std_logic_vector( 31 DOWNTO 0);    --Source1 and Source2
    Instr: IN std_logic_vector( 4 DOWNTO 0);    	--Shift Amount
    ALU_Sel: IN std_logic_vector(3 DOWNTO 0);   	-- Operation Selector
    Stall: IN std_logic; 				-- Stall --NOT IMPLEMENTED YET
    Zero, Carry, Negative: OUT std_logic;		--FLAGS
    Result: OUT std_logic_vector(31 DOWNTO 0);		--Output
    FlagsRegisterEnable: OUT std_logic
    );
END ENTITY ALU; 

ARCHITECTURE arch1 OF ALU IS 
SIGNAL tempOut: std_logic_vector(32 DOWNTO 0);
SIGNAL Rsrc1Signal: std_logic_vector(32 DOWNTO 0);-- := '0' & Rsrc1;
SIGNAL Rsrc2Signal: std_logic_vector(32 DOWNTO 0);--:= '0' & Rsrc2;
begin
    Rsrc1Signal <= '0' & Rsrc1;
    Rsrc2Signal <= '0' & Rsrc2;
    tempOut <= (Others => '0') WHEN ALU_SEL = "0000" --Disables
    ELSE std_logic_vector(unsigned(Rsrc1Signal) + 1) WHEN ALU_SEL = "0001" 	--Convert Source1 to integer, increment, and then turn back to vector
    ELSE std_logic_vector(unsigned(Rsrc1Signal) - 1) WHEN ALU_SEL = "0010" 	--Convert Source2 to integer, decrement, and then turn back to vector
    ELSE  Rsrc1Signal WHEN ALU_SEL = "0011"								  	--Pass Source1
    ELSE std_logic_vector(unsigned(Rsrc1Signal) + unsigned(Rsrc2Signal)) WHEN ALU_SEL = "0100" 	--Convert Source1, Source2, add then turn them back to integer
    ELSE std_logic_vector(unsigned(Rsrc1Signal) - unsigned(Rsrc2Signal)) WHEN ALU_SEL = "0101" 	--Convert Source1, Source2, subtract then turn them back to integer
    ELSE Rsrc1Signal AND Rsrc2Signal WHEN ALU_SEL = "0110" --And Source1 and Source2
    ELSE Rsrc1Signal OR Rsrc2Signal WHEN ALU_SEL = "0111"  --OR Source1 and Source2
    ELSE NOT Rsrc1Signal WHEN ALU_SEL = "1000"       --NOT Source1
    ELSE std_logic_vector(shift_left(unsigned(Rsrc1Signal), to_integer(unsigned(Instr)))) WHEN ALU_SEL = "1001" 	--Shift left Source1 by Instr bits
    ELSE std_logic_vector(shift_right(unsigned(Rsrc1Signal), to_integer(unsigned(Instr)))) WHEN ALU_SEL = "1010" 	--Shift Right Source1 by Instr bits
    ELSE Rsrc2Signal WHEN ALU_SEL = "1011"; --pass Source2
    Zero <= '1' WHEN tempOut = "000000000000000000000000000000000" AND ALU_SEL /= "0000" 	--if the ALU is not disabled and the result of the operation is zero, set the zero flag.
    ELSE '0';
    Negative <= '1' WHEN tempOut(31) = '1' AND ALU_SEL /= "0000" 	--set Negative flag if the most significant bit of the result is 1
    ELSE '0'; 
    FlagsRegisterEnable <= '0' when ALU_SEL = "0000"
    ELSE '1';
    Carry <= '1' WHEN  tempOut(32) = '1'
    ELSE '0';	
    Result <= tempOut(31 DOWNTO 0); --set the result to tempOut
    
END arch1;