vsim -gui work.fetcher
mem load -filltype inc -filldata 0 -fillradix symbolic -skip 0 -update_properties /fetcher/INST_MEM/ram
add wave -position insertpoint  \
sim:/fetcher/INT_SIGNAL \
sim:/fetcher/JUMP_BIT \
sim:/fetcher/RETI_BIT \
sim:/fetcher/MEMORY_BIT \
sim:/fetcher/CLK \
sim:/fetcher/JUMP_LOCATION \
sim:/fetcher/MEMORY_INSTR \
sim:/fetcher/INSTRUCTION \
sim:/fetcher/PC \
sim:/fetcher/RESET
force -freeze sim:/fetcher/INT_SIGNAL 0 0
force -freeze sim:/fetcher/JUMP_BIT 0 0
force -freeze sim:/fetcher/RETI_BIT 0 0
force -freeze sim:/fetcher/MEMORY_BIT 0 0
force -freeze sim:/fetcher/CLK 1 0, 0 {50 ps} -r 100
force -freeze sim:/fetcher/JUMP_LOCATION 32'h00000000 0
force -freeze sim:/fetcher/MEMORY_INSTR 32'h00000000 0
force -freeze sim:/fetcher/RESET 1 0
run
force -freeze sim:/fetcher/RESET 0 0

