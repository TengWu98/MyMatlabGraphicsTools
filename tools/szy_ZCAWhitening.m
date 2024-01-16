% [tr_dat, tt_dat, latent] = szy_ZCAWhitening(tr_Samples, tt_Samples, epsilon)
% ע������epsilon��ѡ�����⣺����UFLDL�еĽ��飬Ӧ����epsilon���ھ������latent
% ����ĺ�С����Щβ��ֵ�����ԣ�ʹ�ñ�������ʱ����������һ�£�Ȼ�󻭳�latent��
% ����ͼ���˹���һ��epsilon��ѡ�ɶ��Ȼ����ѡ�е�epsilonֵ�ٴ�����һ�Σ�
% �õ����ս��Result��
function [tr_dat, tt_dat, latent] = szy_ZCAWhitening(tr_Samples, tt_Samples, epsilon)
% ����UFLDL���飬Ϊ�˷�ֹ��ĸ����0�����Լ�һ����С��epsilon����ĸ
if exist('epsilon', 'var') ~= 1
    epsilon = 0;
end

% [coeff, score, latent] = pca(tr_Samples');
% tr_dat = score ./ repmat(sqrt(latent' + epsilon), size(score, 1), 1);
% tr_dat = tr_dat * coeff';
% tr_dat = tr_dat';
[tr_dat, tt_dat, latent, coeff] = szy_PCAWhitening(tr_Samples, tt_Samples, epsilon);
tr_dat = coeff * tr_dat;

tt_dat = coeff * tt_dat;
end