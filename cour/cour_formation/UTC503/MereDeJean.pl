% fait
epouse(alice,luc).
pere(luc,jean).

% régle
mere(X,E) :- epouse(X,P) , pere(P,E).
