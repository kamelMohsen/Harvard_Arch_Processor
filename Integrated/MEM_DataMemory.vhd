LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY DataMemory IS
Generic (N : integer:=32);
PORT (Clk : IN std_logic;
      WriteEnable : IN std_logic;
      StackOrData : IN std_logic;
      Address : IN std_logic_vector(N-1 DOWNTO 0);
      DataIn : IN std_logic_vector(N-1 DOWNTO 0);
      DataOut : OUT std_logic_vector(N-1 DOWNTO 0) );
END ENTITY DataMemory;

ARCHITECTURE sync_ram OF DataMemory IS
TYPE ram_type IS ARRAY(0 TO (2**11)-1) of std_logic_vector(15 DOWNTO 0);
SIGNAL ram : ram_type ;
SIGNAL IntegerAddress :integer:=0 ;
SIGNAL IntegerAddressPlusOne :integer:=0;
SIGNAL IntegerAddressMinusOne :integer:=0 ;

BEGIN
	IntegerAddress <= to_integer(unsigned(Address));
	IntegerAddressMinusOne <= to_integer(unsigned(Address))-1 when to_integer(unsigned(Address)) /= 0
	Else 0;
	IntegerAddressPlusOne <= to_integer(unsigned(Address))+1  when to_integer(unsigned(Address)) /= 2047
	Else 0;
	
	PROCESS(Clk) IS
	BEGIN
		IF clk'event and clk = '0' THEN
			IF WriteEnable = '1' THEN
				IF StackOrData = '1'  THEN
					ram(IntegerAddress) <= DataIn(15 DOWNTO 0);
					ram(IntegerAddressMinusOne) <= DataIn(N-1 DOWNTO 16);
				ELSE
					ram(IntegerAddress) <= DataIn(15 DOWNTO 0);
					ram(IntegerAddressPlusOne) <= DataIn(N-1 DOWNTO 16);
				END IF;

			END IF;
		END IF;
	END PROCESS;
	
	DataOut <= ram(IntegerAddressPlusOne) & ram(IntegerAddress) WHEN StackOrData = '0' 
	ELSE ram(IntegerAddressMinusOne) & ram(IntegerAddress) WHEN StackOrData = '1';
	
	

END sync_ram; 
