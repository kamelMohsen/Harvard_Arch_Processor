LIBRARY IEEE;
USE IEEE.std_logic_1164.all;



ENTITY FORWARDING IS PORT 
(
    MEM_Destination_Address,WB_Destination_Address,EX_Destination_Address: IN std_logic_vector(2 DOWNTO 0);
    MEM_Destination_Data,WB_Destination_Data : IN std_logic_vector(31 DOWNTO 0);
    FW_Data : OUT std_logic_vector(31 DOWNTO 0);
    FW_Enable: OUT std_logic
);
END ENTITY FORWARDING;


ARCHITECTURE FWU OF FORWARDING IS
    BEGIN

    
    FW_Data <= WB_Destination_Data WHEN EX_Destination_Address = WB_Destination_Address
    ELSE  MEM_Destination_Data WHEN EX_Destination_Address = MEM_Destination_Address
    ELSE  X"00000000";

    FW_Enable <= '1' WHEN ((EX_Destination_Address = WB_Destination_Address) OR (EX_Destination_Address = MEM_Destination_Address))
    ELSE '0';



END FWU;