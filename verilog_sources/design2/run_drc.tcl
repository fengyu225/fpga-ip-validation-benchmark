# run_drc.tcl
open_project /home/ubuntu/verilog_sources/design2/design2_project/design2_project.xpr
launch_runs impl_1
wait_on_run impl_1
open_run impl_1
report_drc -file /home/ubuntu/verilog_sources/design2/drc_report.txt
close_project
exit
