% D2 = szy_Compute_D2(fileNameOfModel, L)
% ��������ģ�͵�D2����������
function D2 = szy_Compute_D2(fileNameOfModel, L)
Num = 5000;
[PointClouds, ~] = szy_ReSamplePointCloudOnMesh(fileNameOfModel, Num);
D = pdist(PointClouds');
D2 = hist(D, L);
D2 = D2 / sum(D2);
end
