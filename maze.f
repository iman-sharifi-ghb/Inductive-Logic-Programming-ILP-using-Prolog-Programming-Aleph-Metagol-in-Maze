next_state(x13,right,x23).
next_state(x13,up,x13).

next_state(x23,right,x23).
next_state(x23,left,x13).
next_state(x23,up,x22).

next_state(x22,right,x22).
next_state(x22,left,x22).
next_state(x22,up,x21).
next_state(x22,down,x23).

next_state(x21,right,x31).
next_state(x21,left,x21).
next_state(x21,down,x22).

next_state(x31,left,x21).
next_state(x31,down,x31).
