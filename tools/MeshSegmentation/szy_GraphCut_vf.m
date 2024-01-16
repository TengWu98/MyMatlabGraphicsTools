% Labels = szy_GraphCut_vf(vertex, face, smoothing_lambda, ProbMatrix, cluster_2_segment)
% ��fileNameOfModelģ��������Ƭ����ProbMatrix���ʾ������GraphCutӲ���࣬
% ���Ƕ�CGAL�й��ܵ�Matlab��װ��
% smoothing_lambdaһ��ȡ0.3����ʾGraph CutsӲ����ʱ������С��ʱ�⻬��Լ����Ȩ�أ�����[0,1]��
% Խ�󣬷ֳ�����Խ�٣�ȡ0�Ļ������������������������һ����
% ProbMatrix�������������ʱ�������һ�£�������ģ�͵���Ƭ����
% ����ֵLabels��һ����������ÿһ��Ԫ���Ƕ�Ӧ��������Ƭ�ķ������š�
% cluster_2_segmentΪtrue����false��true��ʾϣ���ָ����ĸ������ȱ�Ų�һ����
% false��ʾϣ���ָ����ĸ������ȱ��һ����
function Labels = szy_GraphCut_vf(vertex, face, smoothing_lambda, ProbMatrix, cluster_2_segment)
tempFileName = ['temp', szy_GUID(), '.off'];
write_mesh(tempFileName, vertex, face);
cluster_Num = size(ProbMatrix, 1);
fileNameOfResult = ['Result', szy_GUID(), '.txt'];
[~,I] = max(ProbMatrix);
fileNameOfInitLabel = ['InitLabel', szy_GUID(), '.txt'];
dlmwrite(fileNameOfInitLabel, I, 'delimiter', ' ');
fileNameOfProbMatrix = ['ProbMatrix', szy_GUID(), '.txt'];
dlmwrite(fileNameOfProbMatrix, ProbMatrix, 'delimiter', ' ');
[~,~] = dos(['szy_GraphCut.exe "', tempFileName, '" "', ...
    fileNameOfResult, '" ', int2str(cluster_Num), ' ', ...
    num2str(smoothing_lambda), ' "', fileNameOfInitLabel, '" "', ...
    fileNameOfProbMatrix, '" ', int2str(size(face, 2)), ' '...
    int2str(cluster_2_segment)]);
Labels = dlmread(fileNameOfResult);
delete(fileNameOfResult, tempFileName, fileNameOfInitLabel, fileNameOfProbMatrix);
end
