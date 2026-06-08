vsim work.VGADriver -L altera_mf_ver
vsim -gui work.VgaTestbench
add wave *
add wave sim:/VgaTestbench/dut/sync_counter/hsync_counter/count
add wave sim:/VgaTestbench/dut/sync_counter/vsync_counter/count
add wave sim:/VgaTestbench/dut/enable_counter/alternate
run -all