function szy_PlotPoints(Points, ValueOfEachPoint)
% szy_PlotPoints(Points, ValueOfEachPoint)
% ���Ʋ�ɫ�㼯��ValueOfEachPoint��һ�������������������һ�£���ʾÿ��
% ����ĳ��ָ�����ֵ���������������ֵ��С�Ĳ�ͬ�Ե��ƽ��в�ͬ��ɫ��
% ע�⣺���뻹�����⣡����������ʾ��ɫ����ԭ������
scatter3(Points(1, :)', Points(2, :)', Points(3, :)', 'filled', 'cdata', ValueOfEachPoint');
end