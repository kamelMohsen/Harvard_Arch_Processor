LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY REG IS
	GENERIC( Data_Width : integer := 32);
	
	PORT(Clk,Rst,enable : IN std_logic;
	d : IN std_logic_vector(Data_Width-1 DOWNTO 0);
	q : OUT std_logic_vector(Data_Width-1 DOWNTO 0));

END REG;


ARCHITECTURE PC OF REG IS

	COMPONENT bitFF IS

	PORT ( d,Clk,Rst,enable : IN std_logic ;
	q : OUT std_logic);

	END COMPONENT;
	BEGIN
	loop1: FOR i IN 0 TO Data_Width-1 GENERATE
		fx : bitFF PORT MAP(d(i),Clk,Rst,enable,q(i));
	END GENERATE;
END PC;