clear all;
addpath('./src/');
addpath('./src/recover/');
addpath('./src/reconstruct/');
%##########################��������####################################

% work over GF(2^16): ��Galois 2^16 ��������
FIELD = 16;
% degree of polynomial ����ʽ���ٴη�
DEGREE = 35;
% number of chaff points to generate:
NUM_CHAFFS = 30;
% define tolerance for adequate length-checks RS������ľ����
TOLERANCE = 2;

key='1235567890';%Ҫʹ�ð󶨵�key 10bit
n=length(key)+TOLERANCE;  k=length(key);                        % Codeword and message word lengths
msgKey = gf(double(key),FIELD); % e.g. gf(key,16) ��Կ ����gf���� Galois field array GF  Create a Galois field array. 
msgKeyRS = rsenc(msgKey,n,k);%key����RS�� �Լ�����ʽ

points=[ 3 4 5 6 7 8 9 10 11 12 13 14];%points ����12���� ��ĸ�����key����+2 �������ֳ���

ply = gf(msgKeyRS,FIELD);
X = gf(points',FIELD);
Y = evaluate(X,ply,FIELD);
mprojection = [ X Y ];

% ===== C. Mix up the projected points with chaff points: =====
chaffs = gf(zeros(NUM_CHAFFS,2),FIELD);% initialize set of chaff points to zeros:
MINDIST=1;%��С����Ϊ1
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
% ===== 2.5. sort points and merge chaffs with points �������ǵõ�������=====
%��������vault ӳ���We refer to the set R and �Լ�the parameter triple (k; t; r) together as a fuzzy v ault, denoted by VA
vault = sortrowsGF([ chaffs ; mprojection ],FIELD);

