# Enable verbose output
set_msg_config -severity INFO -limit 10000
set_msg_config -severity STATUS -limit 10000
set_msg_config -severity WARNING -limit 10000
set_msg_config -severity ERROR -limit 10000

# Set the project name and directory
set project_name "design1_project"
set project_dir "/home/ubuntu/designs/design1/$project_name"
set source_dir "/home/ubuntu/designs/design1"
set source_file "$source_dir/design_wrapper.v"
set constraints_file "$source_dir/constraints.xdc"
set bitstream_file "$project_dir/$project_name.bit"
set_property SEVERITY {Warning} [get_drc_checks UCIO-1]

# Create a new project
create_project $project_name $project_dir -part xc7z020clg484-1 -force

# Add the source file to the project
add_files $source_file

# Add the constraints file to the project
add_files $constraints_file

# Set the top module
set_property top design_wrapper [current_fileset]

# Synthesize the design
synth_design -top design_wrapper -part xc7z020clg484-1

# Implement the design
opt_design
place_design
route_design

# Generate the bitstream
write_bitstream -force $bitstream_file

# Close the project
close_project

exit