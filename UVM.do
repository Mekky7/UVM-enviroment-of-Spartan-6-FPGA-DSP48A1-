vlib work
vlog -f src_files.list -sv +cover
vsim -voptargs=+acc work.top -cover -classdebug -uvmcontrol=all 
run 0
add wave -position insertpoint sim:/top/dspif/*
coverage save -instance dut DSP_DB.ucdb -onexit -du dsp
run -all



 