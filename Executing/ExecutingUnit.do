vsim -gui work.executingunit
add wave sim:/executingunit/*

#--------------------------------------------TestCase 1--------------------------------------

force -freeze sim:/executingunit/PC 31'b0 0
force -freeze sim:/executingunit/Read1 32'b10100010 0
force -freeze sim:/executingunit/Read2 32'b01011101 0
force -freeze sim:/executingunit/Three_Eight 1111111 0
force -freeze sim:/executingunit/SETC 00 0
force -freeze sim:/executingunit/OutPortSel 0 0
force -freeze sim:/executingunit/ALUSel 0100 0
force -freeze sim:/executingunit/M3_Sel 1 0
force -freeze sim:/executingunit/M4_Sel 0 0
force -freeze sim:/executingunit/AND_INPUT1 0 0
force -freeze sim:/executingunit/AND_INPUT2 0 0
force -freeze sim:/executingunit/AND_INPUT3 0 0
force -freeze sim:/executingunit/Solo_Or_Input 0 0
force -freeze sim:/executingunit/Zero_Two_IN 111 0
force -freeze sim:/executingunit/Six_Eight_IN 111 0
force -freeze sim:/executingunit/Zero_Four 10001 0
force -freeze sim:/executingunit/Sixteen_ThirtyOne 16'b01 0
force -freeze sim:/executingunit/M1_Sel 0 0
force -freeze sim:/executingunit/M2_Sel 0 0
force -freeze sim:/executingunit/FWUOUTPUT1 32'b0 0
force -freeze sim:/executingunit/FWUOUTPUT2 32'b0 0
force -freeze sim:/executingunit/FlagsRegisterReset 0 0
force -freeze sim:/executingunit/ZeroReset 0 0
force -freeze sim:/executingunit/NegativeReset 0 0
force -freeze sim:/executingunit/CarryReset 0 0
force -freeze sim:/executingunit/MemoryInput 0000 0
force -freeze sim:/executingunit/clk 1 0, 0 {50 ps} -r 100
run
run
run

#---------------------------------------------------------------------TestCase 2-------------------------------

force -freeze sim:/executingunit/ALUSel 0001 0
force -freeze sim:/executingunit/OutPortSel 1 0
run 
run 
run

#---------------------------------------------------------------------TestCase 3-------------------------------

force -freeze sim:/executingunit/ALUSel 0101 0
force -freeze sim:/executingunit/Read2 32'b10100010 0
run
run
run
