# Inductive-Logic-Programming-using-Prolog-Programming-and-Metagol

# Abstract

Meta-Interpretive Learning (MIL) is a machine learning technique that allows a learning system to modify its own knowledge representations and improve its own performance over time. This is in contrast to traditional machine learning, where the model is fixed and the learning process only adjusts the model's parameters.

MIL is based on the idea of learning by interpretation, where the learning system interprets examples, modifies its knowledge, and then re-interprets the examples. This process continues until the learning system reaches a satisfactory level of performance.

MIL has been applied in a variety of domains, including natural language processing, computer vision, and robotics. It has the advantage of allowing for incremental learning and the ability to continuously improve performance over time.

MIL is a relatively new and emerging field, and there is still much work to be done to fully understand its capabilities and limitations. However, it has shown promise as a powerful and flexible approach to machine learning that can be applied to a wide range of problems.

Creator: **_Iman Sharifi_**

Email: iman.sharifi.edu@gmail.com

# State Transition in Maze

![image](https://github.com/98210184/Inductive-Logic-Programming-using-Prolog-Programming-and-Aleph/blob/main/MazeEnv.png)

## Language Settings
#### Metagol Settings
```
:- use_module('metagol').
max_clauses(5).

head_pred(next_state/3).
body_pred(adjacent/3).
body_pred(wall/1).
body_pred(not_wall/1).
```

## Background Knowledge

#### States

`state(X).` means, X is a state.
```
state((1,1)). state((2,1)). state((3,1)).
state((1,2)). state((2,2)). state((3,2)).
state((1,3)). state((2,3)). state((3,3)).
```

#### Actions

`action(X).` means, X is an action.
```
act(right).
act(left).
act(up).
act(down).

action(X):-act(X).
```

#### Neighborhood (adjacent)

`adjacent(X,D,Y).` means, if we be in state X and move in direction D, then we will be in the state Y.
```
adjacent((A,B),right,(C,D)):-state((A,B)),state((C,D)),D is B,C is A+1,!.
adjacent((A,B),left ,(C,D)):-state((A,B)),state((C,D)),D is B,C is A-1,!.
adjacent((A,B),up   ,(C,D)):-state((A,B)),state((C,D)),C is A,D is B-1,!.
adjacent((A,B),down ,(C,D)):-state((A,B)),state((C,D)),C is A,D is B+1,!.

adjacent(X,right,Y):-adjacent(Y,left,X).
adjacent(X,up,Y):-adjacent(Y,down,X).
```

#### Obstacles (walls)

`wall(X).` means, state X is an obstacle (wall).
```
wall((1,1)).
wall((1,2)).
wall((3,2)).
wall((3,3)).

not_wall(X):-not(wall(X)).
```

## Meta-Rules
```
metarule(postcon,[P,Q,R,S],[P,A,B,C],[[Q,A,B,C],[R,A],[S,C]]).
metarule(postcon2,[P,Q,R,S],[P,A,B,A],[[Q,A,B,C],[R,A],[S,C]]).
```

#### Positive Examples
```
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
```

#### Negative Examples
```
next_state((1,1),right,(2,1)).
next_state((1,1),down,(1,2)).

next_state((2,1),right,(2,1)).
next_state((2,1),left,(1,1)).
next_state((2,1),down,(2,1)).

next_state((3,1),left,(3,1)).
next_state((3,1),down,(3,2)).

next_state((1,2),right,(2,2)).
next_state((1,2),up,(1,1)).
next_state((1,2),down,(1,3)).

next_state((2,2),right,(3,2)).
next_state((2,2),left,(1,2)).
next_state((2,2),up,(2,2)).
next_state((2,2),down,(2,2)).

next_state((3,2),left,(2,2)).
next_state((3,2),up,(3,1)).
next_state((3,2),down,(3,3)).

next_state((1,3),right,(1,3)).
next_state((1,3),up,(1,2)).

next_state((2,3),right,(3,3)).
next_state((2,3),left,(2,3)).
next_state((2,3),up,(2,3)).

next_state((3,3),left,(2,3)).
next_state((3,3),up,(3,2)).
```

## Extracted Rules
```
% learning next_state/3
% clauses: 1
% clauses: 2
next_state(A,B,C):-adjacent(A,B,C),not_wall(A),not_wall(C).
next_state(A,B,A):-adjacent(A,B,C),not_wall(A),wall(C).
true.
```

# How to run:

1. Before running, make sure you have installed SWI-Prolog on your OS Linux.
  
2. After installation, type `prolog` in terminal and prolog command prompt will be opened.

3. Use `pwd.` command to find current directory and `cd('files directory').` to change your directory.

4. Type `consult('maze.pl').`.
