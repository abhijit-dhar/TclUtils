namespace eval stack {
    variable stack
    variable count
    proc init {} {
        variable stack
        variable count
        set stack [list]
        set count 0
    }
    proc push {item} {
        variable stack
        variable count
        lappend stack $item
        incr count
    }

    proc pop {} {
        variable stack
        variable count
        set retval [lindex $stack end]
        set stack [lrange $stack [expr $count - 2]]
        incr count -1
    }

    proc stack_top {} {
       variable stack
       return [lindex $stack 0]
    }
}
namespace export stack *

