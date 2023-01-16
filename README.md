# Inductive-Logic-Programming-using-Prolog-Programming-and-Aleph
We are going to find State Transition in the Maze gridworld. This project aims to find some general rules, all of which are gereralizeable to new environments, in gridworld environment.

Creator: Iman Sharifi
Email: iman.sharifi.edu@gmail.com

# How to run:

1. Before running, make sure you have installed YAP (Yet Another Prolog) on your OS Linux.
  To install 'YAP', you can simply use this (link)[https://gist.github.com/mdip/caab58b5b329ff02d819].
  
2. After installation, type 'yap' in terminal and prolog command prompt will be opened.

3. Use 'pwd.' command to find current directory and "cd('files directory')." to change your directory.

4. load Aleph using '[aleph].'.

5. Use 'read_all(maze).' to load language setting (maze.b), positive (maze.f) and negative examples (maze.n).

6. Use 'induce.' to extract target rules.

7. To find bottum clauses one by one, just use 'sat(i).' i is the number of a rule, and use 'reduce.' to find rules.

