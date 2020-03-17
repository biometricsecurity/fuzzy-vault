function Ply = genPoly(key,field,degree)
% GENPOLY() takes a key (ASCII) and a specified finite field,
% generating a polynomial from the key by using segments of
% the key as coefficients.
% PARAMETERS:
%	key ---
%   field --- exponent of field degree, i.e. GF(2^field)
%   degree --- degree of polynomial

% define tolerance for adequate length-checks
tolerance = 1;

% ==== Run reed-solomon encoder on key =====
% ==== GF  Create a Galois field array. 
msgKey = gf(double(key),field); % e.g. gf(key,16)

% check to see if degree is large enough:
if ((degree + 1 - length(msgKey)) < tolerance)
	error('Degree and key length mismatched');
else
    %code = rsenc(msg,n,k) encodes the message in msg using an [n,k] Reed-Solomon code with the narrow-sense generator polynomial. 
	Ply = rsenc(msgKey,(degree+1),length(msgKey));
end

end

% ===============================================================================

%encodedKey = rsenc(msgKey,n,k);

% ===== 2. Check to make sure degree divides into keylength: =====
%if (mod(length(encodedKey),(degree+1)) ~= 0)
	% exit script and send error message while quitting
%	error('Degree and key length mismatched');
%end

% ===== 3. Cut the key into segments of appropriate length: =====
%segmentSize = (length(encodedKey) / (degree +1));
%segments = sliceArray(encodedKey,segmentSize);

% ===== 4. Convert each segment into a field element and return coeffs: =====

% initialize output to zeros:
%Ply = zeros(1,(degree+1));

% loop through segments and convert to field elements:
%for idx=1:length(segments)
%	Ply = gf(segments(idx),field);
%end