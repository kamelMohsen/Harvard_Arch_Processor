LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

Entity StackPointer IS
PORT (SPSel : IN std_logic_vector(2 downto 0);
      Address : OUT std_logic_vector(31 DOWNTO 0) );
END ENTITY StackPointer;


architecture SP of StackPointer IS
Signal FreeAddress:integer:=(2**11)-1;
Begin

Process(SPSel)
	Begin
		IF(SPSel = "000") then
			FreeAddress <= FreeAddress;
			Address<=std_logic_vector((to_unsigned(FreeAddress,32)));
		ElsIf (SPSel = "001") then
			Address<=std_logic_vector((to_unsigned(FreeAddress,32)));
			FreeAddress <= FreeAddress-2;
		ElsIf (SPSel = "010") then
			FreeAddress <= FreeAddress+2;
			Address<=std_logic_vector((to_unsigned(FreeAddress+2,32)));
		ElsIf (SPSel = "011") then
			Address<=std_logic_vector((to_unsigned(FreeAddress,32)));
			FreeAddress <= FreeAddress-2;
		ElsIf (SPSel = "100") then
			FreeAddress <= FreeAddress+2;
			Address<=std_logic_vector((to_unsigned(FreeAddress+2,32)));
		End If;
	End Process;

End SP;
