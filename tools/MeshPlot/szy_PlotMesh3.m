function szy_PlotMesh3(fileName, ValueOfEachVertex)
% szy_PlotMesh3(fileName, ValueOfEachVertex)
% ���ݵ��ϵ�ָ����Ʋ�ɫ����ģ�ͣ�ValueOfEachVertex��һ����������������ģ�͵Ķ�����һ�£�
% ��ʾÿ��������ĳ��ָ�����ֵ���������������ֵ��С�Ĳ�ͬ����άģ�͵���Ƭ���в�ͬ��ɫ��
if exist('ValueOfEachVertex', 'var') == 1
    ValueOfEachFace = szy_VertexValueToFaceValue(fileName, ValueOfEachVertex);
    szy_PlotMesh(fileName, ValueOfEachFace);
else
    szy_PlotMesh(fileName);
end
end