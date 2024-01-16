% function Labels = szy_Segmentation(fileNameOfModel, FaceFeature, Smoothing_lambda, ...
%    ClusterNum, PatchNum, PatchDim)
% ��fileNameOfModel������������Ƭ�ϵ�FaceFeature�����������зָ
% �ָ�����ÿ����Ƭ�ķ����ǩ�ϳɵ�����Labels���ء�
% ClusterNum, PatchNum, PatchDim����Ĭ��ֵ��
% ����FaceFeature��һ������ÿһ�д���һ����Ƭ�ϵ�����������
% Smoothing_lambda��ʾGraph Cutʱ���Ȩ��ϵ��, һ�������ѡ��ֵΪ[0, 2]֮�䡣
% ClusterNum��ʾGraph Cutʱ��ľ���������Ĭ��ֵΪ10��
% PatchNum��ʾOver Segment�׶�Patch�ĸ�����Ĭ��ֵΪ50��
% PatchDim��ʾOver Segment��ʱ��ÿ��Patch��Ӧ������ά����Ĭ��ֵΪ80��
function Labels = szy_Segmentation(fileNameOfModel, FaceFeature, Smoothing_lambda, ...
    ClusterNum, PatchNum, PatchDim)

[vertex, face] = read_mesh(fileNameOfModel);
Labels = szy_Segmentation_vf(vertex, face, FaceFeature, Smoothing_lambda, ...
    ClusterNum, PatchNum, PatchDim);

end