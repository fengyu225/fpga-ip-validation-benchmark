# run_drc.tcl
open_project /home/ubuntu/designs/design1/design1_project/design1_project.xpr
launch_runs impl_1
wait_on_run impl_1
open_run impl_1
report_drc -file /home/ubuntu/designs/design1/drc_report.txt
close_project
exit
