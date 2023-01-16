% Simple illustration of the use of Aleph on
%       Learning State Transition in Maze
% To run do the following:
%       a. Load Aleph
%       b. read_all(maze).
%       c. induce

:-write('These codes have been written by Iman Sharifi (Email:iman.sharifi.edu@gmail.com).'),nl,write('Do not forget to hit the star bottun in this repository if you could use it.'),nl,nl,write('This project aims to find some rules regarding State Transition in Maze platform.'),nl,write('Using Current State and taken action, we are going to find some general rules for the Next State which is generalizeable to different Maze environments.'),nl,nl.

:-nl,write('Mode Declarations ...'),nl.

:-modeh(*,next_state(+state,+act,-state)).
:-write('The head of the desired rules has been defined.'),nl.

:-modeb(*,adjacent(+state,+act,-state)).
:-modeb(*,not_wall(+state)).
:-modeb(*,wall(+state)).
:-write('The terms of the body of the rules have been settled.'),nl.

:-determination(next_state/3,adjacent/3).
:-determination(next_state/3,not_wall/1).
:-determination(next_state/3,wall/1).

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
