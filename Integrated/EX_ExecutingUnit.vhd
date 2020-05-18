LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ExecutingUnit IS PORT(
CARRY_FLAG_OUT, ZERO_FLAG_OUT, NEGATIVE_FLAG_OUT: OUT STD_LOGIC;
--CONTROL SIGNALS-----
WB_IN: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
MEM_IN: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
WB_OUT: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
MEM_OUT: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
------------------------------------INPUT--------------------------------------------------
--An output from the buffer should be going to the fetch stage
--Buffer Outputs

PC: IN std_logic_vector(31 DOWNTO 0);
Read1: IN std_logic_vector(31 DOWNTO 0);
Read2: IN std_logic_vector(31 DOWNTO 0);

--Blue Buffer Outputs

SETC: IN std_logic_vector(1 DOWNTO 0);
OutPortSel: IN  std_logic;
ALUSel: IN std_logic_vector(3 DOWNTO 0);
M3_Sel, M4_Sel: IN std_logic;
AND_INPUT1,AND_INPUT2,AND_INPUT3: IN std_logic; 
Solo_Or_Input: IN std_logic;


--Divided Bits

ZERO_TO_THIRTY_ONE_IN: IN std_logic_vector(31 DOWNTO 0);
--ID/EX INPUTS
OP1_ADDRESS:IN std_logic_vector(2 DOWNTO 0);
OP2_ADDRESS:IN std_logic_vector(2 DOWNTO 0);

--MEM INPUTS
MEM_DESTINATION_ADRESS:IN std_logic_vector(2 DOWNTO 0);
MEM_DESTINATION_DATA:IN std_logic_vector(31 DOWNTO 0);
MEM_REG_WRITE : IN STD_LOGIC;

--WB INPUTS
WB_DESTINATION_ADRESS:IN std_logic_vector(2 DOWNTO 0);
WB_DESTINATION_DATA:IN std_logic_vector(31 DOWNTO 0);
WB_REG_WRITE : IN STD_LOGIC;

--not drawn in the design

clk : IN std_logic;
FlagsRegisterReset: IN std_logic;
MemoryInput: In std_logic_vector(3 DOWNTO 0); --Input to Flags Register

--Output to buffer
AluOut: OUT std_logic_vector(31 DOWNTO 0);
ZERO_TO_EIGHT_OUT: OUT std_logic_vector(8 DOWNTO 0);
Extender: OUT std_logic_vector(15 DOWNTO 0);
FlagsRegisterOut: OUT std_logic_vector(3 DOWNTO 0);
OutPort_Output: OUT std_logic_vector( 31 DOWNTO 0);
Swap_Output: OUT std_logic_vector (31 DOWNTO 0);

--Other Output
Or_Output: OUT std_logic;

-- More Outputs still need to be specified when the buffers are implemented
FORWARD_OP1,FORWARD_OP2: OUT STD_LOGIC

);
END ENTITY ExecutingUnit;

ARCHITECTURE ExecutingUnit_ARCH OF ExecutingUnit IS 

COMPONENT Execute_ALU  IS PORT (
    Rsrc1, Rsrc2: IN std_logic_vector( 31 DOWNTO 0);    --Source1 and Source2
    Instr: IN std_logic_vector( 4 DOWNTO 0);    	--Shift Amount
    ALU_Sel: IN std_logic_vector(3 DOWNTO 0);   	-- Operation Selector
    Stall: IN std_logic; 				-- Stall --NOT IMPLEMENTED YET
    Zero, Carry, Negative: OUT std_logic;		--FLAGS
    Result: OUT std_logic_vector(31 DOWNTO 0);		--Output
    FlagsRegisterEnable: OUT std_logic
);
END COMPONENT;

COMPONENT Execute_FlagsRegister IS PORT (
    ZeroInput, NegativeInput, CarryInput: IN std_logic;
    SETC: IN std_logic_vector(1 DOWNTO  0);
    clk: IN std_logic;
    rst: IN std_logic;
    ZeroReset, CarryReset, NegativeReset: IN std_logic;
    MemoryInput: IN std_logic_vector(3 DOWNTO 0);
    --ZeroOutput, CarryOutput, NegativeOutput: OUT std_logic;
    RegOut: OUT std_logic_vector(3 DOWNTO 0)
    --reti input
);
END COMPONENT;

COMPONENT Execute_OutPort IS PORT  (
	en: IN std_logic;
	input1: IN std_logic_vector(31 DOWNTO 0);
	clk: IN std_logic;
	output1: OUT std_logic_vector(31 DOWNTO 0)
    );
END COMPONENT;

COMPONENT Execute_ZeroExtender IS PORT (
    INST: IN std_logic_vector(31 DOWNTO 16);
    BufferOut: OUT std_logic_vector(31 DOWNTO 0);
    AluOut: OUT std_logic_vector(15 DOWNTO 0)
);
END COMPONENT;

COMPONENT Execute_MUX2x1 IS 
GENERIC(Data_Width : INTEGER := 32); 
PORT ( 
    Input0, Input1 :IN STD_LOGIC_VECTOR(Data_Width - 1 DOWNTO 0); 
    Sel: IN STD_LOGIC;
    Output : OUT  STD_LOGIC_VECTOR(Data_Width - 1 DOWNTO 0)
);
END COMPONENT ;

COMPONENT Execute_TwoInputAnd IS PORT (
    firstInput: IN std_logic;
    secondInput: IN std_logic;
    output: OUT std_logic
    );
END COMPONENT;

COMPONENT Execute_FourInputOr IS PORT (
firstInput: IN std_logic;
secondInput: IN std_logic;
thirdInput:  IN std_logic;
fourthInput: IN std_logic;
output1: OUT std_logic
);
END COMPONENT;


COMPONENT Execute_FWU IS 
    PORT 
    (
        MEM_REG_WRITE, WB_REG_WRITE: IN STD_LOGIC;
        MEM_Destination_Address,WB_Destination_Address,EX_Destination_OP1_Address, EX_Destination_OP2_Address: IN std_logic_vector(2 DOWNTO 0);
        MEM_Destination_Data,WB_Destination_Data : IN std_logic_vector(31 DOWNTO 0);
        FW_OP1_Data, FW_OP2_Data : OUT std_logic_vector(31 DOWNTO 0);
        FW_OP1_Enable, FW_OP2_Enable: OUT std_logic
    );
END COMPONENT;

SIGNAL M1_Sel,M2_Sel: std_logic;
SIGNAL FWUOUTPUT1, FWUOUTPUT2:  std_logic_vector(31 DOWNTO 0); 
SIGNAL M1Output, M2Output, M3Output, M4Output: std_logic_vector(31 DOWNTO 0);
SIGNAL ZeroExtendedSignal: std_logic_vector(31 DOWNTO 0);
SIGNAL ALU_Neg, ALU_Zero, ALU_Carry: std_logic;
SIGNAL FROut: std_logic_vector(3 DOWNTO 0);
SIGNAL And1_Out, And2_Out, And3_Out: std_logic;
BEGIN

CARRY_FLAG_OUT <=  FROut(2);
ZERO_FLAG_OUT <=   FROut(0); 
NEGATIVE_FLAG_OUT <= FROut(1);

WB_OUT <= WB_IN;
MEM_OUT <= MEM_IN;

Ext: Execute_ZeroExtender PORT MAP(ZERO_TO_THIRTY_ONE_IN(31 DOWNTO 16), ZeroExtendedSignal, Extender);

FR1: Execute_FlagsRegister PORT MAP(ALU_Zero, ALU_Neg, ALU_Carry, SETC, clk, FlagsRegisterReset, And1_Out, And3_Out, And2_Out, MemoryInput, FROut);

Outport1: Execute_OutPort PORT MAP(OutPortSel, M1Output,clk, OutPort_Output);

Mux1: Execute_MUX2x1 PORT MAP(Read1, FWUOUTPUT1 , '0', M1Output);--eftkr rag3 el fw ba3dain M1_Sel,M2_Sel
Mux2: Execute_MUX2x1 PORT MAP(Read2, FWUOUTPUT2 , '0', M2Output);
Mux3: Execute_MUX2x1 PORT MAP(PC, M1Output, M3_Sel, M3Output);
Mux4: Execute_MUX2x1 PORT MAP(M2Output, ZeroExtendedSignal, M4_Sel, M4Output);

ALU1: Execute_ALU PORT MAP(M3Output, M4Output, ZERO_TO_THIRTY_ONE_IN(8 DOWNTO 4), ALUSel, '1', ALU_Zero, ALU_Carry, ALU_Neg, AluOut);
ZERO_TO_EIGHT_OUT <=ZERO_TO_THIRTY_ONE_IN(8 DOWNTO 0);
Swap_Output <= M2Output;
FlagsRegisterOut <= FROut;
and1: Execute_TwoInputAnd PORT MAP(FROut(0), AND_INPUT1, And1_Out);
and2: Execute_TwoInputAnd PORT MAP(FROut(1), AND_INPUT2, And2_Out);
and3: Execute_TwoInputAnd PORT MAP(FROut(2), AND_INPUT3, And3_Out);

or1: Execute_FourInputOr PORT MAP(And1_Out, And2_Out, And3_Out, Solo_Or_Input, Or_Output);

FORWARDING_UNIT: Execute_FWU PORT MAP (MEM_REG_WRITE, WB_REG_WRITE,
                                        MEM_DESTINATION_ADRESS,WB_DESTINATION_ADRESS,
                                        OP1_ADDRESS, OP2_ADDRESS,
                                        MEM_DESTINATION_DATA,WB_DESTINATION_DATA,
                                        FWUOUTPUT1, FWUOUTPUT2,
                                        M1_Sel, M2_Sel);

                                        FORWARD_OP1 <= M1_Sel;
                                        FORWARD_OP2 <= M2_Sel;
END ExecutingUnit_ARCH;


