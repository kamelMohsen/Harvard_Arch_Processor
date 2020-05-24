LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY DECODER_ControlUnit IS 
PORT( Instruction: IN std_logic_vector(31 DOWNTO 0);
      CU_CLOCK: IN std_logic;
      ReadEnable,Jmp,OUTT,Branch,Reg_IMM,PC_Reg,Data_Stack,WriteEnableMemory,Call,RETI,Result_Mem,INN,RegPC_MemPC,Rdst_Rsrc1,Rdst_Rsrc2,INT: OUT std_logic;
      Set_Clr_Carry,WriteEnableWB : OUT std_logic_vector(1 DOWNTO 0);
      SPSel : OUT std_logic_vector(2 DOWNTO 0);
      ALU_Selc : OUT std_logic_vector(3 DOWNTO 0));
      
END DECODER_ControlUnit;
--===================================================================================================================--

ARCHITECTURE DECODER_ControlUnit_ARCH OF DECODER_ControlUnit IS

BEGIN
	PROCESS(CU_CLOCK,Instruction)
	BEGIN
--=========================================================================================--
		IF(Instruction(15 DOWNTO 12)="0000") THEN
			IF(Instruction(11 DOWNTO 9)="000") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '0';
				Rdst_Rsrc2 <= '0';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '0';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '0';
				PC_Reg <= '0';
				ALU_Selc <= "0000";
			--======Memory=====--
				Data_Stack <= '0';
				SPSel <=  "000";
				ReadEnable <= '0';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '0';
				WriteEnableWB <= "00";
				INN <= '0';
				RegPC_MemPC <= '0';
			ELSIF(Instruction(11 DOWNTO 9)="001") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '0';
				Rdst_Rsrc2 <= '0';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '0';
				Set_Clr_Carry <= "01";
				Reg_IMM <= '0';
				PC_Reg <= '0';
				ALU_Selc <= "0000";
			--======Memory=====--
				Data_Stack <= '0';
				SPSel <=  "000";
				ReadEnable <= '0';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '0';
				WriteEnableWB <= "00";
				INN <= '0';
				RegPC_MemPC <= '0';
			ELSIF(Instruction(11 DOWNTO 9)="010") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '0';
				Rdst_Rsrc2 <= '0';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '0';
				Set_Clr_Carry <= "10";
				Reg_IMM <= '0';
				PC_Reg <= '0';
				ALU_Selc <= "0000";
			--======Memory=====--
				Data_Stack <= '0';
				SPSel <=  "000";
				ReadEnable <= '0';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '0';
				WriteEnableWB <= "00";
				INN <= '0';
				RegPC_MemPC <= '0';
			ELSIF(Instruction(11 DOWNTO 9)="011") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '0';
				Rdst_Rsrc2 <= '0';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '0';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '0';
				PC_Reg <= '1';
				ALU_Selc <= "0001";
			--======Memory=====--
				Data_Stack <= '0';
				SPSel <=  "000";
				ReadEnable <= '0';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '0';
				WriteEnableWB <= "01";
				INN <= '0';
				RegPC_MemPC <= '0';

			ELSIF(Instruction(11 DOWNTO 9)="100") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '0';
				Rdst_Rsrc2 <= '0';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '0';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '0';
				PC_Reg <= '1';
				ALU_Selc <= "0010";
			--======Memory=====--
				Data_Stack <= '0';
				SPSel <=  "000";
				ReadEnable <= '0';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '0';
				WriteEnableWB <= "01";
				INN <= '0';
				RegPC_MemPC <= '0';
			ELSIF(Instruction(11 DOWNTO 9)="101") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '0';
				Rdst_Rsrc2 <= '0';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '1';
				Branch <= '0';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '0';
				PC_Reg <= '0';
				ALU_Selc <= "0000";
			--======Memory=====--
				Data_Stack <= '0';
				SPSel <=  "000";
				ReadEnable <= '0';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '0';
				WriteEnableWB <= "00";
				INN <= '0';
				RegPC_MemPC <= '0';
			ELSIF(Instruction(11 DOWNTO 9)="110") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '0';
				Rdst_Rsrc2 <= '0';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '0';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '0';
				PC_Reg <= '0';
				ALU_Selc <= "0011";
			--======Memory=====--
				Data_Stack <= '0';
				SPSel <=  "000";
				ReadEnable <= '0';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '0';
				WriteEnableWB <= "01";
				INN <= '1';
				RegPC_MemPC <= '0';
			END IF;
--=========================================================================================--

		ELSIF (Instruction(15 DOWNTO 12)="0001") THEN
			IF(Instruction(11 DOWNTO 9)= "000") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '1';
				Rdst_Rsrc2 <= '0';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '0';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '0';
				PC_Reg <= '1';
				ALU_Selc <= "0011";
			--======Memory=====--
				Data_Stack <= '0';
				SPSel <=  "000";
				ReadEnable <= '0';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '0';
				WriteEnableWB <= "10";
				INN <= '0';
				RegPC_MemPC <= '0';
			ELSIF(Instruction(11 DOWNTO 9)="001") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '1';
				Rdst_Rsrc2 <= '1';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '0';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '0';
				PC_Reg <= '1';
				ALU_Selc <= "0100";
			--======Memory=====--
				Data_Stack <= '0';
				SPSel <=  "000";
				ReadEnable <= '0';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '0';
				WriteEnableWB <= "01";
				INN <= '0';
				RegPC_MemPC <= '0';
			ELSIF(Instruction(11 DOWNTO 9)="010") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '1';
				Rdst_Rsrc2 <= '1';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '0';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '0';
				PC_Reg <= '1';
				ALU_Selc <= "0101";
			--======Memory=====--
				Data_Stack <= '0';
				SPSel <=  "000";
				ReadEnable <= '0';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '0';
				WriteEnableWB <= "01";
				INN <= '0';
				RegPC_MemPC <= '0';
			ELSIF(Instruction(11 DOWNTO 9)="011") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '1';
				Rdst_Rsrc2 <= '1';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '0';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '0';
				PC_Reg <= '1';
				ALU_Selc <= "0110";
			--======Memory=====--
				Data_Stack <= '0';
				SPSel <=  "000";
				ReadEnable <= '0';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '0';
				WriteEnableWB <= "01";
				INN <= '0';
				RegPC_MemPC <= '0';

			ELSIF(Instruction(11 DOWNTO 9)="100") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '1';
				Rdst_Rsrc2 <= '1';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '0';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '0';
				PC_Reg <= '1';
				ALU_Selc <= "0111";
			--======Memory=====--
				Data_Stack <= '0';
				SPSel <=  "000";
				ReadEnable <= '0';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '0';
				WriteEnableWB <= "01";
				INN <= '0';
				RegPC_MemPC <= '0';
			ELSIF(Instruction(11 DOWNTO 9)="101") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '0';
				Rdst_Rsrc2 <= '0';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '0';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '0';
				PC_Reg <= '1';
				ALU_Selc <= "1000";
			--======Memory=====--
				Data_Stack <= '0';
				SPSel <=  "000";
				ReadEnable <= '0';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '0';
				WriteEnableWB <= "01";
				INN <= '0';
				RegPC_MemPC <= '0';
			ELSIF(Instruction(11 DOWNTO 9)="110") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '0';
				Rdst_Rsrc2 <= '0';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '0';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '0';
				PC_Reg <= '1';
				ALU_Selc <= "1001";
			--======Memory=====--
				Data_Stack <= '0';
				SPSel <=  "000";
				ReadEnable <= '0';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '0';
				WriteEnableWB <= "01";
				INN <= '0';
				RegPC_MemPC <= '0';
			ELSIF(Instruction(11 DOWNTO 9)="111") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '0';
				Rdst_Rsrc2 <= '0';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '0';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '0';
				PC_Reg <= '1';
				ALU_Selc <= "1010";
			--======Memory=====--
				Data_Stack <= '0';
				SPSel <=  "000";
				ReadEnable <= '0';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '0';
				WriteEnableWB <= "01";
				INN <= '0';
				RegPC_MemPC <= '0';
			END IF;
--=========================================================================================--
		ELSIF (Instruction(15 DOWNTO 12)="0010") THEN
			IF(Instruction(11 DOWNTO 9)="000") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '0';
				Rdst_Rsrc2 <= '0';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '0';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '0';
				PC_Reg <= '1';
				ALU_Selc <= "0011";
			--======Memory=====--
				Data_Stack <= '1';
				SPSel <=  "001";
				ReadEnable <= '0';
				WriteEnableMemory <= '1';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '0';
				WriteEnableWB <= "00";
				INN <= '0';
				RegPC_MemPC <= '0';
			ELSIF(Instruction(11 DOWNTO 9)="001") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '0';
				Rdst_Rsrc2 <= '0';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '0';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '0';
				PC_Reg <= '0';
				ALU_Selc <= "0000";
			--======Memory=====--
				Data_Stack <= '1';
				SPSel <=  "010";
				ReadEnable <= '1';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '1';
				WriteEnableWB <= "01";
				INN <= '0';
				RegPC_MemPC <= '0';
			END IF;
--=========================================================================================--
		ELSIF (Instruction(15 DOWNTO 12)="0011") THEN
			IF(Instruction(11 DOWNTO 9)="000") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '0';
				Rdst_Rsrc2 <= '0';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '0';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '0';
				PC_Reg <= '0';
				ALU_Selc <= "0001";
			--======Memory=====--
				Data_Stack <= '1';
				SPSel <=  "011";
				ReadEnable <= '0';
				WriteEnableMemory <= '1';
				Call <= '1';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '0';
				WriteEnableWB <= "00";
				INN <= '0';
				RegPC_MemPC <= '0';
			ELSIF(Instruction(11 DOWNTO 9)="001") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '0';
				Rdst_Rsrc2 <= '0';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '0';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '0';
				PC_Reg <= '0';
				ALU_Selc <= "0000";
			--======Memory=====--
				Data_Stack <= '1';
				SPSel <=  "100";
				ReadEnable <= '0';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '1';
				WriteEnableWB <= "00";
				INN <= '0';
				RegPC_MemPC <= '1';
			ELSIF(Instruction(11 DOWNTO 9)="010") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '0';
				Rdst_Rsrc2 <= '0';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '0';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '0';
				PC_Reg <= '0';
				ALU_Selc <= "0000";
			--======Memory=====--
				Data_Stack <= '1';
				SPSel <=  "100";
				ReadEnable <= '0';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '1';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '1';
				WriteEnableWB <= "00";
				INN <= '0';
				RegPC_MemPC <= '1';
			END IF;
--=========================================================================================--
		ELSIF (Instruction(15 DOWNTO 12)="0100") THEN
			IF(Instruction(11 DOWNTO 9)="000") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '0';
				Rdst_Rsrc2 <= '0';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '1';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '0';
				PC_Reg <= '0';
				ALU_Selc <= "0000";
			--======Memory=====--
				Data_Stack <= '0';
				SPSel <=  "000";
				ReadEnable <= '0';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '0';
				WriteEnableWB <= "00";
				INN <= '0';
				RegPC_MemPC <= '0';
			ELSIF(Instruction(11 DOWNTO 9)="001") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '0';
				Rdst_Rsrc2 <= '0';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '1';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '0';
				PC_Reg <= '0';
				ALU_Selc <= "0000";
			--======Memory=====--
				Data_Stack <= '0';
				SPSel <=  "000";
				ReadEnable <= '0';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '0';
				WriteEnableWB <= "00";
				INN <= '0';
				RegPC_MemPC <= '0';
			ELSIF(Instruction(11 DOWNTO 9)="010") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '0';
				Rdst_Rsrc2 <= '0';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '1';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '0';
				PC_Reg <= '0';
				ALU_Selc <= "0000";
			--======Memory=====--
				Data_Stack <= '0';
				SPSel <=  "000";
				ReadEnable <= '0';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '0';
				WriteEnableWB <= "00";
				INN <= '0';
				RegPC_MemPC <= '0';
			ELSIF(Instruction(11 DOWNTO 9)="011") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '0';
				Rdst_Rsrc2 <= '0';
			--=======Execute=====--
				Jmp <= '1';
				OUTT <= '0';
				Branch <= '0';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '0';
				PC_Reg <= '0';
				ALU_Selc <= "0000";
			--======Memory=====--
				Data_Stack <= '0';
				SPSel <=  "000";
				ReadEnable <= '0';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '0';
				WriteEnableWB <= "00";
				INN <= '0';
				RegPC_MemPC <= '0';
			END IF;
--=========================================================================================--
		ELSIF (Instruction(15 DOWNTO 12)="1000") THEN
			IF(Instruction(11 DOWNTO 9)="000") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '1';
				Rdst_Rsrc2 <= '0';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '0';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '1';
				PC_Reg <= '1';
				ALU_Selc <= "0100";
			--======Memory=====--
				Data_Stack <= '0';
				SPSel <=  "000";
				ReadEnable <= '0';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '0';
				WriteEnableWB <= "01";
				INN <= '0';
				RegPC_MemPC <= '0';
			ELSIF(Instruction(11 DOWNTO 9)="001") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '0';
				Rdst_Rsrc2 <= '0';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '0';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '1';
				PC_Reg <= '1';
				ALU_Selc <= "1011";
			--======Memory=====--
				Data_Stack <= '0';
				SPSel <=  "000";
				ReadEnable <= '0';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '0';
				WriteEnableWB <= "01";
				INN <= '0';
				RegPC_MemPC <= '0';
			ELSIF(Instruction(11 DOWNTO 9)="010") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '0';
				Rdst_Rsrc2 <= '0';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '0';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '0';
				PC_Reg <= '0';
				ALU_Selc <= "0000";
			--======Memory=====--
				Data_Stack <= '0';
				SPSel <=  "000";
				ReadEnable <= '1';
				WriteEnableMemory <= '0';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '1';
				WriteEnableWB <= "01";
				INN <= '0';
				RegPC_MemPC <= '0';
			ELSIF(Instruction(11 DOWNTO 9)="011") THEN
			--=====Decoder=======--
				Rdst_Rsrc1 <= '0';
				Rdst_Rsrc2 <= '0';
			--=======Execute=====--
				Jmp <= '0';
				OUTT <= '0';
				Branch <= '0';
				Set_Clr_Carry <= "00";
				Reg_IMM <= '0';
				PC_Reg <= '1';
				ALU_Selc <= "0011";
			--======Memory=====--
				Data_Stack <= '0';
				SPSel <=  "000";
				ReadEnable <= '0';
				WriteEnableMemory <= '1';
				Call <= '0';
				RETI <= '0';
				INT <= '0';
			--=====WriteBack====--
				Result_Mem <= '1';
				WriteEnableWB <= "00";
				INN <= '0';
				RegPC_MemPC <= '0';
			END IF;

		END IF;
	END PROCESS;
End DECODER_ControlUnit_ARCH;