function dist = computeDist1D(points,pt,field)
% COMPUTEDIST() computes the minimum distance of a point 'x' from
% any point in a point-set [ x ] ~ N x 1.
% All measurement takes place in a finite field of order specified in
% the argument `field`.

% define vector to hold distances:
dists = zeros(size(points,1),1);

pointsx = points.x;
ptx = pt.x;

% compute distance of `pt` to each point in `points`:
for idx=1:size(points,1)  
  %  fprintf('pointsx: %8.5f  ptx: %8.5f dist: %8.5f\n', pointsx(idx,1),  ptx,abs(pointsx(idx,1) - ptx));
	dists(idx) = abs(ptx-pointsx(idx,1) );
end

% return minimum distance:
dist = min(dists);
end