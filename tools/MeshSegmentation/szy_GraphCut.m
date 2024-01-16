% Labels = szy_GraphCut(fileNameOfModel, smoothing_lambda, ProbMatrix, cluster_2_segment)
% ��fileNameOfModelģ��������Ƭ����ProbMatrix���ʾ������GraphCutӲ���࣬
% ���Ƕ�CGAL�й��ܵ�Matlab��װ��
% smoothing_lambdaһ��ȡ0.3����ʾGraph CutsӲ����ʱ������С��ʱ�⻬��Լ����Ȩ�أ�����[0,1]��
% Խ�󣬷ֳ�����Խ�٣�ȡ0�Ļ������������������������һ����
% ProbMatrix�������������ʱ�������һ�£�������ģ�͵���Ƭ����
% ����ֵLabels��һ����������ÿһ��Ԫ���Ƕ�Ӧ��������Ƭ�ķ������š�
% cluster_2_segmentΪtrue����false��true��ʾϣ���ָ����ĸ������ȱ�Ų�һ����
% false��ʾϣ���ָ����ĸ������ȱ��һ����
function Labels = szy_GraphCut(fileNameOfModel, smoothing_lambda, ProbMatrix, cluster_2_segment)
[vertex, face] = read_mesh(fileNameOfModel);
Labels = szy_GraphCut_vf(vertex, face, smoothing_lambda, ProbMatrix, cluster_2_segment);
end
