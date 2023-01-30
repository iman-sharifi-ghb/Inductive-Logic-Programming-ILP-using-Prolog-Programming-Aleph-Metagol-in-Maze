:- use_module('metagol').

max_clauses(2).

%% metagol settings
head_pred(next_state/3).
body_pred(adjacent/3).
%body_pred(wall/1).
%body_pred(not_wall/1).

:-nl,write('Language Setting ...'),nl.

% type definitions
% pre-defined states
state((1,1)). state((2,1)). state((3,1)).
state((1,2)). state((2,2)). state((3,2)).
state((1,3)). state((2,3)). state((3,3)).
:-write('The states (maze cells) have been defined.'),nl.

%row(Y):-integer(Y),Y>=1,Y=<3.
%column(X):-integer(X),X>=1,X=<3.
%state((X,Y)):-row(Y),column(X).

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
adjacent((A,B),right,(C,D)):-state((A,B)),state((C,D)),D is B,C is A+1,!.
adjacent((A,B),left ,(C,D)):-state((A,B)),state((C,D)),D is B,C is A-1,!.
adjacent((A,B),up   ,(C,D)):-state((A,B)),state((C,D)),C is A,D is B-1,!.
adjacent((A,B),down ,(C,D)):-state((A,B)),state((C,D)),C is A,D is B+1,!.

adjacent(X,right,Y):-adjacent(Y,left,X).
adjacent(X,up,Y):-adjacent(Y,down,X).

:-write('The neighborhood relations have been defined.'),nl.

% wall(X) means: state X is an obstacle (wall).
wall((1,1)).
wall((1,2)).
wall((3,2)).
wall((3,3)).

not_wall(X):-not(wall(X)).
:-write('The obstacles (walls) have been defined.'),nl,nl.

%% metarules
metarule([P,Q],[P,A,B,C],[[Q,A,B,C],[not_wall,A],[not_wall,C]]).
metarule([P,Q],[P,A,B,A],[[Q,A,B,C],[not_wall,A],[wall,C]]).
%metarule([P,Q,R],[P,A,B,A],[[Q,A,B,C],[R,C]]).
%metarule([P,Q],[P,A,B],[[Q,A,B]]).
%metarule([P,Q],[P,A,B,C],[[Q,A,B,C]]).

%% learning task
:-
  %% positive examples
  Pos = [
	next_state((1,3),right,(2,3)),
	next_state((1,3),up,(1,3)),
	next_state((2,3),right,(2,3)),
	next_state((2,3),left,(1,3)),
	next_state((2,3),up,(2,2)),
	next_state((2,2),right,(2,2)),
	next_state((2,2),left,(2,2)),
	next_state((2,2),up,(2,1)),
	next_state((2,2),down,(2,3)),
	next_state((2,1),right,(3,1)),
	next_state((2,1),left,(2,1)),
	next_state((2,1),down,(2,2)),
	next_state((3,1),left,(2,1)),
	next_state((3,1),down,(3,1))
  ],
  %% negative examples
  Neg = [
        next_state((1,1),right,(2,1)),
	next_state((1,1),down,(1,2)),
	next_state((2,1),right,(2,1)),
	next_state((2,1),left,(1,1)),
	next_state((2,1),down,(2,1)),
	next_state((3,1),left,(3,1)),
	next_state((3,1),down,(3,2)),
	next_state((1,2),right,(2,2)),
	next_state((1,2),up,(1,1)),
	next_state((1,2),down,(1,3)),
	next_state((2,2),right,(3,2)),
	next_state((2,2),left,(1,2)),
	next_state((2,2),up,(2,2)),
	next_state((2,2),down,(2,2)),
	next_state((3,2),left,(2,2)),
	next_state((3,2),up,(3,1)),
	next_state((3,2),down,(3,3)),
	next_state((1,3),right,(1,3)),
	next_state((1,3),up,(1,2)),
	next_state((2,3),right,(3,3)),
	next_state((2,3),left,(2,3)),
	next_state((2,3),up,(2,3)),
	next_state((3,3),left,(2,3)),
	next_state((3,3),up,(3,2))
  ],
  learn(Pos,Neg).
