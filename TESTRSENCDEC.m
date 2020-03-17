
% work over GF(2^16): 在Galois 2^16 有限域工作
FIELD = 16;
% degree of polynomial 多项式多少次方
DEGREE = 35;
key='1234567890';%要使用绑定的key 10bit

msgKey = gf(double(key),FIELD); % e.g. gf(key,16) 密钥 生成gf数组 Galois field array GF  Create a Galois field array. 

   n=length(key)+2;  k=length(key);                        % Codeword and message word lengths
       m=3;                               % Number of bits per symbol
      
       code = rsenc(msgKey,n,k);             % Two n-symbol codewords
       % Add 1 error in the 1st word, 2 errors in the 2nd, 3 errors in the 3rd
       errors = gf([3 0 0 0 0 0 0 0 0 0 0 0],FIELD);
       codeNoi = code + errors
       [dec,cnumerr] = rsdec(code,n,k) % Decoding failure : cnumerr(3) is -1
       key = '';

% convert each coefficient into a string and append to key:
for idx=1:(length(dec))
	% convert each coefficient into char and append:
	key = strcat(key,fieldToAscii(dec(idx),FIELD));
end
key