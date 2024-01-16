% NormalizedSDFs = szy_SDF_Values_Postprocessing(fileNameOfModel, SDFValues)
% ��ԭʼSDFֵ���к�̴�������˫���˲������Ի���log normalize�ȡ�
function NormalizedSDFs = szy_SDF_Values_Postprocessing(fileNameOfModel, SDFValues)
[vertex, face] = read_mesh(fileNameOfModel);
tempFileName = ['temp', szy_GUID(), '.off'];
write_mesh(tempFileName, vertex, face);
tempFileName2 = ['temp', szy_GUID(), '.txt'];
dlmwrite(tempFileName2, SDFValues, ' ');
fileNameOfResult = ['Result', szy_GUID(), '.txt'];
[~,~] = dos(['szy_SDF_Values_Postprocessing.exe "', tempFileName, '" "',... 
    tempFileName2, '" "', fileNameOfResult, '"']);
NormalizedSDFs = dlmread(fileNameOfResult);
delete(fileNameOfResult, tempFileName, tempFileName2);
end
