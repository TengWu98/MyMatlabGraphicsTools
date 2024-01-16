function szy_NormalizeModel(inMeshFileName, outMeshFileName)
% szy_NormalizeModel(inMeshFileName, outMeshFileName)
% ��modelFileName���й�һ����ʹ�������Ϊ1��
[~,~] = dos(['szy_NormalizeModel.exe "', inMeshFileName, '"']);
[a, b, ~] = fileparts(inMeshFileName);
tempFileName = [a, '/', b, '_normalized.off'];
[vertex, face] = read_mesh(tempFileName);
delete(tempFileName);
write_mesh(outMeshFileName, vertex, face);
end
