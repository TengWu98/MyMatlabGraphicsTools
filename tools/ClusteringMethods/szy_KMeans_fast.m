% ����vl_kmeans���п���KMeans���࣬�Ұ���һ�㡣
function Labels = szy_KMeans_fast(A, clusterNum)
[~, Labels] = vl_kmeans(A, clusterNum, 'Verbose', 'Initialization', 'PLUSPLUS',...
    'MaxNumIterations', 500, 'NumRepetitions', 10);
end