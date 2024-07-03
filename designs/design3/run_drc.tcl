# run_drc.tcl
open_project /home/ubuntu/designs/design3/design3_project/design3_project.xpr
launch_runs impl_1
wait_on_run impl_1
open_run impl_1
report_drc -file /home/ubuntu/designs/design3/drc_report.txt
close_project
exit
