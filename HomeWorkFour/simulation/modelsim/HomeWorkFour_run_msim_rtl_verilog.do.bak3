transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Administrator/Desktop/HomeWorkFour/src {C:/Users/Administrator/Desktop/HomeWorkFour/src/HomeWorkFour.v}

vlog -vlog01compat -work work +incdir+C:/Users/Administrator/Desktop/HomeWorkFour/simulation/modelsim {C:/Users/Administrator/Desktop/HomeWorkFour/simulation/modelsim/HomeWorkFour.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  HomeWorkFour_test

add wave *
view structure
view signals
run -all
