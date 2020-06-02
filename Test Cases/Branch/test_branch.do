vsim -gui work.harvard_processor
add wave -position insertpoint  \
sim:/harvard_processor/INT_SIGNAL \
sim:/harvard_processor/IF_ID_PC_IN_WIRE \
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
sim:/harvard_processor/ZERO_FLAG \
sim:/harvard_processor/StackAddress_WIRE \
sim:/harvard_processor/EX_MEM_MEM_OUT_WIRE
force -freeze sim:/harvard_processor/RESET 1 0
force -freeze sim:/harvard_processor/INT_SIGNAL 0 0
force -freeze sim:/harvard_processor/CLK 1 0, 0 {50 ns} -r 100
mem load -i {F:/Tech/CUFE_CHS/Spring 2020/Architecture/Project/Harvard_Arch_Processor/Test Cases/Branch/BranchData.mem} /harvard_processor/MEMORY_UNITT/Memory/ram
mem load -i {F:/Tech/CUFE_CHS/Spring 2020/Architecture/Project/Harvard_Arch_Processor/Test Cases/Branch/BranchInstruction.mem} /harvard_processor/FETCHING_UNIT/INST_MEM/ram
run
force -freeze sim:/harvard_processor/RESET 0 0
run 
run  
force -freeze sim:/harvard_processor/IN_PORT 32'h000000030 0
run
force -freeze sim:/harvard_processor/IN_PORT 32'h00000050 0 
run  
force -freeze sim:/harvard_processor/IN_PORT 32'h00000100 0
run    
force -freeze sim:/harvard_processor/IN_PORT 32'h00000300 0
run   
force -freeze sim:/harvard_processor/IN_PORT 32'hFFFFFFFF 0
run  
run  
run 
force -freeze sim:/harvard_processor/INT_SIGNAL 1 0
run  
force -freeze sim:/harvard_processor/INT_SIGNAL 0 0
run 
run 
run
run
run
run
run
force -freeze sim:/harvard_processor/IN_PORT 32'h000000200 0
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
force -freeze sim:/harvard_processor/INT_SIGNAL 1 0
run
force -freeze sim:/harvard_processor/INT_SIGNAL 0 0
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