% [GaussianCurvature, MeanCurvature] = szy_Compute_JetCurvature_vf(vertex, face)
% ��CGAL�Դ��Ĺ��ܹ�����άģ�Ͷ����ϵ����ʡ�
% jetDegreeΪ1��4֮�䣬Ĭ��ֵΪ2�� 
% mongeDegree����1��Ĭ��ֵΪ2��
% nRing��ʾ�������ڵĶ������fit���棬Ĭ��ֵΪ0����ʾ�Զ��ռ��㹻�Ķ�������
function [GaussianCurvature, MeanCurvature] = szy_Compute_JetCurvature_vf(vertex, face, jetDegree, mongeDegree, nRing)
tempFileName = ['temp', szy_GUID(), '.off'];
write_mesh(tempFileName, vertex, face);
fileNameOfResult = ['Result', szy_GUID(), '.txt'];

if exist('jetDegree', 'var') ~= 1
    jetDegree = 2;
end

if exist('mongeDegree', 'var') ~= 1
    mongeDegree = 2;
end

if exist('nRing', 'var') ~= 1
    nRing = 0;
end

[~,~] = dos(['szy_ComputeJetCurvatures.exe -f "', tempFileName, '" -o "', ...
    fileNameOfResult, '" -d "', int2str(jetDegree), '" -m "', int2str(mongeDegree), ... 
    '" -a "', int2str(nRing), '"']);
% result�ļ�����ÿһ�й�12����������Ϊ��
% origin��4������ maximal_principal_direction * scale��4������minimal_principal_direction * scale��4������ k_1��1��������������ʣ� k_2��1������С�������ʣ�
Result = dlmread(fileNameOfResult);
JetCurvature = Result(:, [13 14])';
GaussianCurvature = JetCurvature(1, :) .* JetCurvature(2, :);
MeanCurvature = mean(JetCurvature);

delete(tempFileName, fileNameOfResult);
end
