% [GaussianCurvature, MeanCurvature] = szy_Compute_JetCurvature_PointCloud(vertex, k, jetDegree, mongeDegree)
% ��CGAL�Դ��Ĺ��ܹ�����άģ�Ͷ����ϵ����ʡ�
% vertex�Ƕ������ÿһ�д���һ���㡣
% k��ʾ����Χѡ����ٸ�����ĵ㣬һ�������ϡ�
% jetDegreeΪ1��4֮�䣬Ĭ��ֵΪ2�� 
% mongeDegree����1��Ĭ��ֵΪ2��
function [GaussianCurvature, MeanCurvature] = szy_Compute_JetCurvature_PointCloud(vertex, k, jetDegree, mongeDegree)
% ��ÿһ��vertex���������ڵ����е㣬���γ�һ������ÿһ�д���һ�е㣬����ÿ�е�һ�����ϼ�������
large_vertex = [];
Idx = knnsearch(vertex, vertex, 'k', k);
for i = 1:size(Idx, 1)
    line = Idx(i, :);
    line = vertex(line', :)';
    line = line(:)';
    large_vertex(i, :) = line;
end
tempFileName = ['temp', szy_GUID(), '.txt'];
dlmwrite(tempFileName, large_vertex, ' ');
fileNameOfResult = ['Result', szy_GUID(), '.txt'];

if exist('jetDegree', 'var') ~= 1
    jetDegree = 2;
end

if exist('mongeDegree', 'var') ~= 1
    mongeDegree = 2;
end

[~, ~] = dos(['szy_ComputeJetCurvaturesOnFirstPointOfPointList.exe "', tempFileName, '" "', ...
    int2str(jetDegree), '" "', int2str(mongeDegree), '" "', fileNameOfResult, '"']);
JetCurvature = dlmread(fileNameOfResult);
GaussianCurvature = JetCurvature(:, 1) .* JetCurvature(:, 2);
MeanCurvature = mean(JetCurvature, 2);

delete(tempFileName, fileNameOfResult);
end
