function szy_PlotMesh2(fileName, ValueOfEachFace)
% szy_PlotMesh2(fileName, ValueOfEachFace)
% ���ƺڰ�����ģ�ͣ�ValueOfEachFace��һ����������������ģ�͵���Ƭ��һ�£���ʾÿ��
% ��Ƭ��ĳ��ָ�����ֵ���������������ֵ��С�Ĳ�ͬ����άģ�͵���Ƭ���в�ͬ��ɫ��
[vertex, face] = read_mesh(fileName);
if exist('ValueOfEachFace', 'var') ~= 1
    ValueOfEachFace = zeros(1, size(face, 2));
end
options.face_vertex_color = ValueOfEachFace';
plot_mesh(vertex, face, options);
end
