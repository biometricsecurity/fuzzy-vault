function character = fieldToAscii(elt,field)
% FIELDTOASCII() takes an element `elt` of a
% finite field GF(2^`field`) and converts it
% into an ASCII character.
%

character = char(mod(elt.x,127));

end