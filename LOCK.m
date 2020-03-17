clear all;
addpath('./src/');
addpath('./src/recover/');
addpath('./src/reconstruct/');
%##########################加锁过程####################################

% work over GF(2^16): 在Galois 2^16 有限域工作
FIELD = 16;
% degree of polynomial 多项式多少次方
DEGREE = 35;
% number of chaff points to generate:
NUM_CHAFFS = 30;
% define tolerance for adequate length-checks RS纠错码的纠错度
TOLERANCE = 2;

key='1235567890';%要使用绑定的key 10bit
n=length(key)+TOLERANCE;  k=length(key);                        % Codeword and message word lengths
msgKey = gf(double(key),FIELD); % e.g. gf(key,16) 密钥 生成gf数组 Galois field array GF  Create a Galois field array. 
msgKeyRS = rsenc(msgKey,n,k);%key生成RS码 以及多项式

points=[ 3 4 5 6 7 8 9 10 11 12 13 14];%points 我们12个点 点的个数是key长度+2 看你码字长度

ply = gf(msgKeyRS,FIELD);
X = gf(points',FIELD);
Y = evaluate(X,ply,FIELD);
mprojection = [ X Y ];

% ===== C. Mix up the projected points with chaff points: =====
chaffs = gf(zeros(NUM_CHAFFS,2),FIELD);% initialize set of chaff points to zeros:
MINDIST=1;%最小距离为1
for count=1:NUM_CHAFFS % ===== 2.1. keep generating random points until we generate 'numChaffs' =====
	% ===== 2.2. generate a random point (a,b) in the field =====
	%rndmPt = gf(randi((2^FIELD - 1),1,2),FIELD);%randi((2^FIELD - 1),1,2) ans= 37026       41963
    	rndmPt = gf(randi((2^FIELD - 1),1,2),FIELD);%randi((2^FIELD - 1),1,2) ans= 37026       41963
	% ===== 2.3. check to make sure that it can be added ===== -- FIX
	% if (a,b) is > minDist away from any point of `points`, add it
	%if (computeDist(points,rndmPt,FIELD) > MINDIST)
		chaffs(count,:) = rndmPt;
	%end
end
% ===== 2.4. remove zeros from chaff point set ===== -- FIX
%chaffs( ~any(chaffs,2), : ) = [];
% ===== 2.5. sort points and merge chaffs with points 至此我们得到保险箱=====
%保险箱由vault 映射点We refer to the set R and 以及the parameter triple (k; t; r) together as a fuzzy v ault, denoted by VA
vault = sortrowsGF([ chaffs ; mprojection ],FIELD);

