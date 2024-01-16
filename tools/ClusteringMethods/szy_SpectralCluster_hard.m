% �׾��࣬W�Ǿ�����󣬶Գơ�k�Ǿ����Ŀ������
function Labels = szy_SpectralCluster_hard(W, k)
D = diag(sum(W));
L = D-W;

opt = struct('issym', true, 'isreal', true);
[V, ~] = eigs(L, D, k, 'lm', opt);

Labels = kmeans(V, k);
Labels = Labels';
end
