vsim -gui work.harvard_processor
add wave -position insertpoint  \
sim:/harvard_processor/RESET \
sim:/harvard_processor/OUT_PORT \
sim:/harvard_processor/MEM_WB_WB_OUT_WIRE \
sim:/harvard_processor/MEM_WB_WB_IN_WIRE \
sim:/harvard_processor/MEM_WB_RESULT_OUT_WIRE \
sim:/harvard_processor/MEM_WB_RESULT_IN_WIRE \
sim:/harvard_processor/MEM_WB_MEMORY_RESULT_OUT_WIRE \
sim:/harvard_processor/MEM_WB_MEMORY_RESULT_IN_WIRE \
sim:/harvard_processor/MEM_WB_INST_0_8_OUT_WIRE \
sim:/harvard_processor/MEM_WB_INST_0_8_IN_WIRE \
sim:/harvard_processor/MEM_WB_DESTINATION_OUT_WIRE \
sim:/harvard_processor/MEM_WB_DESTINATION_IN_WIRE \
sim:/harvard_processor/JUMP_BIT_OUT_WIRE \
sim:/harvard_processor/IN_PORT \
sim:/harvard_processor/INT_SIGNAL \
sim:/harvard_processor/IF_ID_PC_OUT_WIRE \
sim:/harvard_processor/IF_ID_PC_IN_WIRE \
sim:/harvard_processor/IF_ID_INST_OUT_WIRE \
sim:/harvard_processor/IF_ID_INST_IN_WIRE \
sim:/harvard_processor/ID_EX_WB_OUT_WIRE \
sim:/harvard_processor/ID_EX_Read2_OUT_WIRE \
sim:/harvard_processor/ID_EX_Read2_IN_WIRE \
sim:/harvard_processor/ID_EX_Read1_OUT_WIRE \
sim:/harvard_processor/ID_EX_Read1_IN_WIRE \
sim:/harvard_processor/ID_EX_PC_OUT_WIRE \
sim:/harvard_processor/ID_EX_PC_IN_WIRE \
sim:/harvard_processor/ID_EX_OP2_ADDRESS_OUT_WIRE \
sim:/harvard_processor/ID_EX_OP2_ADDRESS_IN_WIRE \
sim:/harvard_processor/ID_EX_OP1_ADDRESS_OUT_WIRE \
sim:/harvard_processor/ID_EX_OP1_ADDRESS_IN_WIRE \
sim:/harvard_processor/ID_EX_MEM_OUT_WIRE \
sim:/harvard_processor/ID_EX_INST_OUT_WIRE \
sim:/harvard_processor/ID_EX_INST_IN_WIRE \
sim:/harvard_processor/ID_EX_EX_OUT_WIRE \
sim:/harvard_processor/EX_MEM_WB_OUT_WIRE \
sim:/harvard_processor/EX_MEM_WB_IN_WIRE \
sim:/harvard_processor/EX_MEM_RESULT_OUT_WIRE \
sim:/harvard_processor/EX_MEM_RESULT_IN_WIRE \
sim:/harvard_processor/EX_MEM_MEM_OUT_WIRE \
sim:/harvard_processor/EX_MEM_MEM_IN_WIRE \
sim:/harvard_processor/EX_MEM_INST_0_8_OUT_WIRE \
sim:/harvard_processor/EX_MEM_INST_0_8_IN_WIRE \
sim:/harvard_processor/EX_MEM_FLAGS_OUT_WIRE \
sim:/harvard_processor/EX_MEM_FLAGS_IN_WIRE \
sim:/harvard_processor/EX_MEM_EFFECTIVE_ADDRESS_OUT_WIRE \
sim:/harvard_processor/EX_MEM_EFFECTIVE_ADDRESS_IN_WIRE \
sim:/harvard_processor/EX_MEM_DESTINATION_OUT_WIRE \
sim:/harvard_processor/EX_MEM_DESTINATION_IN_WIRE \
sim:/harvard_processor/EXTENDED_IMM \
sim:/harvard_processor/CS_WB_WriteEnable \
sim:/harvard_processor/CS_WB_Result_Mem \
sim:/harvard_processor/CS_WB_RegPC_MemPC \
sim:/harvard_processor/CS_WB_IN \
sim:/harvard_processor/CS_MEM_WriteEnableMemory \
sim:/harvard_processor/CS_MEM_SPSel \
sim:/harvard_processor/CS_MEM_RETI \
sim:/harvard_processor/CS_MEM_INT \
sim:/harvard_processor/CS_MEM_Data_Stack \
sim:/harvard_processor/CS_MEM_Call \
sim:/harvard_processor/CS_EX_Set_Clr_Carry \
sim:/harvard_processor/CS_EX_Reg_IMM \
sim:/harvard_processor/CS_EX_PC_Reg \
sim:/harvard_processor/CS_EX_OUT \
sim:/harvard_processor/CS_EX_Jmp \
sim:/harvard_processor/CS_EX_Branch \
sim:/harvard_processor/CS_EX_ALU_SEL \
sim:/harvard_processor/CLK \
sim:/harvard_processor/CAT_ID_EX_WB \
sim:/harvard_processor/CAT_ID_EX_MEM \
sim:/harvard_processor/CAT_ID_EX_EX
mem load -i {C:/Users/Kamel/Desktop/Spring 2020/Architecture/Project/Harvard_Arch_Processor/TestCases/OneOperand.mem} /harvard_processor/MEMORY_UNITT/Memory/ram
mem load -i {C:/Users/Kamel/Desktop/Spring 2020/Architecture/Project/Harvard_Arch_Processor/TestCases/OneOperand.mem} /harvard_processor/FETCHING_UNIT/INST_MEM/ram
force -freeze sim:/harvard_processor/RESET 1 0
force -freeze sim:/harvard_processor/INT_SIGNAL 0 0
force -freeze sim:/harvard_processor/CLK 1 0, 0 {50 ps} -r 100
run
force -freeze sim:/harvard_processor/RESET 0 0
