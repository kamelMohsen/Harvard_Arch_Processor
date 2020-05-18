--test for register file
vsim -gui work.harvard_processor
add wave -position insertpoint  \
sim:/harvard_processor/INT_SIGNAL \
sim:/harvard_processor/RESET \
sim:/harvard_processor/CLK \
sim:/harvard_processor/IN_PORT \
sim:/harvard_processor/REG_0_TEST \
sim:/harvard_processor/WB_WRITE_ENABLE_OUT_WIRE \
sim:/harvard_processor/WB_IN_ENABLE_OUT_WIRE \
sim:/harvard_processor/WB_WRITE_BACK_DATA1_OUT_WIRE \
sim:/harvard_processor/WRITE_DATA1_TEST \
sim:/harvard_processor/MEM_WB_RESULT_IN_WIRE \
sim:/harvard_processor/ID_EX_Read1_OUT_WIRE \
sim:/harvard_processor/EX_MEM_RESULT_IN_WIRE \
sim:/harvard_processor/EX_MEM_RESULT_OUT_WIRE \
sim:/harvard_processor/ID_EX_Read1_IN_WIRE 
force -freeze sim:/harvard_processor/IN_PORT 32'h00000001 0
force -freeze sim:/harvard_processor/RESET 1 0
force -freeze sim:/harvard_processor/INT_SIGNAL 0 0
force -freeze sim:/harvard_processor/CLK 1 0, 0 {50 ps} -r 100
mem load -i {C:/Users/Kamel/Desktop/Spring 2020/Architecture/Project/Harvard_Arch_Processor/TestCases/TestData.mem} /harvard_processor/MEMORY_UNITT/Memory/ram
mem load -i {C:/Users/Kamel/Desktop/Spring 2020/Architecture/Project/Harvard_Arch_Processor/TestCases/TestInstruction.mem} /harvard_processor/FETCHING_UNIT/INST_MEM/ram
run
force -freeze sim:/harvard_processor/RESET 0 0
run 
run 
run 
run
run


----------test tany reg file
vsim -gui work.harvard_processor
add wave -position insertpoint  \
sim:/harvard_processor/INT_SIGNAL \
sim:/harvard_processor/RESET \
sim:/harvard_processor/CLK \
sim:/harvard_processor/IN_PORT \
sim:/harvard_processor/REG_0_TEST \
sim:/harvard_processor/WB_WRITE_ENABLE_OUT_WIRE \
sim:/harvard_processor/WB_IN_ENABLE_OUT_WIRE \
sim:/harvard_processor/WB_WRITE_BACK_DATA1_OUT_WIRE \
sim:/harvard_processor/WRITE_DATA1_TEST \
sim:/harvard_processor/MEM_WB_RESULT_IN_WIRE \
sim:/harvard_processor/ID_EX_Read1_OUT_WIRE \
sim:/harvard_processor/EX_MEM_RESULT_IN_WIRE \
sim:/harvard_processor/EX_MEM_RESULT_OUT_WIRE \
sim:/harvard_processor/ID_EX_Read1_IN_WIRE \
sim:/harvard_processor/REG_0_TEST \
sim:/harvard_processor/REG_1_TEST \
sim:/harvard_processor/REG_2_TEST \
sim:/harvard_processor/REG_3_TEST \
sim:/harvard_processor/REG_4_TEST \
sim:/harvard_processor/REG_5_TEST \
sim:/harvard_processor/REG_6_TEST \
sim:/harvard_processor/REG_7_TEST 
force -freeze sim:/harvard_processor/IN_PORT 32'h00000003 0
force -freeze sim:/harvard_processor/RESET 1 0
force -freeze sim:/harvard_processor/INT_SIGNAL 0 0
force -freeze sim:/harvard_processor/CLK 1 0, 0 {50 ps} -r 100
mem load -i {C:/Users/Kamel/Desktop/Spring 2020/Architecture/Project/Harvard_Arch_Processor/TestCases/TestData.mem} /harvard_processor/MEMORY_UNITT/Memory/ram
mem load -i {C:/Users/Kamel/Desktop/Spring 2020/Architecture/Project/Harvard_Arch_Processor/TestCases/TestInstruction.mem} /harvard_processor/FETCHING_UNIT/INST_MEM/ram
run
force -freeze sim:/harvard_processor/RESET 0 0
run 
run 
run 
run
run





--test for setc/clrc file
vsim -gui work.harvard_processor
add wave -position insertpoint  \
sim:/harvard_processor/INT_SIGNAL \
sim:/harvard_processor/RESET \
sim:/harvard_processor/CLK \
sim:/harvard_processor/IN_PORT \
sim:/harvard_processor/CARRY_FLAG \

force -freeze sim:/harvard_processor/IN_PORT 32'h00000001 0
force -freeze sim:/harvard_processor/RESET 1 0
force -freeze sim:/harvard_processor/INT_SIGNAL 0 0
force -freeze sim:/harvard_processor/CLK 1 0, 0 {50 ps} -r 100
mem load -i {C:/Users/Kamel/Desktop/Spring 2020/Architecture/Project/Harvard_Arch_Processor/TestCases/TestData.mem} /harvard_processor/MEMORY_UNITT/Memory/ram
mem load -i {C:/Users/Kamel/Desktop/Spring 2020/Architecture/Project/Harvard_Arch_Processor/TestCases/TestInstruction.mem} /harvard_processor/FETCHING_UNIT/INST_MEM/ram
run
force -freeze sim:/harvard_processor/RESET 0 0
run 
run 
run 
run
run



----------test alu file
vsim -gui work.harvard_processor
add wave -position insertpoint  \
sim:/harvard_processor/INT_SIGNAL \
sim:/harvard_processor/RESET \
sim:/harvard_processor/CLK \
sim:/harvard_processor/IN_PORT \
sim:/harvard_processor/ID_EX_Read1_IN_WIRE \
sim:/harvard_processor/ID_EX_Read2_IN_WIRE \
sim:/harvard_processor/ID_EX_Read1_OUT_WIRE \
sim:/harvard_processor/ID_EX_Read2_OUT_WIRE \
sim:/harvard_processor/EX_MEM_RESULT_IN_WIRE \
sim:/harvard_processor/EX_MEM_RESULT_OUT_WIRE \
sim:/harvard_processor/MEM_WB_RESULT_IN_WIRE \
sim:/harvard_processor/MEM_WB_RESULT_OUT_WIRE \
sim:/harvard_processor/WB_WRITE_BACK_DATA1_OUT_WIRE \
sim:/harvard_processor/WB_WRITE_ENABLE_OUT_WIRE \
sim:/harvard_processor/REG_0_TEST \
sim:/harvard_processor/REG_1_TEST \
sim:/harvard_processor/REG_2_TEST \
sim:/harvard_processor/REG_3_TEST \
sim:/harvard_processor/REG_4_TEST \
sim:/harvard_processor/REG_5_TEST \
sim:/harvard_processor/REG_6_TEST \
sim:/harvard_processor/REG_7_TEST \
sim:/harvard_processor/FORWARD_OP1_TEST \
sim:/harvard_processor/FORWARD_OP2_TEST \
sim:/harvard_processor/ID_EX_EX_OUT_WIRE \
sim:/harvard_processor/CS_EX_ALU_SEL
force -freeze sim:/harvard_processor/IN_PORT 32'h00000003 0
force -freeze sim:/harvard_processor/RESET 1 0
force -freeze sim:/harvard_processor/INT_SIGNAL 0 0
force -freeze sim:/harvard_processor/CLK 1 0, 0 {50 ps} -r 100
mem load -i {C:/Users/Kamel/Desktop/Spring 2020/Architecture/Project/Harvard_Arch_Processor/TestCases/TestData.mem} /harvard_processor/MEMORY_UNITT/Memory/ram
mem load -i {C:/Users/Kamel/Desktop/Spring 2020/Architecture/Project/Harvard_Arch_Processor/TestCases/TestInstruction.mem} /harvard_processor/FETCHING_UNIT/INST_MEM/ram
run
force -freeze sim:/harvard_processor/RESET 0 0
run 
run 
run 
run
run
force -freeze sim:/harvard_processor/IN_PORT 32'h00000005 0
run
run
run
run
