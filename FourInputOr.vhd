LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY FourInputOr IS PORT (
firstInput: IN std_logic;
secondInput: IN std_logic;
thirdInput:  IN std_logic;
fourthInput: IN std_logic;
output: OUT std_logic


);
END ENTITY;

ARCHITECTURE fourOr of FourInputOr IS
BEGIN
output <= firstInput or secondInput or thirdInput or fourthInput;
END fourOr;