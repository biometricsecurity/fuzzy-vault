function coeffs = recoverPoly2(points,vault,field,degree)
% RECOVERPOLY() takes a point-set { x' }, a fuzzy vault
% { x,y }, a polynomial degree n, and the order of a finite
% field F_q; the function reconstructs the coefficients of
% the polynomial in the form of a row vector:
% Ply = [ c0 c1 ... cn ], where ci is in F_q for all i=1:n.
%
% Relies on the POLYNOMIAL DECODING algorithm viz. matrix inversion
% over the field F_q.

% add path to polynomial recovery utils:
% for Octave:
%addpath('./recover/');
% for MATLAB:
addpath('./src/recover/');

% define shorthands:
vaultLength = size(vault,1);
numPts = size(points,1);

% initialize output:
coeffs = gf(zeros(1,(degree+1)),field);

% ===== 1. Sort vault based on distance to closest query point: =====

% define column vector of distances:
dists = zeros(vaultLength,1);
for idx=1:vaultLength
	dists(idx) = computeDist1D(points,vault(idx,1),field);
end

% wrap distances in GF(2^field) array:
distsGF = gf(dists,field);

% sort `vault`based on `dists`:
vaultSorted_pre = sortrowsGF([ distsGF vault ],field);
vaultSorted = vaultSorted_pre(:,2:3);

% ===== 2. Run decodePolynomial() on subset of vaultSorted: =====

% initialize testset to first D+1 points of sorted vault:
testSet = vaultSorted(1:(degree+1),:);
testSet
% try running on points of vaultSorted:
polyCoeffs = decodePolynomial(testSet,field,degree);

% if it works, return it
if (checkPoly(testSet,polyCoeffs,field))
	coeffs = polyCoeffs;
end

end
%======================================
%correct = 0;

%while (correct == 0)
	% try running on points of vaultSorted:
%	polyCoeffs = decodePolynomial(testSet,field,degree);

	% if it works, return it; if not continue on:
%	if (checkPoly(testSet,polyCoeffs,field))
%		coeffs = polyCoeffs;
%		correct = 1;
%	end

	% update set to look at:
%	testSet = % FINISH THIS
%end