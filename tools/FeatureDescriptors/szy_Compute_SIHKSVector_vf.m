function SIHKSVector = szy_Compute_SIHKSVector_vf(vertex, face, Labels, L)
    [~, SIHKSMatrix] = szy_Compute_SIHKSMatrix_vf(vertex, face);
    sample1.M = SIHKSMatrix;
    Areas = szy_GetAreaOfFaces(vertex, face);%ÿ����Ƭ���������
    sample1.w = Areas;%������
    trainSamples = {};
    trainSamples{1} = sample1;
    
    %testSamples
    testSamples = {};
    for j = 1:length(unique(Labels))
        sample2.M = SIHKSMatrix(:, Labels == j);%һ��patch����������
        sample2.w = Areas(Labels == j);%һ��patch����Ƭ���������
        testSamples{j} = sample2;
    end
    %bag of features
    [~, tt_dat] = szy_BagOfFeatures(trainSamples, testSamples, L);
    SIHKSVector = tt_dat;
end