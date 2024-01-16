% [NN_right, Tier1, Tier2, DCG, E_Measure, PRCurve] = szy_MeasureRetrievalPerformance3(AllSamples, Labels)
% ��������������ɵľ���AllSamples����������������ָ�꣬����Labels��ÿ�������ı�ǩ
function [NN_right, Tier1, Tier2, DCG, E_Measure, PRCurve] = ...
    szy_MeasureRetrievalPerformance3(AllSamples, Labels)

DistanceMatrix = squareform(pdist(AllSamples', 'cityblock'));
[NN_right, Tier1, Tier2, DCG, E_Measure, PRCurve] = ...
    szy_MeasureRetrievalPerformance2(DistanceMatrix, Labels);
end