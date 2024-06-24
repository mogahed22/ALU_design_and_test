vlib work
vlog ALU.v alu_gold.vh ALU_test.svh  +cover
vsim -voptargs=+acc work.test -cover
add wave *
coverage save test.ucdb -onexit
run -all