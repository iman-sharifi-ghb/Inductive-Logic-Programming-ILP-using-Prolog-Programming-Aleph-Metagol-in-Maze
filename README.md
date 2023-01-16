# Inductive-Logic-Programming-using-Prolog-Programming-and-Aleph
We are going to find State Transition in the Maze gridworld. This project aims to find some general rules, all of which are gereralizeable to new environments, in gridworld environment.

Creator: **_Iman Sharifi_**

Email: iman.sharifi.edu@gmail.com

# State Transition in Maze
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

`state(X).` means: state X is a state.
```
state((1,1)). state((2,1)). state((3,1)).
state((1,2)). state((2,2)). state((3,2)).
state((1,3)). state((2,3)). state((3,3)).
```

#### Actions

`action(X).` means: state X is an action.
```
act(right).
act(left).
act(up).
act(down).

action(X):-act(X).
```

#### Neighborhood (adjacent)

`adjacent(X,D,Y).` means: if we be in state X and move in direction D, then we will be in the state Y.
```
adjacent((A,B),right,(C,D)):-state((A,B)),state((C,D)),D is B,C is A+1,!.
adjacent((A,B),left ,(C,D)):-state((A,B)),state((C,D)),D is B,C is A-1,!.
adjacent((A,B),up   ,(C,D)):-state((A,B)),state((C,D)),C is A,D is B-1,!.
adjacent((A,B),down ,(C,D)):-state((A,B)),state((C,D)),C is A,D is B+1,!.

adjacent(X,right,Y):-adjacent(Y,left,X).
adjacent(X,up,Y):-adjacent(Y,down,X).
```

#### Obstacles (walls)

`wall(X).` means: state X is an obstacle (wall).
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

# How to run:

1. Before running, make sure you have installed YAP (Yet Another Prolog) on your OS Linux.
  To install `YAP`, you can simply use this [link](https://gist.github.com/mdip/caab58b5b329ff02d819).
  
2. After installation, type `yap` in terminal and prolog command prompt will be opened.

3. Use `pwd.` command to find current directory and `cd('files directory').` to change your directory.

4. load Aleph using `[aleph].`.

5. Use `read_all(maze).` to load language setting (maze.b), positive (maze.f) and negative examples (maze.n).

6. Use `induce.` to extract target rules.

7. To find bottum clauses one by one, just use `sat(i).` i is the number of a rule, and use `reduce.` to find rules.
