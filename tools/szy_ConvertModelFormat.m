function szy_ConvertModelFormat(inMeshFileName, outMeshFileName)
% szy_ConvertModelFormat(inMeshFileName, outMeshFileName)
% ����άģ��inMeshFileName�ļ�ת��ΪoutMeshFileName��ʽ��
[vertex, face] = read_mesh(inMeshFileName);
write_mesh(outMeshFileName, vertex, face);
end
