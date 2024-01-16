% [tr_dat, tt_dat, latent] = szy_PreprocessingData_ForDL(tr_Samples, tt_Samples, epsilon, isUseZCAWhitening, isMapMinMax)
% ע������epsilon��ѡ�����⣺����UFLDL�еĽ��飬Ӧ����epsilon���ھ������latent
% ����ĺ�С����Щβ��ֵ�����ԣ�ʹ�ñ�������ʱ����������һ�£�Ȼ�󻭳�latent��
% ����ͼ���˹���һ��epsilon��ѡ�ɶ��Ȼ����ѡ�е�epsilonֵ�ٴ�����һ�Σ�
% �õ����ս��Result��
function [tr_dat, tt_dat, latent] = szy_PreprocessingData_ForDL(tr_Samples, tt_Samples, epsilon, isUseZCAWhitening, isMapMinMax)
% ����UFLDL���飬Ϊ�˷�ֹ��ĸ����0�����Լ�һ����С��epsilon����ĸ
if exist('epsilon', 'var') ~= 1
    epsilon = 0;
end

if exist('isUseZCAWhitening', 'var') ~= 1
    isUseZCAWhitening = true;
end

if exist('isMapMinMax', 'var') ~= 1
    isMapMinMax = false;
end

% ͨ��ʵ�鷢�֣����������1���ƺ���������΢���ͷǳ�Сһ����׼ȷ�ʡ�
if isMapMinMax
    Y = mapminmax(tr_Samples', 0, 1);
else
    Y = tr_Samples';
end

% ��һ�����ҵ�onenote�ʼ���˵�ĵ�2��������Ҫ�ˣ���Ϊ��3���Ѿ������ˡ�
% Z = zscore(Y);

if isUseZCAWhitening
    % ͨ��ʵ�鷢�֣�ZCA�ܱ�PCAЧ�����á�
    [tr_dat, tt_dat, latent] = szy_ZCAWhitening(Y', tt_Samples, epsilon);
else
    [tr_dat, tt_dat, latent, ~] = szy_PCAWhitening(Y', tt_Samples, epsilon);
end
end