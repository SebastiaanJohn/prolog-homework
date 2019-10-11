%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
% PSS − Homework assignment 4
% Tutor group D
% Sebastiaan Dijkstra , Bachelor Programme in AI , 1st year 
% sebastiaandijkstra@gmail.com 
  /*
   * I hereby declare I have actively participated 
   * in solving every exercise. All solutions are 
   * entirely my own work and no part has been 
   * copied from other sources. -> except the algorithms by Afshari.
   */
% no. of hours in lab: 4
% no. of hours spent on homework assignment: 5
%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
%Question 1
%++++++++++++++++++++++++++++++++++++++++++++++++++++
% set get_counter as a dynamic so we can assert and retract numbers.
:- (dynamic get_counter/1). 

% initiate the counter by first removing the clause in memory, and
% then asserting 0 to get counter.
init_counter :-
    retractall(get_counter(_)),
    assert(get_counter(0)).
/*
Gets the current counter by calling get_counter.
Then clears the clause from memory.
Use the build in predicate succ to increment the number that was
asserted from get_counter.
Assert the new number num to get_counter.
*/
step_counter :-
    get_counter(Num_old),
    retractall(get_counter(_)),
    succ(Num_old, Num),
    assert(get_counter(Num)).

%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
%Question 2
%++++++++++++++++++++++++++++++++++++++++++++++++++++

% algorithms by b. Afshari (UvA)
% =================== BUBBLESORT ===================
check(Rel, A, B) :-
    Goal=..[Rel, A, B], % Goal becomes Rel(A, B)
    call(step_counter), % added a call to step_counter for question 2
    call(Goal). % calls predicate Rel(A, B)

% Go recursively through a list until you find a pair A/B to swap and return the new list, 
% or fail if there is no such pair:
swap(Rel, [A, B|List], [B, A|List]) :-
    check(Rel, B, A).

swap(Rel, [A|List], [A|NewList]) :-
    swap(Rel, List, NewList).

% bubblesort algorithm
bubblesort(Rel, List, SortedList) :-
    swap(Rel, List, NewList),
    !,
    bubblesort(Rel, NewList, SortedList).

% basecase for bubblesort
bubblesort(_, SortedList, SortedList).
% =================== BUBBLESORT ===================

% =================== BUBBLESORT2 ===================
swap2(Rel, [A, B|List], [B|NewList]) :-
    check(Rel, B, A),
    swap2(Rel, [A|List], NewList). % continue!
swap2(Rel, [A|List], [A|NewList]) :-
    swap2(Rel, List, NewList).
   
% base case: reached end of list B. 
swap2(_, [], []). 

bubblesort2(Rel, List, SortedList) :-
    swap2(Rel, List, NewList), % this now always succeeds 
    List\=NewList,
    !, % check there has been a swap 
    bubblesort2(Rel, NewList, SortedList).

bubblesort2(_, SortedList, SortedList).
% =================== BUBBLESORT2 ===================

% =================== QUICKSORT ===================
% Base case: sorting the empty list results in the empty list
quicksort(_, [], []).

/* 
Recursive call : remove the Head from the
unsorted list and split the Tail into those elements ∗ Left and Right of the pivot with respect to Rel
*/
quicksort(Rel, [Head|Tail], SortedList) :-
    split(Rel, Head, Tail, Left, Right),
    quicksort(Rel, Left, SortedLeft),
    quicksort(Rel, Right, SortedRight),
    append(SortedLeft, [Head|SortedRight], SortedList). % put together

% Base case: empty list splits into two empty lists
split(_, _, [], [], []).

% Recursive call
split(Rel, Middle, [Head|Tail], [Head|Left], Right) :-
    check(Rel, Head, Middle),
    !,
    split(Rel, Middle, Tail, Left, Right).

split(Rel, Middle, [Head|Tail], Left, [Head|Right]) :-
    split(Rel, Middle, Tail, Left, Right).
% =================== QUICKSORT ===================
% basecase where list is empty.
experiment(_, [], 0).

/*
take in the algorithm, a list, and a variable Count.
first sets counter from question 1 to 0 by using init.
then creates goal from list using the =.. operator, and calls this goal.
finally, instantiates the variable Count to the number of primitive comparison operations.
*/
experiment(Algorithm, List, Count) :-
    init_counter,
    Goal=..[Algorithm, <, List, _],
    call(Goal),
    get_counter(Count).

%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
%Question 3
%++++++++++++++++++++++++++++++++++++++++++++++++++++
% basecase where length L is 0 which makes List empty.
random_list(0, _, []) :-
    !.

/*
Takes in length L, Maximum M, and variable List.
Checks if the length of L>0.
Subtracts 1 of L and instantiates L1 with the result.
Generates integeres through the build in predicate random_between, 
where 1 is the lower bound, and M is the higher bound. 
The result is instantiated to the variable Int.
Use recursion to repeat the process with L1 untill basecase.
*/
random_list(L, M, [Int|List]) :-
    L>0,
    L1 is L-1,
    random_between(1, M, Int),
    random_list(L1, M, List).

%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
%Question 4
%++++++++++++++++++++++++++++++++++++++++++++++++++++
% a)
% basecase where Length = 0.
random_experiment(_, 0, _, 0) :-
    !.

% basecase where MaxElem = 0.
random_experiment(_, _, 0, 0) :-
    !.

% First calls random_list from Q2, then uses the result list to
% call experiment from Q3. Result is instantiated to Count.
random_experiment(Algorithm, Length, MaxElem, Count) :-
    random_list(Length, MaxElem, List),
    experiment(Algorithm, List, Count).

% b)
% Predicate calculates the rounded average of the accumulator and AvgCount.
average(Acc, AvgCount) :-
    sumlist(Acc, Sum),
    length(Acc, Length),
    Length>0,
    AvgCountNotRounded is Sum/Length,
    AvgCount is round(AvgCountNotRounded).

/*
First it checks if N > 0.
Subtracts 1 of N and instantiates N1 with the result.
Calls random_experiment from Q4a and instansiates result to Count.
Adds count to the accumulator and uses recursion untill N = 0.
*/
random_experiments(Algorithm, Length, MaxElem, N, AvgCount, Acc) :-
    N>0,
    N1 is N-1,
    random_experiment(Algorithm, Length, MaxElem, Count),
    random_experiments(Algorithm,
                       Length,
                       MaxElem,
                       N1,
                       AvgCount,
                       [Count|Acc]).

% When N = 0, and above predicate fails, calls average on Acc 
% and instantiates result to AvgCount.
random_experiments(_, _, _, _, AvgCount, Acc) :-
    average(Acc, AvgCount).

% basecase where N = 0. This results in an AvgCount of 0.
random_experiments(_, _, _, 0, 0) :-
    !.

% Predicate calls itselfs but adds an acumulator Acc.
random_experiments(Algorithm, Length, MaxElem, N, Avgcount) :-
    random_experiments(Algorithm,
                       Length,
                       MaxElem,
                       N,
                       Avgcount,
                       _),
    !.


/*
All results measured using time/1.

?- time(random_experiments(bubblesort2, 100, 500, 500, AvgCount)).
% 40,045,028 inferences, 16.323 CPU in 17.608 seconds (93% CPU, 2453247 Lips)
AvgCount = 8802.

On average there are 8862 comparison operations needed to sort a list of 100
random numbers between 1 and 500 using bubblesort2, which took 17.608 seconds.

?- time(random_experiments(quicksort, 100, 500, 500, AvgCount)).
% 3,529,404 inferences, 4.998 CPU in 5.133 seconds (97% CPU, 706105 Lips)
AvgCount = 647.

On average there are 651 comparison operations needed to sort a list of 100
random numbers between 1 and 500 using quicksor, which took 5.133 seconds.
*/
%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
%Question 5
%++++++++++++++++++++++++++++++++++++++++++++++++++++
% Basecase for line
line(0, _).

% Predicate line that loops and prints variable 
% char untill Length is equal to 0 and basecase gets activated.
line(Length, Char) :-
    write(Char),
    LengthN is Length-1,
    line(LengthN, Char).

% Basecase of chart/5.
chart(_, Acc, _, _, Acc) :-
    !.

/*
First checks if the accumulator is less then or equal to the Length of the max
list length.
Then it calls random_experiments/5 to run the experiments.
It then writes the accumulator number and a '>'.
Futhermore, it ads 1 to the accumulator and uses recursion untill Acc > Length.
*/
chart(Algorithm, Length, MaxElem, N, Acc) :-
    Acc=<Length,
    random_experiments(Algorithm, Acc, MaxElem, N, AvgCount),
    write(Acc),
    write(" > "),
    line(AvgCount, "*"),
    nl,
    AccN is Acc+1,
    chart(Algorithm, Length, MaxElem, N, AccN).

chart(_, 0, _, 0) :-
    !.

% Predicate chart ads an accumulator and sets it to 1,
% add 1 to Length, and calls chart/5.
chart(Algorithm, Length, MaxElem, N) :-
    % chart(Algorithm, Length, MaxNum, MaxExperiments)
    LengthN is Length+1,
    chart(Algorithm, LengthN, MaxElem, N, 1).

/*
?- chart(bubblesort, 8, 50, 100).
1 >
2 > *
3 > ****
4 > *********
5 > ***************
6 > **************************
7 > ****************************************
8 > ***********************************************************
true

?- chart(quicksort, 8, 50, 100).
1 >
2 > *
3 > ***
4 > *****
5 > *******
6 > **********
7 > **************
8 > *****************
true
*/

%++++++++++++++++++++++++++++++++++++++++++++++++++++
% Self−check passed!