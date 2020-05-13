LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY DECODESTAGE IS 
PORT( PC_in,Fetch_Instruction,INPORT,Result,WrtieBack_WriteData2: IN std_logic_vector(31 DOWNTO 0);
      WriteEnable_RegisterFile: IN std_logic_vector(1 DOWNTO 0); 
      WrtieBack_WriteAddress1,WrtieBack_WriteAddress2: IN std_logic_vector(2 DOWNTO 0); 
      CLOCK_ALL,Reset_Registers,IN_Enable: IN std_logic;
      RegisterFile_Read1,RegisterFile_Read2,Decode_instruction,PC_out: OUT std_logic_vector(31 DOWNTO 0);
--=====ControlUnit Outputs====--
      CU_Jmp,CU_OUTT,CU_Branch,CU_Reg_IMM,CU_PC_Reg,CU_Data_Stack,CU_ReadEnable,CU_WriteEnableMemory,CU_Call,CU_RETI,CU_Result_Mem,CU_INN,CU_RegPC_MemPC: OUT std_logic;
      CU_Set_Clr_Carry,CU_WriteEnableWB : OUT std_logic_vector(1 DOWNTO 0);
      CU_SPSel : OUT std_logic_vector(2 DOWNTO 0);
      CU_ALU_Selc : OUT std_logic_vector(3 DOWNTO 0));

END DECODESTAGE;
--===================================================================================================================--

ARCHITECTURE DECODESTAGE_ARCH OF DECODESTAGE IS

COMPONENT DECODER_ControlUnit IS 
PORT( Instruction: IN std_logic_vector(31 DOWNTO 0);
      CU_CLOCK: IN std_logic;
      Jmp,OUTT,Branch,Reg_IMM,PC_Reg,Data_Stack,WriteEnableMemory,Call,RETI,Result_Mem,INN,RegPC_MemPC,Rdst_Rsrc1,Rdst_Rsrc2: OUT std_logic;
      Set_Clr_Carry,WriteEnableWB : OUT std_logic_vector(1 DOWNTO 0);
      SPSel : OUT std_logic_vector(2 DOWNTO 0);
      ALU_Selc : OUT std_logic_vector(3 DOWNTO 0));
      
END COMPONENT;

COMPONENT DECODER_RegisterFile IS 
PORT( WriteData1,WriteData2: IN std_logic_vector(31 DOWNTO 0);
      Rsrc1,Rsrc2,WriteAddress1 ,WriteAddress2: IN std_logic_vector(2 DOWNTO 0);
      WriteEn: IN std_logic_vector(1 DOWNTO 0); 
      CLOCK,RESET: IN std_logic;
      Read1,Read2: OUT std_logic_vector(31 DOWNTO 0));

END COMPONENT;

COMPONENT DECODER_mux IS 
	Generic ( n : Integer:=3);
	PORT ( Rsrc,Rdst : IN std_logic_vector (n-1 DOWNTO 0);
	       S : IN  std_logic;
	       OUT1 : OUT std_logic_vector (n-1 DOWNTO 0));
END COMPONENT;



SIGNAL Mux3_WriteData1 : std_logic_vector(31 DOWNTO 0);
SIGNAL Mux1_Rsrc1,Mux2_Rsrc2 : std_logic_vector(2 DOWNTO 0);
SIGNAL Enable1_Rdst_Rsrc1,Enable2_Rdst_Rsrc2 :std_logic;

BEGIN


RegisterFile: DECODER_RegisterFile PORT MAP (Mux3_WriteData1,WrtieBack_WriteData2,Mux1_Rsrc1,Mux2_Rsrc2,WrtieBack_WriteAddress1,WrtieBack_WriteAddress2,WriteEnable_RegisterFile,CLOCK_ALL,Reset_Registers,RegisterFile_Read1,RegisterFile_Read2);
ControlUnit: DECODER_ControlUnit PORT MAP (Fetch_Instruction,CLOCK_ALL,CU_Jmp,CU_OUTT,CU_Branch,CU_Reg_IMM,CU_PC_Reg,CU_Data_Stack,CU_WriteEnableMemory,CU_Call,CU_RETI,CU_Result_Mem,CU_INN,CU_RegPC_MemPC,Enable1_Rdst_Rsrc1,Enable2_Rdst_Rsrc2,CU_Set_Clr_Carry,CU_WriteEnableWB,CU_SPSel,CU_ALU_Selc);
Mux1: DECODER_mux GENERIC MAP (3) PORT MAP (Fetch_Instruction(2 DOWNTO 0),Fetch_Instruction(8 DOWNTO 6),Enable1_Rdst_Rsrc1,Mux1_Rsrc1);
Mux2: DECODER_mux GENERIC MAP (3) PORT MAP (Fetch_Instruction(2 DOWNTO 0),Fetch_Instruction(5 DOWNTO 3),Enable2_Rdst_Rsrc2,Mux2_Rsrc2);
Mux3: DECODER_mux GENERIC MAP (32) PORT MAP (Result,INPORT,IN_Enable,Mux3_WriteData1);

PC_out <= PC_in;
Decode_instruction <= Fetch_Instruction;

END DECODESTAGE_ARCH;