function FeatureInput = szy_GetFeatureForEachPatch_VectorField(FaceFeature, weight, idx, P)
L = numel(unique(idx));
sample1.M = FaceFeature;
sample1.w = weight;
trainSamples = {sample1};
testSamples = cell(1, L);
for j = 1:L
    FacesPosition = find(idx == j);
    PatchMatrix = FaceFeature(:, FacesPosition);%һ��patch��ÿ����Ƭ�ϵ�����ֵ��ɵľ���
    smallWeight = weight(FacesPosition);%һ��patch��������Ƭ�������ɵ�����
    sample2.M = PatchMatrix;
    sample2.w = smallWeight;
    testSamples{j} = sample2;
end
% bag of features
[~, tt_dat] = szy_BagOfFeatures(trainSamples, testSamples, P);
FeatureInput = tt_dat;
end