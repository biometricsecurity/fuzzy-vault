function sorted = sortrowsGF(mtrx,field)
% SORTROWSGF() takes a galois field array over
% a galois field GF(2^field) and sorts the rows
% by their integer representation.
% Returns the sorted matrix.

sorted = gf(sortrows(mtrx.x),field);

end