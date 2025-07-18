% fait
aime(adam,pommes).
aime(clara,carrote).
aime(olivier,orange).
fruit(pommes).
fruit(orange).
legumes(carrote).

% régle : ceux qui aiment les fruits sont en bonne santée
enBonneSante(X) :- aime(X,F), fruit(F).

