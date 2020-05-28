#----------test OneOperand Explanation
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
sim:/harvard_processor/CARRY_FLAG \
sim:/harvard_processor/NEGATIVE_FLAG \
sim:/harvard_processor/ZERO_FLAG 
force -freeze sim:/harvard_processor/RESET 1 0
force -freeze sim:/harvard_processor/INT_SIGNAL 0 0
force -freeze sim:/harvard_processor/CLK 1 0, 0 {50 ns} -r 100
mem load -i {F:/Tech/CUFE_CHS/Spring 2020/Architecture/Project/Harvard_Arch_Processor/TestCases/OneOperand/OneOperandData.mem} /harvard_processor/MEMORY_UNITT/Memory/ram
mem load -i {F:/Tech/CUFE_CHS/Spring 2020/Architecture/Project/Harvard_Arch_Processor/TestCases/OneOperand/OneOperandInstruction.mem} /harvard_processor/FETCHING_UNIT/INST_MEM/ram
run
force -freeze sim:/harvard_processor/RESET 0 0
run  # f setc
run  # d setc, f nop
run  # e setc, d nop, f clrc
run  # m setc, e nop, d clrc, f not:r1
run  # w setc, m nop, e clrc, d not:r1, f inc:r1  
run  # w nop, m clrc, e not:r1, d inc:r1, f in:r1  
run  # w clrc, m not:r1, e inc:r1, d in:r1, f in:r2  
force -freeze sim:/harvard_processor/IN_PORT 32'h00000005 0
run  # w not:r1, m inc:r1, e in:r1, d in:r2, f not:r2
force -freeze sim:/harvard_processor/IN_PORT 32'h00000010 0
run  # w inc:r1, m in:r1, e in:r2, d not:r2, f inc:r1
run  # w in:r1, m in:r2, e not:r2, d inc:r1, f dec:r2 
run  # w in:r2, m not:r2, e inc:r1, d dec:r2, f out:r1 
run  # w not:r2, m inc:r1, e dec:r2, d out:r1, f out:r2 
run  # w inc:r1, m dec:r2, e out:r1, d out:r2 
run  # w dec:r2, m out:r1, e out:r2 
run  # w out:r1, m out:r2
run  # w out:r2
run

#----------test OneOperand Ready
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
sim:/harvard_processor/CARRY_FLAG \
sim:/harvard_processor/NEGATIVE_FLAG \
sim:/harvard_processor/ZERO_FLAG 
force -freeze sim:/harvard_processor/RESET 1 0
force -freeze sim:/harvard_processor/INT_SIGNAL 0 0
force -freeze sim:/harvard_processor/CLK 1 0, 0 {50 ns} -r 100
mem load -i {F:/Tech/CUFE_CHS/Spring 2020/Architecture/Project/Harvard_Arch_Processor/TestCases/OneOperand/OneOperandData.mem} /harvard_processor/MEMORY_UNITT/Memory/ram
mem load -i {F:/Tech/CUFE_CHS/Spring 2020/Architecture/Project/Harvard_Arch_Processor/TestCases/OneOperand/OneOperandInstruction.mem} /harvard_processor/FETCHING_UNIT/INST_MEM/ram
run
force -freeze sim:/harvard_processor/RESET 0 0
run 
run  
run 
run  
run    
run   
run  
force -freeze sim:/harvard_processor/IN_PORT 32'h00000005 0
run  
force -freeze sim:/harvard_processor/IN_PORT 32'h00000010 0
run 
run  
run 
run 
run
run
run
run
run



#----------test TwoOperand Ready
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



#----------test Branch Prediction Ready
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
mem load -i {F:/Tech/CUFE_CHS/Spring 2020/Architecture/Project/Harvard_Arch_Processor/TestCases/BranchPrediction/BranchPredictionData.mem} /harvard_processor/MEMORY_UNITT/Memory/ram
mem load -i {F:/Tech/CUFE_CHS/Spring 2020/Architecture/Project/Harvard_Arch_Processor/TestCases/BranchPrediction/BranchPredictionInstruction.mem} /harvard_processor/FETCHING_UNIT/INST_MEM/ram
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




#----------test Memory Ready
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
mem load -i {F:/Tech/CUFE_CHS/Spring 2020/Architecture/Project/Harvard_Arch_Processor/TestCases/Memory/MemoryData.mem} /harvard_processor/MEMORY_UNITT/Memory/ram
mem load -i {F:/Tech/CUFE_CHS/Spring 2020/Architecture/Project/Harvard_Arch_Processor/TestCases/Memory/MemoryInstruction.mem} /harvard_processor/FETCHING_UNIT/INST_MEM/ram
run
force -freeze sim:/harvard_processor/RESET 0 0
run 
run  
force -freeze sim:/harvard_processor/IN_PORT 32'h0CDAFE19 0
run
force -freeze sim:/harvard_processor/IN_PORT 32'hFFFF 0 
run  
force -freeze sim:/harvard_processor/IN_PORT 32'hF320 0
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




-------TEST branch
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
mem load -i {F:/Tech/CUFE_CHS/Spring 2020/Architecture/Project/Harvard_Arch_Processor/TestCases/Branch/BranchData.mem} /harvard_processor/MEMORY_UNITT/Memory/ram
mem load -i {F:/Tech/CUFE_CHS/Spring 2020/Architecture/Project/Harvard_Arch_Processor/TestCases/Branch/BranchInstruction.mem} /harvard_processor/FETCHING_UNIT/INST_MEM/ram
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
force -freeze sim:/harvard_processor/IN_PORT 32'h00000200 0
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