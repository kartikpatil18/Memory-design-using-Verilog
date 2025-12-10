vlog sample.v
vsim tb +test_name=consecutive_wr_rd
do wave.do
#add wave -position insertpoint sim:/tb/*
run -all
