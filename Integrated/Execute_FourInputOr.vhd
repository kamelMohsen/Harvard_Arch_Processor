LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Execute_FourInputOr IS PORT (
firstInput: IN std_logic;
secondInput: IN std_logic;
thirdInput:  IN std_logic;
fourthInput: IN std_logic;
output1: OUT std_logic


);
END ENTITY;

ARCHITECTURE Execute_FourInputOr_ARCH of Execute_FourInputOr IS
BEGIN
output1 <= firstInput or secondInput or thirdInput or fourthInput;
END Execute_FourInputOr_ARCH;