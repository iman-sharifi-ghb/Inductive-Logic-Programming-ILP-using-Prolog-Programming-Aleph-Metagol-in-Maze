next_state((1,3),right,(2,3)).
next_state((1,3),up,(1,3)).

next_state((2,3),right,(2,3)).
next_state((2,3),left,(1,3)).
next_state((2,3),up,(2,2)).

next_state((2,2),right,(2,2)).
next_state((2,2),left,(2,2)).
next_state((2,2),up,(2,1)).
next_state((2,2),down,(2,3)).

next_state((2,1),right,(3,1)).
next_state((2,1),left,(2,1)).
next_state((2,1),down,(2,2)).

next_state((3,1),left,(2,1)).
next_state((3,1),down,(3,1)).
