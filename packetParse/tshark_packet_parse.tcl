source ./stack.tcl
proc parsePacket {file_name {mycount -1}} {
    set retval ""
    stack::init
    set command "tshark -T pdml -r $file_name"

    if {[catch {set channel [open "|$command" r]}]} {
	puts "tshark utility is not found!"
        puts "error -> $::errorInfo"
	return $retval
    }

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
	    break
        }       
    }
    catch {close $channel}
    return $retval
}

set retval [parsePacket "sample.cap" 10]
puts $retval
