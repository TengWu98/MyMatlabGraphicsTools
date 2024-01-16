function szy_PlotMesh(fileName, ValueOfEachFace)
% szy_PlotMesh(fileName, ValueOfEachFace)
% ���Ʋ�ɫ����ģ�ͣ�ValueOfEachFace��һ����������������ģ�͵���Ƭ��һ�£���ʾÿ��
% ��Ƭ��ĳ��ָ�����ֵ���������������ֵ��С�Ĳ�ͬ����άģ�͵���Ƭ���в�ͬ��ɫ��
[vertex, face] = read_mesh(fileName);
if exist('ValueOfEachFace', 'var') ~= 1
    ValueOfEachFace = zeros(1, size(face, 2));
end
mesh = makeMesh(vertex', face');
% ����readMeshֻ��֧��.obj�����Ը���Ϊread_mesh
% mesh = readMesh(fileName, 'nC');
plotMesh(mesh, 'f', ValueOfEachFace');
end