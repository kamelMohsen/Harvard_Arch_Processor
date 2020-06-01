vsim -gui work.harvard_processor
add wave -position insertpoint  \
sim:/harvard_processor/INT_SIGNAL \
sim:/harvard_processor/RESET \
sim:/harvard_processor/CLK \
sim:/harvard_processor/IN_PORT \
sim:/harvard_processor/OUT_PORT \
sim:/harvard_processor/REG_0_TEST \
sim:/harvard_processor/REG_1_TEST \
sim:/harvard_processor/REG_2_TEST \
sim:/harvard_processor/REG_3_TEST \
sim:/harvard_processor/REG_4_TEST \
sim:/harvard_processor/REG_5_TEST \
sim:/harvard_processor/REG_6_TEST \
sim:/harvard_processor/REG_7_TEST \
sim:/harvard_processor/CARRY_FLAG \
sim:/harvard_processor/NEGATIVE_FLAG \
sim:/harvard_processor/ZERO_FLAG 
force -freeze sim:/harvard_processor/RESET 1 0
force -freeze sim:/harvard_processor/INT_SIGNAL 0 0
force -freeze sim:/harvard_processor/CLK 1 0, 0 {50 ns} -r 100
mem load -i {F:/Tech/CUFE_CHS/Spring 2020/Architecture/Project/Harvard_Arch_Processor/TestCases/TwoOperand/TwoOperandData.mem} /harvard_processor/MEMORY_UNITT/Memory/ram
mem load -i {F:/Tech/CUFE_CHS/Spring 2020/Architecture/Project/Harvard_Arch_Processor/TestCases/TwoOperand/TwoOperandInstruction.mem} /harvard_processor/FETCHING_UNIT/INST_MEM/ram
run
force -freeze sim:/harvard_processor/RESET 0 0
run 
run  
force -freeze sim:/harvard_processor/IN_PORT 32'h00000005 0
run
force -freeze sim:/harvard_processor/IN_PORT 32'h00000019 0 
run  
force -freeze sim:/harvard_processor/IN_PORT 32'h0000FFFD 0
run    
force -freeze sim:/harvard_processor/IN_PORT 32'h0000F320 0
run   
run  
run  
run 
run  
run 
run 
run
run
run
run
run