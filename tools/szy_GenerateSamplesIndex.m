% result = szy_GenerateSamplesIndex(classNumber, Indices)
% ��һ�������飬�ɳ��̲�һ��������ƴ�ɣ�ÿ��������ĳ�����classNumber���cell����
% ��ÿ��Ԫ����str���ͣ���'20'����������ÿ����������ȡ����ΪIndices��λ�ã�����
% ��Щλ���ڳ������е�����λ�ú���һ�𷵻ء�
% ���������д��
function result = szy_GenerateSamplesIndex(classNumber, Indices)
count = 0;
result = [];
for i = 1:size(classNumber, 2)
    result = [result (count + Indices)];
    count = count + str2double(classNumber{i});
end

end