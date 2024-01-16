function [DihedralAngles, Index] = szy_Compute_Dihedral_Angles(fileNameOfModel)
% [DihedralAngles, Index] = szy_Compute_Dihedral_Angles(fileNameOfModel)
% ����fileNameOfModelģ��ÿһ�����ϵĶ���ǣ�[-PI��PI]���������ڽӾ���DihedralAngles�з��أ�
% DihedralAngles�Ǹ�ϡ��������е�i�е�j�е�Ԫ�ر�ʾ��άģ���ϵ�i����Ƭ�͵�j����Ƭ
% ֮��Ķ���ǡ��ڲ�����OpenMeshʵ�֣�����еõ��Ķ���������и���
% С��0�ı�ʾ���ģ�����0�ı�ʾ͹�ġ����ȡ����ֵ�Ժ�ı�ʾ������������Ƭ�ع�����
% ��ת������һ�£�����ָ������άģ����ÿ����Ƭ���Ѷ��õ����ⷨ������Ҫ�����ĽǶȴ�С��
fileNameOfResult = ['Result', szy_GUID(), '.txt'];
[~,~] = dos(['szy_Compute_Dihedral_Angles.exe "', fileNameOfModel, '" "', fileNameOfResult, '"']);
temp = dlmread(fileNameOfResult);
Index = temp(:, [1 2]);
DihedralAngles = spconvert(temp);
delete(fileNameOfResult);
end
