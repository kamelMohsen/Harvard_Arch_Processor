LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ExecutingUnit IS PORT(

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

Zero_Two_IN:IN std_logic_vector(2 DOWNTO 0);
Three_Eight:IN std_logic_vector(6 DOWNTO 0);
Six_Eight_IN:IN std_logic_vector(2 DOWNTO 0);
Zero_Four:IN std_logic_vector(4 DOWNTO 0);
Sixteen_ThirtyOne:IN std_logic_vector(15 DOWNTO 0);

--FWU Outputs

M1_Sel,M2_Sel: IN std_logic;
FWUOUTPUT1, FWUOUTPUT2: IN std_logic_vector(31 DOWNTO 0); 

--not drawn in the design

clk : IN std_logic;
FlagsRegisterReset: IN std_logic;
ZeroReset, NegativeReset, CarryReset: IN std_logic;

MemoryInput: In std_logic_vector(3 DOWNTO 0); --Input to Flags Register

--Output to buffer
AluOut: OUT std_logic_vector(31 DOWNTO 0);
Six_Eight_OUT:OUT std_logic_vector(2 DOWNTO 0);
Zero_Two_OUT:OUT std_logic_vector(2 DOWNTO 0);
Three_Eight_OUT: OUT std_logic_vector(6 DOWNTO 0);
Extender: OUT std_logic_vector(31 DOWNTO 0);
FlagsRegisterOut: OUT std_logic_vector(3 DOWNTO 0);
OutPort_Output: OUT std_logic_vector( 31 DOWNTO 0);
Swap_Output: OUT std_logic_vector (31 DOWNTO 0);

--Other Output
Or_Output: OUT std_logic

-- More Outputs still need to be specified when the buffers are implemented

);
END ENTITY ExecutingUnit;

ARCHITECTURE exec OF ExecutingUnit IS 

COMPONENT ALU  IS PORT (
    Rsrc1, Rsrc2: IN std_logic_vector( 31 DOWNTO 0);    --Source1 and Source2
    Instr: IN std_logic_vector( 4 DOWNTO 0);    	--Shift Amount
    ALU_Sel: IN std_logic_vector(3 DOWNTO 0);   	-- Operation Selector
    Stall: IN std_logic; 				-- Stall --NOT IMPLEMENTED YET
    Zero, Carry, Negative: OUT std_logic;		--FLAGS
    Result: OUT std_logic_vector(31 DOWNTO 0);		--Output
    FlagsRegisterEnable: OUT std_logic
);
END COMPONENT;

COMPONENT FlagsRegister IS PORT (
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

COMPONENT OutPort IS PORT  (
    sel: IN std_logic;
    input: IN std_logic_vector(31 DOWNTO 0);
    output: OUT std_logic_vector(31 DOWNTO 0)
    );
END COMPONENT;

COMPONENT ZeroExtender IS PORT (
    INST: IN std_logic_vector(31 DOWNTO 16);
    BufferOut, AluOut: OUT std_logic_vector(31 DOWNTO 0)
);
END COMPONENT;

COMPONENT MUX2x1 IS 
GENERIC(Data_Width : INTEGER := 32); 
PORT ( 
    Input0, Input1 :IN STD_LOGIC_VECTOR(Data_Width - 1 DOWNTO 0); 
    Sel: IN STD_LOGIC;
    Output : OUT  STD_LOGIC_VECTOR(Data_Width - 1 DOWNTO 0)
);
END COMPONENT ;

COMPONENT TwoInputAnd IS PORT (
    firstInput: IN std_logic;
    secondInput: IN std_logic;
    output: OUT std_logic
    );
END COMPONENT;

COMPONENT FourInputOr IS PORT (
firstInput: IN std_logic;
secondInput: IN std_logic;
thirdInput:  IN std_logic;
fourthInput: IN std_logic;
output1: OUT std_logic
);
END COMPONENT;

SIGNAL M1Output, M2Output, M3Output, M4Output: std_logic_vector(31 DOWNTO 0);
SIGNAL ZeroExtendedSignal: std_logic_vector(31 DOWNTO 0);
SIGNAL ALU_Neg, ALU_Zero, ALU_Carry: std_logic;
SIGNAL FROut: std_logic_vector(3 DOWNTO 0);
SIGNAL And1_Out, And2_Out, And3_Out: std_logic;
BEGIN

Ext: ZeroExtender PORT MAP(Sixteen_ThirtyOne, ZeroExtendedSignal, Extender);

FR1: FlagsRegister PORT MAP(ALU_Zero, ALU_Neg, ALU_Carry, SETC, clk, FlagsRegisterReset, ZeroReset, CarryReset, NegativeReset, MemoryInput, FROut);

Outport1: OutPort PORT MAP(OutPortSel, M1Output, OutPort_Output);

Mux1: MUX2x1 PORT MAP(Read1, FWUOUTPUT1 , M1_Sel, M1Output);
Mux2: MUX2x1 PORT MAP(Read2, FWUOUTPUT2 , M2_Sel, M2Output);
Mux3: MUX2x1 PORT MAP(PC, M1Output, M3_Sel, M3Output);
Mux4: MUX2x1 PORT MAP(M2Output, ZeroExtendedSignal, M4_Sel, M4Output);

ALU1: ALU PORT MAP(M3Output, M4Output, Zero_Four, ALUSel, '1', ALU_Zero, ALU_Carry, ALU_Neg, AluOut);
Six_Eight_OUT <= Six_Eight_IN;
Three_Eight_OUT <= Three_Eight;
Zero_Two_OUT <= Zero_Two_IN;
Swap_Output <= M2Output;
FlagsRegisterOut <= FROut;
and1: TwoInputAnd PORT MAP(FROut(0), AND_INPUT1, And1_Out);
and2: TwoInputAnd PORT MAP(FROut(1), AND_INPUT2, And2_Out);
and3: TwoInputAnd PORT MAP(FROut(2), AND_INPUT3, And3_Out);

or1: FourInputOr PORT MAP(And1_Out, And2_Out, And3_Out, Solo_Or_Input, Or_Output);
END exec;


--Bottom Register Outputs DONEZEL WASHINGTON
--OutPort DONEZEL WASHINGTON
--Ands and Ors