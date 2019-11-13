transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {HomeWorkFive_7_1200mv_100c_slow.vo}

vlog -vlog01compat -work work +incdir+C:/Users/Administrator/Desktop/HomeWorkFive/simulation/modelsim {C:/Users/Administrator/Desktop/HomeWorkFive/simulation/modelsim/HomeWorkFive.vt}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L cycloneive_ver -L gate_work -L work -voptargs="+acc"  HomeWorkFive_test

add wave *
view structure
view signals
run -all
