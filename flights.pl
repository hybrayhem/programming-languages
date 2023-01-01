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

%
%%% main %%%
%
main :- 
    write('Flight Graph'), nl,

    connection(canakkale, X, C).
    % X = erzincan,
    % C = 6 ;

    connection(istanbul, X, C).
    % X = ankara,
    % C = 1 ;
    % X = rize,
    % C = 4 ;
    % X = izmir,
    % C = 2.

    connection(kayseri, X, C).
    % X = antalya,
    % C = 4 ;
    % X = ankara,
    % C = 2.
