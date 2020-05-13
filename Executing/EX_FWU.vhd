LIBRARY IEEE;
USE IEEE.std_logic_1164.all;



ENTITY Execute_FWU IS PORT 
(
    MEM_REG_WRITE, WB_REG_WRITE: IN STD_LOGIC;
    MEM_Destination_Address,WB_Destination_Address,EX_Destination_OP1_Address, EX_Destination_OP2_Address: IN std_logic_vector(2 DOWNTO 0);
    MEM_Destination_Data,WB_Destination_Data : IN std_logic_vector(31 DOWNTO 0);
    FW_OP1_Data, FW_OP2_Data : OUT std_logic_vector(31 DOWNTO 0);
    FW_OP1_Enable, FW_OP2_Enable: OUT std_logic
);
END ENTITY Execute_FWU;


ARCHITECTURE Execute_FWU_ARCH OF Execute_FWU IS
    BEGIN

    
    FW_OP1_Data <= WB_Destination_Data WHEN ( (EX_Destination_OP1_Address = WB_Destination_Address) AND (WB_REG_WRITE = '1') ) 
    ELSE  MEM_Destination_Data WHEN ( (EX_Destination_OP1_Address = MEM_Destination_Address) AND (MEM_REG_WRITE = '1') ) 
    ELSE  X"00000000";

    FW_OP1_Enable <= '1' WHEN ( ((EX_Destination_OP1_Address = WB_Destination_Address) AND (WB_REG_WRITE = '1')) OR ((EX_Destination_OP1_Address = MEM_Destination_Address) AND (MEM_REG_WRITE = '1')) )
    ELSE '0';

    FW_OP2_Data <= WB_Destination_Data WHEN ( (EX_Destination_OP2_Address = WB_Destination_Address) AND (WB_REG_WRITE = '1') ) 
    ELSE  MEM_Destination_Data WHEN ( (EX_Destination_OP2_Address = MEM_Destination_Address) AND (MEM_REG_WRITE = '1') ) 
    ELSE  X"00000000";

    FW_OP2_Enable <= '1' WHEN ( ((EX_Destination_OP2_Address = WB_Destination_Address) AND (WB_REG_WRITE = '1')) OR ((EX_Destination_OP2_Address = MEM_Destination_Address) AND (MEM_REG_WRITE = '1')) )
    ELSE '0';

END Execute_FWU_ARCH;