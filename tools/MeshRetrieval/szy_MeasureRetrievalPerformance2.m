% [NN_right, Tier1, Tier2, DCG, E_Measure, PRCurve] = szy_MeasureRetrievalPerformance2(DistanceMatrix, Labels)
% ���ݾ������DistanceMatrix����������������ָ�꣬����Labels��ÿ�����������Ź��ɵ���������
function [NN_right, Tier1, Tier2, DCG, E_Measure, PRCurve] = szy_MeasureRetrievalPerformance2(DistanceMatrix, Labels)
tempLabelsFileName = ['temp', szy_GUID(), 'Labels.txt'];
dlmwrite(tempLabelsFileName, Labels, 'delimiter', ' ');

tempDistanceMatrixFileName = ['temp', szy_GUID(), 'DistanceMatrix.txt'];
dlmwrite(tempDistanceMatrixFileName, DistanceMatrix, 'delimiter', ' ');

tempResultFileName = ['temp', szy_GUID(), 'Result.txt'];

command = ['szy_MeasureRetrievalPerformance2.exe ', int2str(size(Labels, 2)), ' ',...
    tempLabelsFileName, ' ', tempDistanceMatrixFileName, ' ', tempResultFileName];
dos(command);

result = dlmread(tempResultFileName);
NN_right = result(1);
Tier1 = result(2);
Tier2 = result(3);
DCG = result(4);
E_Measure = result(5);
PRCurve = [(0.1:0.1:1)', result(6:end)];
PRCurve = [0 1; PRCurve];

delete(tempLabelsFileName ,tempDistanceMatrixFileName, tempResultFileName);
end