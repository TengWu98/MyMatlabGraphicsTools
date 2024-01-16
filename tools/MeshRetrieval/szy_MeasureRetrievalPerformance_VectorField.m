function [NN_right, Tier1, Tier2, DCG, E_Measure, PRCurve] = szy_MeasureRetrievalPerformance_VectorField(Features_VectorField, classNumber, trainSampleIndicesForEachClass, L)
Labels = szy_GenerateLabels(classNumber);
% ѵ�����������ڹ����ֵ�
% ��ΪҪ��Bag of Feature��������ǰ5��ģ����Ϊѵ���������ֵ䡣
% ���������ģ����Ϊѵ���������ֵ�Ļ���ѵ���������ٶȼ�����K-Means�㷨��������
trainSamples = Features_VectorField(szy_GenerateSamplesIndex(classNumber, trainSampleIndicesForEachClass));
disp('��ʼ����Bag of Features...');
[~, A] = szy_BagOfFeatures(trainSamples, Features_VectorField, L);
DistanceMatrix = squareform(pdist(A', 'cityblock'));
[NN_right, Tier1, Tier2, DCG, E_Measure, PRCurve] = szy_MeasureRetrievalPerformance2(DistanceMatrix, Labels);
end