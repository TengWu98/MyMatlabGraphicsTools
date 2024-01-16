% ProbMatrix = szy_GMM_matlab(A, clusterNum)
function ProbMatrix = szy_GMM_matlab(A, clusterNum)

% ����Kmeans++���о��࣬�õ�ÿ������ĵ㣬����������ʼ��GMM�㷨��ʹ��GMMЧ�����á�
% �������Ѿ���kmeans++���г�ʼ���ˣ������ٵ�������ǰ���kmeans�㷨���г�ʼ���ˡ�        
options = statset('MaxIter', 5000, 'Display', 'final');
GMModel = fitgmdist(A', clusterNum, 'Options', options, ...
    'Replicates', 10, 'Start', 'plus');
ProbMatrix = posterior(GMModel, A')';

end