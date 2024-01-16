% [tr_dat, tt_dat, latent, coeff] = szy_PCAWhitening(tr_Samples, tt_Samples, epsilon)
% ע������epsilon��ѡ�����⣺����UFLDL�еĽ��飬Ӧ����epsilon���ھ������latent
% ����ĺ�С����Щβ��ֵ�����ԣ�ʹ�ñ�������ʱ����������һ�£�Ȼ�󻭳�latent��
% ����ͼ���˹���һ��epsilon��ѡ�ɶ��Ȼ����ѡ�е�epsilonֵ�ٴ�����һ�Σ�
% �õ����ս��Result��
function [tr_dat, tt_dat, latent, coeff] = szy_PCAWhitening(tr_Samples, tt_Samples, epsilon)
% ����UFLDL���飬Ϊ�˷�ֹ��ĸ����0�����Լ�һ����С��epsilon����ĸ
if exist('epsilon', 'var') ~= 1
    epsilon = 0;
end

[coeff, score, latent] = pca(tr_Samples');
% [coeff, score, latent] = pca(AllSamples', 'Economy',false);
% AllSamples_R = score * coeff';
% AllSamples_R = AllSamples_R; + repmat(mu, size(AllSamples_R, 1), 1);
% epsilon = ;
tr_dat = score ./ repmat(sqrt(latent' + epsilon), size(score, 1), 1);
tr_dat = tr_dat';

temp = tt_Samples - repmat(mean(tr_Samples, 2), 1, size(tt_Samples, 2));
score2 = temp' * coeff;

tt_dat = score2 ./ repmat(sqrt(latent' + epsilon), size(score2, 1), 1);
tt_dat = tt_dat';
end