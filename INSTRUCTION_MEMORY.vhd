library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

entity sync_ram is
  port (
    clock   : in  std_logic;
    we      : in  std_logic;
    address : in  std_logic_vector(31 DOWNTO 0);
    datain  : in  std_logic_vector(31 DOWNTO 0);
    dataout : out std_logic_vector(31 DOWNTO 0)
  );
end entity sync_ram;

architecture RTL of sync_ram is

   type ram_type is array (0 to (2**31)-1) of std_logic_vector(31 DOWNTO 0);
   signal ram : ram_type;
   signal read_address : std_logic_vector(31 DOWNTO 0);

begin

  RamProc: process(clock) is

  begin
    if rising_edge(clock) then
      if we = '1' then
        ram(to_integer(unsigned(address))) <= datain;
      end if;
      read_address <= address;
    end if;
  end process RamProc;

  dataout <= ram(to_integer(unsigned(read_address)));

end architecture RTL;
