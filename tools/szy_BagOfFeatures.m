function [tr_dat, tt_dat] = szy_BagOfFeatures(trainSamples, testSamples, L, ...
    NumRepetitions, MaxNumIterations)
% [tr_dat, tt_dat] = szy_BagOfFeatures(trainSamples, testSamples, L, NumRepetitions, MaxNumIterations)
% ʹ��Bag of Features�õ�ѵ�������Ͳ���������Ӧ����������trainSamples��testSamples
% ��cell���ͣ�����ÿ��Ԫ�ض���һ���ṹ��sample������sample.M������󣬴���һ��������������
% �����ÿһ�б�ʾһ������������sample.w��һ��������������M��ÿ������������Ӧ��Ȩ�ء�
% ��������M��������ȡ�
% �㷨��trainSamples�й����ֵ䣬���õ�trainSamples��ÿ���������ֵ��µ�Ƶ�ʱ�
% ���ɾ���tr_dat���Լ�testSamples��ÿ���������ֵ��µ�Ƶ�ʱ����ɾ���tt_dat��
% tr_dat��tt_dat�Ǿ��󣬷ֱ����õ���ѵ�����Ͳ��Լ�������ÿһ�д���һ��ѵ�����������������
% L�����ص�ѵ�����Ͳ��Լ��е�ѵ�������Ͳ���������ά����
% MaxNumIterations��ʾ����ʱ��������������Ĭ��Ϊ100000��
% NumRepetitions��ʾ���������㷨�Ĵ�����Ĭ��Ϊ30��

% ��������£����ص�tr_datûɶ�ã���ΪtrainSamplesֻ�����������ֵ䣬���ص�tt_dat
% �����������õġ�

% ���������д��

if exist('MaxNumIterations', 'var') ~= 1
    MaxNumIterations = 100000;
end

if exist('NumRepetitions', 'var') ~= 1
    NumRepetitions = 30;
end

disp('Constructing vocabulary...');
BigMatrix = [];
for i = 1:length(trainSamples)
    trainSample = trainSamples{i};
    BigMatrix = [BigMatrix trainSample.M];
end

disp('Clustering...');
tic
[Dict, ~] = vl_kmeans(BigMatrix, L, 'Verbose', 'Initialization', 'PLUSPLUS',...
    'MaxNumIterations', MaxNumIterations, 'NumRepetitions', NumRepetitions);
Dict = Dict';
% opts = statset('MaxIter', 1000);
% [~, Dict] = kmeans(BigMatrix', L, 'Options', opts);
toc

disp('Computing tr_dat...');
tr_dat = [];

for i = 1:length(trainSamples)
    trainSample = trainSamples{i};
    IDX = knnsearch(Dict, trainSample.M');
    
    n = zeros(L, 1);
    for k = 1:L
        n(k, 1) = sum(trainSample.w(IDX == k));
    end
    if sum(n) == 0
        error('BagOfFeature���ִ������������г���ȫ0������˵��ģ������0�������Ƭ��');
    end    
    d = n / sum(n);
    tr_dat(:, i) = d;
end

disp('Computing tt_dat...');
tt_dat = [];

for i = 1:length(testSamples)
    testSample = testSamples{i};
    IDX = knnsearch(Dict, testSample.M');

    n = zeros(L, 1);
    for k = 1:L
        n(k, 1) = sum(testSample.w(IDX == k));
    end
    if sum(n) == 0
        error('BagOfFeature���ִ������������г���ȫ0������˵��ģ������0�������Ƭ��');
    end    

    d = n / sum(n);
    
    tt_dat(:, i) = d;
end

if sum(sum(isnan(tr_dat))) ~= 0
    error('tr_dat����NaN������');
end
if sum(sum(isnan(tt_dat))) ~= 0
    error('tt_dat����NaN������');
end

if sum(sum(isinf(tr_dat))) ~= 0
    error('tr_dat����inf������');
end
if sum(sum(isinf(tt_dat))) ~= 0
    error('tt_dat����inf������');
end
end