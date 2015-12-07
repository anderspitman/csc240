% Anders Pitman - Program 14 - Quest to find cellphone

start_state(bedroom).

next_state(bedroom, a, bedroom).
next_state(bedroom, b, hallway).

next_state(hallway, a, bedroom).
next_state(hallway, b, bathroom).
next_state(hallway, c, kitchen).
next_state(hallway, d, living_room).

next_state(bathroom, a, bathroom).
next_state(bathroom, b, bathroom).
next_state(bathroom, c, hallway).

next_state(kitchen, a, kitchen).
next_state(kitchen, b, kitchen).
next_state(kitchen, c, hallway).

next_state(living_room, a, found_phone).
next_state(living_room, b, living_room).
next_state(living_room, c, hallway).

display_intro :-
    nl,
    write('You misplaced your cellphone.'), nl,
    write('You are pretty sure it is somewhere in the house.'), nl,
    write('Find it!'), nl, nl.

initialize :-
    asserta(stored_answer(moves, 0)),
    asserta(stored_answer(cellphone, no)),
    asserta(stored_answer(cellphone_under_couch, yes)),
    asserta(stored_answer(cellphone_ringing, no)).

goodbye :-
    stored_answer(moves, Count),
    write('You made this many moves...'),
    write(Count), nl.

show_state_with_quit(State) :-
    show_state(State),
    write('(q) quit'), nl, nl.


show_state(bedroom) :-
    write('You are in the bedroom'), nl,
    write('There is a nightstand and a door leading to the hallway'), nl,
    write('Do you want to...'), nl,
    write('(a) Look on the nightstand'), nl,
    write('(b) Go to the hallway'), nl.

show_state(hallway) :-
    write('You are in the hallway'), nl,
    write('Not much going on here...'), nl,
    write('Do you want to...'), nl,
    write('(a) Go into the bedroom'), nl,
    write('(b) Go into the bathroom'), nl,
    write('(c) Go into the kitchen'), nl,
    write('(d) Go into the living room'), nl.

show_state(bathroom) :-
    write('You are in the bathroom'), nl,
    write('There is a toilet and sink'), nl,
    write('Do you want to...'), nl,
    write('(a) Look under the sink'), nl,
    write('(b) Check beside toilet'), nl,
    write('(c) Go into hallway'), nl.

show_state(kitchen) :-
    write('You are in the kitchen'), nl,
    write('There is a fridge and a house phone on the counter'), nl,
    write('Do you want to...'), nl,
    write('(a) Look in the fridge'), nl,
    write('(b) Use the house phone to call your cell'), nl,
    write('(c) Go into hallway'), nl.

show_state(living_room) :-
    write('You are in the living room'), nl,
    living_room_maybe_ring,
    write('There is a couch and an entertainment center'), nl,
    write('Do you want to...'), nl,
    write('(a) Look under the couch'), nl,
    write('(b) Look on the entertainment center'), nl,
    write('(c) Go into hallway'), nl.

show_state(found_phone).

living_room_maybe_ring :-
    stored_answer(cellphone_ringing, yes),
    write('You hear ringing coming from the couch'), nl.

living_room_maybe_ring :-
    stored_answer(cellphone_ringing, no).

room_change_transition(FromRoom, ToRoom) :-
    nl,
    write('Going from '),
    write(FromRoom),
    write(' '),
    write('to '),
    write(ToRoom), nl, nl.

% Transitions from bedroom
show_transition(bedroom, a) :-
    nl,
    write('No cellphone on the nightstand'), nl, nl.

show_transition(bedroom, b) :-
    room_change_transition('bedroom', 'hallway').

% Transitions from hallway
show_transition(hallway, a) :-
    room_change_transition('hallway', 'bedroom').

show_transition(hallway, b) :-
    room_change_transition('hallway', 'bathroom').

show_transition(hallway, c) :-
    room_change_transition('hallway', 'kitchen').

show_transition(hallway, d) :-
    room_change_transition('hallway', 'living room').

% Transitions from bathroom
show_transition(bathroom, a) :-
    nl,
    write('Just bathroom stuff under the sink'), nl, nl.

show_transition(bathroom, b) :-
    nl,
    write('Nothing next to the toilet'), nl, nl.

show_transition(bathroom, c) :-
    room_change_transition('bathroom', 'hallway').

% Transitions from kitchen
show_transition(kitchen, a) :-
    nl,
    write('Just food in the fridge'), nl, nl.

show_transition(kitchen, b) :-
    nl,
    write('You hear ringing in the living room!'), nl, nl,
    retract(stored_answer(cellphone_ringing, no)),
    asserta(stored_answer(cellphone_ringing, yes)).

show_transition(kitchen, c) :-
    room_change_transition('kitchen', 'hallway').

% Transitions from living room
show_transition(living_room, a) :-
    nl,
    write('You found your cellphone under the couch!'), nl, nl.

show_transition(living_room, b) :-
    nl,
    write('No phone on the entertainment center'), nl, nl.

show_transition(living_room, c) :-
    nl,
    write('Going from living room to hallway'), nl, nl.

go_to_next_state(_, q) :-
    goodbye, !.

go_to_next_state(S1, Cin) :-
    next_state(S1, Cin, S2),
    show_transition(S1, Cin),
    show_state_with_quit(S2),
    stored_answer(moves, K),
    OneMoreMove is K + 1,
    retract(stored_answer(moves, _)),
    asserta(stored_answer(moves, OneMoreMove)),
    get_choice(S2, Cnew),
    go_to_next_state(S2, Cnew).

go_to_next_state(S1, Cin) :-
    \+ next_state(S1, Cin, _),
    show_transition(S1, fail),
    get_choice(S1, Cnew),
    go_to_next_state(S1, Cnew).


get_choice(found_phone, q).

get_choice(_, C) :-
    write('Next entry (letter followed by a period)? '),
    read(C).

go :-
    intro,
    start_state(X),
    show_state_with_quit(X),
    get_choice(X, Y),
    go_to_next_state(X, Y).

intro :-
    display_intro,
    clear_stored_answers,
    initialize.

:- dynamic(stored_answer/2).

clear_stored_answers :-
    retract(stored_answer(_, _)), fail.
clear_stored_answers.

:- go.
