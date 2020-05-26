LIBRARY IEEE;
USE IEEE.std_logic_1164.all;



ENTITY Execute_FWU IS PORT 
(
    
    CLK,MEM_REG_WRITE, WB_REG_WRITE: IN STD_LOGIC;
    MEM_Destination_Address,WB_Destination_Address,EX_Destination_OP1_Address, EX_Destination_OP2_Address: IN std_logic_vector(2 DOWNTO 0);
    MEM_Destination_Data,WB_Destination_Data : IN std_logic_vector(31 DOWNTO 0);
    FW_OP1_Data, FW_OP2_Data : OUT std_logic_vector(31 DOWNTO 0);
    FW_OP1_Enable, FW_OP2_Enable: OUT std_logic;
    MEM_SWAP_BIT,WB_SWAP_BIT : IN STD_LOGIC;
    MEM_SWAP_VALUE,WB_SWAP_VALUE :IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
    MEM_SWAP_ADDRESS,WB_SWAP_ADDRESS:IN std_logic_vector(2 DOWNTO 0)
);
END ENTITY Execute_FWU;


ARCHITECTURE Execute_FWU_ARCH OF Execute_FWU IS
    BEGIN

    PROCESS(MEM_REG_WRITE,WB_REG_WRITE,MEM_Destination_Address,WB_Destination_Address,EX_Destination_OP1_Address, EX_Destination_OP2_Address,MEM_Destination_Data,WB_Destination_Data,CLK)
    BEGIN

        IF ((EX_Destination_OP1_Address = MEM_Destination_Address) AND (MEM_REG_WRITE = '1')) AND MEM_Destination_Data /= X"00000000"  THEN
            FW_OP1_Data <=MEM_Destination_Data;
            FW_OP1_Enable <= '1';
        ELSIF  ( (EX_Destination_OP1_Address = WB_Destination_Address) AND (WB_REG_WRITE = '1') ) AND WB_Destination_Data /= X"00000000" THEN 
            FW_OP1_Data <= WB_Destination_Data; 
            FW_OP1_Enable <= '1';
        ELSIF ( (EX_Destination_OP1_Address = MEM_SWAP_ADDRESS) AND (MEM_SWAP_BIT = '1') ) AND MEM_SWAP_VALUE /= X"00000000" THEN
            FW_OP1_Data <= MEM_SWAP_VALUE; 
            FW_OP1_Enable <= '1';
        ELSIF ( (EX_Destination_OP1_Address = WB_SWAP_ADDRESS) AND (WB_SWAP_BIT = '1') ) AND WB_SWAP_VALUE /= X"00000000" THEN
            FW_OP1_Data <= WB_SWAP_VALUE; 
            FW_OP1_Enable <= '1';
        ELSE
            FW_OP1_Data <= X"11111111";  
            FW_OP1_Enable <= '0';
        END IF;    

        
        IF ((EX_Destination_OP2_Address = MEM_Destination_Address) AND (MEM_REG_WRITE = '1')) AND MEM_Destination_Data /= X"00000000" THEN
            FW_OP2_Data <=MEM_Destination_Data; 
            FW_OP2_Enable <= '1';
        ELSIF  ( (EX_Destination_OP2_Address = WB_Destination_Address) AND (WB_REG_WRITE = '1') ) AND WB_Destination_Data /= X"00000000" THEN 
            FW_OP2_Data <= WB_Destination_Data;
            FW_OP2_Enable <= '1';
        ELSIF ( (EX_Destination_OP2_Address = MEM_SWAP_ADDRESS) AND (MEM_SWAP_BIT = '1') ) AND MEM_SWAP_VALUE /= X"00000000" THEN
            FW_OP2_Data <= MEM_SWAP_VALUE; 
            FW_OP2_Enable <= '1';
        ELSIF ( (EX_Destination_OP2_Address = WB_SWAP_ADDRESS) AND (WB_SWAP_BIT = '1') ) AND WB_SWAP_VALUE /= X"00000000" THEN
            FW_OP2_Data <= WB_SWAP_VALUE; 
            FW_OP2_Enable <= '1';
        ELSE
            FW_OP2_Data <= X"11111111";  
            FW_OP2_Enable <= '0';
        END IF;   

    END PROCESS;
  
END Execute_FWU_ARCH;