function set = excludeSet(bigSet,littleSet,field)
% EXCLUDESET() takes two arrays `bigSet` and `littleSet` over
% GF(2^field) of dimensions Mx2 and Nx2, respectively (where N < M)
% and removes every row appearing in both bigSet and littleSet
% from bigSet; the new set is returned.
% Test:
%	M = gf([ 3 125 ; 4 3664 ; 5 3401 ; 6 2284 ],16);
%	excluded = gf([ 3 125 ],16);
%	excludeSet(M, excluded, 16);
%	ans = GF(2^16) array,
%	Array elements = [ 4 3664 ; 5 3401 ; 6 2284 ]

% ===== 1. make sure dimensions are right: =====
if (size(littleSet,1) > size(bigSet,1))
	error('Incorrect dimensions: second set must have smaller cardinality than the first set');
end

% ===== 2. generate subset by excluding littleSet: =====
results = setdiff(bigSet.x,littleSet.x,'rows');

% ===== 3. return set: =====
set = gf(results,field);

end