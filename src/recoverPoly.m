function coeffs = recoverPoly(points,vault,field,degree)
% RECOVERPOLY() takes a point-set { x' }, a fuzzy vault
% { x,y }, a polynomial degree n, and the order of a finite
% field F_q; the function reconstructs the coefficients of
% the polynomial in the form of a row vector:
% Ply = [ c0 c1 ... cn ], where ci is in F_q for all i=1:n.
%
% Relies on the POLYNOMIAL DECODING algorithm viz. matrix inversion
% over the field F_q.


% add path to polynomial recovery utils:
addpath('./src/recover/');

% define shorthands:
vaultLength = size(vault,1);
numPts = size(points,1);

% initialize output:
coeffs = zeros(1,(degree+1));

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

% ===== 2. Run decodePolynomial() on each subset of vaultSorted: =====

% define flag to break out of all loops:
flag = 0;

% loop over all admissible subset sizes:
for n=(degree+1):vaultLength

	% define subset of size n:
	subset = vaultSorted((1:n),:);

	% loop over subsets of subset:
	for m=1:(n-(degree+1))

		% generate matrix of all size-m subsets of `subset`,
		% of dimension ([n choose m] x m):
		subsetsM = getSubsets(subset,m,field);

		% loop over all subsets of size m:
		for jdx=1:(size(subsetsM,1))
			% get the jdx-th matrix in the array of subsets:
			excluded = subsetsM(:,:,jdx);
			% form difference of `subset` and `subsetsM(jdx)`:
			testSet = excludeSet(subset,excluded,field);
			% compute polynomial by BM algorithm:
			polyCoeffs = decodePolynomial(testSet,field,degree);
			% check if polynomial is correct:
			if (checkPoly(testSet,polyCoeffs,field))
				% return P and skip the rest:
				coeffs = polyCoeffs;
				% short-circuit the rest of the loop:
				flag = 1;
				break;
			end
		end

		% break out of loop if flag is set:
		if (flag == 1)
			break;
		end

	end

	% break out of loop if flag is set:
	if (flag == 1)
		break;
	end

end

end