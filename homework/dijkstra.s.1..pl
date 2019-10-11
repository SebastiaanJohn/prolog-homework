%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
% PSS − Homework assignment 1
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

% a)

% customer predicates
customer(810506, afshari, uk). 
customer(840904, edberg, se). 
customer(660228, venema, nl).
customer(420420, dijkstra, nl). % My data for question a
% product predicates
product(866, blender, 100). 
product(1002, coffee_machine, 350). 
product(42, icecream_machine, 600).
product(21, headphones, 359). % My data for question a
% purchase predicates
purchase(810506, 42, 2019). 
purchase(810506, 1002, 2012).
purchase(420420, 21, 2019). % My data for question a

% b)

% Looks at customer predicate and checks if the Name variable is found.
is_customer(Name) :-
    customer(_, Name, _).

% c)

loyal(PName, Name) :-
    customer(ID, Name, _),  % check if variable Name is a customer.
    purchase(ID, PID, _),   % check with customer id if variable Name made a purchase.
    product(PID, PName, _). % check with PID (product ID) what product name PName is.

%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
%Question 2
%++++++++++++++++++++++++++++++++++++++++++++++++++++ 

% Start with basecase to check if lists are empty.
remove_repeats([], []).

/* 
Split list in head H & tail T, and check if head H is a member of tail T.
If it is: repeat predicate with tail T.
If it fails: go to next predicate. 
*/
remove_repeats([H|T], List) :-
    member(H, T),
    remove_repeats(T, List).

/* 
Inserts head H and tail T to not_in_list predicate.
Appends head H with List to output Listout.
Uses recursion to insert list tail T and List back into remove_repeats.
*/
remove_repeats([H|T], Listout) :-
    not_in_list(H, T),
    append([H], List, Listout),
    remove_repeats(T, List).

% Check if list from tail T is empty.
not_in_list(_, []).

/* 
Splits tail T into head H1 and tail T.
Checks if head H is not equal to head H1.
Repeats predicate untill list tail T is empty, 
which makes the above predicate not_in_list True.
*/
not_in_list(H, [H1|T]) :-
    H \= H1,
    not_in_list(H, T).

%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
%Question 3
%++++++++++++++++++++++++++++++++++++++++++++++++++++ 

% a)

% Basecase: checks if the last element of the list is equal to the variable Last. 
% Returns True or False.
last1([Last], Last).

/* 
Removes the head from the list and returns a new list containing only the tail.
Inserts the tail back into predicate last1 untill the last element in the list is reached.
Which makes the above predicate either True or False.
*/
last1([_|T], Last) :- 
    last1(T, Last).

% b)

/* 
Predicate takes in a list and element.
Appends anonymous variable together with supposed last element Last,
together with List, and returns True or False depending if the element is the last item in the list.
*/
last2(List, Last) :-
    append(_, [Last], List).

%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
%Question 4
%++++++++++++++++++++++++++++++++++++++++++++++++++++ 

% a)

/* 
Basecase where the list is of one element Elem.
Returns List1 as an empty list.
*/
delete(Elem, [Elem], []).

/* 
If the desired element Elem for deletion is the head of the list, 
then the result is the tail List1.
*/
delete(Elem, [Elem|List1], List1).

/*
If the element Elem is not matching with head H, 
use recursion to rerun the delete predicate with the tails List and List1.
*/
delete(Elem, [H|List], [H|List1]) :-
    delete(Elem, List, List1).

% b)

% Basecase when set X is empty.
subset([], _).

/* 
Split set X in head X1 and tail XT.
Check if head X1 is a member of set Y.
If true: continue recursion with tail XT.
If false: return false. 
*/
subset([X1|XT], Y) :-
    member(X1, Y),
    subset(XT, Y).

% c)

% query "?- subset([a, a, c],[a, b, c])" runs succesfully, so no alterations.

%++++++++++++++++++++++++++++++++++++++++++++++++++++
% Self−check passed!




    










