%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
% PSS − Homework assignment 3
% Tutor group D
% Sebastiaan Dijkstra , Bachelor Programme in AI , 1st year 
% sebastiaandijkstra@gmail.com 
  /*
   * I hereby declare I have actively participated 
   * in solving every exercise. All solutions are 
   * entirely my own work and no part has been 
   * copied from other sources. 
   */
% no. of hours in lab: 2
% no. of hours spent on homework assignment: 2.5
%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
%Question 1
%++++++++++++++++++++++++++++++++++++++++++++++++++++
p(1).
p(2) :-
    !. 
p(3).

/*
?- p(X). gives the answer:
   X = 1;
   X = 2.

   It won't assign the variable X to 3, 
   as there is a cut ! after P(2).

?- p(X). gives the answer:
   X = Y, Y = 1 ;
      Assigns the variable Y the value of P(1), 
      and then assigns X the value of Y.
   X = 1,
   Y = 2 ;
      Assigns X the value of 1, and Y the value of 2.
   X = 2,
   Y = 1 ;
      Assigns X the value of 2, and Y the value of 1.
   X = Y, Y = 2.
      Assigns X the value of Y, and Y the value of 2.

   Prolog tries all the combinations of 1 and 2, 
   but can't try combinations with P(3), 
   because of the cut in the body of P(2).

p(X),!,p(Y). gives the answer:
   X = Y, Y = 1 ;
      Prolog assigns the variables X the value of Y, 
      and Y the value of 1. Just like in the previous query.
   X = 1,
   Y = 2.
      Prolog assigns the variables X the value of 1,
      and Y the value of 2.

   Because of the cut ! after P(X), Prolog can't backtrack
   any further and thus won't try to assign the variables the values
   of the previous query.
*/

%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
%Question 2
%++++++++++++++++++++++++++++++++++++++++++++++++++++

% basecase where the given list is empty, 
% this will return N = 0.
occurrences(_, [], 0) :-
    !.

/*
If list is not empty, checks if X is equal to head H,
If it is: add 1 to counter N, and continue recursion with tail T.
There is a cut ! after the X == H check to make sure there is only
one answer.
*/
occurrences(X, [H|T], N) :-
    X==H,
    !,
    occurrences(X, T, N1),
    N is N1+1.

% Predicate runs if X is not equal to head H.
% Continues recursion with tail T.
occurrences(X, [_|T], N) :-
    occurrences(X, T, N).

%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
%Question 3
%++++++++++++++++++++++++++++++++++++++++++++++++++++

% ==== Version without cut ====

% basecase where the input is an empty list.
separation([], [], []).

% Add head H to List1 if head H >= 0.
% Continue recursion with tail T.
separation([H|T], [H|List1], List2) :-
    H>=0,
    separation(T, List1, List2).

% Add head H to List2 if head H < 0.
% Continue recursion with tail T.
separation([H|T], List1, [H|List2]) :-
    H<0,
    separation(T, List1, List2).

% ==== Version without cut ====

% ==== Version with cut ====

% basecase where the input is an empty list.
separation2([], [], []).

/*
Add head H to List1 if H >= 0.
Continue recursion with tail T.
Add cut ! after checking head H to prevent any wrong alternative answers after correct
answer is found.
*/
separation2([H|T], [H|List1], List2) :-
    H>=0,
    !,
    separation2(T, List1, List2).

% Add head H to List2.
% Contine recursion with tail T.
separation2([H|T], List1, [H|List2]) :-
    separation2(T, List1, List2).

% ==== Version with cut ====

%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
%Question 4
%++++++++++++++++++++++++++++++++++++++++++++++++++++

% Add accumulator to divisors and set it to 1.
divisors(Y, X) :-
    divisors(Y, 1, X).

% Basecase where Y = 1 seeing we are only using natural numbers (NaturalNumber/NaturalNumber = 1).
% Add cut ! to prevent infinite loop.
divisors(Y, Y, [Y]) :-
    !.
/*
Check if Y (input number) mod Y1 (accumulator) = 0.
If it is, add Y1 to list X, and increase accumulator by 1.
Repeat recursion with Y (input number), Y2 (updated accumulator), and list X.
Add cut ! after mod check to prevent any wrong alternative answers after correct
answer is found.
*/
divisors(Y, Y1, [Y1|X]) :-
    0=:=Y mod Y1,
    !,
    Y2 is Y1+1,
    divisors(Y, Y2, X).

% If above predicate fails, increase accumulator by 1,
% and repeat recursion with Y (input number), Y2 (updated accumulator), and list X.
divisors(Y, Y1, X) :-
    Y2 is Y1+1,
    divisors(Y, Y2, X).

%++++++++++++++++++++++++++++++++++++++++++++++++++++
% Self−check passed!