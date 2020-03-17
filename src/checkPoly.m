function correct = checkPoly(points,ply,field)
% CHECKPOLY() takes a row vector of polynomial coefficients
% and a set of points { (x,y) } over a galois field with
% degree given by 2^field, and proceeds to pass each x over
% the polynomial and evaluates it, comparing it to the actual
% points { y }.
% PARAMETERS:
%	ply    --- a row vector of elements from GF(2^field)
%	points --- an M x 2 matrix of pairs from GF(2^field)
%	field  --- an integer between 2 and 16 representing
%			   the exponent of the field degree
% This function returns `correct` == 1 if all points match,
% and `correct` == 0 if there is at least one mistake.
% TEST:
%	ply = gf([ 1 1 2 3 5 ],16);
%	X = [ 3 4 5 6 ]';
%	Y = evaluate(X,ply,16);
%	M = gf([ X Y ],16);
%	checkPoly(M,ply,16);
%	ans = 1;

% add in parent folder to access the evaluate() function:
addpath('../');

matches = (evaluate(points(:,1),ply,field) == points(:,2));

if (sum(matches) > 0)
	correct = 1;
else
	correct = 0;
end

end