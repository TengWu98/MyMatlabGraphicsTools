function [PointClouds, Normals] = szy_UniformSamplePointsOnMesh(meshFileName, Num)
% [PointClouds, Normals] = szy_ReSmaplePointCloudOnMesh(meshFileName, Num)
% ��fileNameOfModel����������о����ز��������ز���������ϵķ���
% PointClouds��3xNum�ľ���ÿһ�д���һ���㡣Normals��3xNum�ľ���ÿһ�д���һ������
[a, b, ~] = fileparts(meshFileName);
fileNameOfResult = [a, '/', b, szy_GUID(), '.txt'];
[~,~] = dos(['szy_ResamplePointCloudOnMesh.exe "', meshFileName, '" "', ...
    fileNameOfResult, '" ', int2str(Num)]);
PointCloudWithNormals = dlmread(fileNameOfResult);
delete(fileNameOfResult);
PointClouds = PointCloudWithNormals(:, 1:3)';
Normals = PointCloudWithNormals(:, 4:6)';
end
