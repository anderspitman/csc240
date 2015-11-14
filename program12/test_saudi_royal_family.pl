:- begin_tests(saudi_royal_family).
:- consult(saudi_royal_family).

% Share father only
test(siblingOf) :-
    siblingOf(khalid, fahd), !.
% Share father and mother
test(siblingOf) :-
    siblingOf(salman, fahd), !.
% Parent should fail
test(siblingOf, fail) :-
    siblingOf(khalid, abdulaziz), !.
test(siblingOf, fail) :-
    siblingOf(khalid, al_jawhara), !.


% Share father only
test(brotherOf) :-
    brotherOf(khalid, fahd), !.
% Share father and mother
test(brotherOf) :-
    brotherOf(salman, fahd), !.
test(brotherOf, fail) :-
    brotherOf(khalid, abdulaziz), !.
test(brotherOf, fail) :-
    brotherOf(khalid, al_jawhara), !.

test(uncleOf) :-
    uncleOf(saud, abdulaziz), !.
test(uncleOf, fail) :-
    uncleOf(abdul_rahman, abdulaziz), !.

test(bornDuringLifeOf) :-
    bornDuringLifeOf(abdulaziz, abdul_rahman), !.
test(bornDuringLifeOf, fail) :-
    bornDuringLifeOf(salman, abdul_rahman), !.

test(contemporaryOf) :-
    contemporaryOf(abdulaziz, salman), !.
test(contemporaryOf) :-
    contemporaryOf(abdul_rahman, abdullah), !.
test(contemporaryOf, fail) :-
    contemporaryOf(abdul_rahman, salman), !.

test(successorOf) :-
    successorOf(faisal, turki), !.
test(successorOf) :-
    successorOf(saud_bin_abdulaziz, abdulaziz), !.
test(successorOf, fail) :-
    successorOf(faisal_bin_abdulaziz, abdulaziz), !.

:- end_tests(saudi_royal_family).
