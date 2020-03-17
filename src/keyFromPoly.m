function key = keyFromPoly(Ply,field,n,k)
% KEYFROMPOLY() takes a polynomial over a finite field and
% reads the coefficients (as elements of that field), converting
% the coefficients into a key.
% Polynomials are represented as row vectors of coefficients,
% of the form
% POLY = [ c0 c1 ... cN ], where c_i is an coefficient from the
% finite field of order `field` as specified in the argument.
% -------
% TEST:
%	ply = gf([72 69 76 76 79],16);
%	encPly = rsenc(ply,n,k);
%	keyFromPoly(encPly,16);
%	ans = HELLO

% perform error correction on polynomial:
fieldKey = rsdec(Ply,n,k)

% initialize `key` as empty string:
key = '';

% convert each coefficient into a string and append to key:
for idx=1:(length(fieldKey))
	% convert each coefficient into char and append:
	key = strcat(key,fieldToAscii(fieldKey(idx),field));
end

end