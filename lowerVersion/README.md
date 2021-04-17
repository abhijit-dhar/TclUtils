# Higher version problem
.ixncfg files created in higher version of the IxNetwork does not get loaded by lower version of that software. So QA Engineers and support engineers often encounters problem when they have to load an ".ixncfg" file
created higher version of the IxNetwork software to the lower version of that. This problem could be handled in the following manner.

1. Load the .ixncfg file in the IxNetwork (higher version)
2. Create a .tcl scriptgen file from that.
3. Modify that script file with this script.

   3.1. `tclsh change_ixNet_ll_scriptgen.tcl your_scriptgen_file_name`

   3.2. The output of the script will be another .tcl script.

4. Source the new tcl script at the IxNetwork of the the desired (lower) version.
5. You should be successfully recreate the .ixncfg file.  


