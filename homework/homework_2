%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
% PSS − Homework assignment 2
% Tutor group D
% Sebastiaan Dijkstra , Bachelor Programme in AI , 1st year 
% sebastiaandijkstra@gmail.com 
  /*
   * I hereby declare I have actively participated 
   * in solving every exercise. All solutions are 
   * entirely my own work and no part has been 
   * copied from other sources. 
   */
% no. of hours in lab: 4
% no. of hours spent on homework assignment: 6
%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
%Question 1
%++++++++++++++++++++++++++++++++++++++++++++++++++++

% Basecase where Arg1 is an empty list.
sublist([], _).

/*
First seperate head H from Arg1.
Check if head H is a member of Arg2.
If true: Use built-in predicate select/3 to match head H with element H in Arg2, and
save remainder of list to variable Rem.
Insert tail T and list Rem into sublist and repeat until basecase.
*/
sublist([H|T], Arg2) :-
    member(H, Arg2),
    select(H, Arg2, Rem),
    sublist(T, Rem).

%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
%Question 2
%++++++++++++++++++++++++++++++++++++++++++++++++++++

% a)
% 'tic' is the principal functor and an prefix which is right-associative.
% 'tac' is the infix because it is in the middle.
:- op(300, fy, tic). 
:- op(200, fy, tac).

% b)


%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
%Question 3
%++++++++++++++++++++++++++++++++++++++++++++++++++++

% a)
:- op(100, fx, the),
   op(100, fx, a),
   op(200, xfx, has).


% has(claudia,a(car)) = claudia has a car.
% 'has' is the principal functor.

% b)
/*
Prolog would reply:
Who = the lion,
What = hunger.
*/

% c)
/*
The query will cause a syntax error because the operator 'has' appears twice. 
This won't work because of the infix xfx. The 'x' suggests an argument whose precedence 
must be lower then that of the operator. A fix for this error would be to replace the 
last 'x' with an 'y': xfy.
*/

%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
%Question 4
%++++++++++++++++++++++++++++++++++++++++++++++++++++

/*

Predicate instructions.

execute/5(current_position (X, Y), <- start at (0,0)
        current_orientation(N, S, W, E), 
        command (right, left, move), 
        new_position(X, Y), 
        new_orientation(N, S, W, E)))

status/5(current_position (X, Y), <- start at (0,0)
        current_orientation(N, S, W, E), 
        [commands (right, left, move)], 
        new_position(X, Y), 
        new_orientation(N, S, W, E))

status/3([commands (right, left, move)],
        Position,
        Orientation).

*/

% execute/5 basecase
execute((X, Y), Orientation, x,  (X, Y), Orientation).

% execute/5 right rotations
execute((X, Y), north, right,  (X, Y), east). % N -> E
execute((X, Y), east, right,  (X, Y), south). % E -> S
execute((X, Y), south, right,  (X, Y), west). % S -> W
execute((X, Y), west, right,  (X, Y), north). % W -> N

% execute/5 left rotations
execute((X, Y), north, left,  (X, Y), west). % N -> W
execute((X, Y), east, left,  (X, Y), north). % E -> N
execute((X, Y), south, left,  (X, Y), east). % S -> E
execute((X, Y), west, left,  (X, Y), south). % W -> S

% execute/5 movement
execute((X, Y), north, move, Position, Orientation) :- % (0,0) -> (0,1)
    Y1 is Y+1,
    execute((X, Y1), north, x, Position, Orientation).

execute((X, Y), east, move, Position, Orientation) :- % (0,0) -> (1,0)
    X1 is X+1,
    execute((X1, Y), east, x, Position, Orientation).

execute((X, Y), south, move, Position, Orientation) :- % (0,0) -> (0,-1)
    Y1 is Y-1,
    execute((X, Y1), south, x, Position, Orientation).

execute((X, Y), west, move, Position, Orientation) :- % (0,0) -> (0,-1)
    X1 is X-1,
    execute((X1, Y), west, x, Position, Orientation).


% status/3 predicate, which runs the status/5 predicate.
status(Commands, Position, Orientation) :-
    status((0, 0), north, Commands, Position, Orientation).  

% status/5 basecase
status((X, Y), Orientation, [],  (X, Y), Orientation).

% status/5 right rotations
status((X, Y), north, [right|Rest], Position, Orientation) :- % N -> E
    status((X, Y), east, Rest, Position, Orientation).  

status((X, Y), east, [right|Rest], Position, Orientation) :- % E -> S
    status((X, Y), south, Rest, Position, Orientation).

status((X, Y), south, [right|Rest], Position, Orientation) :- % S -> W
    status((X, Y), west, Rest, Position, Orientation).

status((X, Y), west, [right|Rest], Position, Orientation) :- % W -> N
    status((X, Y), north, Rest, Position, Orientation).

% status/5 left rotations
status((X, Y), north, [left|Rest], Position, Orientation) :- % N -> W
    status((X, Y), west, Rest, Position, Orientation).

status((X, Y), east, [left|Rest], Position, Orientation) :- % E -> N
    status((X, Y), north, Rest, Position, Orientation).

status((X, Y), south, [left|Rest], Position, Orientation) :- % S -> E
    status((X, Y), east, Rest, Position, Orientation).

status((X, Y), west, [left|Rest], Position, Orientation) :- % W -> S
    status((X, Y), south, Rest, Position, Orientation).

% status/5 movement
status((X, Y), north, [move|Rest], Position, Orientation) :- % (X,Y) -> (X,Y+1)
    Y1 is Y+1,
    status((X, Y1), north, Rest, Position, Orientation).

status((X, Y), east, [move|Rest], Position, Orientation) :- % (X,Y) -> (X+1,Y)
    X1 is X+1,
    status((X1, Y), east, Rest, Position, Orientation).

status((X, Y), south, [move|Rest], Position, Orientation) :- % (X,Y) -> (X,Y-1)
    Y1 is Y-1,
    status((X, Y1), south, Rest, Position, Orientation).

status((X, Y), west, [move|Rest], Position, Orientation) :- % (X,Y) -> (X-1,Y)
    X1 is X-1,
    status((X1, Y), west, Rest, Position, Orientation).

%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
%Question 5
%++++++++++++++++++++++++++++++++++++++++++++++++++++

% a)
fibonacci(0, 0). % basecase where N = 0
fibonacci(1, 1). % basecase where N = 1

/*
If N is greater then or equal to 2, N1 is equal to N-1, and N2 is equal to N-2.
Then use recursion with N1 and N2 to get to the basecase.
Finally, add X1+X2 to get X.
*/
fibonacci(N, X) :-
    N>=2,
    N1 is N-1,
    N2 is N-2,
    fibonacci(N1, X1),
    fibonacci(N2, X2),
    X is X1+X2.

% b)
/*
?- fibonacci(17, X). Got me X = 1597.
?- fibonacci(27, X). Got me X = 196418.
?- fibonacci(37, X). This didn't load for me. Probably because the number is to large for this recursion. 
*/

% c)
fastfibo(0, 0). % basecase where N = 0
fastfibo(1, 1). % basecase where N = 1

/*
The main two advantages with this version is the use of tail recursion,  
which means that the recursive call is the last thing executed by the function,
and that it saves the two previous fibonacci numbers. 
This will make sure that prolog doesn't run out of memory at very large numbers.
*/
fastfibo(N, X) :- % every other case where N>=2
    N>=2,
    fastfibo(0, 1, 2, N, X).

fastfibo(X1, X2, N, N, X) :-
    X is X1+X2.

fastfibo(X1, X2, X3, N, X) :-
    Y is X1+X2,
    X4 is X3+1,
    fastfibo(X2, Y, X4, N, X).
/*
The main thing learned is that the first solution that might come to mind is not always
the best solution. Futhermore, creating memory efficient programs is very important.
*/
