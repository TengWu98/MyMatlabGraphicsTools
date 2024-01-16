% ProbMatrix = szy_GMM(A, clusterNum)
% ����Kmeans++���о��࣬�õ�ÿ������ĵ㣬����������ʼ��GMM�㷨��ʹ��GMMЧ�����á�
function ProbMatrix = szy_GMM(A, clusterNum)

% ����Kmeans++���о��࣬�õ�ÿ������ĵ㣬����������ʼ��GMM�㷨��ʹ��GMMЧ�����á�
 
% ---������VL����Kmeans�㷨���о��࣬��ó�ʼ���ĵ㡣
% [C, idx] = vl_kmeans(feature, clusterNum, 'Verbose', 'Initialization', 'PLUSPLUS',...
%     'MaxNumIterations', 500, 'NumRepetitions', 10);

% ---������Matlab�Դ���kmeans�㷨���࣬Ĭ�Ͼ�����kmeans++���г�ʼ���ġ�
[~, C] = kmeans(A', clusterNum);

[MEANS, COVARIANCES, PRIORS, LL, ProbMatrix] = vl_gmm(A, ...
    clusterNum, 'verbose', 'MaxNumIterations', 500, ...
    'InitMeans', C', 'InitPriors', ones(1, clusterNum) /clusterNum, ...
    'InitCovariances', zeros(size(A, 1), clusterNum), ...
	'NumRepetitions', 10);
end