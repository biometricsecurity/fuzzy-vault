clear all;
addpath('./src/');
addpath('./src/recover/');
addpath('./src/reconstruct/');

% work over GF(2^16): 在Galois 2^16 有限域工作
FIELD = 16;
% degree of polynomial 多项式多少次方
DEGREE = 35;
key='1234567890';%要使用绑定的key 10bit
n=length(key)+2;  k=length(key);                        % Codeword and message word lengths
msgKey = gf(double(key),FIELD); % e.g. gf(key,16) 密钥 生成gf数组 Galois field array GF  Create a Galois field array. 
msgKeyRS = rsenc(msgKey,n,k);%key生成RS码 以及多项式

points=[ 3 4 5 6 7 8 9 10 11 12 13 14];%points 我们12个点 点的个数是key长度+2 看你码字长度

ply = gf(msgKeyRS,FIELD);
X = gf(points',FIELD);
Y = evaluate(X,ply,FIELD);
M = [ X Y ];



fieldKey=decodePolynomial(M,FIELD,length(points)-1);
fieldKey = rsdec(fieldKey,n,k);
% initialize `key` as empty string:
key = '';

% convert each coefficient into a string and append to key:
for idx=1:(length(fieldKey))
	% convert each coefficient into char and append:
	key = strcat(key,fieldToAscii(fieldKey(idx),FIELD));
end
key