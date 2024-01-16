% function Labels = szy_Segmentation_vf(vertex, face, FaceFeature, Smoothing_lambda, ...
%     ClusterNum, PatchNum, PatchDim)
% ��fileNameOfModel������������Ƭ�ϵ�FaceFeature�����������зָ
% �ָ�����ÿ����Ƭ�ķ����ǩ�ϳɵ�����Labels���ء�
% ClusterNum, PatchNum, PatchDim����Ĭ��ֵ��
% ����FaceFeature��һ������ÿһ�д���һ����Ƭ�ϵ�����������
% Smoothing_lambda��ʾGraph Cutʱ���Ȩ��ϵ��, һ�������ѡ��ֵΪ[0, 2]֮�䡣
% ClusterNum��ʾGraph Cutʱ��ľ���������Ĭ��ֵΪ10��
% PatchNum��ʾOver Segment�׶�Patch�ĸ�����Ĭ��ֵΪ50��
% PatchDim��ʾOver Segment��ʱ��ÿ��Patch��Ӧ������ά����Ĭ��ֵΪ80��
function Labels = szy_Segmentation_vf(vertex, face, FaceFeature, Smoothing_lambda, ...
    ClusterNum, PatchNum, PatchDim)

% over segmentation�׶�patch�ĸ���
if ~exist('PatchNum', 'var')
    PatchNum = 50;
end
% ÿ��patch��Ӧ������ά��
if ~exist('PatchDim', 'var')
    PatchDim = 80;
end
% Graph Cut�ľ�������
if ~exist('ClusterNum', 'var')
    ClusterNum = 10;
end

Area = szy_GetAreaOfFaces_vf(vertex, face);
% Over Segmentation
%     disp(['VLKmeans Clustering ', int2str(kk), '.off ...']);
%     [~, idx] = vl_kmeans(FaceFeature, L, 'Verbose', 'Initialization', 'PLUSPLUS',...
%         'MaxNumIterations', 500, 'NumRepetitions', 10);
idx = szy_OverSegment_vf(vertex, face, PatchNum);
% ����ÿ��patch��Ӧ����������
isVectorFeature = size(FaceFeature, 1) ~= 1;
if ~isVectorFeature
    FeatureInput = szy_GetFeatureForEachPatch_ScalarField(FaceFeature, Area, idx, PatchDim);
else
    FeatureInput = szy_GetFeatureForEachPatch_VectorField(FaceFeature, Area, idx, PatchDim);
end
% �ָ�

% �ø�˹���ģ�ͽ��о��࣬�õ����ʾ���
POSTERIORS_Patch = szy_GMM(FeatureInput, ClusterNum);
%     label = szy_KMeans(FeatureInput, clusterNum);
%     POSTERIORS_Patch = zeros(clusterNum, L);
%     for i = 1:numel(label)
%         POSTERIORS_Patch(label(i), i) = 1;
%     end
% ������Matlab�Դ��ĸ�˹���ģ���㷨Ҫ��vl������㷨Ч�����ã�likelihood����
% �ָ�Ŀ��ӻ�Ч��Ҳ���ã�������ʱ�����һЩ��
% ��Matlab�Դ���GMM�㷨���о��ࡣ
%     POSTERIORS_Patch = szy_GMM_matlab(FeatureInput, clusterNum);

POSTERIORS_Face = [];
for i = 1:ClusterNum
    for j = 1:PatchNum
        FacesPosition = find(idx == j);
        N = size(FacesPosition, 2);
        for k = 1:N
            POSTERIORS_Face(i, FacesPosition(k)) = POSTERIORS_Patch(i, j);
        end
    end
end
% ����CGAL�е�Graph Cut���зָ�����ƽ����
Labels = szy_GraphCut_vf(vertex, face, Smoothing_lambda, POSTERIORS_Face, true);
end