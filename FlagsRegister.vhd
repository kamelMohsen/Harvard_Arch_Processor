LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
--Remember popping flags from the memory might need write enable
ENTITY FlagsRegister IS PORT 
(
    ZeroInput, NegativeInput, CarryInput: IN std_logic;
    SETC: IN std_logic_vector(1 DOWNTO  0);
    clk: IN std_logic;
    rst: IN std_logic;
    ZeroReset, CarryReset, NegativeReset: IN std_logic;
    MemoryInput: IN std_logic_vector(3 DOWNTO 0);
    --ZeroOutput, CarryOutput, NegativeOutput: OUT std_logic;
    RegOut: OUT std_logic_vector(3 DOWNTO 0)
    --reti input
);
END ENTITY FlagsRegister;


ARCHITECTURE arch1 OF FlagsRegister IS

Signal CarrySignal, ZeroSignal, NegativeSignal: std_logic;
Signal FlagsSignal: std_logic_vector(3 DOWNTO 0);

COMPONENT my_DFF IS PORT( 
d:IN std_logic_vector(3 DOWNTO 0);
clk,rst,en : IN std_logic;
q : OUT std_logic_vector(3 DOWNTO 0)
);
END COMPONENT;

BEGIN


CarrySignal <= CarryInput WHEN SETC = "00" OR SETC = "11"
ELSE  '1' WHEN SETC = "01"
ELSE  '0' WHEN SETC = "10" OR CarryReset = '1';
 
ZeroSignal <= '0' WHEN ZeroReset = '1' 
ELSE ZeroInput;

NegativeSignal <= '0' WHEN NegativeReset = '1' 
ELSE NegativeInput;

FlagsSignal(0) <= ZeroSignal;
FlagsSignal(1) <= NegativeSignal;
FlagsSignal(2) <= CarrySignal;
FlagsSignal(3) <= '0';
Flag_Reg: my_DFF PORT MAP(FlagsSignal, clk, rst, '1', RegOut);







END arch1;