LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

Entity Execute_TwoInputAnd IS PORT (
firstInput: IN std_logic;
secondInput: IN std_logic;
output: OUT std_logic
);
END ENTITY Execute_TwoInputAnd;


Architecture Execute_TwoInputAnd_ARCH of Execute_TwoInputAnd IS 
BEGIN
output <= firstInput AND secondInput;
END Execute_TwoInputAnd_ARCH;