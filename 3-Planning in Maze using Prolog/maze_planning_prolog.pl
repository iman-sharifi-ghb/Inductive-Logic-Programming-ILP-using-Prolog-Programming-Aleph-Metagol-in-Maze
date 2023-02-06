:-writeln('Language Setting ...').

% type definitions
% pre-defined states
state((1,1)). state((2,1)). state((3,1)).
state((1,2)). state((2,2)). state((3,2)).
state((1,3)). state((2,3)). state((3,3)).
:-writeln('The states (maze cells) have been defined.').

valid_state(X):-state(X).

% Actions
act(right).
act(left).
act(up).
act(down).

action(X):-act(X).

:-write('The actions (right,left,up,down) have been defined.'),nl.

:-nl,write('Background Knowledge ...'),nl.

% Neighborhood
% adjacent(X,D,Y). means: if we be in state X and move in direction D, then we will be in the state Y.
adjacent((A,B),right,(C,D)):-state((A,B)),state((C,D)),D is B,C is A+1.
adjacent((A,B),left ,(C,D)):-state((A,B)),state((C,D)),D is B,C is A-1.
adjacent((A,B),up   ,(C,D)):-state((A,B)),state((C,D)),C is A,D is B-1.
adjacent((A,B),down ,(C,D)):-state((A,B)),state((C,D)),C is A,D is B+1.

adjacent(X,right,Y):-adjacent(Y,left,X).
adjacent(X,left,Y):-adjacent(Y,right,X).
adjacent(X,up,Y):-adjacent(Y,down,X).
adjacent(X,down,Y):-adjacent(Y,up,X).

:-write('The neighborhood relations have been defined.'),nl.

% wall(X) means: state X is an obstacle (wall).
wall((1,1)).
wall((1,2)).
wall((3,2)).
wall((3,3)).

not_wall(X):-not(wall(X)).
:-write('The obstacles (walls) have been defined.'),nl,nl.

% Next State
% next_state(S1,A,S2). means If we be in the legal state S1 and go towards action A, we will be in the legal state S2.
next_state(S1,A,S2):-adjacent(S1,A,S2),not_wall(S1),not_wall(S2).
next_state(S1,A,S1):-adjacent(S1,A,S2),not_wall(S1),wall(S2).

revert(X,Y):-reverse(X,Y).
not_member(X,Y):-not(member(X,Y)).

% Planning
find_path(Start,Goal,Path):-not_wall(Start),not_wall(Goal),find_path_helper(Start,Goal,[],Path).
find_path_helper(State,State,Visited,Path):-revert([State|Visited],Path).
find_path_helper(State,Goal,Visited,Path):-
	next_state(State,Action,NewState),
	not_member(NewState,Visited),
	writeln(Action),
	find_path_helper(NewState,Goal,[State|Visited],Path),!.
