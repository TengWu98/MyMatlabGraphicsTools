% ����ProbMatrixӦ������ʵ�ĸ���ȡ-log�Ժ�õ��ģ�
% �Ż�����ǰ���Ȩϵ����Ӧ������AdjacentMatrix��ProbMatrix�Ȳ�����
% ����AdjacentMatrix��ͼ������node���ڽӾ������ڽӹ�ϵΪ0����������Ȩ�أ��磺
% 0 2 1 0
% 2 0 0 0
% 1 0 0 3
% 0 0 3 0
% ����ProbMatrixָ����ÿ��nodeӦ������ÿһ��ĸ��ʷֲ�����ÿһ�ж�Ӧһ��node�����磺
% -log(0.1) -log(0.2) -log(0.3) -log(0.1)
% -log(0.3) -log(0.4) -log(0.5) -log(0.5)
% -log(0.6) -log(0.4) -log(0.2) -log(0.4)
% ����InitLabelָÿ��node�ĳ�ʼ���Ź��ɵ�������������ͨ��ProbMatrix�е�ÿ�����ֵ������ָ��
% ����ֵLabel��ÿ��node�Ż������յ�����
function Label = szy_AlphaExpansionGraphCut(AdjacentMatrix, ProbMatrix, InitLabel)

[I, J] = find(AdjacentMatrix ~= 0);
I_ = I(I < J);
J_ = J(I < J);
weight = AdjacentMatrix(sub2ind(size(AdjacentMatrix), I_, J_));
Edge = [I_ - 1, J_ - 1, weight];
fileNameOfEdges = ['Edge', szy_GUID(), '.txt'];
dlmwrite(fileNameOfEdges, Edge, 'delimiter', ' ');

fileNameOfInitLabel = ['InitLabel', szy_GUID(), '.txt'];
dlmwrite(fileNameOfInitLabel, InitLabel - 1, 'delimiter', ' ');

fileNameOfProbMatrix = ['ProbMatrix', szy_GUID(), '.txt'];
dlmwrite(fileNameOfProbMatrix, ProbMatrix, 'delimiter', ' ');

fileNameOfResult = ['Result', szy_GUID(), '.txt'];

[~,~] = dos(['szy_AlphaExpansionGraphCut.exe "', fileNameOfEdges, '" "', ...
    fileNameOfProbMatrix, '" "', fileNameOfInitLabel, '" ', ...
    int2str(size(AdjacentMatrix, 1)), ' ', int2str(size(ProbMatrix, 1)), ' "', ...
    fileNameOfResult, '"'], '-echo');

Label = dlmread(fileNameOfResult);
Label = (Label + 1)';

delete(fileNameOfResult, fileNameOfEdges, fileNameOfInitLabel, fileNameOfProbMatrix);
end

% "e:/MyPapers/MyMatlabToolbox/�ҵĹ��߰�/AlphaExpansionGraphCut/data/InEdges.txt"  
% "e:/MyPapers/MyMatlabToolbox/�ҵĹ��߰�/AlphaExpansionGraphCut/data/InProbMatrix.txt"  
% "e:/MyPapers/MyMatlabToolbox/�ҵĹ��߰�/AlphaExpansionGraphCut/data/InLabel.txt" 1280 10  
% "e:/MyPapers/MyMatlabToolbox/�ҵĹ��߰�/AlphaExpansionGraphCut/data/outLabel.txt"