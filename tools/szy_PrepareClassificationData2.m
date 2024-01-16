function [trainSamples, testSamples, tr_lb, tt_lb] = szy_PrepareClassificationData2(...
    AllSamples, classNum, sampleNumInClass, trainingNum)
% [trainSamples, testSamples, tr_lb, tt_lb] = szy_PrepareClassificationData2(AllSamples, classNum, sampleNumInClass, trainingNum)
% ׼���������з�����������ݡ�ע�⣺������������Bag Of Featuresģ�͡�
% AllSamples��һ��cell���ͣ���ʾ����������classNum��ʾ�ܹ��ж����࣬
% sampleNumInClass��ʾÿ���ж��ٸ�������trainingNum��ʾÿ������ǰ���ٸ���Ϊѵ��������
% ������Ϊ����������trainSamples��testSamples����cell���ͣ��ֱ��ʾѵ�������Ͳ���������
% tr_lb��tt_lb�ֱ��ʾѵ�������Ͳ�����������ȷ�����ǩ��

%ÿһ���������ó�����������Ϊѵ������
% trainingNum = 10;
%ÿһ���������ó�����������Ϊ��������
testNum = sampleNumInClass - trainingNum;
tr_index = szy_RepeatIndex(1:trainingNum, sampleNumInClass, classNum);
tt_index = setdiff(1:size(AllSamples, 2), tr_index);
%����ѵ������
trainSamples = AllSamples(tr_index);
%���в�������
testSamples = AllSamples(tt_index);
Labels = szy_RepeatIndex(ones(1, sampleNumInClass), 1, classNum);
%ѵ�����������
tr_lb = Labels(:, tr_index);
%������������ȷ���
tt_lb = Labels(:, tt_index);
end