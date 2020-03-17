function subsets = getSubsets(points,m,field)
% GETSUBSETS() takes an N x 2 matrix of pairs and
% a number m between 1 and N, returning a matrix
% of subsets of size m.
% TEST:
%	M = gf([ 3 6 ; 2 8 ; 11 23 ; 4 102 ],16);
%	getSubsets(M,3,16);

numPts = size(points,1);

% generate array of all possible subsets, in binary:
allSubsetsBin = dec2bin(0:((2^numPts)-1),numPts);

% get number of subsets:
numSubsets = size(allSubsetsBin,1);

% get number of subsets of size M (numPts CHOOSE m):
numSubsetsSizeM = nchoosek(numPts,m);

% initialize matrix of subsets:
subsets = gf(ones(m,2,numSubsetsSizeM),field);

% compute subsets from all rows of `allSubsetsBin` that sum to m:
for idx=1:(numSubsets)
	% if there are m points in the current subset:
	if (sum(abs(allSubsetsBin(idx,:) - 48)) == m)
		% append to subsets at idx:
		ctr = 1;
		% go over each point in `points`:
		for jdx=1:numPts
			% if the subset contains that point, then add it:
			if (allSubsetsBin(idx,jdx) == 1)
				subsets(ctr,:,idx) = points(jdx,:);
				ctr = ctr + 1;
			end
		end

	end

end

end