function szy_PlotMesh3_vf(vertex, face, ValueOfEachVertex)
% szy_PlotMesh3(vertex, face, ValueOfEachVertex)
% ���ݵ��ϵ�ָ����Ʋ�ɫ����ģ�ͣ�ValueOfEachVertex��һ����������������ģ�͵Ķ�����һ�£�
% ��ʾÿ��������ĳ��ָ�����ֵ���������������ֵ��С�Ĳ�ͬ����άģ�͵���Ƭ���в�ͬ��ɫ��
ValueOfEachFace = szy_VertexValueToFaceValue(face, ValueOfEachVertex);
szy_PlotMesh_vf(vertex, face, ValueOfEachFace);
end