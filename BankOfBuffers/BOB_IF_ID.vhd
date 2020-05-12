LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;



ENTITY BOB_IF_ID IS
	PORT (
    RESET,STALL,CLK: IN STD_LOGIC;
    PC_IN, INST_IN: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    INST_OUT, PC_OUT : OUT  STD_LOGIC_VECTOR(31 DOWNTO 0));
END ENTITY BOB_IF_ID;


ARCHITECTURE BOB_IF_ID_ARCH OF BOB_IF_ID IS
  


    --THE IF/ID PC Register  
    COMPONENT BOB_IF_ID_PC IS 

    PORT(
    Clk,Rst,enable : IN std_logic;
	d : IN std_logic_vector(31 DOWNTO 0);
    q : OUT std_logic_vector(31 DOWNTO 0));
    
    END COMPONENT;

    --THE IF/ID INST Register  
    COMPONENT BOB_IF_ID_INST IS 

    PORT(
    Clk,Rst,enable : IN std_logic;
    d : IN std_logic_vector(31 DOWNTO 0);
    q : OUT std_logic_vector(31 DOWNTO 0));

    END COMPONENT;


    SIGNAL NOT_STALL: STD_LOGIC;
    BEGIN	
    

    NOT_STALL <= NOT STALL;

    --THE PC Register
    IF_ID_PC: BOB_IF_ID_PC PORT MAP (CLK, RESET, NOT_STALL, PC_IN, PC_OUT);

    --THE INST Register
    IF_ID_INST: BOB_IF_ID_PC PORT MAP (CLK, RESET, NOT_STALL, INST_IN, INST_OUT);


    
END BOB_IF_ID_ARCH;