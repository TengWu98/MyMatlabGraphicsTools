% function Labels = szy_GenerateLabels(classNumber)
% ����classNumber�������������ı�ǩ����Labels��classNumber��һ��cell��ÿ��Ԫ�ش���ÿ������������ַ������ͣ���
% classNumber = {'20', '30', '25'};
function Labels = szy_GenerateLabels(classNumber)
Labels = [];
for i = 1:max(size(classNumber))
    for j = 1:str2num(classNumber{i})
        Labels = [Labels i];
    end
end
end