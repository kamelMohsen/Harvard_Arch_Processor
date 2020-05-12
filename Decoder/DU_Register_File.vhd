LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY DECODER_RegisterFile IS 
PORT( WriteData1,WriteData2: IN std_logic_vector(31 DOWNTO 0);
      Rsrc1,Rsrc2,WriteAddress1 ,WriteAddress2: IN std_logic_vector(2 DOWNTO 0);
      WriteEn: IN std_logic_vector(1 DOWNTO 0); 
      CLOCK,RESET: IN std_logic;
      Read1,Read2: OUT std_logic_vector(31 DOWNTO 0));

END DECODER_RegisterFile;
--===================================================================================================================--

ARCHITECTURE DECODER_RegisterFile_ARCH OF DECODER_RegisterFile IS

COMPONENT DECODER_Register IS 
	PORT( WriteData1,WriteData2 : IN std_logic_vector(31 DOWNTO 0);
	      CLK,RST : IN std_logic; 
	      EnData1,EnData2: IN std_logic;
	      Q : OUT std_logic_vector(31 DOWNTO 0));
END COMPONENT;


COMPONENT DECODER_Decoder IS 
	PORT( INP : IN std_logic_vector(2 DOWNTO 0);
	      Enable: IN std_logic;
	      OUTP : OUT std_logic_vector(7 DOWNTO 0));
END COMPONENT;

COMPONENT DECODER_Tristate IS 
	PORT( INP : IN std_logic_vector(31 DOWNTO 0);
	      EN : IN std_logic; 
	      OUTP : OUT std_logic_vector(31 DOWNTO 0));
END COMPONENT;

COMPONENT DECODER_WriteEnable IS 
	PORT( INP : IN std_logic_vector(1 DOWNTO 0);
	      OutpDec2,OutpDec1 : OUT std_logic);
END COMPONENT;

SIGNAL R_Decoder_TriEnable1,W_Decoder_Reg1,R_Decoder_TriEnable2,W_Decoder_Reg2 : std_logic_vector(7 DOWNTO 0);
SIGNAL Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7 : std_logic_vector(31 DOWNTO 0);
SIGNAL DecoderEnable1,DecoderEnable2 :std_logic;

BEGIN

Enable: DECODER_WriteEnable PORT MAP (WriteEn,DecoderEnable2,DecoderEnable1);
ReadDecoder1: DECODER_Decoder PORT MAP (Rsrc1,'1',R_Decoder_TriEnable1);
ReadDecoder2: DECODER_Decoder PORT MAP (Rsrc2,'1',R_Decoder_TriEnable2);
WriteDecoder1: DECODER_Decoder PORT MAP (WriteAddress1,DecoderEnable1,W_Decoder_Reg1);
WriteDecoder2: DECODER_Decoder PORT MAP (WriteAddress2,DecoderEnable2,W_Decoder_Reg2);

R0: DECODER_Register PORT MAP(WriteData1,WriteData2,CLOCK,RESET,W_Decoder_Reg1(0),W_Decoder_Reg2(0),Q0);
R1: DECODER_Register PORT MAP(WriteData1,WriteData2,CLOCK,RESET,W_Decoder_Reg1(1),W_Decoder_Reg2(1),Q1);
R2: DECODER_Register PORT MAP(WriteData1,WriteData2,CLOCK,RESET,W_Decoder_Reg1(2),W_Decoder_Reg2(2),Q2);
R3: DECODER_Register PORT MAP(WriteData1,WriteData2,CLOCK,RESET,W_Decoder_Reg1(3),W_Decoder_Reg2(3),Q3);
R4: DECODER_Register PORT MAP(WriteData1,WriteData2,CLOCK,RESET,W_Decoder_Reg1(4),W_Decoder_Reg2(4),Q4);
R5: DECODER_Register PORT MAP(WriteData1,WriteData2,CLOCK,RESET,W_Decoder_Reg1(5),W_Decoder_Reg2(5),Q5);
R6: DECODER_Register PORT MAP(WriteData1,WriteData2,CLOCK,RESET,W_Decoder_Reg1(6),W_Decoder_Reg2(6),Q6);
R7: DECODER_Register PORT MAP(WriteData1,WriteData2,CLOCK,RESET,W_Decoder_Reg1(7),W_Decoder_Reg2(7),Q7);

TRIRead1_0: DECODER_Tristate PORT MAP(Q0,R_Decoder_TriEnable1(0),Read1);
TRIRead1_1: DECODER_Tristate PORT MAP(Q1,R_Decoder_TriEnable1(1),Read1);
TRIRead1_2: DECODER_Tristate PORT MAP(Q2,R_Decoder_TriEnable1(2),Read1);
TRIRead1_3: DECODER_Tristate PORT MAP(Q3,R_Decoder_TriEnable1(3),Read1);
TRIRead1_4: DECODER_Tristate PORT MAP(Q4,R_Decoder_TriEnable1(4),Read1);
TRIRead1_5: DECODER_Tristate PORT MAP(Q5,R_Decoder_TriEnable1(5),Read1);
TRIRead1_6: DECODER_Tristate PORT MAP(Q6,R_Decoder_TriEnable1(6),Read1);
TRIRead1_7: DECODER_Tristate PORT MAP(Q7,R_Decoder_TriEnable1(7),Read1);

TRIRead2_0: DECODER_Tristate PORT MAP(Q0,R_Decoder_TriEnable2(0),Read2);
TRIRead2_1: DECODER_Tristate PORT MAP(Q1,R_Decoder_TriEnable2(1),Read2);
TRIRead2_2: DECODER_Tristate PORT MAP(Q2,R_Decoder_TriEnable2(2),Read2);
TRIRead2_3: DECODER_Tristate PORT MAP(Q3,R_Decoder_TriEnable2(3),Read2);
TRIRead2_4: DECODER_Tristate PORT MAP(Q4,R_Decoder_TriEnable2(4),Read2);
TRIRead2_5: DECODER_Tristate PORT MAP(Q5,R_Decoder_TriEnable2(5),Read2);
TRIRead2_6: DECODER_Tristate PORT MAP(Q6,R_Decoder_TriEnable2(6),Read2);
TRIRead2_7: DECODER_Tristate PORT MAP(Q7,R_Decoder_TriEnable2(7),Read2);



END DECODER_RegisterFile_ARCH;


