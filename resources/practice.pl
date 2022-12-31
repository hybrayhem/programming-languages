write('Hello, world!'), nl. % Hello, world!
write('This is Prolog'). % This is prolog

% Fact: predicate(atom, atom)
loves(romeo, juliet). % true.

loves(juliet, romeo) :- loves(romeo, juliet). % true.

% loves(romeo, X). % X = juliet.

male(albert).
male(bob).
male(bill).

female(alice).
female(leia).

listing(male). % lists all male predicates

male(X), female(Y). 
% X = albert, Y = alice ;
% X = albert, Y = leia ;
% X = bob, Y = alice ;
% ...


happy(albert).
happy(alice).
with_albert(alice).

runs(albert) :- happy(albert).
dances(alice) :- happy(alice), with_albert(alice).
does_alice_dance :- dances(alice), 
    write('When Alice is happy and with Albert she dances').

swims(bill) :- happy(bill), near_water(bill), 
    write('Bill is happy and near water, so he swims').

