vlog tb_mem.v
vsim tb +test_name=fd_wr_fd_rd
do wave.do
#add wave -position insertpoint sim:/tb/*
run -all
