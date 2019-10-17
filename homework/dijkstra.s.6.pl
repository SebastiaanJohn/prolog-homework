%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
% PSS − Homework assignment 6
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
% no. of hours spent on homework assignment: 4
%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
%Question 1
%++++++++++++++++++++++++++++++++++++++++++++++++++++
% Given the name of one player, return the name of the other player.
other(max, min). 
other(min, max). 

% Given the name of a player, return the value associated 
% with the terminal states where that player is winning.
value(max, 1). 
value(min, -1).

% Lower/2 in ascending order.
lower(X, N) :-
    N1 is N-1,
    between(0, N1, X).

% Lower/2 in descending order.
lower_descending(X, N) :-
    N1 is N-1,
    between(0, N1, X1),
    X is N-X1-1.

% initial/1 sets Heaps size and player to max.
initial((Heaps, max)) :-
    Heaps=[3, 5, 7].
/*
move/2 takes in the board(Heaps) and the Player.
It checks if there are matches in the heap and
uses append/3 to update the matches that got taking out in
HeapsNew.
*/
move((Heaps, Player),  (HeapsNew, OtherPlayer)) :-
    append(HeapsLeft, [Matches|HeapsRight], Heaps),
    Matches>0,
    lower(MatchesRemaining, Matches),
    append(HeapsLeft, [MatchesRemaining|HeapsRight], HeapsNew),
    other(Player, OtherPlayer). 

/*
terminal/2 takes in the current Heaps, and checks by using
sumlist if the value is equal to zero. If it is, the Player
won and assigns a value to them.
*/
terminal((Heaps, Player), Value) :-
    sumlist(Heaps, 0),
    value(Player, Value).

% ===== Minimax / Alpha-Beta =====
moves(State, NextStates) :-
    findall(NextState, move(State, NextState), NextStates).

round(X, A, _, A) :-
    X<A,
    !.
round(X, _, B, B) :-
    X>B,
    !.
round(X, _, _, X).
  
choose(Condition, X, _, X) :-
    call(Condition),
    !.
  
choose(_, _, Y, Y).

eval(_, Value, Value, Value) :-
    !.
  
eval(State, Alpha, Beta, RoundedValue) :-
    terminal(State, Value),
    !,
    round(Value, Alpha, Beta, RoundedValue).

eval((Board, max), Alpha, Beta, Value) :-
    moves((Board, max), NextStates),
    maxeval(NextStates, Alpha, Beta, _, Value).

eval((Board, min), Alpha, Beta, Value) :-
    moves((Board, min), NextStates),
    mineval(NextStates, Alpha, Beta, _, Value).
  
maxeval([State], Alpha, Beta, State, Value) :-
    !,
    eval(State, Alpha, Beta, Value).
  
maxeval([State1|States], Alpha, Beta, MaxState, MaxValue) :-
    eval(State1, Alpha, Beta, Value1),
    maxeval(States, Value1, Beta, State, Value),
    choose(Value>Value1,
           (State, Value),
           (State1, Value1),
           (MaxState, MaxValue)).
  
mineval([State], Alpha, Beta, State, Value) :-
    !,
    eval(State, Alpha, Beta, Value).
  
mineval([State1|States], Alpha, Beta, MinState, MinValue) :-
    eval(State1, Alpha, Beta, Value1),
    mineval(States, Alpha, Value1, State, Value),
    choose(Value<Value1,
           (State, Value),
           (State1, Value1),
           (MinState, MinValue)).
   
alphabeta((Board, max), MaxState) :-
    moves((Board, max), NextStates),
    maxeval(NextStates, -1, 1, MaxState, _).
  
alphabeta((Board, min), MinState) :-
    moves((Board, min), NextStates),
    mineval(NextStates, -1, 1, MinState, _).
% ===== Minimax / Alpha-Beta =====

/*
?- initial(State), time(alphabeta(State, NextState)).
% 3,683,247 inferences, 1.096 CPU in 1.162 seconds (94% CPU, 3359462 Lips)
State =  ([3, 5, 7], max),
NextState =  ([2, 5, 7], min) .

?- initial(State), time(alphabeta(State, NextState)).
% 60,306,848 inferences, 24.250 CPU in 25.119 seconds (97% CPU, 2486930 Lips)
State =  ([3, 5, 7], max),
NextState =  ([2, 5, 7], min) .

The ascending order is way faster (1,58 sec vs 25,12 sec),
because it's only taking away one match, and with descending it starts checking at
X = 4, instead of X = 0.
*/

%++++++++++++++++++++++++++++++++++++++++++++++++++++
% Self−check passed!