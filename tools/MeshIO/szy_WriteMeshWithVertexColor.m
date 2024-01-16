function szy_WriteMeshWithVertexColor(vertex, face, fileNameOfModel, ValueOfVertex)
% szy_WriteMeshWithVertexColor(vertex, face, fileNameOfModel, ValueOfVertex)
% ����ÿ�������ϵ�Value��ֵ������ɫ���������������Ⱦ��obj��ʽ��άģ�͡�
mesh = makeMesh(vertex', face');
% ������[0, 1]֮�䡣
ValueOfVertex = (ValueOfVertex - min(ValueOfVertex)) / (max(ValueOfVertex) - min(ValueOfVertex));
mesh.u = [ValueOfVertex', zeros(size(ValueOfVertex,2), 1)];
writeMesh(mesh, fileNameOfModel);
[directory, ~, ~] = fileparts(fileNameOfModel);
copyfile(which('MyColorBar.mtl'), directory);
copyfile(which('MyColorBar.png'), directory);
end
