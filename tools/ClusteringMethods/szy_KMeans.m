% KMeans���࣬featureÿ��һ��������clusterNum�Ǿ���Ŀ����
% Labels�����ţ�C�Ǿ�������
function [Labels, C] = szy_KMeans(feature, clusterNum)
[Labels, C] = kmeans(feature', clusterNum, 'MaxIter',10000, 'Replicates', 10,...
    'Display','final');
Labels = Labels';
end
