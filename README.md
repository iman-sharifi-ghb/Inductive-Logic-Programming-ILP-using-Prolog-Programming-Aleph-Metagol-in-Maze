# Inductive-Logic-Programming-for-Maze-State-Transition-and-Planning-using-Prolog-Programming

Creator: **_Iman Sharifi_**

Email: iman.sharifi.edu@gmail.com 

# Abstract

Most Machine learning algorithms lack logical reasoning, data-efficiency, and interpretability, which makes the situation worse when is needed to be used in different environments from the training one. However, symbolic methods can simply get rid of these shartages using logical programming. In this project, we are going to find State Transition in the Maze gridworld using Prolog and Aleph. In fact, using pre-defined states, actions, neighborhood relations, and obstacles, we aim to find the next state in a given state by taking a specific action. This project shows that the extracted rules are gereralizeable to new environments.

# State Transition in Maze using Aleph

![image](https://github.com/98210184/Inductive-Logic-Programming-using-Prolog-Programming-and-Aleph/blob/main/MazeEnv.png)

## Language Settings
#### Mode Declaration and Determination
```
:-modeh(*,next_state(+state,+act,-state)).
:-modeb(*,adjacent(+state,+act,-state)).
:-modeb(*,not_wall(+state)).
:-modeb(*,wall(+state)).

:-determination(next_state/3,adjacent/3).
:-determination(next_state/3,not_wall/1).
:-determination(next_state/3,wall/1).
```

## Background Knowledge

#### States

`state(X).` means, X is a state.
```
state((1,1)). state((2,1)). state((3,1)).
state((1,2)). state((2,2)). state((3,2)).
state((1,3)). state((2,3)). state((3,3)).
```

If you want to creats maze states automatically, please use this code block:
```
:- dynamic state/1.
maxWidth(3).
maxHeight(3).

create:-
	maxWidth(N),
	maxHeight(M),
	forall(between(1,N,X),(
	forall(between(1,M,Y),assertz(state((X,Y)))))).
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
next_state(A,B,C) :-
   adjacent(A,B,C), not_wall(C), not_wall(A).
next_state(A,B,A) :-
   adjacent(A,B,C), wall(C).
```

#### Accuracy

Confusion Matrix

```
[Training set performance]
          Actual
       +        - 
     + 14        0        14 
Pred 
     - 0        24        24 

       14        24        38 

Accuracy = 1.0
```

#### How to run:

1. Before running, make sure you have installed YAP (Yet Another Prolog) on your OS Linux.
  To install `YAP`, you can simply use this [link](https://gist.github.com/mdip/caab58b5b329ff02d819).
  
2. After installation, type `yap` in terminal and prolog command prompt will be opened.

3. Use `pwd.` command to find current directory and `cd('files directory').` to change your directory.

4. load Aleph using `[aleph].`.

5. Use `read_all(maze).` to load language setting and background knowledge (maze.b), positive (maze.f) and negative examples (maze.n).

6. Use `induce.` to extract target rules.

7. To find bottum clauses one by one, just use `sat(i).` i is the number of a rule, and use `reduce.` to find rules.

8. To save extracted rules use `write_rules('filename.txt')`.



# State Transition in Maze using Metagol

## Abstract

Meta-Interpretive Learning (MIL) is a machine learning technique that allows a learning system to modify its own knowledge representations and improve its own performance over time. This is in contrast to traditional machine learning, where the model is fixed and the learning process only adjusts the model's parameters.

MIL is based on the idea of learning by interpretation, where the learning system interprets examples, modifies its knowledge, and then re-interprets the examples. This process continues until the learning system reaches a satisfactory level of performance.

MIL has been applied in a variety of domains, including natural language processing, computer vision, and robotics. It has the advantage of allowing for incremental learning and the ability to continuously improve performance over time.

MIL is a relatively new and emerging field, and there is still much work to be done to fully understand its capabilities and limitations. However, it has shown promise as a powerful and flexible approach to machine learning that can be applied to a wide range of problems.

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

## Meta-Rules
```
metarule(postcon,[P,Q,R,S],[P,A,B,C],[[Q,A,B,C],[R,A],[S,C]]).
metarule(postcon2,[P,Q,R,S],[P,A,B,A],[[Q,A,B,C],[R,A],[S,C]]).
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

#### How to run:

1. Before running, make sure you have installed SWI-Prolog on your OS Linux.
  
2. After installation, type `prolog` in terminal and prolog command prompt will be opened.

3. Use `pwd.` command to find current directory and `cd('files directory').` to change your directory.

4. Type `consult('maze.pl').`.

You can see the corresponding codes in this [link](https://github.com/98210184/Inductive-Logic-Programming-using-Prolog-Programming-and-Aleph/tree/main/2-Maze%20State%20Transition%20using%20Metagol).



# Planning in Maze grid world using Prolog

% Next State
`next_state(S1,A,S2).` means If we be in the legal state S1 and go towards action A, we will be in the legal state S2.

```
next_state(S1,A,S2):-adjacent(S1,A,S2),not_wall(S1),not_wall(S2).
next_state(S1,A,S1):-adjacent(S1,A,S2),not_wall(S1),wall(S2).
```
Required build-in predicates:
```
revert(X,Y):-reverse(X,Y).
not_member(X,Y):-not(member(X,Y)).
```

#### Planning rules
```
find_path(Start,Goal,Path):-not_wall(Start),not_wall(Goal),find_path_helper(Start,Goal,[],Path).
find_path_helper(State,State,Visited,Path):-revert([State|Visited],Path).
find_path_helper(State,Goal,Visited,Path):-
	next_state(State,Action,NewState),
	not_member(NewState,Visited),
	writeln(Action),
	find_path_helper(NewState,Goal,[State|Visited],Path),!.
```

#### outputs

```
?- find_path((3,1),(1,3),Path).
left
down
down
left
Path = [(3, 1),  (2, 1),  (2, 2),  (2, 3),  (1, 3)].

?- find_path((1,3),(3,1),Path).
right
up
up
right
Path = [(1, 3),  (2, 3),  (2, 2),  (2, 1),  (3, 1)].
```

You can readily find paths from one state (cell) to another state using Prolog in this [link](https://github.com/98210184/Inductive-Logic-Programming-using-Prolog-Programming-and-Aleph/tree/main/3-Planning%20in%20Maze%20using%20Prolog).




# Planning in Maze grid world using Metagol

## Language Settings
#### Metagol Settings
```
:- use_module('metagol').

max_clauses(10).

%% metagol settings
%head_pred(find_path/3).
body_pred(next_state/2).
body_pred(wall/1).
body_pred(not_wall/1).
body_pred(valid_state/1).
```

## Meta-Rules
```
metarule(ident, [P,Q], [P,A,B], [[Q,A,B]]).
metarule(ident1, [P,Q], [P,A,B,C], [[Q,A,B,C]]).
metarule(ident2, [P,Q], [P,A,B,[A,B]], [[Q,A,B]]).
metarule(postcon, [P,Q,R], [P,A,B], [[R,B], [Q,A,B]]).
metarule(postcon1, [P,Q,R], [P,A,B], [[Q,A,B], [R,B]]).
metarule(recursion, [P,Q,R], [P,A,B,[A|L1]], [[R,B], [Q,A,C], [R,C], [P,C,B,L1]]).
```

#### Positive Examples
```
find_path((1,3),(2,3),[(1,3),(2,3)]),
find_path((1,3),(2,2),[(1,3),(2,3),(2,2)]),
find_path((1,3),(2,1),[(1,3),(2,3),(2,2),(2,1)]),
fid_path((1,3),(3,1),[(1,3),(2,3),(2,2),(2,1),(3,1)]),
find_path((3,1),(2,1),[(3,1),(2,1)]),
find_path((3,1),(2,2),[(3,1),(2,1),(2,2)]),
find_path((3,1),(2,3),[(3,1),(2,1),(2,2),(2,3)]),
find_path((3,1),(1,3),[(3,1),(2,1),(2,2),(2,3),(1,3)])
```

#### Negative Examples
```
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
```

## Extracted Rules
```
?- learn.
% learning find_path/3
% clauses: 1
% clauses: 2
find_path(A,B,[A,B]):-next_state(A,B).
find_path(A,B,[A|C]):-not_wall(B),next_state(A,D),not_wall(D),find_path(D,B,C).
true ;
find_path(A,B,[A,B]):-next_state(A,B).
find_path(A,B,[A|C]):-valid_state(B),next_state(A,D),valid_state(D),find_path(D,B,C).
true ;
% clauses: 3
find_path(A,B,C):-find_path_1(A,B,C).
find_path_1(A,B,[A,B]):-next_state(A,B).
find_path_1(A,B,[A|C]):-not_wall(B),next_state(A,D),not_wall(D),find_path_1(D,B,C).
true ;
find_path(A,B,C):-find_path_1(A,B,C).
find_path_1(A,B,[A,B]):-next_state(A,B).
find_path_1(A,B,[A|C]):-valid_state(B),next_state(A,D),valid_state(D),find_path_1(D,B,C).
true 
```

#### How to run:

1. Before running, make sure you have installed SWI-Prolog on your OS Linux.
  
2. After installation, type `prolog` in terminal and prolog command prompt will be opened.

3. Use `pwd.` command to find current directory and `cd('files directory').` to change your directory.

4. Type `consult('maze_planning_metagol.pl').`.

We extracted some rules for finding paths from one state (cell) to another  state using Metagol in this [link](https://github.com/98210184/Inductive-Logic-Programming-using-Prolog-Programming-and-Aleph/tree/main/4-Extract%20Planning%20Rules%20using%20Metagol).
