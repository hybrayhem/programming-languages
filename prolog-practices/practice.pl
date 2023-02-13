%
%%% BASICS %%%
%
% write('Hello, world!'), nl, write('This is Prolog'). % This is prolog

% Fact: predicate(atom, atom)
loves(romeo, juliet). % true.

loves(juliet, romeo) :- loves(romeo, juliet). % true.

who_romeo_loves :- loves(romeo, X). % X = juliet.

male(albert).
male(bob).
male(bill).

female(alice).
female(leia).

listing(male). % lists all male predicates

% male(X), female(Y). 
% X = albert, Y = alice ;
% X = albert, Y = leia ;
% X = bob, Y = alice ;
% ...

parent(albert, alice).
parent(albert, bob).

parent(alice, bill). % granbchild
parent(bob, bill).
parent(bill, leia). % grand grandchild

get_grandchild(X) :- 
    parent(X, Y), 
    parent(Y, Z), 
    write(Z), write(' is the grandchild of '), write(X), nl,
    format('~w is the grandparent ~n', [X]).
% bill is the grandchild of albert
% albert is the grandparent 
% true ;
% bill is the grandchild of albert
% albert is the grandparent 
% true ;
% leia is the grandchild of albert
% albert is the grandparent 
% true.

% Recursion
related(X, Y) :- 
    (parent(X, Z),
    related(Z, Y),
    format('~w is related to ~w~n', [X, Y]))
    |
    format('~w is not related to ~w~n', [X, Y]).


happy(albert).
happy(alice).
with_albert(alice).

runs(albert) :- happy(albert).
dances(alice) :- happy(alice), with_albert(alice).
does_alice_dance :- dances(alice), 
    write('When Alice is happy and with Albert she dances').

swims(bill) :- 
    (happy(bill), 
    near_water(bill), 
    write('Bill is happy and near water, so he swims')) 
    | 
    write('Bill not swims.').
 

what_age(5) :- write('Go to kindergarten.').
what_age(6) :- write('Go to grade 1.').
what_age(Other) :- 
    Grade is Other - 5, 
    format('Go to grade ~w.~n', [Grade]).

owns(albert, pet(cat, garfield)).
owns(albert, pet(dog, ligtning)).
get_pets(X) :- 
    owns(X, pet(Type, Name)),
    format('~w owns a ~w named ~w.~n', [X, Type, Name]).

vertical(line(point(X, Y1), point(X, Y2))).
horizontal(line(point(X1, Y), point(X2, Y))).


% betsy = betsy. % yes
% 'betsy' = betsy. % yes
% \+ (betsy = charlie). % yes (not equal)
% 3 > 5. % no
% 4 =< 17. % yes

% variable assingment
% A = alice.

% rich(money, X) = rich(Y, no_debt).
% X = no_debt
% Y = money

% X is 2+2. % X = 4
% X is mod(7, 2).

double_num(X, Y) :- Y is X*2.
is_even(X) :- 0 is mod(X, 2).

random(0, 20, X).
succ(2, X).
% X is abs(-8).
% X is max(3,7).
% X is min(3,7).
% X is round(5.12).
% X is truncate(5.12).
% X is floor(5.12).
% X is ceiling(5.12).
% X is 2** 3.


%
%%% IO %%%
%
% write('Hello').
% writeq('Hello'), nl.
greeting :- 
    write('What is your name? '),
    read(Name),
    format('Hi ~w.~n', [Name]).

write_to_file(Filename, Text) :-
    open(Filename, write, Stream),
    write(Stream, Text), nl,
    close(Stream).

read_file(Filename) :-
    open(Filename, read, Stream),
    get_char(Stream, Char),
    process_stream(Char, Stream),
    close(Stream).

process_stream(end_of_file, _) :- !.

process_stream(Char, Stream) :- 
    write(Char),
    get_char(Stream, CharNext),
    process_stream(CharNext, Stream).

%
%%% LOOP %%%
%
count_X_to_Y(Current, End) :-
    write(Current), nl,
    Next is Current + 1,
    (Current \= End), % stop condition
    count_X_to_Y(Next, End).

count_to_X(X) :- count_X_to_Y(1, X).

countdown(Low, High) :-
    between(Low, High, Value),
    Count is Low + High - Value,
    write(Count), nl.

%
%%% CHANGE DATABASE %%%
%
:- dynamic(father/2).
:- dynamic(saber/2).
:- dynamic(friend/2).
:- dynamic(stabs/3).

father(anakin, luke).
father(luke, ben).

saber(anakin, purple).
saber(vader, red).
saber(revan, red).
saber(revan, purple).
saber(luke, blue).
saber(din, dark).

friend(din, grogu).
friend(han, r2d2).

stabs(obi, anakin, saber).
stabs(vader, luke, saber).

% Operations
assert(friend(luke, obi)). % new friendship
% asserta(friend(luke, yoda)). % new friendship
% retract(saber(revan, red)). % remove saber
% retractall(father(_,_)). % remove all fathers

%
%%% LIST & STRING %%%
%
% length([1,2,3], X). % X = 3

% [Head|Tail] = [a, b, c]. 
% Head = a
% Tail = [b,c]

% List = [a, b, c].
member(a, List). % yes
member(X, List). % X = a ; X = b ; X = c

reverse(List, ReversedList).
append(List, [1,2,3]).

name('A string', X). % returns X = [65, 32, 115, 116, 114, 105, 110, 103].
% join_str(Str1, Str2, Result) :- % not working
%     name(Str1, ChList1),
%     name(Str2, ChList2),
%     append(ChList1, ChList2, ChResult),
%     name(Result, ChResult).

%
%%% MAIN %%%
%
main :- 
        does_alice_dance, nl, 
        swims(bill), nl, 
        get_grandchild(albert), nl,
        what_age(5), nl,
        what_age(12), nl,
        get_pets(albert), nl,
        related(albert, leia), nl, % grand granchild
        write_to_file('dict.txt', 'cow: inek, cat: kedi, dog: kopek'), nl,
        read_file('dict.txt'), nl,
        greeting, nl.
        % halt.
