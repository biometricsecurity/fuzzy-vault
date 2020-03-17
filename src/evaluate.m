function values = evaluate(points,Ply,field)
% EVALUATE() takes a column vector of points and a polynomial
% represented by a row vector of coefficients; it returns
% the evaluation of each point.
% TEST:
%	X = gf([ 14 ; 32 ], 16);
%	POLY = gf([ 5 9 1 ], 16);
%	evaluate(X,POLY,16)
%	ans = GF(2^16) array,
%	Array elements =
%
%		47
%	  1317

% initialize output to matrix of zeros in GF(2^field):
values = gf(zeros(length(points),1),field);

% define polyn degree, accounting for constant term:
degree = length(Ply) - 1;

% generate square matrix [1 X X^2 X^3 ... X^N]:
X = genPolyMatrix(points,degree,field);

% compute polynomial evaluations: return [1 X X^2 X^3 ... X^N] * P' ~ (M x 1)
for jdx=1:length(points)
	%values = X * Ply';
	values(jdx) = X(jdx,:) * Ply';
end

end