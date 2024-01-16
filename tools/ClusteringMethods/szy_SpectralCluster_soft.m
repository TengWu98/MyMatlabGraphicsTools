% �׾��࣬W�Ǿ�����󣬶Գơ�k�Ǿ����Ŀ������
function ProbMatrix = szy_SpectralCluster_soft(W, k)
D = diag(sum(W));
L = D-W;

opt = struct('issym', true, 'isreal', true);
[V, ~] = eigs(L, D, k, 'lm', opt);

ProbMatrix = szy_GMM(V', k);
end
