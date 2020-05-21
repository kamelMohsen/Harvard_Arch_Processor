LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

Entity StackPointer IS
PORT (SPSel : IN std_logic_vector(2 downto 0);
	  Address : OUT std_logic_vector(10 DOWNTO 0);
	  CLK,RESET: IN STD_LOGIC );
END ENTITY StackPointer;


architecture SP of StackPointer IS

COMPONENT MEM_STACK_POINTER_REGISTER IS

	PORT(Clk,Rst,enable : IN std_logic;
	d : IN std_logic_vector(10 DOWNTO 0);
	q : OUT std_logic_vector(10 DOWNTO 0));

END COMPONENT;


SIGNAL SP_EN : STD_LOGIC;
SIGNAL SP_REG_OUT , SP_REG_IN : STD_LOGIC_VECTOR (10 DOWNTO 0);

Begin
		SP_EN <= '0' WHEN SPSel = "000"
		ELSE '1';

		SP_REG: MEM_STACK_POINTER_REGISTER  PORT MAP (CLK, RESET, SP_EN, SP_REG_IN, SP_REG_OUT);
		



		Address <= SP_REG_OUT WHEN SPSel = "001"
		ELSE std_logic_vector((to_unsigned((to_integer(unsigned(SP_REG_OUT)) + 0),11))) WHEN SPSel = "010"
		ELSE SP_REG_OUT	 WHEN SPSel = "011"
		ELSE std_logic_vector((to_unsigned((to_integer(unsigned(SP_REG_OUT))+ 0 ),11))) WHEN SPSel = "100"
		;



		SP_REG_IN <= std_logic_vector((to_unsigned((to_integer(unsigned(SP_REG_OUT))-2),11))) WHEN SPSel = "001"
		ELSE std_logic_vector((to_unsigned((to_integer(unsigned(SP_REG_OUT))+2),11))) WHEN SPSel = "010"
		ELSE std_logic_vector((to_unsigned((to_integer(unsigned(SP_REG_OUT))-2),11))) WHEN SPSel = "011"
		ELSE std_logic_vector((to_unsigned((to_integer(unsigned(SP_REG_OUT))+2),11))) WHEN SPSel = "100"
		;
	

End SP;
