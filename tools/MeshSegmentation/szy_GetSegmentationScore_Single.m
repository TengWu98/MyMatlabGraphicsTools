% ��ȡ�����˳��4��consistency error��3��hamming distance��
% 1��cut discrepancy��1��rand index
% ע�⣺�������е�·�������á�/��,�����ǡ�\����ԭ������ԭ���߳���ûд�á�
function [ConsistencyError, HammingDistance, CutDiscrepancy, RandIndex] = ...
    szy_GetSegmentationScore_Single(MeshFileName, SegFileName, RefSegFileName)
% N = 15;
% Results = [];
%     Result= [];
%     fnMesh = MeshFileName;
%     fnSeg = SegFileName;
%     fnSegRef = RefSegFileName;
%     dirStat = ResultStoreDir;
tempFolderName = ['ResultStoreDir', szy_GUID()];
mkdir(tempFolderName);
[~, ~] = dos(['segEval.exe "', ...
    MeshFileName, '" "', SegFileName, '" "', ...
    RefSegFileName , '" "', tempFolderName, '" -v -CD -CE -HD -RI']);
% temp = strfind(RefSegFileName, '.');
% temp2 = strfind(RefSegFileName, '/');
[~, refSegFileNameWithoutExt, ~] = fileparts(RefSegFileName);
% refSegFileNameWithoutExt = RefSegFileName((temp2(end) + 1):(temp(end)-1));
ConsistencyError = load([tempFolderName, '/', refSegFileNameWithoutExt, '.CE']);%4 consistency error, ����GCE��LCE�ֱ�ָ���ǵ�1���͵�2��
HammingDistance = load([tempFolderName, '/', refSegFileNameWithoutExt, '.HD']);%3 hamming distance
CutDiscrepancy = load([tempFolderName, '/', refSegFileNameWithoutExt, '.CD']);%1 cut discrepancy
RandIndex = load([tempFolderName, '/', refSegFileNameWithoutExt, '.RI']);%1 rand index

ConsistencyError = ConsistencyError';
HammingDistance =HammingDistance';
CutDiscrepancy = CutDiscrepancy';
RandIndex = RandIndex';

rmdir(tempFolderName, 's');
end
