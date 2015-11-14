% Anders Pitman - Program 10 - Family Tree for Saudi Arabian Royal Family

% male( <name> ).
male(turki ).
male(faisal ).
male(abdul_rahman ).
male(saud ).
male(abdulaziz ).
male(saud_bin_abdulaziz ).
male(faisal_bin_abdulaziz ).
male(khalid ).
male(fahd ).
male(abdullah ).
male(salman ).

% female( <name> ).
female(wadhah ).
female(tarfa ).
female(al_jawhara ).
female(hassa ).
female(fahda ).

% lifespan( <name>, <birth year>, <death year>).
lifespan(wadhah, unknown, unknown).
lifespan(tarfa, unknown, unknown).
lifespan(turki, 1755, 1834 ).
lifespan(faisal, 1785, 1865 ).
lifespan(saud, unknown, 1875 ).
lifespan(abdul_rahman, 1845, 1928 ).
lifespan(abdulaziz, 1875, 1953 ).
lifespan(saud_bin_abdulaziz, 1902, 1969 ).
lifespan(faisal_bin_abdulaziz, 1906, 1975 ).
lifespan(khalid, 1913, 1982 ).
lifespan(fahd, 1921, 2005 ).
lifespan(abdullah, 1924, 2015 ).
lifespan(salman, 1935, unknown).
lifespan(al_jawhara, unknown, 1919 ).
lifespan(hassa, 1900, 1969 ).
lifespan(fahda, unknown, 1930 ).

% parentOf( <name>, <child name>).
parentOf(turki, faisal ).
parentOf(faisal, abdul_rahman).
parentOf(faisal, saud ).
parentOf(abdul_rahman, abdulaziz).
parentOf(abdulaziz, saud_bin_abdulaziz ).
parentOf(abdulaziz, faisal_bin_abdulaziz).
parentOf(abdulaziz, khalid).
parentOf(abdulaziz, fahd).
parentOf(abdulaziz, abdullah).
parentOf(abdulaziz, salman).
parentOf(wadhah, saud_bin_abdulaziz ).
parentOf(tarfa, faisal_bin_abdulaziz).
parentOf(al_jawhara, khalid).
parentOf(hassa, fahd).
parentOf(fahda, abdullah).
parentOf(hassa, salman).

% rulerOf( <name>, <country>, <year began>, <year ended> ).
rulerOf(turki, second_saudi_state, 1818, 1834 ).
rulerOf(faisal, second_saudi_state, 1834, 1838 ).
rulerOf(faisal, second_saudi_state, 1843, 1865 ).
rulerOf(saud, second_saudi_state, 1871, 1871 ).
rulerOf(saud, second_saudi_state, 1873, 1875 ).
rulerOf(abdul_rahman, second_saudi_state, 1875, 1876 ).
rulerOf(abdul_rahman, second_saudi_state, 1889, 1891 ).
rulerOf(abdulaziz, saudi_arabia, 1932, 1953 ).
rulerOf(saud_bin_abdulaziz, saudi_arabia, 1953, 1964 ).
rulerOf(faisal_bin_abdulaziz, saudi_arabia, 1964, 1975 ).
rulerOf(khalid, saudi_arabia, 1975, 1982 ).
rulerOf(fahd, saudi_arabia, 1982, 2005 ).
rulerOf(abdullah, saudi_arabia, 2005, 2015 ).
rulerOf(salman, saudi_arabia, 2015, current ).

motherOf(Mother, Child)
    :- female(Mother),
       parentOf(Mother, Child).

fatherOf(Father, Child)
    :- male(Father),
       parentOf(Father, Child).

sonOf(Son, Parent)
    :- male(Son),
       parentOf(Parent, Son).

daughterOf(Daughter, Parent)
    :- female(Daughter),
       parentOf(Parent, Daughter).

% For the sibling definitions below, I chose to include half siblings since
% the kings often have children from multiple wives.

siblingOf(Person, Sibling)
    :- (motherOf(Mother, Person), motherOf(Mother, Sibling);
        fatherOf(Father, Person), fatherOf(Father, Sibling)),
        Person \= Sibling.

brotherOf(Brother, Sibling)
    :- male(Brother),
       siblingOf(Brother, Sibling).

sisterOf(Sister, Sibling)
    :- female(Sister),
       siblingOf(Sister, Sibling).

auntOf(Aunt, Person)
    :- female(Aunt),
       parentOf(Parent, Person),
       siblingOf(Aunt, Parent).

uncleOf(Uncle, Person)
    :- male(Uncle),
       parentOf(Parent, Person),
       siblingOf(Uncle, Parent).
       
grandparentOf(Grandparent, Grandchild)
    :- parentOf(Parent, Grandchild),
       parentOf(Grandparent, Parent).

ancestorOf(Ancestor, Descendent)
    :- parentOf(Ancestor, Descendent);
       (motherOf(Mother, Descendent),
        ancestorOf(Ancestor, Mother));
       (fatherOf(Father, Descendent),
        ancestorOf(Ancestor, Father)).

descenentOf(Descendent, Ancestor)
    :- ancestorOf(Ancestor, Descendent).

bornDuringLifeOf(Person, Other) :-
    lifespan(Person, BirthYear, _),
    integer(BirthYear),
    lifespan(Other, OtherBirthYear, OtherDeathYear),
    integer(OtherBirthYear),
    integer(OtherDeathYear),
    BirthYear >= OtherBirthYear,
    BirthYear =< OtherDeathYear.

contemporaryOf(Contemporary, Person) :-
    bornDuringLifeOf(Contemporary, Person);
    bornDuringLifeOf(Person, Contemporary).

successorOf(Successor, Person) :-
    rulerOf(Successor, Country, SuccessorBeganYear, _),
    integer(SuccessorBeganYear),
    rulerOf(Person, Country, _, PersonEndYear),
    integer(PersonEndYear),
    SuccessorBeganYear == PersonEndYear.
