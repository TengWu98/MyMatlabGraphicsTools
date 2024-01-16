function FeatureInput = szy_GetFeatureForEachPatch_ScalarField(FaceFeature, weight, idx, P)
L = numel(unique(idx));
FeaturePatch = cell(L);
FeatureInput = zeros(P, L);
interval_a = min(FaceFeature);
interval_b = max(FaceFeature);
for j = 1:L
    FacesPosition = find(idx == j);
    PatchMatrix = FaceFeature(:, FacesPosition);%һ��patch��ÿ����Ƭ�ϵ�����ֵ��ɵ�����
    smallWeight = weight(FacesPosition);
    FeaturePatch{j} = PatchMatrix;
    d = histcwc(FeaturePatch{j}, smallWeight, linspace(interval_a, interval_b - ...
        (interval_b - interval_a) / P, P));
    d = d / sum(d);
    % FeatureInput��һ��ģ����ÿ��Patch�ϵ�����������ɵľ���
    FeatureInput(:, j) = d;
end
end