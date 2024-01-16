% Labels = szy_SegmentationUsingSDF_vf(vertex, face, cluster_Num, smoothing_lambda)
% ����vertex��face��ʾ����άģ�ͽ��зָ���Ƕ�CGAL�й��ܵ�Matlab��װ��
% ���SDFָ�꣬���û�ϸ�˹ģ�ͽ�������࣬
% Ȼ����Graph Cuts����Ӳ���ࡣ cluster_Num��ʾ���������Ŀ������
% smoothing_lambdaһ��ȡ0.3����ʾGraph CutsӲ����ʱ������С��ʱ�⻬��Լ����Ȩ�أ�����[0,1]��
% Խ�󣬷ֳ�����Խ�٣�ȡ0�Ļ������������������������һ��������cluster_Num��
% ����ֵLabels��һ����������ÿһ��Ԫ���Ƕ�Ӧ��������Ƭ�ķ������š�
function Labels = szy_SegmentationUsingSDF_vf(vertex, face, cluster_Num, ...
    smoothing_lambda)
tempFileName = ['temp', szy_GUID(), '.off'];
write_mesh(tempFileName, vertex, face);
fileNameOfResult = ['Result', szy_GUID(), '.txt'];
[~,~] = dos(['szy_SegmentationUsingSDF.exe "', tempFileName, '" "', ...
    fileNameOfResult, '" ', int2str(cluster_Num), ' ', num2str(smoothing_lambda)]);
Labels = dlmread(fileNameOfResult)';
delete(fileNameOfResult, tempFileName);
end
