%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
% PSS − Homework assignment 5
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
% no. of hours spent on homework assignment: 5
%++++++++++++++++++++++++++++++++++++++++++++++++++++ 
%Question 1
%++++++++++++++++++++++++++++++++++++++++++++++++++++

% ===== Database with cities and roads in the Netherlands =====
% Cities in the Netherlands with X/Y coordinates.
city(alkmaar/110/81).        
city(almelo/225/110).        
city(amersfoort/135/135).    
city(amsterdam/103/110).     
city(apeldoorn/175/120).     
city(arnhem/171/155).        
city(breda/95/200).          
city(den_bosch/103/175).      
city(den_haag/62/145).       
city(dordrecht/85/175).      
city(eindhoven/142/215).     
city(enschede/241/120).      
city(goes/32/208).           
city(groningen/220/18).      
city(haarlem/85/108).        
city(heerenveen/195/44).     
city(hengelo/235/123).       
city(hoorn/135/80).          
city(leeuwarden/185/18).     
city(maastricht/160/280).    
city(nijmegen/165/175).      
city(rotterdam/95/161).      
city(tilburg/115/202).       
city(utrecht/117/142).       
city(venlo/190/222).         
city(zwolle/205/95).         

% Roads connected with each city
road(alkmaar/haarlem/44).
road(almelo/hengelo/20).
road(amersfoort/amsterdam/49). 
road(amersfoort/apeldoorn/51). 
road(amersfoort/utrecht/23). 
road(amersfoort/zwolle/97).
road(amsterdam/amersfoort/49). 
road(amsterdam/den_haag/65). 
road(amsterdam/haarlem/22). 
road(amsterdam/hoorn/53). 
road(amsterdam/utrecht/42).
road(apeldoorn/amersfoort/51). 
road(apeldoorn/arnhem/42). 
road(apeldoorn/hengelo/72). 
road(apeldoorn/zwolle/47).
road(arnhem/apeldoorn/42). 
road(arnhem/nijmegen/25). 
road(arnhem/utrecht/67).
road(breda/den_bosch/57). 
road(breda/dordrecht/32). 
road(breda/goes/76). 
road(breda/tilburg/24).
road(den_bosch/breda/57). 
road(den_bosch/dordrecht/60). 
road(den_bosch/eindhoven/49). 
road(den_bosch/nijmegen/36). 
road(den_bosch/utrecht/45).
road(den_haag/amsterdam/65). 
road(den_haag/rotterdam/44). 
road(den_haag/utrecht/66).
road(dordrecht/breda/32). 
road(dordrecht/den_bosch/60). 
road(dordrecht/nijmegen/96). 
road(dordrecht/rotterdam/21).
road(eindhoven/den_bosch/49). 
road(eindhoven/maastricht/81). 
road(eindhoven/nijmegen/55). 
road(eindhoven/tilburg/36). 
road(eindhoven/venlo/58).
road(enschede/hengelo/8).
road(goes/breda/76).
road(groningen/heerenveen/43). 
road(groningen/zwolle/94).
road(haarlem/alkmaar/44). 
road(haarlem/amsterdam/22).
road(heerenveen/groningen/43). 
road(heerenveen/hoorn/84). 
road(heerenveen/leeuwarden/33). 
road(heerenveen/zwolle/62).
road(hengelo/almelo/20). 
road(hengelo/apeldoorn/72). 
road(hengelo/enschede/8).
road(hoorn/amsterdam/53). 
road(hoorn/heerenveen/84).
road(leeuwarden/heerenveen/33).
road(maastricht/eindhoven/81). 
road(maastricht/venlo/78).
road(nijmegen/arnhem/25). 
road(nijmegen/den_bosch/36). 
road(nijmegen/dordrecht/96). 
road(nijmegen/eindhoven/55). 
road(nijmegen/venlo/64).
road(rotterdam/den_haag/44). 
road(rotterdam/dordrecht/21). 
road(rotterdam/utrecht/35).
road(tilburg/breda/24). 
road(tilburg/eindhoven/36).
road(utrecht/amersfoort/23). 
road(utrecht/amsterdam/42). 
road(utrecht/arnhem/67). 
road(utrecht/den_bosch/45). 
road(utrecht/den_haag/66). 
road(utrecht/rotterdam/35).
road(venlo/eindhoven/58). 
road(venlo/maastricht/78). 
road(venlo/nijmegen/64).
road(zwolle/amersfoort/97). 
road(zwolle/apeldoorn/47). 
road(zwolle/arnhem/83). 
road(zwolle/groningen/94). 
road(zwolle/heerenveen/62). 
% ===== Database with cities and roads in the Netherlands =====

/*
goal(+State).
Set goal/1 as a dynamic predicate so we can assert and retract
different goals so we can use the program with different target
cities.
*/
:- (dynamic goal/1). 

/*
route(StartCity+, EndCity+, Route-, Distance-).
Initiate goal/1 by first removing the clause in memory, and
then asserting the end destination.

Next, we call estimate/3 to calculate estimated distance(cost)
of start position with the end position.

Futhermore, call the astar predicate to get the most optimal route,
and reverse this at the end to get the correct path.
*/
route(Start, End, Route, Distance) :-
    retractall(goal(_)),
    assert(goal(End)),
    estimate(Start, Estimate),
    astar([[Start]/0/Estimate], RevPath/Distance/_),
    reverse(RevPath, Route).

/*
estimate(+State, -Estimate).
Gets the city coordinates from the database, and
calculates the heuristic function h by using pythagoras theorem.
*/
estimate(Start, Estimate) :-
    goal(End),
    city(Start/X1/Y1),
    city(End/X2/Y2),
    Estimate is sqrt((X1-X2)**2+(Y1-Y2)**2).

/*
move(+State, -NextState, -Cost).
Calls the database for possible roads between cities.
*/
move(State, NextState, Cost) :-
    road(State/NextState/Cost).

% ===== A* Algorithm by B. Afshari (UvA) =====
solve_astar(Node, Path/Cost) :-
    estimate(Node, Estimate),
    astar([[Node]/0/Estimate], RevPath/Cost/_),
    reverse(RevPath, Path).

move_astar([Node|Path]/Cost/_, [NextNode, Node|Path]/NewCost/Est) :-
    move(Node, NextNode, StepCost),
    \+ member(NextNode, Path),
    NewCost is Cost+StepCost,
    estimate(NextNode, Est).

expand_astar(Path, ExpPaths) :-
    findall(NewPath, move_astar(Path, NewPath), ExpPaths).

get_best([Path], Path) :-
    !.

get_best([Path1/Cost1/Est1, _/Cost2/Est2|Paths], BestPath) :-
    Cost1+Est1=<Cost2+Est2,
    !,
    get_best([Path1/Cost1/Est1|Paths], BestPath).

get_best([_|Paths], BestPath) :-
    get_best(Paths, BestPath).

astar(Paths, Path) :-
    get_best(Paths, Path),
    Path=[Node|_]/_/_,
    goal(Node).

astar(Paths, SolutionPath) :-
    get_best(Paths, BestPath),
    select(BestPath, Paths, OtherPaths),
    expand_astar(BestPath, ExpPaths),
    append(OtherPaths, ExpPaths, NewPaths),
    astar(NewPaths, SolutionPath).
% ===== A* Algorithm by B. Afshari (UvA) =====

/*
Answers

?- route(breda, haarlem, Route, Distance).
Route = [breda, dordrecht, rotterdam, utrecht, amsterdam, haarlem],
Distance = 152 ;
Route = [breda, den_bosch, utrecht, amsterdam, haarlem],
Distance = 166 ;
Route = [breda, dordrecht, rotterdam, utrecht, amersfoort, amsterdam, haarlem],
Distance = 182.

?- route(amsterdam, groningen, Route, Distance).
Route = [amsterdam, hoorn, heerenveen, groningen],
Distance = 180 ;
Route = [amsterdam, amersfoort, zwolle, groningen],
Distance = 240 ;
Route = [amsterdam, amersfoort, apeldoorn, zwolle, groningen],
Distance = 241 .
*/

%++++++++++++++++++++++++++++++++++++++++++++++++++++
% Self−check passed!