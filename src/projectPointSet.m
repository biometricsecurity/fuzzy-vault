function vault = projectPointSet(points,Ply,field)
% PROJECTPOINTSET() takes a point set of the form
% { z } and generates a point set of the form
% { z,P(z) } by applying the polynomial `Ply` to each
% point z in the point set.
% PARAMETERS:
%	points --- column vector of arbitrary length inside
%			   a galois field array GF(2^field).
%	ply    --- a row vector of elements of GF(2^field) of
%			   arbitrary length.
%	field  --- an integer between 2 and 16 representing
%			   the exponent of degree of the galois field.

% ===== 1. For each point in points, compute polynomial =====
projections = evaluate(points,Ply,field);

% ===== 2. Append projected values P(z) as another column =====
vault = [ points projections ];

end