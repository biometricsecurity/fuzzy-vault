function mtrx = genPolyMatrix(points,degree,field)
% GENPOLYMATRIX() takes a set of points { x1, ..., xM }
% over a field GF(2^field) and a degree N and generates
% the following matrix:
%	[ 1  x1  x1^2 ... x1^N ]
%	[ 1  x1  x2^2 ... x2^N ]
%	[        .....         ]
%	[ 1	 xM  xM^2 ... xM^N ]
% over the same field.
% PARAMETERS:
%	points --- column vector over GF(2^field)
%	degree --- positive integer
%	field  --- integer between 3 and 16

% get dimensional parameters:
M = length(points);
N = degree;

% generate square matrix [X X^2 X^3 ... X^N]:
X = gf(zeros(M,N),field);
for nexp=1:degree
	% define X^nexp by repeated multiplication:
	monomialN = gf(ones(M,1),field);
	for idx=1:nexp
		monomialN = monomialN .* points;
	end
	% store in the `nexp`-th column of X:
	X(:,nexp) = monomialN;
end

% return output:
mtrx = [ gf(ones(M,1),field) X ];

end