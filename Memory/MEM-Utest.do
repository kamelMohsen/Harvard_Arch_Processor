vsim -gui work.memory_unit(mem_u)
add wave sim:/memory_unit/*
mem load -i {D:/eman/6th sem/Arch/Memory/DATA.mem} /memory_unit/Memory/ram

radix signal sim:/memory_unit/EA decimal
radix signal sim:/memory_unit/Result hexadecimal
radix signal sim:/memory_unit/Flags hexadecimal
radix signal sim:/memory_unit/DataRead hexadecimal
radix signal sim:/memory_unit/Result_Out hexadecimal
radix signal sim:/memory_unit/Data hexadecimal
radix signal sim:/memory_unit/Address decimal
radix signal sim:/memory_unit/StackAddress decimal

force -freeze sim:/memory_unit/Clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/memory_unit/WriteEnable 0 0
force -freeze sim:/memory_unit/StackOrData 0 0
force -freeze sim:/memory_unit/ResultOrFlags 0 0
force -freeze sim:/memory_unit/SPSEL 000 0
force -freeze sim:/memory_unit/EA 32'h4 0
force -freeze sim:/memory_unit/Result 32'h14 0
force -freeze sim:/memory_unit/WB_ResultOrMem_IN 1 0
force -freeze sim:/memory_unit/WB_WriteEnable_IN 01 0
force -freeze sim:/memory_unit/WB_INPort_IN 1 0
force -freeze sim:/memory_unit/WB_RegPCOrMemPC_IN 1 0
force -freeze sim:/memory_unit/RdstOrRsrc_IN 32'h2 0
force -freeze sim:/memory_unit/Inst6to8_IN 111 0
force -freeze sim:/memory_unit/Inst0to2_IN 100 0
run

force -freeze sim:/memory_unit/WriteEnable 1 0
force -freeze sim:/memory_unit/StackOrData 0 0
force -freeze sim:/memory_unit/ResultOrFlags 0 0
force -freeze sim:/memory_unit/SPSEL 000 0
force -freeze sim:/memory_unit/EA 32'h14 0
force -freeze sim:/memory_unit/Result 32'h14 0
force -freeze sim:/memory_unit/WB_ResultOrMem_IN 1 0
force -freeze sim:/memory_unit/WB_WriteEnable_IN 11 0
force -freeze sim:/memory_unit/WB_INPort_IN 1 0
force -freeze sim:/memory_unit/WB_RegPCOrMemPC_IN 1 0
force -freeze sim:/memory_unit/RdstOrRsrc_IN 32'h2 0
force -freeze sim:/memory_unit/Inst6to8_IN 111 0
force -freeze sim:/memory_unit/Inst0to2_IN 100 0
run

force -freeze sim:/memory_unit/WriteEnable 0 0
force -freeze sim:/memory_unit/StackOrData 0 0
force -freeze sim:/memory_unit/ResultOrFlags 0 0
force -freeze sim:/memory_unit/SPSEL 000 0
force -freeze sim:/memory_unit/EA 32'h14 0
force -freeze sim:/memory_unit/Result 32'h14 0
force -freeze sim:/memory_unit/WB_ResultOrMem_IN 0 0
force -freeze sim:/memory_unit/WB_WriteEnable_IN 00 0
force -freeze sim:/memory_unit/WB_INPort_IN 0 0
force -freeze sim:/memory_unit/WB_RegPCOrMemPC_IN 0 0
force -freeze sim:/memory_unit/RdstOrRsrc_IN 32'h5 0
force -freeze sim:/memory_unit/Inst6to8_IN 110 0
force -freeze sim:/memory_unit/Inst0to2_IN 101 0
run

force -freeze sim:/memory_unit/WriteEnable 1 0
force -freeze sim:/memory_unit/StackOrData 1 0
force -freeze sim:/memory_unit/ResultOrFlags 1 0
force -freeze sim:/memory_unit/SPSEL 001 0
force -freeze sim:/memory_unit/EA 32'h14 0
force -freeze sim:/memory_unit/Result 32'h14 0
force -freeze sim:/memory_unit/Flags 32'h101 0
force -freeze sim:/memory_unit/WB_ResultOrMem_IN 1 0
force -freeze sim:/memory_unit/WB_WriteEnable_IN 01 0
force -freeze sim:/memory_unit/WB_INPort_IN 1 0
force -freeze sim:/memory_unit/WB_RegPCOrMemPC_IN 1 0
force -freeze sim:/memory_unit/RdstOrRsrc_IN 32'h2 0
force -freeze sim:/memory_unit/Inst6to8_IN 111 0
force -freeze sim:/memory_unit/Inst0to2_IN 100 0
run

force -freeze sim:/memory_unit/WriteEnable 1 0
force -freeze sim:/memory_unit/StackOrData 0 0
force -freeze sim:/memory_unit/ResultOrFlags 0 0
force -freeze sim:/memory_unit/SPSEL 000 0
force -freeze sim:/memory_unit/EA 32'h26 0
force -freeze sim:/memory_unit/Result 32'h26 0
force -freeze sim:/memory_unit/WB_ResultOrMem_IN 1 0
force -freeze sim:/memory_unit/WB_WriteEnable_IN 11 0
force -freeze sim:/memory_unit/WB_INPort_IN 1 0
force -freeze sim:/memory_unit/WB_RegPCOrMemPC_IN 1 0
force -freeze sim:/memory_unit/RdstOrRsrc_IN 32'h2 0
force -freeze sim:/memory_unit/Inst6to8_IN 111 0
force -freeze sim:/memory_unit/Inst0to2_IN 100 0
run

force -freeze sim:/memory_unit/WriteEnable 0 0
force -freeze sim:/memory_unit/StackOrData 1 0
force -freeze sim:/memory_unit/ResultOrFlags  0
force -freeze sim:/memory_unit/SPSEL 010 0
force -freeze sim:/memory_unit/EA 32'h14 0
force -freeze sim:/memory_unit/Result 32'h14 0
force -freeze sim:/memory_unit/Flags 32'h101 0
force -freeze sim:/memory_unit/WB_ResultOrMem_IN 1 0
force -freeze sim:/memory_unit/WB_WriteEnable_IN 10 0
force -freeze sim:/memory_unit/WB_INPort_IN 1 0
force -freeze sim:/memory_unit/WB_RegPCOrMemPC_IN 1 0
force -freeze sim:/memory_unit/RdstOrRsrc_IN 32'h2 0
force -freeze sim:/memory_unit/Inst6to8_IN 111 0
force -freeze sim:/memory_unit/Inst0to2_IN 100 0
run

force -freeze sim:/memory_unit/WriteEnable 0 0
force -freeze sim:/memory_unit/StackOrData 0 0
force -freeze sim:/memory_unit/ResultOrFlags  0
force -freeze sim:/memory_unit/SPSEL 000 0
force -freeze sim:/memory_unit/EA 32'h14 0
run