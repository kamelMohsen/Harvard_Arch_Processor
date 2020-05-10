vsim -gui work.alu
add wave sim:/alu/*
force -freeze sim:/alu/Rsrc1 8'hffffffff 0
force -freeze sim:/alu/Rsrc2 8'h01 0
force -freeze sim:/alu/ALU_Sel 0100 0
run
run