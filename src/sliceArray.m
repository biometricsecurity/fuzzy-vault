function segments = sliceArray(mtrx,segSize)
% SLICEARRAY() takes an array of size (1 x N) and a
% parameter `segSize` = S, cutting the array into segments
% of length S columns.
% We require that N % S == 0.
% Returns an L x S array, where each row is of length S.

% get dimensions and data on the array:
N = size(mtrx,2);
S = segSize;

% ===== 1. Check that N % S == 0 : =====
if (mod(N,S) ~= 0)
	error('Incorrect sizes.');
end

% ===== 2. Keep cutting segments of length S: =====
curr = [];
for idx=0:( (N / S)-1 )
	fst = 1 + (idx * S);
	snd = S * (idx + 1);
	curr = [curr ; mtrx(fst:snd)];
end

segments = curr;

end