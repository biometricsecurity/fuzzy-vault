addpath('./src/');
addpath('./src/recover/');
addpath('./src/reconstruct/');
% work over GF(2^16): 在Galois 2^16 有限域工作
FIELD = 8;
key='12345';%要使用绑定的key 10bit

msgKey = gf(double(key),FIELD) % e.g. gf(key,16) 密钥 生成gf数组 Galois field array GF  Create a Galois field array. 
% msgKeyRS = rsenc(msgKey,n,k);%key生成RS码 以及多项式



ply = gf(msgKey,FIELD);

X = gf([ 3 4 5 6 7 8 9 ]',FIELD);
Y = evaluate(X,ply,FIELD);

M = [ X Y ];
decodePolynomial(M,FIELD,7-1)