library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

entity sync_ram is
GENERIC (Data_Width : integer := 32);
  port (
    clock   : in  std_logic;
    we      : in  std_logic;
    address : in  std_logic_vector(Data_Width-1 DOWNTO 0);
    datain  : in  std_logic_vector(Data_Width-1 DOWNTO 0);
    dataout : out std_logic_vector(Data_Width-1 DOWNTO 0)
  );
end entity sync_ram;

architecture RTL of sync_ram is

	COMPONENT FULL_ADDER IS

	PORT   (a, b : IN std_logic_vector(Data_Width-1 DOWNTO 0) ;
             cin : IN std_logic;
             s : OUT std_logic_vector(Data_Width-1 DOWNTO 0);
             cout : OUT std_logic);

	END COMPONENT;

   type ram_type is array (0 to (2**20)-1) of std_logic_vector(15 DOWNTO 0);
   signal ram : ram_type;
   signal read_address : std_logic_vector(Data_Width-1 DOWNTO 0);
   signal incremented_address : std_logic_vector(Data_Width-1 DOWNTO 0);
   signal cout : std_logic;
begin
	adder : FULL_ADDER GENERIC MAP (Data_Width) PORT MAP (address,"00000000000000000000000000000001", '0',incremented_address, cout);
  RamProc: process(clock) is

  begin
    if rising_edge(clock) then
      if we = '1' then
        ram(to_integer(unsigned(address))) <= datain(15 DOWNTO 0);
        ram(to_integer(unsigned(incremented_address))) <= datain(31 DOWNTO 16);
      end if;
      read_address <= address;
    end if;
  end process RamProc;

  dataout(15 DOWNTO 0) <= ram(to_integer(unsigned(read_address)));
  dataout(31 DOWNTO 16) <= ram(to_integer(unsigned(incremented_address)));

end architecture RTL;
