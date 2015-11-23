% Anders Pitman - Program 13 - Expert System for Identifying Classical
% Instruments


instrument_classifier :-
    intro,
    write('Answer all questions y for yes or n for no.'), nl,
    clear_stored_answers,
    try_all_possibilities.

try_all_possibilities :-
    may_be(D),
    explain(D),
    fail.

try_all_possibilities.

:- dynamic(stored_answer/2).

clear_stored_answers :- retract(stored_answer(_, _)), fail.
clear_stored_answers.

user_says(Q, A) :- stored_answer(Q, A).

user_says(Q, A) :-
    \+ stored_answer(Q, _),
    nl, nl,
    ask_question(Q),
    get_yes_or_no(Response),
    asserta(stored_answer(Q, Response)),
    Response = A.

get_yes_or_no(Result) :-
    get(Char),
    get0(_),
    interpret(Char, Result),
    !.

get_yes_or_no(Result) :-
    nl,
    write('Type y or n'),
    get_yes_or_no(Result).

interpret(89, yes).
interpret(121, yes).
interpret(78, no).
interpret(110, no).

intro :-
    write('This program identifies classical musical instruments'), nl.

% possibiliies
may_be(violin) :-
    user_says(has_strings, yes),
    user_says(has_frets, no),
    user_says(has_4_strings, yes).

may_be(piano) :-
    user_says(has_strings, yes),
    user_says(has_frets, no),
    user_says(has_4_strings, no).

may_be(electric_guitar) :-
    user_says(has_strings, yes),
    user_says(has_frets, yes),
    user_says(has_6_strings, yes),
    user_says(is_electric, yes).

may_be(acoustic_guitar) :-
    user_says(has_strings, yes),
    user_says(has_frets, yes),
    user_says(has_6_strings, yes),
    user_says(is_electric, no).

may_be(mandolin) :-
    user_says(has_strings, yes),
    user_says(has_frets, yes),
    user_says(has_6_strings, no),
    user_says(has_8_strings, yes).

may_be(ukulele) :-
    user_says(has_strings, yes),
    user_says(has_frets, yes),
    user_says(has_6_strings, no),
    user_says(has_8_strings, no).

may_be(trumpet) :-
    user_says(has_strings, no),
    user_says(is_brass, yes).

may_be(clarinet) :-
    user_says(has_strings, no),
    user_says(is_brass, no).


% Text of the questions

ask_question(has_strings) :-
    write('Does it have strings?'), nl.

ask_question(has_frets) :-
    write('Does it have frets?'), nl.

ask_question(has_4_strings) :-
    write('Does it have 4 strings?'), nl.

ask_question(has_6_strings) :-
    write('Does it have 6 strings?'), nl.

ask_question(has_8_strings) :-
    write('Does it have 8 strings?'), nl.

ask_question(is_electric) :-
    write('Is it electric?'), nl.

ask_question(is_brass) :-
    write('Is it brass?'), nl.


% Explanations

explain(violin) :- nl,
    write('It is a violin.'), nl.

explain(piano) :- nl,
    write('It is a piano.'), nl.

explain(electric_guitar) :- nl,
    write('It is an electric guitar.'), nl.

explain(acoustic_guitar) :- nl,
    write('It is an acoustic guitar.'), nl.

explain(mandolin) :- nl,
    write('It is a mandolin.'), nl.

explain(ukulele) :- nl,
    write('It is a ukulele.'), nl.

explain(trumpet) :- nl,
    write('It is a trumpet.'), nl.

explain(clarinet) :- nl,
    write('It is a clarinet.'), nl.
