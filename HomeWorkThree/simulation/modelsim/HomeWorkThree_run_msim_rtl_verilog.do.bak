transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Administrator/Desktop/HomeWorkThree/src {C:/Users/Administrator/Desktop/HomeWorkThree/src/HomeWorkThree.v}

vlog -vlog01compat -work work +incdir+C:/Users/Administrator/Desktop/HomeWorkThree/simulation/modelsim {C:/Users/Administrator/Desktop/HomeWorkThree/simulation/modelsim/HomeWorkThree.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  HomeWorkThree_test

add wave *
view structure
view signals
run -all
