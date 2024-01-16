function szy_WriteMeshWithFaceColor_Continuous(vertex, face, fileNameOfModel, ValueOfFace)
% szy_WriteMeshWithFaceColor(vertex, face, fileNameOfModel, ValueOfFace)
% ����ÿ����Ƭ�ϵ�Value��ֵ������ɫ���������������Ⱦ��obj��ʽ��άģ�͡�
mesh = makeMesh(vertex', face');
if size(ValueOfFace, 2) == 1
    ValueOfFace = ValueOfFace';
end
% ������[0, 1)֮�䡣
ValueOfFace = (ValueOfFace - min(ValueOfFace)) / (max(ValueOfFace) - min(ValueOfFace));
mesh.u = [ValueOfFace', zeros(size(ValueOfFace,2), 1)];
writeMesh(mesh, fileNameOfModel);
[directory, ~, ~] = fileparts(fileNameOfModel);
copyfile(which('MyColorBar.mtl'), directory);
copyfile(which('MyColorBar.png'), directory);
end
