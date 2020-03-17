
% work over GF(2^16): 在Galois 2^16 有限域工作
FIELD = 16;
% degree of polynomial 多项式多少次方
DEGREE = 35;

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

M = [ X Y ];
 	decodePolynomial(M,16,12);

%##########################解锁过程####################################
testpoints=[ 3 4 5 6 7 8 9 10 11 12 13 19];%points 我们12个点 点的个数是key长度+2 看你码字长度 指纹细节点 解锁
testpoints = gf(testpoints',FIELD); % e.g. gf(key,16)
% 解锁做的就是 
%1 找出和vault最接近的点 
% 2.获取我们应该用的解锁数据
% 3.解锁 获取多项式参数 然后RS解码

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
decodeFactor=decodePolynomial(vault(vaultOverlapping,:),FIELD,length(testpoints)-1);%解多项式
fieldKey = rsdec(decodeFactor,n,k);%解码
 % initialize `key` as empty string:
key = '';
% convert each coefficient into a string and append to key:
for idx=1:(length(fieldKey))
	% convert each coefficient into char and append:
	key = strcat(key,fieldToAscii(fieldKey(idx),FIELD));
end
key