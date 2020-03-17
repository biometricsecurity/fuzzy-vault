
% work over GF(2^16): ��Galois 2^16 ��������
FIELD = 16;
% degree of polynomial ����ʽ���ٴη�
DEGREE = 35;

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

M = [ X Y ];
 	decodePolynomial(M,16,12);

%##########################��������####################################
testpoints=[ 3 4 5 6 7 8 9 10 11 12 13 19];%points ����12���� ��ĸ�����key����+2 �������ֳ��� ָ��ϸ�ڵ� ����
testpoints = gf(testpoints',FIELD); % e.g. gf(key,16)
% �������ľ��� 
%1 �ҳ���vault��ӽ��ĵ� 
% 2.��ȡ����Ӧ���õĽ�������
% 3.���� ��ȡ����ʽ���� Ȼ��RS����

% define shorthands:
vaultLength = size(vault,1);
numPts = size(testpoints,1);

% ===== 1. Sort vault based on distance to closest query point: =====

% define column vector of distances:
dists = zeros(vaultLength,1);
overlapointscount=0;
vaultOverlapping= zeros(1,1);

for idx=1:vaultLength
	dists(idx) = computeDist1D(testpoints,vault(idx,1),FIELD);
    if (dists(idx)<1) 
        overlapointscount=overlapointscount+1;
        vaultOverlapping(overlapointscount)=idx;
    end
end
decodeFactor=decodePolynomial(vault(vaultOverlapping,:),FIELD,length(testpoints)-1);%�����ʽ
fieldKey = rsdec(decodeFactor,n,k);%����
 % initialize `key` as empty string:
key = '';
% convert each coefficient into a string and append to key:
for idx=1:(length(fieldKey))
	% convert each coefficient into char and append:
	key = strcat(key,fieldToAscii(fieldKey(idx),FIELD));
end
key