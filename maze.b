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
state(x11). state(x21). state(x31). 
state(x12). state(x22). state(x32).
state(x13). state(x23). state(x33).
:-write('The states (maze cells) have been defined.'),nl.

% Actions
act(right).
act(left).
act(up).
act(down).

action(X):-act(X).
:-write('The actions (right,left,up,down) have been defined.'),nl.

:-nl,write('Background Knowledge ...'),nl.


% Neighborhood
% adjacent(X,D,Y) means: if agent is in the state X and move in direction D, then we will be in the state Y.
adjacent(x11,right,x21).
adjacent(x11,down,x12).

adjacent(x21,right,x31).
adjacent(x21,left,x11).
adjacent(x21,down,x22).

adjacent(x31,left,x21).
adjacent(x31,down,x32).

adjacent(x12,right,x22).
adjacent(x12,up,x11).
adjacent(x12,down,x13).

adjacent(x22,right,x32).
adjacent(x22,left,x12).
adjacent(x22,up,x21).
adjacent(x22,down,x23).

adjacent(x32,left,x22).
adjacent(x32,up,x31).
adjacent(x32,down,x33).

adjacent(x13,right,x23).
adjacent(x13,up,x12).

adjacent(x23,right,x33).
adjacent(x23,left,x13).
adjacent(x23,up,x22).

adjacent(x33,left,x23).
adjacent(x33,up,x32).

adjacent(X,right,Y):-adjacent(Y,left,X).
adjacent(X,up,Y):-adjacent(Y,down,X).

:-write('The neighborhood relations have been defined.'),nl.

% wall(X) means: state X is an obstacle (wall).
wall(x11).
wall(x12).
wall(x32).
wall(x33).

not_wall(X):-not(wall(X)).
:-write('The obstacles (walls) have been defined.'),nl,nl.
