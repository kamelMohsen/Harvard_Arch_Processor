LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Memory_unit IS
Generic (N : integer:=32);
PORT (	Clk : IN std_logic;
      	WriteEnable : IN std_logic;				-- Write enable of the memory
      	StackOrData : IN std_logic;				-- selector of Address
      	ResultOrFlags: IN std_logic;				-- selector of data
	SPSEL :IN std_logic_vector(2 downto 0);			-- StackPointer selector
      	EA : IN std_logic_vector(N-1 DOWNTO 0);			-- Effective Address input
      	Result : IN std_logic_vector(N-1 DOWNTO 0);		-- Result input from ALU_unit
	Flags : IN std_logic_vector(N-1 DOWNTO 0);		-- Flags input from ALU_unit
      	WB_ResultOrMem_IN : IN std_logic;			-- WriteBack selector of result or memory  
	WB_WriteEnable_IN : IN std_logic_vector(1 DOWNTO 0);	-- WriteBack Write Enable
	WB_INPort_IN : IN std_logic;				-- WriteBack IN-Port enable
	WB_RegPCOrMemPC_IN : IN std_logic;			-- WriteBack selector of Reg PC or Mem PC
	RdstOrRsrc_IN : IN std_logic_vector(N-1 DOWNTO 0);	-- Transition of Rdst data or Rsrc data from Exec to WB
	Inst6to8_IN : IN std_logic_vector(2 DOWNTO 0);		-- Transition of Inst[6-8] from Exec to WB
	Inst0to2_IN : IN std_logic_vector(2 DOWNTO 0);		-- Transition of Inst[0-2] from Exec to WB
	DataRead : OUT std_logic_vector(N-1 DOWNTO 0);  	-- Data Read from memory
	Result_OUT : OUT std_logic_vector(N-1 DOWNTO 0);
	WB_ResultOrMem_Out : OUT std_logic;
	WB_WriteEnable_Out : OUT std_logic_vector(1 DOWNTO 0);
	WB_INPort_Out : OUT std_logic;
	WB_RegPCOrMemPC_Out : OUT std_logic;
	RdstOrRsrc_OUT : OUT std_logic_vector(N-1 DOWNTO 0);	
	Inst6to8_OUT : OUT std_logic_vector(2 DOWNTO 0);		
	Inst0to2_OUT : OUT std_logic_vector(2 DOWNTO 0)
		);
END ENTITY Memory_unit;

ARCHITECTURE MEM_U OF Memory_unit IS

-- Data Memory component
COMPONENT DataMemory IS
Generic (N : integer:=32);
PORT (Clk : IN std_logic;
      WriteEnable : IN std_logic;
      StackOrData : IN std_logic;
      Address : IN std_logic_vector(N-1 DOWNTO 0);
      DataIn : IN std_logic_vector(N-1 DOWNTO 0);
      DataOut : OUT std_logic_vector(N-1 DOWNTO 0) );
END COMPONENT;

-- Stack Pointer component
COMPONENT StackPointer IS
PORT (SPSel : IN std_logic_vector(2 downto 0);
      Address : OUT std_logic_vector(31 DOWNTO 0) );
END COMPONENT;

SIGNAL Data,Address : std_logic_vector(N-1 DOWNTO 0);
SIGNAL StackAddress :std_logic_vector(N-1 DOWNTO 0);

BEGIN

-- Transition from Exec to WB
Result_OUT <= Result;
RdstOrRsrc_OUT <= RdstOrRsrc_IN;
Inst0to2_OUT <= Inst0to2_IN;
Inst6to8_OUT <= Inst6to8_IN; 
-------------------------------------------
-- Write Back Signals transition
WB_ResultOrMem_Out <= WB_ResultOrMem_IN;
WB_WriteEnable_Out <= WB_WriteEnable_IN;
WB_INPort_Out <= WB_INPort_IN;
WB_RegPCOrMemPC_Out <= WB_RegPCOrMemPC_IN;
--------------------------------------------

Memory : DataMemory Generic MAP(N) PORT MAP (Clk,WriteEnable,StackOrData,Address,Data,DataRead);
SP: StackPointer PORT MAP (SPSEL,StackAddress);

Data <= Result WHEN ResultOrFlags = '0'
ELSE  Flags WHEN ResultOrFlags = '1';

Address <= EA WHEN StackOrData = '0'
ELSE StackAddress WHEN StackOrData = '1';

END MEM_U; 