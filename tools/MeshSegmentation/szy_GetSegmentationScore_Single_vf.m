% ��ȡ�����˳��4��consistency error��3��hamming distance��
% 1��cut discrepancy��1��rand index
% ע�⣺�������е�·�������á�/��,�����ǡ�\����ԭ������ԭ���߳���ûд�á�
function Result = szy_GetSegmentationScore_Single_vf(vertex, face, SegFileName, RefSegFileName)
% N = 15;
% Results = [];
%     Result= [];
%     fnMesh = MeshFileName;
%     fnSeg = SegFileName;
%     fnSegRef = RefSegFileName;
%     dirStat = ResultStoreDir;
tempFolderName = ['ResultStoreDir', szy_GUID()];
tempModelFileName = ['tempModel', szy_GUID(), '.off'];
write_mesh(tempModelFileName, vertex, face);
mkdir(tempFolderName);
[status, cmdout] = dos(['segEval.exe "', ...
    tempModelFileName, '" "', SegFileName, '" "', ...
    RefSegFileName , '" "', tempFolderName, '" -v -CD -CE -HD -RI']);
if status ~= 0
    disp('segEval��ִ���!');
    return;
end
% temp = strfind(RefSegFileName, '.');
% temp2 = strfind(RefSegFileName, '/');
[~, refSegFileNameWithoutExt, ~] = fileparts(RefSegFileName);
% refSegFileNameWithoutExt = RefSegFileName((temp2(end) + 1):(temp(end)-1));
ResCE = load([tempFolderName, '/', refSegFileNameWithoutExt, '.CE']);%4 consistency error
ResHD = load([tempFolderName, '/', refSegFileNameWithoutExt, '.HD']);%3 hamming distance
ResCD = load([tempFolderName, '/', refSegFileNameWithoutExt, '.CD']);%1 cut discrepancy
ResRI = load([tempFolderName, '/', refSegFileNameWithoutExt, '.RI']);%1 rand index
Result = [ResCE ResHD ResCD ResRI]';
%     Results = [Results; Result];
rmdir(tempFolderName, 's');
delete(tempModelFileName);
end
