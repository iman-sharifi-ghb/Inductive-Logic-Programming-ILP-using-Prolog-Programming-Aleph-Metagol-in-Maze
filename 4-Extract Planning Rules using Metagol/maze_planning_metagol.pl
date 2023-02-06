:- use_module('metagol').

max_clauses(10).

%% metagol settings
%head_pred(find_path/3).
body_pred(next_state/2).
body_pred(wall/1).
body_pred(not_wall/1).
body_pred(valid_state/1).

:-nl,write('Language Setting ...'),nl.

% type definitions
% pre-defined states
state((1,1)). state((2,1)). state((3,1)).
state((1,2)). state((2,2)). state((3,2)).
state((1,3)). state((2,3)). state((3,3)).
:-write('The states (maze cells) have been defined.'),nl.

valid_state(X):-state(X).

% Neighborhood
% adjacent(X,D,Y). means: if we be in state X and move in direction D, then we will be in the state Y.
adjacent((A,B),(C,D)):-state((A,B)),state((C,D)),D is B,C is A+1.
adjacent((A,B),(C,D)):-state((A,B)),state((C,D)),D is B,C is A-1.
adjacent((A,B),(C,D)):-state((A,B)),state((C,D)),C is A,D is B-1.
adjacent((A,B),(C,D)):-state((A,B)),state((C,D)),C is A,D is B+1.

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
next_state(S1,S2):-adjacent(S1,S2),not_wall(S1),not_wall(S2).
next_state(S1,S1):-adjacent(S1,S2),not_wall(S1),wall(S2).

%% metarules
metarule(ident, [P,Q], [P,A,B], [[Q,A,B]]).
metarule(ident1, [P,Q], [P,A,B,C], [[Q,A,B,C]]).
metarule(ident2, [P,Q], [P,A,B,[A,B]], [[Q,A,B]]).
metarule(postcon, [P,Q,R], [P,A,B], [[R,B], [Q,A,B]]).
metarule(postcon1, [P,Q,R], [P,A,B], [[Q,A,B], [R,B]]).
metarule(recursion, [P,Q,R], [P,A,B,[A|L1]], [[R,B], [Q,A,C], [R,C], [P,C,B,L1]]).

%% learning planning task
learn :-
  %% positive examples
  Pos = [
	find_path((1,3),(2,3),[(1,3),(2,3)]),
	find_path((1,3),(2,2),[(1,3),(2,3),(2,2)]),
	find_path((1,3),(2,1),[(1,3),(2,3),(2,2),(2,1)]),
	find_path((1,3),(3,1),[(1,3),(2,3),(2,2),(2,1),(3,1)]),
	find_path((3,1),(2,1),[(3,1),(2,1)]),
	find_path((3,1),(2,2),[(3,1),(2,1),(2,2)]),
	find_path((3,1),(2,3),[(3,1),(2,1),(2,2),(2,3)]),
	find_path((3,1),(1,3),[(3,1),(2,1),(2,2),(2,3),(1,3)])
  ],
  %% negative examples
  Neg = [
	find_path((1,3),(1,2),[(1,3),(1,2)]),
	find_path((1,3),(2,2),[(1,3),(1,2),(2,2)]),
	find_path((1,3),(2,1),[(1,3),(1,2),(1,1),(2,1)]),
	find_path((1,3),(3,1),[(1,3),(2,3),(3,3),(3,2),(3,1)]),
	find_path((3,1),(3,2),[(3,1),(3,2)]),
	find_path((3,1),(2,2),[(3,1),(3,2),(2,2)]),
	find_path((3,1),(2,3),[(3,1),(3,2),(3,3),(2,3)]),
	find_path((3,1),(1,3),[(3,1),(2,1),(1,1),(1,2),(1,3)]),
	find_path((1,1),(1,2),[(1,1),(1,2)]),
	find_path((1,1),(2,1),[(1,1),(2,1)])
  ],
  learn(Pos,Neg).
