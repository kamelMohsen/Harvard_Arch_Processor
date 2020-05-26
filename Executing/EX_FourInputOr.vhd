LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Execute_FourInputOr IS PORT (
clk: IN std_logic;
firstInput: IN std_logic;
secondInput: IN std_logic;
thirdInput:  IN std_logic;
fourthInput: IN std_logic;
output1: OUT std_logic


);
END ENTITY;

ARCHITECTURE Execute_FourInputOr_ARCH of Execute_FourInputOr IS
BEGIN
process(clk)
Begin
if falling_edge(clk) then

output1 <= firstInput or secondInput or thirdInput or fourthInput;

end if;
end PROCESS;
END Execute_FourInputOr_ARCH;