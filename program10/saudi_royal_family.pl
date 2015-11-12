% Anders Pitman - Program 10 - Family Tree for Saudi Arabian Royal Family

% male( <name> ).
male( turki_bin_abdullah_bin_muhammad ).
male( faisal_bin_turki ).
male( abdul_rahman_bin_faisal_al_saud ).
male( saud_bin_faisal ).
male( abdulaziz_ibn_abdul_rahman ).
male( saud_bin_abdulaziz_al_saud ).
male( faisal_bin_abdulaziz_al_saud ).
male( khalid_bin_adbulaziz_al_saud ).
male( fahd_bin_abdulaziz_al_saud ).
male( abdullah_bin_abdulaziz_al_saud ).
male( salman_bin_abdulaziz_al_saud ).

% female( <name> ).
female( wadhah_bint_muhammad_bin_aqab ).
female( tarfa_bint_abdullah_bin_abdulateef_al_sheikh ).
female( al_jawhara_bint_musaed_al_jiluwi ).
female( hassa_bint_ahmed_al_sudairi ).
female( fahda_bint_asi_al_shuraim ).

% lifespan( <name>, <birth year>, <death year>).
lifespan( wadhah_bint_muhammad_bin_aqab, unknown, unknown).
lifespan( tarfa_bint_abdullah_bin_abdulateef_al_sheikh, unknown, unknown).
lifespan( turki_bin_abdullah_bin_muhammad, 1755, 1834 ).
lifespan( faisal_bin_turki, 1785, 1865 ).
lifespan( saud_bin_faisal, unknown, 1875 ).
lifespan( abdul_rahman_bin_faisal_al_saud, 1845, 1928 ).
lifespan( abdulaziz_ibn_abdul_rahman, 1875, 1953 ).
lifespan( saud_bin_abdulaziz_al_saud, 1902, 1969 ).
lifespan( faisal_bin_abdulaziz_al_saud, 1906, 1975 ).
lifespan( khalid_bin_adbulaziz_al_saud, 1913, 1982 ).
lifespan( fahd_bin_abdulaziz_al_saud, 1921, 2005 ).
lifespan( abdullah_bin_abdulaziz_al_saud, 1924, 2015 ).
lifespan( salman_bin_abdulaziz_al_saud, 1935, unknown).
lifespan( al_jawhara_bint_musaed_al_jiluwi, unknown, 1919 ).
lifespan( hassa_bint_ahmed_al_sudairi, 1900, 1969 ).
lifespan( fahda_bint_asi_al_shuraim, unknown, 1930 ).

% parentOf( <name>, <child name>).
parentOf( turki_bin_abdullah_bin_muhammad, faisal_bin_turki ).
parentOf( faisal_bin_turki, abdul_rahman_bin_faisal_al_saud).
parentOf( faisal_bin_turki, saud_bin_faisal ).
parentOf( abdul_rahman_bin_faisal_al_saud, abdulaziz_ibn_abdul_rahman).
parentOf( abdulaziz_ibn_abdul_rahman, saud_bin_abdulaziz_al_saud ).
parentOf( wadhah_bint_muhammad_bin_aqab, saud_bin_abdulaziz_al_saud ).
parentOf( tarfa_bint_abdullah_bin_abdulateef_al_sheikh,
          faisal_bin_abdulaziz_al_saud).
parentOf( al_jawhara_bint_musaed_al_jiluwi, khalid_bin_adbulaziz_al_saud).
parentOf( hassa_bint_ahmed_al_sudairi, fahd_bin_abdulaziz_al_saud).
parentOf( fahda_bint_asi_al_shuraim, abdullah_bin_abdulaziz_al_saud).
parentOf( hassa_bint_ahmed_al_sudairi, salman_bin_abdulaziz_al_saud).

% rulerOf( <name>, <country>, <year began>, <year ended> ).
rulerOf( turki_bin_abdullah_bin_muhammad, second_saudi_state, 1818, 1834 ).
rulerOf( faisal_bin_turki, second_saudi_state, 1834, 1838 ).
rulerOf( faisal_bin_turki, second_saudi_state, 1843, 1865 ).
rulerOf( saud_bin_faisal, second_saudi_state, 1871, 1871 ).
rulerOf( saud_bin_faisal, second_saudi_state, 1873, 1875 ).
rulerOf( abdul_rahman_bin_faisal_al_saud, second_saudi_state, 1875, 1876 ).
rulerOf( abdul_rahman_bin_faisal_al_saud, second_saudi_state, 1889, 1891 ).
rulerOf( abdulaziz_ibn_abdul_rahman, saudi_arabia, 1953, 1964 ).
rulerOf( faisal_bin_abdulaziz_al_saud, saudi_arabia, 1964, 1975 ).
rulerOf( khalid_bin_adbulaziz_al_saud, saudi_arabia, 1975, 1982 ).
rulerOf( fahd_bin_abdulaziz_al_saud, saudi_arabia, 1982, 2005 ).
rulerOf( abdullah_bin_abdulaziz_al_saud, saudi_arabia, 2005, 2015 ).
rulerOf( salman_bin_abdulaziz_al_saud, saudi_arabia, 2015, current ).
