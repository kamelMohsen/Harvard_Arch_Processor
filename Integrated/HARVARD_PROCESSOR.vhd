LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY HARVARD_PROCESSOR IS
  PORT (INT_SIGNAL, CLK, RESET: IN STD_LOGIC;
  OUT_PORT: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END ENTITY HARVARD_PROCESSOR;


ARCHITECTURE HARVARD_PROCESSOR_ARCH OF HARVARD_PROCESSOR IS
  
    --IMPORTING THE FETCHING UNIT
    COMPONENT FU_FETCHER IS
    
    PORT (INT_SIGNAL, JUMP_BIT, RETI_BIT, MEMORY_BIT,CLK: IN STD_LOGIC;
    JUMP_LOCATION, MEMORY_INSTR: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
  	INSTRUCTION, PC : OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
	  RESET : IN STD_LOGIC);
    
    END COMPONENT;
    
    --IMPORTING THE IF/ID BUFFER
    COMPONENT BOB_IF_ID IS
    
    PORT (
    RESET,STALL,CLK: IN STD_LOGIC;
    PC_IN, INST_IN: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    INST_OUT, PC_OUT : OUT  STD_LOGIC_VECTOR(31 DOWNTO 0));
    
    END COMPONENT;
    
    --IMPORTING THE DECODE UNIT
    COMPONENT DECODESTAGE IS 
    
    PORT( PC_in,Fetch_Instruction,INPORT,Result,WrtieBack_WriteData2: IN std_logic_vector(31 DOWNTO 0);
      WriteEnable_RegisterFile: IN std_logic_vector(1 DOWNTO 0); 
      WrtieBack_WriteAddress1,WrtieBack_WriteAddress2: IN std_logic_vector(2 DOWNTO 0); 
      CLOCK_ALL,Reset_Registers,IN_Enable: IN std_logic;
      RegisterFile_Read1,RegisterFile_Read2,Decode_instruction,PC_out: OUT std_logic_vector(31 DOWNTO 0);
      CU_Jmp,CU_OUTT,CU_Branch,CU_Reg_IMM,CU_PC_Reg,CU_Data_Stack,CU_WriteEnableMemory,CU_Call,CU_RETI,CU_Result_Mem,CU_INN,CU_RegPC_MemPC: OUT std_logic;
      CU_Set_Clr_Carry,CU_WriteEnableWB : OUT std_logic_vector(1 DOWNTO 0);
      CU_SPSel : OUT std_logic_vector(2 DOWNTO 0);
      CU_ALU_Selc : OUT std_logic_vector(3 DOWNTO 0));

    END COMPONENT;
    
    --IMPORTING THE ID/EX BUFFER
    COMPONENT BOB_ID_EX IS
      PORT (
      RESET,STALL,CLK: IN STD_LOGIC;
      PC_IN, INST_IN, READ1_IN, READ2_IN: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      WB_IN: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      MEM_IN: IN STD_LOGIC_VECTOR(6 DOWNTO 0);
      EX_IN: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
      WB_OUT: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
      MEM_OUT: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
      EX_OUT: OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
      INST_OUT, PC_OUT, READ1_OUT, READ2_OUT : OUT  STD_LOGIC_VECTOR(31 DOWNTO 0));
    END COMPONENT;

    COMPONENT ExecutingUnit IS 
    PORT(
    PC: IN std_logic_vector(31 DOWNTO 0);
    Read1: IN std_logic_vector(31 DOWNTO 0);
    Read2: IN std_logic_vector(31 DOWNTO 0);
    SETC: IN std_logic_vector(1 DOWNTO 0);
    OutPortSel: IN  std_logic;
    ALUSel: IN std_logic_vector(3 DOWNTO 0);
    M3_Sel, M4_Sel: IN std_logic;
    AND_INPUT1,AND_INPUT2,AND_INPUT3: IN std_logic; 
    Solo_Or_Input: IN std_logic;
    Zero_Two_IN:IN std_logic_vector(2 DOWNTO 0);
    Three_Eight:IN std_logic_vector(6 DOWNTO 0);
    Six_Eight_IN:IN std_logic_vector(2 DOWNTO 0);
    Zero_Four:IN std_logic_vector(4 DOWNTO 0);
    Sixteen_ThirtyOne:IN std_logic_vector(15 DOWNTO 0);
    M1_Sel,M2_Sel: IN std_logic;
    FWUOUTPUT1, FWUOUTPUT2: IN std_logic_vector(31 DOWNTO 0); 
    clk : IN std_logic;
    FlagsRegisterReset: IN std_logic;
    ZeroReset, NegativeReset, CarryReset: IN std_logic;
    MemoryInput: In std_logic_vector(3 DOWNTO 0); 
    AluOut: OUT std_logic_vector(31 DOWNTO 0);
    Six_Eight_OUT:OUT std_logic_vector(2 DOWNTO 0);
    Zero_Two_OUT:OUT std_logic_vector(2 DOWNTO 0);
    Three_Eight_OUT: OUT std_logic_vector(6 DOWNTO 0);
    Extender: OUT std_logic_vector(31 DOWNTO 0);
    FlagsRegisterOut: OUT std_logic_vector(3 DOWNTO 0);
    OutPort_Output: OUT std_logic_vector( 31 DOWNTO 0);
    Swap_Output: OUT std_logic_vector (31 DOWNTO 0);
    Or_Output: OUT std_logic
    );
    END COMPONENT ;
    
  --INTERMEDIATE BUFFER WIRES
    --IF/ID
    SIGNAL IF_ID_INST_IN_WIRE, IF_ID_PC_IN_WIRE,IF_ID_INST_OUT_WIRE, IF_ID_PC_OUT_WIRE : STD_LOGIC_VECTOR(31 DOWNTO 0);
    --ID/EX
    SIGNAL ID_EX_Read1_IN_WIRE,ID_EX_Read2_IN_WIRE,ID_EX_INST_IN_WIRE,ID_EX_PC_IN_WIRE,ID_EX_Read1_OUT_WIRE,ID_EX_Read2_OUT_WIRE,ID_EX_INST_OUT_WIRE,ID_EX_PC_OUT_WIRE: std_logic_vector(31 DOWNTO 0);
    SIGNAL ID_EX_WB_OUT_WIRE: std_logic_vector(4 DOWNTO 0);
    SIGNAL ID_EX_MEM_OUT_WIRE: std_logic_vector(6 DOWNTO 0);
    SIGNAL ID_EX_EX_OUT_WIRE: std_logic_vector(10 DOWNTO 0);
    --EX/MEM
    SIGNAL EX_MEM_DESTINATION_IN_WIRE,EX_MEM_DESTINATION_OUT_WIRE: STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL EX_MEM_FLAGS_IN_WIRE, EX_MEM_FLAGS_OUT_WIRE : STD_LOGIC_VECTOR(3 DOWNTO 0);

    --CONCATENATED SIGNALS
    SIGNAL CAT_ID_EX_WB: std_logic_vector(4 DOWNTO 0);
    SIGNAL CAT_ID_EX_MEM: std_logic_vector(6 DOWNTO 0);
    SIGNAL CAT_ID_EX_EX: std_logic_vector(10 DOWNTO 0);


    --CONTROL SIGNALS
    SIGNAL CS_EX_ALU_SEL: STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL CS_EX_Set_Clr_Carry: std_logic_vector(1 DOWNTO 0);
    SIGNAL CS_EX_Jmp,CS_EX_OUT,CS_EX_Branch,CS_EX_Reg_IMM,CS_EX_PC_Reg:std_logic;
    SIGNAL CS_MEM_SPSel: std_logic_vector(2 DOWNTO 0);
    SIGNAL CS_MEM_Data_Stack,CS_MEM_WriteEnableMemory,CS_MEM_Call,CS_MEM_RETI: std_logic;
    SIGNAL CS_WB_WriteEnable: std_logic_vector(1 DOWNTO 0);
    SIGNAL CS_WB_Result_Mem,CS_WB_IN,CS_WB_RegPC_MemPC: std_logic;

    --EXECUTION UNIT SIGNALS
    SIGNAL JUMP_BIT_OUT_WIRE: std_logic;
    SIGNAL EXTENDED_IMM: STD_LOGIC_VECTOR(31 DOWNTO 0);


    BEGIN	
    

    CAT_ID_EX_WB <= CS_WB_RegPC_MemPC & CS_WB_IN & CS_WB_Result_Mem & CS_WB_WriteEnable;--WB = (0-1 -> WRITE_ENABLE) & (2 -> RESULT_MEM) & (3 -> IN) & (4 -> REGPC_MEMPC)  
    CAT_ID_EX_MEM <= CS_MEM_RETI & CS_MEM_Call & CS_MEM_WriteEnableMemory & CS_MEM_Data_Stack & CS_MEM_SPSel;--MEM = (0-2 -> SPSEL) & (3 -> DATA_STACK) & (4 -> WRITE_ENABLE_MEMORY) & (5 -> CALL) & (6 -> RETI)
    CAT_ID_EX_EX <= CS_EX_PC_Reg & CS_EX_Reg_IMM & CS_EX_Branch & CS_EX_OUT & CS_EX_Jmp & CS_EX_Set_Clr_Carry & CS_EX_ALU_SEL;--EX = (0-3 -> ALU_SEL) & (4-5 SET_CLR_CARRY) & (6 -> JMP) & (7 -> OUT) & (8 -> BRANCH) & (9 -> REG_IMM) & (10 -> PC_REG)




    --THE FETCHING UNIT 
    FETCHING_UNIT: FU_FETCHER PORT MAP (INT_SIGNAL, '0', '0', '0',CLK, X"00000000", X"00000000", IF_ID_INST_IN_WIRE, IF_ID_PC_IN_WIRE, RESET);    

    --THE IF/ID INTERMEDIATE BUFFER
    IF_ID_BUFFER: BOB_IF_ID PORT MAP (RESET, '0', CLK, IF_ID_PC_IN_WIRE, IF_ID_INST_IN_WIRE, IF_ID_INST_OUT_WIRE, IF_ID_PC_OUT_WIRE);

    --THE DECODE UNIT
    DECODE_UNIT: DECODESTAGE PORT MAP (IF_ID_PC_OUT_WIRE,IF_ID_INST_OUT_WIRE,X"00000000",X"00000000",X"00000000","01","000","000", 
    CLK,RESET,'0', ID_EX_Read1_IN_WIRE,ID_EX_Read2_IN_WIRE,ID_EX_INST_IN_WIRE,ID_EX_PC_IN_WIRE,
    CS_EX_Jmp,CS_EX_OUT,CS_EX_Branch,CS_EX_Reg_IMM,CS_EX_PC_Reg,CS_MEM_Data_Stack,CS_MEM_WriteEnableMemory,CS_MEM_Call,CS_MEM_RETI,
    CS_WB_Result_Mem,CS_WB_IN,CS_WB_RegPC_MemPC,
    CS_EX_Set_Clr_Carry,CS_WB_WriteEnable, CS_MEM_SPSel, CS_EX_ALU_SEL);

    --THE ID/EX INTERMEDIATE BUFFER
    ID_EX_BUFFER: BOB_ID_EX PORT MAP (RESET,'0',CLK,ID_EX_PC_IN_WIRE, ID_EX_INST_IN_WIRE, ID_EX_Read1_IN_WIRE, ID_EX_Read2_IN_WIRE,
    CAT_ID_EX_WB, CAT_ID_EX_MEM, CAT_ID_EX_EX,
    ID_EX_WB_OUT_WIRE, ID_EX_MEM_OUT_WIRE, ID_EX_EX_OUT_WIRE,
    ID_EX_INST_OUT_WIRE, ID_EX_PC_OUT_WIRE, ID_EX_Read1_OUT_WIRE, ID_EX_Read2_OUT_WIRE);

    --THE EXECUTING UNIT
    EXECUTION_UNIT: ExecutingUnit PORT MAP (PC: IN std_logic_vector(31 DOWNTO 0);
    Read1: IN std_logic_vector(31 DOWNTO 0);
    Read2: IN std_logic_vector(31 DOWNTO 0);
    SETC: IN std_logic_vector(1 DOWNTO 0);
    OutPortSel: IN  std_logic;--EN
    ALUSel: IN std_logic_vector(3 DOWNTO 0);
    M3_Sel, M4_Sel: IN std_logic;--BA3D FW UP DOWN
    AND_INPUT1,AND_INPUT2,AND_INPUT3: IN std_logic; 
    Solo_Or_Input: IN std_logic;--JMP
    Zero_Two_IN:IN std_logic_vector(2 DOWNTO 0);--CAT
    Three_Eight:IN std_logic_vector(6 DOWNTO 0);--CAT
    Six_Eight_IN:IN std_logic_vector(2 DOWNTO 0);--CAT
    Zero_Four:IN std_logic_vector(4 DOWNTO 0);--SHIFT VALUE
    Sixteen_ThirtyOne:IN std_logic_vector(15 DOWNTO 0);--IMM VALUE ENTERED
    M1_Sel,M2_Sel: IN std_logic;--FW MUXES UP DOWN
    FWUOUTPUT1, FWUOUTPUT2: IN std_logic_vector(31 DOWNTO 0);--CHECK DE 
    clk : IN std_logic;
    FlagsRegisterReset: IN std_logic;--HABOS 3ALEHA
    ZeroReset, NegativeReset, CarryReset: IN std_logic;--DOL HAZABATHOM AWL LAMA AS7A
    MemoryInput: In std_logic_vector(3 DOWNTO 0); 
    AluOut: OUT std_logic_vector(31 DOWNTO 0);
    Six_Eight_OUT:OUT std_logic_vector(2 DOWNTO 0);--CAT
    Zero_Two_OUT:OUT std_logic_vector(2 DOWNTO 0);--CAT
    Three_Eight_OUT: OUT std_logic_vector(6 DOWNTO 0);--CAT
    EXTENDED_IMM, EX_MEM_FLAGS_IN_WIRE, OUT_PORT, EX_MEM_DESTINATION_IN_WIRE, JUMP_BIT_OUT_WIRE);

END HARVARD_PROCESSOR_ARCH;