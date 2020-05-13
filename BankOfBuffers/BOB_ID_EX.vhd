LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;



ENTITY BOB_ID_EX IS
	PORT (
    RESET,STALL,CLK: IN STD_LOGIC;
    PC_IN, INST_IN, READ1_IN, READ2_IN: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    READ1_ADDRESS_IN, READ2_ADDRESS_IN: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    READ1_ADDRESS_OUT, READ2_ADDRESS_OUT: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    WB_IN: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
    MEM_IN: IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    EX_IN: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    WB_OUT: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    MEM_OUT: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
    EX_OUT: OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
    INST_OUT, PC_OUT, READ1_OUT, READ2_OUT : OUT  STD_LOGIC_VECTOR(31 DOWNTO 0));
END ENTITY BOB_ID_EX;


ARCHITECTURE BOB_ID_EX_ARCH OF BOB_ID_EX IS
  


    --THE ID/EX PC Register  
    COMPONENT BOB_ID_EX_PC IS 

    PORT(
    Clk,Rst,enable : IN std_logic;
	d : IN std_logic_vector(31 DOWNTO 0);
    q : OUT std_logic_vector(31 DOWNTO 0));
    
    END COMPONENT;

    --THE ID/EX INST Register  
    COMPONENT BOB_ID_EX_INST IS 

    PORT(
    Clk,Rst,enable : IN std_logic;
    d : IN std_logic_vector(31 DOWNTO 0);
    q : OUT std_logic_vector(31 DOWNTO 0));

    END COMPONENT;

    --THE ID/EX WB Register  
    COMPONENT BOB_ID_EX_WB IS 

    PORT(
    Clk,Rst,enable : IN std_logic;
    d : IN std_logic_vector(4 DOWNTO 0);
    q : OUT std_logic_vector(4 DOWNTO 0));

    END COMPONENT;

    --THE ID/EX MEM Register  
    COMPONENT BOB_ID_EX_MEM IS 

    PORT(
    Clk,Rst,enable : IN std_logic;
    d : IN std_logic_vector(6 DOWNTO 0);
    q : OUT std_logic_vector(6 DOWNTO 0));

    END COMPONENT;

    --THE ID/EX EX Register  
    COMPONENT BOB_ID_EX_EX IS 

    PORT(
    Clk,Rst,enable : IN std_logic;
    d : IN std_logic_vector(10 DOWNTO 0);
    q : OUT std_logic_vector(10 DOWNTO 0));

    END COMPONENT;

    --THE ID/EX Read1 Register  
    COMPONENT BOB_ID_EX_READ1 IS 

    PORT(
    Clk,Rst,enable : IN std_logic;
    d : IN std_logic_vector(31 DOWNTO 0);
    q : OUT std_logic_vector(31 DOWNTO 0));

    END COMPONENT;

    --THE ID/EX Read2 Register  
    COMPONENT BOB_ID_EX_READ2 IS 

    PORT(
    Clk,Rst,enable : IN std_logic;
    d : IN std_logic_vector(31 DOWNTO 0);
    q : OUT std_logic_vector(31 DOWNTO 0));

    END COMPONENT;


    --THE ID/EX Read1 Register Address  
    COMPONENT BOB_ID_EX_READ1_ADDRESS IS 

    PORT(
    Clk,Rst,enable : IN std_logic;
    d : IN std_logic_vector(2 DOWNTO 0);
    q : OUT std_logic_vector(2 DOWNTO 0));

    END COMPONENT;

    --THE ID/EX Read2 Register Address 
    COMPONENT BOB_ID_EX_READ2_ADDRESS IS 

    PORT(
    Clk,Rst,enable : IN std_logic;
    d : IN std_logic_vector(2 DOWNTO 0);
    q : OUT std_logic_vector(2 DOWNTO 0));

    END COMPONENT;


    SIGNAL NOT_STALL: STD_LOGIC;
    BEGIN	
    

    NOT_STALL <= NOT STALL;

    --THE PC Register
    ID_EX_PC: BOB_ID_EX_PC PORT MAP (CLK, RESET, NOT_STALL, PC_IN, PC_OUT);

    --THE INST Register
    ID_EX_INST: BOB_ID_EX_INST PORT MAP (CLK, RESET, NOT_STALL, INST_IN, INST_OUT);

    --THE WB Register
    ID_EX_WB: BOB_ID_EX_WB PORT MAP (CLK, RESET, NOT_STALL, WB_IN, WB_OUT);

    --THE MEM Register
    ID_EX_MEM: BOB_ID_EX_MEM PORT MAP (CLK, RESET, NOT_STALL, MEM_IN, MEM_OUT);

    --THE EX Register
    ID_EX_EX: BOB_ID_EX_EX PORT MAP (CLK, RESET, NOT_STALL, EX_IN, EX_OUT);

    --THE READ1 Register
    ID_EX_READ1: BOB_ID_EX_READ1 PORT MAP (CLK, RESET, NOT_STALL, READ1_IN, READ1_OUT);

    --THE READ2 Register
    ID_EX_READ2: BOB_ID_EX_READ2 PORT MAP (CLK, RESET, NOT_STALL, READ2_IN, READ2_OUT);

    --THE READ1 Register Address
    ID_EX_READ1_ADDRESS: BOB_ID_EX_READ1_ADDRESS PORT MAP (CLK, RESET, NOT_STALL, READ1_ADDRESS_IN, READ1_ADDRESS_OUT);

    --THE READ2 Register Address
    ID_EX_READ2_ADDRESS: BOB_ID_EX_READ2_ADDRESS PORT MAP (CLK, RESET, NOT_STALL, READ2_ADDRESS_IN, READ2_ADDRESS_OUT);    

    
END BOB_ID_EX_ARCH;