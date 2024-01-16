function szy_WriteMeshWithFaceColor_Discrete(vertex, face, fileNameOfModel, ...
    LabelOfFace)
% szy_WriteMeshWithFaceColor_Discrete(vertex, face, fileNameOfModel, LabelOfFace)
% ����ÿ����Ƭ�ϵ�Labelֵ(��1��ʼ����)��������ɢɫ��������24����ɫ�������������Ⱦ
% ��obj��ʽ��άģ�͡�
mesh = makeMesh(vertex', face');
if size(LabelOfFace, 2) == 1
    LabelOfFace = LabelOfFace';
end
LabelOfFace = (mod(LabelOfFace-1, 24)+1) / 24 - 1/48;
mesh.u = [LabelOfFace', ones(size(LabelOfFace,2), 1)* 0.5];
writeMesh(mesh, fileNameOfModel);
[directory, ~, ~] = fileparts(fileNameOfModel);
if exist([pwd, 'MyColorBar.mtl'], 'file') == 2
    delete([pwd, 'MyColorBar.mtl']);
end
copyfile(which('MyColorBar.mtl'), directory);
copyfile(which('MyColorBar_Discrete.png'), directory);
movefile([directory, '/MyColorBar_Discrete.png'], [directory, '/MyColorBar.png']);
end
