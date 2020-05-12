LIBRARY IEEE;
USE IEEE.std_logic_1164.all;



ENTITY FORWARDING IS PORT 
(
    MEM_First_Operand_Address,MEM_Second_Operand_Address,WB_First_Operand_Address,WB_Second_Operand_Address,EX_First_Operand_Address,EX_Second_Operand_Address: IN std_logic_vector(2 DOWNTO 0);
    MEM_First_Operand_Data,MEM_Second_Operand_Data,WB_First_Operand_Data,WB_Second_Operand_Data : IN std_logic_vector(31 DOWNTO 0);
    FW_First_Operand_Data,FW_Second_Operand_Data: OUT std_logic_vector(31 DOWNTO 0);
    FW_First_Operand_Enable,FW_Second_Operand_Enable: OUT std_logic
);
END ENTITY FORWARDING;


ARCHITECTURE FWU OF FORWARDING IS
    BEGIN

    
    FW_First_Operand_Data <= WB_First_Operand_Data WHEN EX_First_Operand_Address = WB_First_Operand_Address
    ELSE  MEM_First_Operand_Data WHEN EX_First_Operand_Address = MEM_First_Operand_Address
    ELSE  X"00000000";

    FW_Second_Operand_Data <= WB_Second_Operand_Data WHEN EX_Second_Operand_Address = WB_Second_Operand_Address
    ELSE  MEM_Second_Operand_Data WHEN EX_Second_Operand_Address = MEM_Second_Operand_Address
    ELSE  X"00000000";

    FW_First_Operand_Enable <= '1' WHEN ((EX_First_Operand_Address = WB_First_Operand_Address) OR (EX_First_Operand_Address = MEM_First_Operand_Address))
    ELSE '0';

    FW_Second_Operand_Enable <= '1' WHEN ((EX_Second_Operand_Address = WB_Second_Operand_Address) OR (EX_Second_Operand_Address = MEM_Second_Operand_Address))
    ELSE '0';

END FWU;