% [GaussianCurvature, MeanCurvature] = szy_Compute_JetCurvature(fileNameOfModel)
% ��CGAL�Դ��Ĺ��ܹ�����άģ�Ͷ����ϵ����ʡ�
% jetDegreeΪ1��4֮�䣬Ĭ��ֵΪ2�� 
% mongeDegree����1��Ĭ��ֵΪ2��
% nRing��ʾ�������ڵĶ������fit���棬Ĭ��ֵΪ0����ʾ�Զ��ռ��㹻�Ķ�������
function [GaussianCurvature, MeanCurvature] = szy_Compute_JetCurvature(fileNameOfModel, jetDegree, mongeDegree, nRing)
[vertex, face] = read_mesh(fileNameOfModel);
[GaussianCurvature, MeanCurvature] = szy_Compute_JetCurvature_vf(vertex, face, jetDegree, mongeDegree, nRing);
end
