function Ply = reconstructPoly(points,vault,field,degree)
% RECONSTRUCTPOLY() takes a point-set { x' }, a fuzzy vault
% { x,y }, a polynomial degree n, and the order of a finite
% field F_q; the function reconstructs the coefficients of
% the polynomial in the form of a row vector:
% Ply = [ c0 c1 ... cn ], where ci is in F_q for all i=1:n.
% Uses lagrangian interpolation to recover polynomial.

% initialize Ply to row vector of length (degree+1):
Ply = zeros(1,(degree+1));

% initialize polyPts to appropriate size of zeros:
polyPts = zeros(length(points),2);

% ===== 1. For each point, find closest point in vault =====
for idx=1:length(points)
	% compute distances: -- CHECK
	distances = computeDist1D([vault(:,1) zeros(size(vault)) ],[points(idx) 0]);
	% compute arg min:
	[A I] = min(distances);
	% set to x & y value closest to it
	polyPts(idx,:) = vault(I,:);
end

% ===== 2. Get coefficients via lagrange interpolating polynomial =====
% get coefficients
coeffs = lagrangeInterpolation(polyPts,field,degree);

% return result
Ply = coeffs;


end