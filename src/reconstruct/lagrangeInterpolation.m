function coeffs = lagrangeInterpolation(points,field,degree)
% LAGRANGEINTERPOLATION() takes a series of points { (x,y) }
% lying on a polynomial of degree n and over a field F_q;
% this function returns a row vector of length (n + 1) of the
% form [ c0 c1 ... cn ].

% ===== 1. Check to make sure there are enough points =====

if(size(points,1) < (degree+2))
	% throw error and quit; not enough data
	% FINISH THIS
end

% ===== 2. Create lagrange interpolating polynomial =====


end