function subsets = getSubsets2(points,m,field)
% GETSUBSETS() takes an N x 2 matrix of pairs and
% a number m between 1 and N, returning a matrix
% of subsets of size m.
% TEST:
%	M = gf([ 3 6 ; 2 8 ; 11 23 ; 4 102 ],16);
%	getSubsets(M,3,16);

% extract underlying matrix of points:
rawPoints = points.x;

% get number of points total:
numPts = size(points,1);

% generate array of all admissible subsets, in binary:
subsetsBin = unique(perms([zeros(1,(numPts - m)) ones(1,m) ]),'rows');

% get number of subsets:
numSubsets = size(subsetsBin,1);

% initialize matrix of subsets:
subsetsX = zeros(m,2,numSubsets);

% for each row of subsetsBin:
for jdx=1:numSubsets
	% get the array of rows we need to append to subsetsX:
	entry = subsetsBin(jdx,:)';
	thesePoints = rawPoints(entry == 1,:);

	% append appropriate rows of rawPoints to subsetsX:
	subsetsX(:,:,jdx) = thesePoints;

end

% return output by wrapping subsetsX back in appropriate field:
subsets = gf(subsetsX,field);

end

% ======================================================

% generate array of all possible subsets, in binary:
%allSubsetsBin = dec2bin(0:((2^numPts)-1),numPts);

% initialize listing of desired subsets in binary:
%subsetsBin = zeros(nchoosek(numPts,m),numPts);

% add every row that have exactly m 1's to `subsetsBin`:
%ctr = 1;
%for idx=1:size(allSubsetsBin,1)
%	if ((sum(abs(allSubsetsBin(idx,:)) - 48)) == m)
%		subsetsBin(ctr,:) = allSubsetsBin(idx,:) - 48;
%		ctr = ctr + 1;
%	end
%end
% ======================================================