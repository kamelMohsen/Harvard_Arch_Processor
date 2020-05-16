vsim -gui work.harvard_processor
add wave -position insertpoint  \
sim:/harvard_processor/RESET \
sim:/harvard_processor/OUT_PORT \
sim:/harvard_processor/IN_PORT \
sim:/harvard_processor/INT_SIGNAL \
sim:/harvard_processor/CLK
force -freeze sim:/harvard_processor/RESET 0 0
force -freeze sim:/harvard_processor/INT_SIGNAL 0 0
force -freeze sim:/harvard_processor/CLK 1 0, 0 {50 ps} -r 100
run
force -freeze sim:/harvard_processor/RESET 1 0