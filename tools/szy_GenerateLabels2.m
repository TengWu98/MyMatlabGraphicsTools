% function Labels = szy_GenerateLabels2(classNumber)
% ����classNumber�������������ı�ǩ����Labels��classNumber��һ����������ÿ��Ԫ�ش���ÿ������������ַ������ͣ���
% classNumber = [20 30 25];
function Labels = szy_GenerateLabels2(classNumber)
Labels = [];
for i = 1:max(size(classNumber))
    for j = 1:classNumber(i)
        Labels = [Labels i];
    end
end
end