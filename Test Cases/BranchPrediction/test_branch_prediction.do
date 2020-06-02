vsim -gui work.harvard_processor
add wave -position insertpoint  \
sim:/harvard_processor/INT_SIGNAL \
sim:/harvard_processor/RESET \
sim:/harvard_processor/CLK \
sim:/harvard_processor/IN_PORT \
sim:/harvard_processor/IF_ID_PC_IN_WIRE \
sim:/harvard_processor/JUMP_OR_CALL \
sim:/harvard_processor/JUMP_CALL_BIT \
sim:/harvard_processor/FWU_OUTPUT1_TEST \
sim:/harvard_processor/JUMP_LOCTION_EX_OUT \
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
mem load -i {F:/Tech/CUFE_CHS/Spring 2020/Architecture/Project/Harvard_Arch_Processor/Test Cases/BranchPrediction/BranchPredictionData.mem} /harvard_processor/MEMORY_UNITT/Memory/ram
mem load -i {F:/Tech/CUFE_CHS/Spring 2020/Architecture/Project/Harvard_Arch_Processor/Test Cases/BranchPrediction/BranchPredictionInstruction.mem} /harvard_processor/FETCHING_UNIT/INST_MEM/ram
run
force -freeze sim:/harvard_processor/RESET 0 0
force -freeze sim:/harvard_processor/IN_PORT 32'h00000000 0
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
run
run
run
run
run