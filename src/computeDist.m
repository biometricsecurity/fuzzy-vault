function dist = computeDist(points,pt,field)
% COMPUTEDIST() computes the minimum distance of a point [x y] from
% any point in a point-set.
% All measurement takes place in a finite field of order specified in
% the argument `field`.

% define vector to hold distances:
dists = zeros(size(points,1),1);

% compute distance of `pt` to each point in `points`:
for idx=1:size(points,1)
	dists(idx) = (points.x(idx,1) - pt.x(1))^2 + (points.x(idx,1) - pt.x(1))^2;
end

% return minimum distance:
dist = min(dists);

end