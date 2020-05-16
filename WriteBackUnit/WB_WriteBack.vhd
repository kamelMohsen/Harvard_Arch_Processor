library IEEE;
use IEEE.STD_LOGIC_1164.all;

ENTITY WriteBack IS PORT (
    Result, DataRead1: IN std_logic_vector(31 DOWNTO 0);
    Rdst_Or_Rsrc_IN: IN std_logic_vector(31 DOWNTO 0);
    Ins6_8_IN: IN std_logic_vector(2 DOWNTO 0);
    Ins2_0_IN: IN std_logic_vector(2 DOWNTO 0);
    Result_Mem_IN, FetchMem_IN: IN std_logic;
    WriteData: OUT std_logic_vector(31 DOWNTO 0);
    
    Rdst_Or_Rsrc_Out: OUT std_logic_vector(31 DOWNTO 0);
    Ins6_8_OUT: OUT std_logic_vector(2 DOWNTO 0);
    Ins2_0_OUT: OUT std_logic_vector(2 DOWNTO 0);
    FetchMem_Out: OUT std_logic

);
END ENTITY WriteBack;
ARCHITECTURE WriteBack_ARCH OF WriteBack IS 
begin
mux: WB_MUX2X1 PORT MAP(Result, DataRead1, Result_Mem_IN, WriteData);
Ins6_8_OUT <= Ins6_8_IN;
Ins2_0_OUT <= Ins2_0_IN;
Rdst_Or_Rsrc_Out <= Rdst_Or_Rsrc_IN;
FetchMem_Out <= FetchMem_IN;
END  WriteBack_ARCH;

