function [tr_dat, tt_dat, tr_lb, tt_lb] = szy_PrepareClassificationData4(...
    AllSamples, Labels, trainingNumRatio)
% [tr_dat, tt_dat, tr_lb, tt_lb] = szy_PrepareClassificationData(AllSamples, Labels, trainingNumRatio)
% ׼���������з�����������ݡ�
% AllSamples��һ�����󣬱�ʾ����������ÿһ����һ��������Labels��ÿ��������Ӧ�ı�ǩ���ɵ���������
% trainingNumRatio��0��1֮�����ֵ����ʾÿ������ǰ�ٷ�֮������Ϊѵ��������
% ������Ϊ����������tr_dat��tt_dat���Ǿ���ÿһ����һ���������ֱ��ʾѵ�������Ͳ���������
% tr_lb��tt_lb�ֱ��ʾѵ�������Ͳ�����������ȷ�����ǩ��

uniqueLabel = unique(Labels);
tr_dat = [];
tt_dat = [];
tr_lb = [];
tt_lb = [];
for i = 1:max(size(uniqueLabel))
    temp = AllSamples(:, Labels == uniqueLabel(i));
    temp2 = size(temp, 2);
    trainNum = ceil(temp2*trainingNumRatio);
    tr_dat = [tr_dat temp(:, 1:trainNum)];
    tr_lb = [tr_lb repmat(uniqueLabel(i), 1, trainNum)];
    tt_dat = [tt_dat temp(:, (trainNum + 1):end)];
    tt_lb = [tt_lb repmat(uniqueLabel(i), 1, temp2 - trainNum)];
end
end