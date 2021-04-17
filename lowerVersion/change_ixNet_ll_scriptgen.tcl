set stub_code {
package req IxTclNetwork
rename ixNet ixNetOld
proc ixNet {args} {
    if {[catch {set retval [eval ixNetOld $args]}] == 1} {
    } else {
        return $retval
    }
}
}

if {[llength $argv] == 1} {
    set out_file_name "out.[lindex $argv 0]"
    if {([catch {set r_fileId [open [lindex $argv 0] r]}] == 0) &&
        ([catch {set w_fileId [open $out_file_name w]}] == 0)} {
        while {[gets $r_fileId line] > -1} {
            if {[string trimleft [string trimright $line]] ==
               "package req IxTclNetwork"} {
                puts $w_fileId $stub_code
            } else {
                puts $w_fileId $line 
            }
        }
        close $w_fileId
    } else {
        puts "error --> $::errorInfo"
        exit -1   
    }

    puts stdout "##"
    puts stdout "## out file : $out_file_name"
    puts stdout "## you can source it to lower version of IxNetwork build"
    puts stdout "##"

    exit 0
} else {
    puts "usage: $argv0 <scripgen filename>"
    exit -1
}

