source ./stack.tcl
proc parsePacket {file_name {mycount -1}} {
    stack::init
    set command "tshark -T pdml -r $file_name"
    set channel [open "|$command" r]
    set count 0
    while {[gets $channel line] > -1} {
        if {$line == "<packet>"} {
             stack::push $line
             set temp_packet ""
        }
        
        if {[stack::stack_top] == "<packet>"} {
            set temp_packet "$temp_packet\n$line" 
        } 

        if {$line == "</packet>"} {
             stack::push $line
             incr count
        }
        
        if {$mycount == $count} {
            set retval $temp_packet
            return $retval
        }       
    }
    close $channel
}

set retval [parsePacket "sample.cap" 10]
puts $retval
