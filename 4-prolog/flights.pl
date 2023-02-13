%
%%% knowledge base %%%
%
% schedule: a route between X and Y with cost C
schedule(canakkale, erzincan, 6).
schedule(erzincan, antalya, 3).
schedule(antalya, izmir, 2).
schedule(antalya, diyarbakir, 4).
schedule(izmir, istanbul, 2). % fact: Istanbul and Izmir has a flight with cost 2 
schedule(izmir, ankara, 6).
schedule(diyarbakir, ankara, 8).
schedule(istanbul, ankara, 1).
schedule(istanbul, rize, 4).
schedule(ankara, rize, 5).
schedule(ankara, van, 4).
schedule(ankara, kayseri, 2).
schedule(kayseri, antalya, 4).
schedule(van, gaziantep, 3).

%
%%% rules %%%
%
connection(X, Y, C) :- 
    schedule(X, Y, C) 
    | 
    schedule(Y, X, C).

write_connections(City) :- % write all connections of city
    connection(City, X, C),
    format('From ~w, there is a route to ~w with cost ~w.~n', [City, X, C]),
    fail. % fail to backtrack all solutions

% after backtrack ends, return true
query(City) :-
    write_connections(City) | true.

%
%%% main %%%
%
main :- 
    write('Flight Graph'), nl,

    query(canakkale), nl,
    % X = erzincan,
    % C = 6 ;

    query(istanbul), nl,
    % X = ankara,
    % C = 1 ;
    % X = rize,
    % C = 4 ;
    % X = izmir,
    % C = 2.

    query(kayseri), nl.
    % X = antalya,
    % C = 4 ;
    % X = ankara,
    % C = 2.
