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
    Result: OUT std_logic_vector(31 DOWNTO 0)		--Output
);
END ENTITY ALU; 

ARCHITECTURE arch1 OF ALU IS 
SIGNAL tempOut: std_logic_vector(31 DOWNTO 0);
begin
    tempOut <= (Others => '0') WHEN ALU_SEL = "0000" --Disables
    ELSE std_logic_vector(to_unsigned(to_integer(unsigned(Rsrc1)) + 1, 32)) WHEN ALU_SEL = "0001" 	--Convert Source1 to integer, increment, and then turn back to vector
    ELSE std_logic_vector(to_unsigned(to_integer(unsigned(Rsrc1)) - 1, 32)) WHEN ALU_SEL = "0010" 	--Convert Source2 to integer, decrement, and then turn back to vector
    ELSE Rsrc1 WHEN ALU_SEL = "0011"								  	--Pass Source1
    ELSE std_logic_vector(to_unsigned(to_integer(unsigned(Rsrc1)) + to_integer(unsigned(Rsrc2)), 32)) WHEN ALU_SEL = "0100" 	--Convert Source1, Source2, add then turn them back to integer
    ELSE std_logic_vector(to_unsigned(to_integer(unsigned(Rsrc1)) - to_integer(unsigned(Rsrc2)), 32)) WHEN ALU_SEL = "0101" 	--Convert Source1, Source2, subtract then turn them back to integer
    ELSE Rsrc1 AND Rsrc2 WHEN ALU_SEL = "0110" --And Source1 and Source2
    ELSE Rsrc1 OR Rsrc2 WHEN ALU_SEL = "0111"  --OR Source1 and Source2
    ELSE NOT Rsrc1 WHEN ALU_SEL = "1000"       --NOT Source1
    ELSE std_logic_vector(shift_left(unsigned(Rsrc1), to_integer(unsigned(Instr)))) WHEN ALU_SEL = "1001" 	--Shift left Source1 by Instr bits
    ELSE std_logic_vector(shift_right(unsigned(Rsrc1), to_integer(unsigned(Instr)))) WHEN ALU_SEL = "1010" 	--Shift Right Source1 by Instr bits
    ELSE Rsrc2 WHEN ALU_SEL = "1011"; --pass Source2
Zero <= '1' WHEN tempOut = "00000000000000000000000000000000" AND ALU_SEL /= "0000" 	--if the ALU is not disabled and the result of the operation is zero, set the zero flag.
ELSE '0';
Negative <= '1' WHEN tempOut(31) = '1' 	--set Negative flag if the most significant bit of the result is 1
ELSE '0';
--Carry <= '1' WHEN  tempOut(32) = '1'
--ELSE '0';	--NEEDS IMPLEMENTATION
Result <= tempOut; --set the result to tempOut
    
END arch1;