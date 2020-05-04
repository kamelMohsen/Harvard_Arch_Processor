LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

--JUMP_BIT IS 1 BIT INDICATING WETHER THERE IS A JMP OR NOT 
--RETI_BIT STALLS THE PC UNIT FROM INCREMENTING THE PC IT COMES ONLY FOR ONE CLOCK CYCLE
--MEMORY_BIT INDICATES THAT A MEMORY LOACTION WILL OVERWRITE THE PC
--JUMP_LOACTION IS THE VALUE THAT WILL OVERWRITE THE CURRENT VALUE OF PC
--MEMORY_INSTR IS THE VALU THAT WILL OVERWRITE THE CURRENT VALUE OF PC 
--RESET WILL DO THE RESET TO FETCHING UNIT NOT YET SPECIFIED WHAT IT WILL DO

ENTITY FETCHER IS
	GENERIC(Data_Width : INTEGER := 32); 
	PORT (INT_SIGNAL, JUMP_BIT, RETI_BIT, MEMORY_BIT,CLK: IN STD_LOGIC;
    JUMP_LOCATION, MEMORY_INSTR: IN STD_LOGIC_VECTOR(Data_Width-1 DOWNTO 0);
	INSTRUCTION, PC : OUT  STD_LOGIC_VECTOR(Data_Width - 1 DOWNTO 0);
	RESET : IN STD_LOGIC);
END ENTITY FETCHER;


ARCHITECTURE FETCH OF FETCHER IS
  

    --THE ADDER COMPONENT IMPORTING
    COMPONENT FULL_ADDER IS

    PORT   (a, b : IN std_logic_vector(Data_Width-1 DOWNTO 0) ;
            cin : IN std_logic;
            s : OUT std_logic_vector(Data_Width-1 DOWNTO 0);
            cout : OUT std_logic);

    END COMPONENT;
    --THE MUXES COMPONENT IMPORTING
    COMPONENT MUX2x1 IS 
    
    PORT ( Input0, Input1 :IN STD_LOGIC_VECTOR(Data_Width - 1 DOWNTO 0); 
	Sel: IN STD_LOGIC;
	Output : OUT  STD_LOGIC_VECTOR(Data_Width - 1 DOWNTO 0)
    );
    
    END COMPONENT;

    --THE PROGRAM COUNTER COMPONENT IMPORTING
    COMPONENT REG IS 

    PORT(Clk,Rst,enable : IN std_logic;
	d : IN std_logic_vector(Data_Width-1 DOWNTO 0);
    q : OUT std_logic_vector(Data_Width-1 DOWNTO 0));
    
    END COMPONENT;

    --THE INT UNIT COMPONENT IMPORTING
    COMPONENT INT_UNIT IS 
    
    GENERIC(Data_Width : INTEGER := 32); 
	PORT (INT_SIG, clk: IN STD_LOGIC;
	Change_to_INT_Commands: OUT STD_LOGIC;
	Instruction : OUT  STD_LOGIC_VECTOR(Data_Width - 1 DOWNTO 0);
    Reset : IN STD_LOGIC);
    
    END COMPONENT;

    --THE INSTRUCTION MEMORY COMPONENT IMPORTING
    COMPONENT sync_ram IS 

    port (
        clock   : in  std_logic;
        we      : in  std_logic;
        address : in  std_logic_vector(Data_Width-1 DOWNTO 0);
        datain  : in  std_logic_vector(Data_Width-1 DOWNTO 0);
        dataout : out std_logic_vector(Data_Width-1 DOWNTO 0)
      );

      END COMPONENT;
    --THE OR GATE IMPORTING
    COMPONENT ORR IS 
    
    PORT ( Input0, Input1 :IN STD_LOGIC; 
	Output0: OUT STD_LOGIC
    );
    
    END COMPONENT;

    SIGNAL OUT_INSTRUCTION, NORMAL_INSTRUCTION, INT_INSTRUCTION, PROG_COUNT, PROG_COUNT_PLUS_ONE, PROG_COUNT_PLUS_TWO, PC_PLUS_ONE_OR_PLUS_TWO, PC_OR_JUMP, PC_OR_JUMP_OR_MEM : STD_LOGIC_VECTOR(Data_Width-1 DOWNTO 0);
    SIGNAL INT_CONTROL, COUT, INT_OR_RETI: STD_LOGIC;
    BEGIN	
    


    --THE INTERUPT UNIT 
    INTR_UNIT: INT_UNIT GENERIC MAP (Data_Width) PORT MAP (INT_SIGNAL, CLK, INT_CONTROL, INT_INSTRUCTION, RESET);    
    --THE ORING OF RETI AND INT 
    ORING_RETI_INT: ORR PORT MAP (INT_CONTROL, RETI_BIT, INT_OR_RETI);
    --THE PC OF THE FETCHING UNIT
    PC_UNIT: REG GENERIC MAP (Data_Width) PORT MAP (CLK, RESET, INT_OR_RETI, PC_OR_JUMP_OR_MEM, PROG_COUNT);
    --INSTRUCTION MEMORY
    INST_MEM: sync_ram GENERIC MAP (Data_Width) PORT MAP (CLK, '0', PROG_COUNT, "00000000000000000000000000000000", NORMAL_INSTRUCTION); 
    --ADDERS THAT ADD 1 TWICE TO THE PC
    ADD_PC_ONE: FULL_ADDER GENERIC MAP (Data_Width) PORT MAP (PROG_COUNT,"00000000000000000000000000000001", '0',PROG_COUNT_PLUS_ONE, COUT);
    ADD_PC_TWO: FULL_ADDER GENERIC MAP (Data_Width) PORT MAP (PROG_COUNT_PLUS_ONE,"00000000000000000000000000000001", '0',PROG_COUNT_PLUS_TWO, COUT);
    --MUX THAT CHOOSE EITHER TO ADD 1 OR TO ADD 2 TO THE PC 
    MUX_PC_PLUS_ONE_OR_PLUS_TWO: MUX2x1 GENERIC MAP (Data_Width) PORT MAP (PROG_COUNT_PLUS_ONE, PROG_COUNT_PLUS_TWO, NORMAL_INSTRUCTION(0), PC_PLUS_ONE_OR_PLUS_TWO);
    --MUX THAT CHOOSES PC OR JUMP LOCATION
    MUX_PC_OR_JUMP: MUX2x1 GENERIC MAP (Data_Width) PORT MAP (PC_PLUS_ONE_OR_PLUS_TWO, JUMP_LOCATION, JUMP_BIT, PC_OR_JUMP);
    --MUX THAT CHOOSES PC/JUMP OR MEM
    MUX_PC_OR_JUMP_MEM: MUX2x1 GENERIC MAP (Data_Width) PORT MAP (PC_OR_JUMP, MEMORY_INSTR, MEMORY_BIT, PC_OR_JUMP_OR_MEM);
    --MUX THAT CHOOSES EITHER NORMAL OR INT INSTRUCTION
    MUX_NORMAL_OR_INT: MUX2x1 GENERIC MAP (Data_Width) PORT MAP (NORMAL_INSTRUCTION, INT_INSTRUCTION, INT_CONTROL, OUT_INSTRUCTION);

    INSTRUCTION <= OUT_INSTRUCTION;

    
END FETCH;