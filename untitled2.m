addpath('./src/');
addpath('./src/recover/');
addpath('./src/reconstruct/');
% work over GF(2^16): ��Galois 2^16 ��������
FIELD = 8;
key='12345';%Ҫʹ�ð󶨵�key 10bit

msgKey = gf(double(key),FIELD) % e.g. gf(key,16) ��Կ ����gf���� Galois field array GF  Create a Galois field array. 
% msgKeyRS = rsenc(msgKey,n,k);%key����RS�� �Լ�����ʽ



ply = gf(msgKey,FIELD);

X = gf([ 3 4 5 6 7 8 9 ]',FIELD);
Y = evaluate(X,ply,FIELD);

M = [ X Y ];
decodePolynomial(M,FIELD,7-1)