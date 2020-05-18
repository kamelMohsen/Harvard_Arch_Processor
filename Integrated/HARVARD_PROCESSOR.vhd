LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY HARVARD_PROCESSOR IS
  PORT (INT_SIGNAL, CLK, RESET: IN STD_LOGIC;
  OUT_PORT: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
  IN_PORT: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
  CARRY_FLAG, ZERO_FLAG, NEGATIVE_FLAG: OUT STD_LOGIC
  );
END ENTITY HARVARD_PROCESSOR;



ARCHITECTURE HARVARD_PROCESSOR_ARCH OF HARVARD_PROCESSOR IS


-----------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------IMPORTING_COMPONENTS---------------------------------------
-----------------------------------------------------------------------------------------------------------------------




-------------------------------------------------------------FETCHING--------------------------------------------------
    --IMPORTING THE FETCHING UNIT
    COMPONENT FU_FETCHER IS
    
    PORT (INT_SIGNAL, JUMP_BIT, RETI_BIT, MEMORY_BIT,CLK: IN STD_LOGIC;
    JUMP_LOCATION, MEMORY_INSTR: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
  	INSTRUCTION, PC : OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
    RESET : IN STD_LOGIC;
    RESET_ADDRESS: IN  STD_LOGIC_VECTOR(31 DOWNTO 0) 
    );
    
    END COMPONENT;
    
    --IMPORTING THE IF/ID BUFFER
    COMPONENT BOB_IF_ID IS
    
    PORT (
    RESET,STALL,CLK: IN STD_LOGIC;
    PC_IN, INST_IN: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    INST_OUT, PC_OUT : OUT  STD_LOGIC_VECTOR(31 DOWNTO 0));
    
    END COMPONENT;

-------------------------------------------------------------DECODEING---------------------------------------------    
    --IMPORTING THE DECODE UNIT
    COMPONENT DECODESTAGE IS 
    
      PORT( PC_in,Fetch_Instruction,INPORT,Result,WrtieBack_WriteData2: IN std_logic_vector(31 DOWNTO 0);
      WriteEnable_RegisterFile: IN std_logic_vector(1 DOWNTO 0); 
      WrtieBack_WriteAddress1,WrtieBack_WriteAddress2: IN std_logic_vector(2 DOWNTO 0); 
      CLOCK_ALL,Reset_Registers,IN_Enable: IN std_logic;
      RegisterFile_Read1,RegisterFile_Read2,Decode_instruction,PC_out: OUT std_logic_vector(31 DOWNTO 0);
      CU_Jmp,CU_OUTT,CU_Branch,CU_Reg_IMM,CU_PC_Reg,CU_Data_Stack,CU_WriteEnableMemory,CU_Call,CU_RETI,CU_Result_Mem,CU_INN,CU_RegPC_MemPC,INT: OUT std_logic;
      CU_Set_Clr_Carry,CU_WriteEnableWB : OUT std_logic_vector(1 DOWNTO 0);
      CU_SPSel : OUT std_logic_vector(2 DOWNTO 0);
      CU_ALU_Selc : OUT std_logic_vector(3 DOWNTO 0);
      OP1_ADDRESS, OP2_ADDRESS: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      REG_0_OUT,REG_1_OUT, REG_2_OUT, REG_3_OUT, REG_4_OUT, REG_5_OUT, REG_6_OUT, REG_7_OUT:OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
      WRITE_DATA1_TO_REG : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
      );

    END COMPONENT;
    
    --IMPORTING THE ID/EX BUFFER
    COMPONENT BOB_ID_EX IS
      
      PORT (
      RESET,STALL,CLK: IN STD_LOGIC;
      PC_IN, INST_IN, READ1_IN, READ2_IN: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      READ1_ADDRESS_IN, READ2_ADDRESS_IN: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      READ1_ADDRESS_OUT, READ2_ADDRESS_OUT: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      WB_IN: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      MEM_IN: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      EX_IN: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
      WB_OUT: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
      MEM_OUT: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      EX_OUT: OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
      INST_OUT, PC_OUT, READ1_OUT, READ2_OUT : OUT  STD_LOGIC_VECTOR(31 DOWNTO 0));
    
    END COMPONENT;

    --IMPORTING THE EXECUTION UNIT
    COMPONENT ExecutingUnit IS 
      PORT(
      CARRY_FLAG_OUT, ZERO_FLAG_OUT, NEGATIVE_FLAG_OUT: OUT STD_LOGIC;
      WB_IN: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      MEM_IN: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      WB_OUT: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
      MEM_OUT: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      PC: IN std_logic_vector(31 DOWNTO 0);
      Read1: IN std_logic_vector(31 DOWNTO 0);
      Read2: IN std_logic_vector(31 DOWNTO 0);
      SETC: IN std_logic_vector(1 DOWNTO 0);
      OutPortSel: IN  std_logic;
      ALUSel: IN std_logic_vector(3 DOWNTO 0);
      M3_Sel, M4_Sel: IN std_logic;
      AND_INPUT1,AND_INPUT2,AND_INPUT3: IN std_logic; 
      Solo_Or_Input: IN std_logic;
      ZERO_TO_THIRTY_ONE_IN: IN std_logic_vector(31 DOWNTO 0);
      OP1_ADDRESS:IN std_logic_vector(2 DOWNTO 0);
      OP2_ADDRESS:IN std_logic_vector(2 DOWNTO 0);
      MEM_DESTINATION_ADRESS:IN std_logic_vector(2 DOWNTO 0);
      MEM_DESTINATION_DATA:IN std_logic_vector(31 DOWNTO 0);
      MEM_REG_WRITE : IN STD_LOGIC;
      WB_DESTINATION_ADRESS:IN std_logic_vector(2 DOWNTO 0);
      WB_DESTINATION_DATA:IN std_logic_vector(31 DOWNTO 0);
      WB_REG_WRITE : IN STD_LOGIC;
      clk : IN std_logic;
      FlagsRegisterReset: IN std_logic;
      MemoryInput: In std_logic_vector(3 DOWNTO 0); --Input to Flags Register
      AluOut: OUT std_logic_vector(31 DOWNTO 0);
      ZERO_TO_EIGHT_OUT: OUT STD_LOGIC_VECTOR(8 DOWNTO 0); 
      Extender: OUT std_logic_vector(15 DOWNTO 0);
      FlagsRegisterOut: OUT std_logic_vector(3 DOWNTO 0);
      OutPort_Output: OUT std_logic_vector( 31 DOWNTO 0);
      Swap_Output: OUT std_logic_vector (31 DOWNTO 0);
      Or_Output: OUT std_logic;
      FORWARD_OP1,FORWARD_OP2: OUT STD_LOGIC
      );
    END COMPONENT;

    --IMPORTING EX/MEM INTERMEDIATE BUFFER
    COMPONENT BOB_EX_MEM IS
      PORT (
      RESET,STALL,CLK: IN STD_LOGIC;
      RESULT_IN, DESTINATION_IN: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      WB_IN: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      MEM_IN: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      FLAGS_IN: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      INST_0_8_IN: IN STD_LOGIC_VECTOR(8 DOWNTO 0);
      EFFECTIVE_ADDRESS_IN: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      RESULT_OUT, DESTINATION_OUT: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      WB_OUT: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
      MEM_OUT: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      FLAGS_OUT: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      INST_0_8_OUT: OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
      EFFECTIVE_ADDRESS_OUT: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
      );
    END COMPONENT;
    --IMPORTING MEMORY UNIT
    COMPONENT Memory_unit IS
      PORT (	
      RETI: IN STD_LOGIC;
      Clk : IN std_logic;
      WriteEnable : IN std_logic;				-- Write enable of the memory
      StackOrData : IN std_logic;				-- selector of Address
      ResultOrFlags: IN std_logic;				-- selector of data
      SPSEL :IN std_logic_vector(2 downto 0);			-- StackPointer selector
      EA : IN std_logic_vector(31 DOWNTO 0);			-- Effective Address input
      Result : IN std_logic_vector(31 DOWNTO 0);		-- Result input from ALU_unit
      Flags : IN std_logic_vector(31 DOWNTO 0);		-- Flags input from ALU_unit
      WB_ResultOrMem_IN : IN std_logic;			-- WriteBack selector of result or memory  
      WB_WriteEnable_IN : IN std_logic_vector(1 DOWNTO 0);	-- WriteBack Write Enable
      WB_INPort_IN : IN std_logic;				-- WriteBack IN-Port enable
      WB_RegPCOrMemPC_IN : IN std_logic;			-- WriteBack selector of Reg PC or Mem PC
      RdstOrRsrc_IN : IN std_logic_vector(31 DOWNTO 0);	-- Transition of Rdst data or Rsrc data from Exec to WB
      Inst0to8_IN : IN std_logic_vector(8 DOWNTO 0);		-- Transition of Inst[6-8] from Exec to WB
      DataRead : OUT std_logic_vector(31 DOWNTO 0);  	-- Data Read from memory
      Result_OUT : OUT std_logic_vector(31 DOWNTO 0);
      WB_ResultOrMem_Out : OUT std_logic;
      WB_WriteEnable_Out : OUT std_logic_vector(1 DOWNTO 0);
      WB_INPort_Out : OUT std_logic;
      WB_RegPCOrMemPC_Out : OUT std_logic;
      RdstOrRsrc_OUT : OUT std_logic_vector(31 DOWNTO 0);	
      Inst0to8_OUT : OUT std_logic_vector(8 DOWNTO 0);
      RESET: IN STD_LOGIC
      );
    END COMPONENT;

  --IMPORTING MEM/WB INTERMEDIATE BUFFER
  COMPONENT BOB_MEM_WB IS
	  PORT (
        RESET,STALL,CLK: IN STD_LOGIC;
        MEMORY_RESULT_IN, RESULT_IN, DESTINATION_IN: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        WB_IN: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        INST_0_8_IN: IN STD_LOGIC_VECTOR(8 DOWNTO 0);
        MEMORY_RESULT_OUT, RESULT_OUT, DESTINATION_OUT: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        WB_OUT: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        INST_0_8_OUT: OUT STD_LOGIC_VECTOR(8 DOWNTO 0));
  END COMPONENT;


  --IMPORTING WRITEBACK UNIT
  COMPONENT WriteBack IS 
    
  PORT (
    Result, DataRead1: IN std_logic_vector(31 DOWNTO 0);
    Rdst_Or_Rsrc_IN: IN std_logic_vector(31 DOWNTO 0);
    Ins6_8_IN: IN std_logic_vector(2 DOWNTO 0);
    Ins2_0_IN: IN std_logic_vector(2 DOWNTO 0);
    IN_EN_IN :IN std_logic;
    WRITE_ENABLE_IN :IN std_logic_vector(1 DOWNTO 0);
    Result_Mem_IN, FetchMem_IN: IN std_logic;
    WriteData: OUT std_logic_vector(31 DOWNTO 0);
    Rdst_Or_Rsrc_Out: OUT std_logic_vector(31 DOWNTO 0);
    Ins6_8_OUT: OUT std_logic_vector(2 DOWNTO 0);
    Ins2_0_OUT: OUT std_logic_vector(2 DOWNTO 0);
    FetchMem_Out: OUT std_logic;
    IN_EN_OUT :OUT std_logic;
    WRITE_ENABLE_OUT :OUT std_logic_vector(1 DOWNTO 0)
    );

  END COMPONENT;
  
--********************************************************************************************************************************
--*********************************************************DONE_IMPORTING_COMPONENTS**********************************************
--********************************************************************************************************************************




-----------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------DECLARING_SIGNALS------------------------------------------
-----------------------------------------------------------------------------------------------------------------------

  --INTERMEDIATE BUFFER WIRES
    --IF/ID
    SIGNAL IF_ID_INST_IN_WIRE, IF_ID_PC_IN_WIRE,IF_ID_INST_OUT_WIRE, IF_ID_PC_OUT_WIRE : STD_LOGIC_VECTOR(31 DOWNTO 0);
    --ID/EX
    SIGNAL ID_EX_Read1_IN_WIRE,ID_EX_Read2_IN_WIRE,ID_EX_INST_IN_WIRE,ID_EX_PC_IN_WIRE,ID_EX_Read1_OUT_WIRE,ID_EX_Read2_OUT_WIRE,ID_EX_INST_OUT_WIRE,ID_EX_PC_OUT_WIRE: std_logic_vector(31 DOWNTO 0);
    SIGNAL ID_EX_WB_OUT_WIRE: std_logic_vector(4 DOWNTO 0);
    SIGNAL ID_EX_MEM_OUT_WIRE: std_logic_vector(7 DOWNTO 0);
    SIGNAL ID_EX_EX_OUT_WIRE: std_logic_vector(10 DOWNTO 0);
    SIGNAL ID_EX_OP1_ADDRESS_IN_WIRE, ID_EX_OP2_ADDRESS_IN_WIRE, ID_EX_OP1_ADDRESS_OUT_WIRE, ID_EX_OP2_ADDRESS_OUT_WIRE : std_logic_vector(2 DOWNTO 0); 
    --EX/MEM
    SIGNAL EX_MEM_DESTINATION_IN_WIRE,EX_MEM_DESTINATION_OUT_WIRE, EX_MEM_RESULT_IN_WIRE,EX_MEM_RESULT_OUT_WIRE: STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL EX_MEM_FLAGS_IN_WIRE, EX_MEM_FLAGS_OUT_WIRE : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL EX_MEM_EFFECTIVE_ADDRESS_IN_WIRE, EX_MEM_EFFECTIVE_ADDRESS_OUT_WIRE: STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL EX_MEM_INST_0_8_IN_WIRE, EX_MEM_INST_0_8_OUT_WIRE: STD_LOGIC_VECTOR(8 DOWNTO 0);
    SIGNAL EX_MEM_WB_IN_WIRE, EX_MEM_WB_OUT_WIRE: std_logic_vector(4 DOWNTO 0);
    SIGNAL EX_MEM_MEM_IN_WIRE, EX_MEM_MEM_OUT_WIRE: std_logic_vector(7 DOWNTO 0);
    --MEM/WB    
    SIGNAL  MEM_WB_MEMORY_RESULT_IN_WIRE, MEM_WB_RESULT_IN_WIRE, MEM_WB_DESTINATION_IN_WIRE, MEM_WB_MEMORY_RESULT_OUT_WIRE, MEM_WB_RESULT_OUT_WIRE, MEM_WB_DESTINATION_OUT_WIRE:  STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL  MEM_WB_WB_IN_WIRE, MEM_WB_WB_OUT_WIRE:  STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL  MEM_WB_INST_0_8_IN_WIRE, MEM_WB_INST_0_8_OUT_WIRE:  STD_LOGIC_VECTOR(8 DOWNTO 0);


    --CONCATENATED SIGNALS
    SIGNAL CAT_ID_EX_WB: std_logic_vector(4 DOWNTO 0);
    SIGNAL CAT_ID_EX_MEM: std_logic_vector(7 DOWNTO 0);
    SIGNAL CAT_ID_EX_EX: std_logic_vector(10 DOWNTO 0);


    --CONTROL SIGNALS
    SIGNAL CS_EX_ALU_SEL: STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL CS_EX_Set_Clr_Carry: std_logic_vector(1 DOWNTO 0);
    SIGNAL CS_EX_Jmp,CS_EX_OUT,CS_EX_Branch,CS_EX_Reg_IMM,CS_EX_PC_Reg:std_logic;
    SIGNAL CS_MEM_SPSel: std_logic_vector(2 DOWNTO 0);
    SIGNAL CS_MEM_Data_Stack,CS_MEM_WriteEnableMemory,CS_MEM_Call,CS_MEM_RETI,CS_MEM_INT: std_logic;
    SIGNAL CS_WB_WriteEnable: std_logic_vector(1 DOWNTO 0);
    SIGNAL CS_WB_Result_Mem,CS_WB_IN,CS_WB_RegPC_MemPC: std_logic;

    --EXECUTION UNIT SIGNALS
    SIGNAL JUMP_BIT_OUT_WIRE: std_logic;
   -- SIGNAL EXTENDED_IMM: STD_LOGIC_VECTOR(31 DOWNTO 0);


    --SIGNALS EXTRA BTFOK AZMAT FEL MEM
    SIGNAL ZERO_EXTENDER_FLAGS, ZERO_EXTENDER_EFFECTIVE_ADDRESS: STD_LOGIC_VECTOR(31 DOWNTO 0 );

    --SIGNALS WRITEBACK
    SIGNAL WB_WRITE_BACK_DATA1_OUT_WIRE, WB_WRITE_BACK_DATA2_OUT_WIRE: STD_LOGIC_VECTOR(31 DOWNTO 0 );
    SIGNAL WB_INST_0_8_OUT_WIRE: STD_LOGIC_VECTOR(8 DOWNTO 0 );
    SIGNAL WB_WRITE_ENABLE_OUT_WIRE : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL WB_IN_ENABLE_OUT_WIRE, WB_FETCH_MEMORY_OUT_WIRE : STD_LOGIC;


    --TESTING SIGNALS 
    SIGNAL REG_0_TEST, REG_1_TEST, REG_2_TEST, REG_3_TEST, REG_4_TEST, REG_5_TEST, REG_6_TEST, REG_7_TEST ,WRITE_DATA1_TEST: STD_LOGIC_VECTOR(31 DOWNTO 0); 
    SIGNAL FORWARD_OP1_TEST,FORWARD_OP2_TEST:  STD_LOGIC;
    
    BEGIN
--********************************************************************************************************************************
--*********************************************************DONE_DECALRING_SIGNALS*************************************************
--********************************************************************************************************************************


-----------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------CONCATINATING_CONTROL_SIGNALS------------------------------
-----------------------------------------------------------------------------------------------------------------------    

    CAT_ID_EX_WB <= CS_WB_RegPC_MemPC & CS_WB_IN & CS_WB_Result_Mem & CS_WB_WriteEnable;--WB = (0-1 -> WRITE_ENABLE) & (2 -> RESULT_MEM) & (3 -> IN) & (4 -> REGPC_MEMPC)  
    CAT_ID_EX_MEM <= CS_MEM_INT & CS_MEM_RETI & CS_MEM_Call & CS_MEM_WriteEnableMemory & CS_MEM_Data_Stack & CS_MEM_SPSel;--MEM = (0-2 -> SPSEL) & (3 -> DATA_STACK) & (4 -> WRITE_ENABLE_MEMORY) & (5 -> CALL) & (6 -> RETI) & (7 -> INT)
    CAT_ID_EX_EX <= CS_EX_PC_Reg & CS_EX_Reg_IMM & CS_EX_Branch & CS_EX_OUT & CS_EX_Jmp & CS_EX_Set_Clr_Carry & CS_EX_ALU_SEL;--EX = (0-3 -> ALU_SEL) & (4-5 SET_CLR_CARRY) & (6 -> JMP) & (7 -> OUT) & (8 -> BRANCH) & (9 -> REG_IMM) & (10 -> PC_REG)


    ZERO_EXTENDER_FLAGS <= X"0000000" & EX_MEM_FLAGS_OUT_WIRE;
    ZERO_EXTENDER_EFFECTIVE_ADDRESS <= X"00000" & '0' & EX_MEM_EFFECTIVE_ADDRESS_OUT_WIRE(10 DOWNTO 0);


--********************************************************************************************************************************
--*********************************************************DONE_CONCATINATING_CONTROL_SIGNALS*************************************
--********************************************************************************************************************************






-----------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------INITIALIZING_COMPONENTS------------------------------------
-----------------------------------------------------------------------------------------------------------------------




-----------------------------------------------------------------FETCHING----------------------------------------------
    --THE FETCHING UNIT 
    FETCHING_UNIT: FU_FETCHER PORT MAP (INT_SIGNAL, --INTERUPT SIGNAL ENTERED TO THE WHOLE PROCESSOR
                                          JUMP_BIT_OUT_WIRE,  --JUMP BIT THAT COMES FROM EX STAGE
                                          '0',  --RETI BIT THAT COME FROM RETI UNIT (MISSING LESA MA ET3AMLSH)***&^$^$%^$%^$%%$#@!$#%^%%$#
                                          WB_FETCH_MEMORY_OUT_WIRE,  --MEMORY BIT THAT COMES FROM WB STAGE
                                          CLK,  --CLK ENTERED TO WHOLE PROCESSOR
                                          X"00000000", --JUMP LOCATION FROM EX SATGE (MISSING LESA MA ET3AMLSH)***&^$^$%^$%^$%%$#@!$#%^%%$#
                                          WB_WRITE_BACK_DATA1_OUT_WIRE, --MEMORY LOCATION FROM MEM STAGE
                                          IF_ID_INST_IN_WIRE, --FETCHED INSTRUCTION
                                          IF_ID_PC_IN_WIRE,  --CURRENT PC
                                          RESET,   --RESET SIGNAL ENTERED TO THE WHOLE PROCESSOR
					  MEM_WB_MEMORY_RESULT_IN_WIRE  
                                          );    

    --THE IF/ID INTERMEDIATE BUFFER
    IF_ID_BUFFER: BOB_IF_ID PORT MAP (RESET, --RESET SIGNAL ENTERED TO THE WHOLE PROCESSOR
                                        '0', --STALL SIGNAL FROM MANY SOURCES***&^$^$%^$%^$%%$#@!$#%^%%$#
                                        CLK,   --CLK ENTERED TO WHOLE PROCESSOR
                                        IF_ID_PC_IN_WIRE,  --CURRENT PC FROM FETCHING UNIT
                                        IF_ID_INST_IN_WIRE, --FETCHED INSTRUCTION FROM FETCHING UNIT
                                        IF_ID_INST_OUT_WIRE, --FETCHED INSTRUCTION OUTED WIRE
                                        IF_ID_PC_OUT_WIRE--CURRENT PC OUTED WIRE                                   
                                        );

-------------------------------------------------------------DECODEING---------------------------------------------
    --THE DECODE UNIT
    DECODE_UNIT: DECODESTAGE PORT MAP (IF_ID_PC_OUT_WIRE,     --PC FROM INTERMEDIATE BUFFER
                                        IF_ID_INST_OUT_WIRE,  --INST FROM INTERMEDIATE BUFFER
                                        IN_PORT,    --IN PORT VALUE FROM USER INPUT
                                        WB_WRITE_BACK_DATA1_OUT_WIRE,    --RESULT FROM WB STAGE
                                        WB_WRITE_BACK_DATA2_OUT_WIRE,    --WRTIE DATA 2 FROM WB
                                        WB_WRITE_ENABLE_OUT_WIRE,   --WRITE ENABLE FOR REGISTER FILE FROM WB
                                        WB_INST_0_8_OUT_WIRE(2 DOWNTO 0),    --WRITE ADDRESS 1 WB
                                        WB_INST_0_8_OUT_WIRE(8 DOWNTO 6),    --WRITE ADDRRES 2 WB
                                        CLK,    --CLK ENTERED TO WHOLE PROCESSOR
                                        RESET,    --RESET SIGNAL ENTERED TO THE WHOLE PROCESSOR
                                        WB_IN_ENABLE_OUT_WIRE,    --IN ENABLE FROM WB
                                        ID_EX_Read1_IN_WIRE,  --READ1 GOING TO INTERMEDIATE BUFFER
                                        ID_EX_Read2_IN_WIRE,  --READ2 GOING TO INTERMEDIATE BUFFER
                                        ID_EX_INST_IN_WIRE,   --INST GOING TO INTERMEDIATE BUFFER
                                        ID_EX_PC_IN_WIRE,     --PC GOING TO INTERMEDIATE BUFFER
                                        CS_EX_Jmp,        --CONTROL SIGNAL JMP GOING TO EX STAGE
                                        CS_EX_OUT,        --CONTROL SIGNAL OUT GOING TO EX STAGE
                                        CS_EX_Branch,      --CONTROL SIGNAL BRANCH GOING TO EX STAGE
                                        CS_EX_Reg_IMM,      --CONTROL SIGNAL REG OR IMM GOING TO EX STAGE
                                        CS_EX_PC_Reg,       --CONTROL SIGNAL PC OR REG GOING TO EX STAGE
                                        CS_MEM_Data_Stack,    --CONTROL SIGNAL DATA OR STACK GOING TO MEM STAGE
                                        CS_MEM_WriteEnableMemory,   --CONTROL SIGNAL WRITE ENABLE  GOING TO MEM STAGE
                                        CS_MEM_Call,          --CONTROL SIGNAL CALL GOING TO MEM STAGE
                                        CS_MEM_RETI,        --CONTROL SIGNAL RETI GOING TO MEM STAGE
                                        CS_WB_Result_Mem,   --CONTROL SIGNAL RESULT OR MEMORY GOING TO WB STAGE
                                        CS_WB_IN,         --CONTROL SIGNAL IN GOING TO WB STAGE
                                        CS_WB_RegPC_MemPC,    --CONTROL SIGNAL REGPC OR MEMPC GOING TO WB STAGE
                                        CS_MEM_INT,           --CONTROL SIGNAL FOR INT
                                        CS_EX_Set_Clr_Carry,  --CONTROL SIGNAL SET OR CLEAR CARRY GOING TO EX STAGE
                                        CS_WB_WriteEnable,    --CONTROL SIGNAL WRITE ENABLE GOING TO WB STAGE
                                        CS_MEM_SPSel,         --CONTROL SIGNAL STACK POINTER SELECTOR GOING TO MEM STAGE
                                        CS_EX_ALU_SEL,        --CONTROL SIGNAL ALU SELECTOR GOING TO EX STAGE
                                        ID_EX_OP1_ADDRESS_IN_WIRE,  --READ 1 SOURCE ADDRESS GOING TO INTERMEDIATE BUFFER
                                        ID_EX_OP2_ADDRESS_IN_WIRE,   --READ 2 SOURCE ADDRESS GOING TO INTERMEDIATE BUFFER
                                        REG_0_TEST, 
                                        REG_1_TEST, 
                                        REG_2_TEST, 
                                        REG_3_TEST,
                                        REG_4_TEST, 
                                        REG_5_TEST, 
                                        REG_6_TEST, 
                                        REG_7_TEST,
                                        WRITE_DATA1_TEST
                                        );

    --THE ID/EX INTERMEDIATE BUFFER
    ID_EX_BUFFER: BOB_ID_EX PORT MAP (RESET,
                                        '0',
                                        CLK,
                                        ID_EX_PC_IN_WIRE, 
                                        ID_EX_INST_IN_WIRE, 
                                        ID_EX_Read1_IN_WIRE, 
                                        ID_EX_Read2_IN_WIRE,
                                        ID_EX_OP1_ADDRESS_IN_WIRE,
                                        ID_EX_OP2_ADDRESS_IN_WIRE,
                                        ID_EX_OP1_ADDRESS_OUT_WIRE,
                                        ID_EX_OP2_ADDRESS_OUT_WIRE,
                                        CAT_ID_EX_WB, 
                                        CAT_ID_EX_MEM, 
                                        CAT_ID_EX_EX,
                                        ID_EX_WB_OUT_WIRE, 
                                        ID_EX_MEM_OUT_WIRE, 
                                        ID_EX_EX_OUT_WIRE,
                                        ID_EX_INST_OUT_WIRE, 
                                        ID_EX_PC_OUT_WIRE, 
                                        ID_EX_Read1_OUT_WIRE, 
                                        ID_EX_Read2_OUT_WIRE
                                        );
                                        
-------------------------------------------------------------EXECUTING---------------------------------------------

    --THE EXECUTING UNIT
    EXECUTION_UNIT: ExecutingUnit PORT MAP ( CARRY_FLAG, 
                                              ZERO_FLAG, 
                                              NEGATIVE_FLAG,
                                              ID_EX_WB_OUT_WIRE,
                                              ID_EX_MEM_OUT_WIRE,
                                              EX_MEM_WB_IN_WIRE,
                                              EX_MEM_MEM_IN_WIRE,
                                              ID_EX_PC_OUT_WIRE,
                                              ID_EX_Read1_OUT_WIRE, 
                                              ID_EX_Read2_OUT_WIRE,
                                              ID_EX_EX_OUT_WIRE(5 DOWNTO 4),
                                              ID_EX_EX_OUT_WIRE(7),
                                              ID_EX_EX_OUT_WIRE(3 DOWNTO 0),
                                              ID_EX_EX_OUT_WIRE(10), 
                                              ID_EX_EX_OUT_WIRE(9),
                                              ID_EX_EX_OUT_WIRE(8), 
                                              ID_EX_EX_OUT_WIRE(8), 
                                              ID_EX_EX_OUT_WIRE(8),
                                              ID_EX_EX_OUT_WIRE(6),
                                              ID_EX_INST_OUT_WIRE(31 DOWNTO 0),
                                              ID_EX_OP1_ADDRESS_OUT_WIRE,
                                              ID_EX_OP2_ADDRESS_OUT_WIRE,
                                              EX_MEM_INST_0_8_IN_WIRE(2 DOWNTO 0),    --RDST
                                              EX_MEM_RESULT_OUT_WIRE,    --RESULT FROM MEMORY FOR flags
                                              EX_MEM_WB_OUT_WIRE(0),    --***&^$^$%^$%^$%%$#@!$#%^%%$#
                                              MEM_WB_INST_0_8_IN_WIRE(2 DOWNTO 0),    --***&^$^$%^$%^$%%$#@!$#%^%%$#
                                              MEM_WB_DESTINATION_OUT_WIRE,     --***&^$^$%^$%^$%%$#@!$#%^%%$#
                                              MEM_WB_WB_OUT_WIRE(0),    --***&^$^$%^$%^$%%$#@!$#%^%%$#
                                              CLK,
                                              RESET,
                                              MEM_WB_MEMORY_RESULT_IN_WIRE(3 DOWNTO 0),
                                              EX_MEM_RESULT_IN_WIRE,
                                              EX_MEM_INST_0_8_IN_WIRE(8 DOWNTO 0),
                                              EX_MEM_EFFECTIVE_ADDRESS_IN_WIRE,
                                              EX_MEM_FLAGS_IN_WIRE,
                                              OUT_PORT,
                                              EX_MEM_DESTINATION_IN_WIRE,
                                              JUMP_BIT_OUT_WIRE,
                                              FORWARD_OP1_TEST,
                                              FORWARD_OP2_TEST
                                              );

    --THE EX/MEM INTERMEDIATE BUFFER
    EX_MEM_BUFFER: BOB_EX_MEM PORT MAP ( RESET,   --RESET SIGNAL ENTERED TO THE WHOLE PROCESSOR
                                          '0',    --STALL SIGNAL FROM MANY SOURCES***&^$^$%^$%^$%%$#@!$#%^%%$#
                                          CLK,     --CLK ENTERED TO WHOLE PROCESSOR
                                          EX_MEM_RESULT_IN_WIRE, 
                                          EX_MEM_DESTINATION_IN_WIRE,
                                          EX_MEM_WB_IN_WIRE,
                                          EX_MEM_MEM_IN_WIRE,
                                          EX_MEM_FLAGS_IN_WIRE,
                                          EX_MEM_INST_0_8_IN_WIRE,
                                          EX_MEM_EFFECTIVE_ADDRESS_IN_WIRE,
                                          EX_MEM_RESULT_OUT_WIRE,
                                          EX_MEM_DESTINATION_OUT_WIRE,
                                          EX_MEM_WB_OUT_WIRE,
                                          EX_MEM_MEM_OUT_WIRE,
                                          EX_MEM_FLAGS_OUT_WIRE,
                                          EX_MEM_INST_0_8_OUT_WIRE,
                                          EX_MEM_EFFECTIVE_ADDRESS_OUT_WIRE
                                          );

-------------------------------------------------------------MEMORY---------------------------------------------

    MEMORY_UNITT: Memory_unit PORT MAP ('0',
                                        CLK,
                                        EX_MEM_MEM_OUT_WIRE(4),				-- Write enable of the memory
                                        EX_MEM_MEM_OUT_WIRE(3),				-- selector of Address
                                        EX_MEM_MEM_OUT_WIRE(7),				-- selector of data
                                        EX_MEM_MEM_OUT_WIRE(2 DOWNTO 0),			-- StackPointer selector
                                        ZERO_EXTENDER_EFFECTIVE_ADDRESS,			-- Effective Address input
                                        EX_MEM_RESULT_OUT_WIRE,		-- Result input from ALU_unit
                                        ZERO_EXTENDER_FLAGS,		-- Flags input from ALU_unit
                                        EX_MEM_WB_OUT_WIRE(2),			-- WriteBack selector of result or memory  
                                        EX_MEM_WB_OUT_WIRE(1 DOWNTO 0),	-- WriteBack Write Enable
                                        EX_MEM_WB_OUT_WIRE(3),				-- WriteBack IN-Port enable
                                        EX_MEM_WB_OUT_WIRE(4),			-- WriteBack selector of Reg PC or Mem PC
                                        EX_MEM_DESTINATION_OUT_WIRE,	-- Transition of Rdst data or Rsrc data from Exec to WB
                                        EX_MEM_INST_0_8_OUT_WIRE(8 DOWNTO 0),		-- Transition of Inst[0-8] from Exec to WB
                                        MEM_WB_MEMORY_RESULT_IN_WIRE,  	-- Data Read from memory
                                        MEM_WB_RESULT_IN_WIRE,
                                        MEM_WB_WB_IN_WIRE(2),
                                        MEM_WB_WB_IN_WIRE(1 DOWNTO 0),
                                        MEM_WB_WB_IN_WIRE(3),
                                        MEM_WB_WB_IN_WIRE(4),
                                        MEM_WB_DESTINATION_IN_WIRE,
                                        MEM_WB_INST_0_8_IN_WIRE(8 DOWNTO 0),
					                              RESET
                                        );

    --THE EX/MEM INTERMEDIATE BUFFER
    MEM_WB_BUFFER: BOB_MEM_WB PORT MAP ( RESET,
                                          '0',
                                          CLK,
                                          MEM_WB_MEMORY_RESULT_IN_WIRE,
                                          MEM_WB_RESULT_IN_WIRE, 
                                          MEM_WB_DESTINATION_IN_WIRE,
                                          MEM_WB_WB_IN_WIRE,
                                          MEM_WB_INST_0_8_IN_WIRE,
                                          MEM_WB_MEMORY_RESULT_OUT_WIRE, 
                                          MEM_WB_RESULT_OUT_WIRE, 
                                          MEM_WB_DESTINATION_OUT_WIRE,
                                          MEM_WB_WB_OUT_WIRE,
                                          MEM_WB_INST_0_8_OUT_WIRE
				                                   );
-------------------------------------------------------------WRITE_BACK---------------------------------------------

WRITEBACK_UNITT: WriteBack PORT MAP (  MEM_WB_RESULT_OUT_WIRE, 
                                        MEM_WB_MEMORY_RESULT_OUT_WIRE,
                                        MEM_WB_DESTINATION_OUT_WIRE,
                                        MEM_WB_INST_0_8_OUT_WIRE(8 DOWNTO 6),
                                        MEM_WB_INST_0_8_OUT_WIRE(2 DOWNTO 0),
                                        MEM_WB_WB_OUT_WIRE(3), 
                                        MEM_WB_WB_OUT_WIRE(1 DOWNTO 0), 
                                        MEM_WB_WB_OUT_WIRE(2), 
                                        MEM_WB_WB_OUT_WIRE(4),
                                        WB_WRITE_BACK_DATA1_OUT_WIRE,
                                        WB_WRITE_BACK_DATA2_OUT_WIRE,
                                        WB_INST_0_8_OUT_WIRE(8 DOWNTO 6),
                                        WB_INST_0_8_OUT_WIRE(2 DOWNTO 0),
                                        WB_FETCH_MEMORY_OUT_WIRE,
                                        WB_IN_ENABLE_OUT_WIRE,
                                        WB_WRITE_ENABLE_OUT_WIRE
                                        );
--********************************************************************************************************************************
--*********************************************************DONE_INITIALIZING_COMPONENTS*******************************************
--********************************************************************************************************************************

  WB_INST_0_8_OUT_WIRE(5 DOWNTO 3) <= "000";
END HARVARD_PROCESSOR_ARCH;