function vault = mixChaffs(points,numChaffs,field,minDist)
% Take a point set of the form { z, P(z) }
% and mix it with a randomly-generated set of
% chaff points of the form { a, b }, where
% a =/= z and b =/=P(a) for any z.

% ===== 1. keep generating random points until we generate 'numChaffs' =====

% initialize set of chaff points to zeros:
chaffs = gf(zeros(numChaffs,2),field);

for count=1:numChaffs
	% ===== 2. generate a random point (a,b) in the field =====
	rndmPt = gf(randi((2^field - 1),1,2),field);

	% ===== 3. check to make sure that it can be added ===== -- FIX
	% if (a,b) is > minDist away from any point of `points`, add it
	%if (computeDist(points,rndmPt,field) > minDist)
		chaffs(count,:) = rndmPt;
	%end
end

% ===== 4. remove zeros from chaff point set ===== -- FIX
%chaffs( ~any(chaffs,2), : ) = [];

% ===== 5. sort points and merge chaffs with points =====
vault = sortrowsGF([ chaffs ; points ],field);
%vault = [chaffs ; points];

end