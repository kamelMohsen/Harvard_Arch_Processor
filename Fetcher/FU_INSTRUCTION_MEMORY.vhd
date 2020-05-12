library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

entity FU_INSTRUCTION_MEMORY is
GENERIC (Data_Width : integer := 32);
  port (
    clock   : in  std_logic;
    address : in  std_logic_vector(Data_Width-1 DOWNTO 0);
    datain  : in  std_logic_vector(Data_Width-1 DOWNTO 0);
    dataout : out std_logic_vector(Data_Width-1 DOWNTO 0)
  );
end entity FU_INSTRUCTION_MEMORY;

architecture FU_INSTRUCTION_MEMORY_ARCH of FU_INSTRUCTION_MEMORY is

	COMPONENT FU_FULL_ADDER IS

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
	adder : FU_FULL_ADDER GENERIC MAP (Data_Width) PORT MAP (address,"00000000000000000000000000000001", '0',incremented_address, cout);

      read_address <= address;


  dataout(15 DOWNTO 0) <= ram(to_integer(unsigned(read_address)));
  dataout(31 DOWNTO 16) <= ram(to_integer(unsigned(incremented_address)));

end architecture FU_INSTRUCTION_MEMORY_ARCH;
