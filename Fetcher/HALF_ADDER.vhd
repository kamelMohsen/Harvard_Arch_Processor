LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

ENTITY HALF_ADDER IS     
	PORT( a,b,cin : IN std_logic; 
	s,cout : OUT std_logic); 
END HALF_ADDER;

ARCHITECTURE ADD OF HALF_ADDER IS
BEGIN
            s <= a XOR b XOR cin;
             cout <= (a AND b) or (cin AND (a XOR b));
END ADD;
