% ValueOfEachFace = szy_VertexValueToFaceValue(face, ValueOfEachVertex)
% ValueOfEachVertexΪ����ÿһ�д���һ�������ϵ�����������
% ValueOfEachFaceΪ����ÿһ�д���һ����Ƭ�ϵ�����������
% face��read_mesh�õ���face��
function ValueOfEachFace = szy_VertexValueToFaceValue(face, ValueOfEachVertex)
    ValueOfEachFace = zeros(size(ValueOfEachVertex, 1), size(face, 2));
    for i = 1:size(ValueOfEachVertex, 1)
        temp = ValueOfEachVertex(i, :);
        ValueOfEachFace(i, :) = mean(temp(face));
    end
end