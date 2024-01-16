function szy_PlotMesh_vf(vertex, face, ValueOfEachFace)
% szy_PlotMesh_vf(vertex, face, ValueOfEachFace)
% ���Ʋ�ɫ����ģ�ͣ�ValueOfEachFace��һ������������������������ģ�͵���Ƭ��һ�£���ʾÿ��
% ��Ƭ��ĳ��ָ�����ֵ���������������ֵ��С�Ĳ�ͬ����άģ�͵���Ƭ���в�ͬ��ɫ��
options.OnlyForFastPlot = 1;
mesh = makeMesh(vertex', face', [], [], options);
% ����readMeshֻ��֧��.obj�����Ը���Ϊread_mesh
% mesh = readMesh(fileName, 'nC');
if exist('ValueOfEachFace', 'var') ~= 1
    ValueOfEachFace = zeros(1, size(face, 2));
end
if size(ValueOfEachFace, 1) == 1
    ValueOfEachFace = ValueOfEachFace';
end
plotMesh(mesh, 'f', ValueOfEachFace);
end