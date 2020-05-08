LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

Entity TwoInputAnd IS PORT (
firstInput: IN std_logic;
secondInput: IN std_logic;
output: OUT std_logic
);
END ENTITY TwoInputAnd;


Architecture and1 of TwoInputAnd IS 
BEGIN
output <= firstInput AND secondInput;
END and1;