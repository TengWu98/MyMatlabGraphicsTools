function [SuccessRatioEachClass, successRatio] = szy_GetSuccessRatio(pred_lb, tt_lb)
% [SuccessRatioEachClass, successRatio] = szy_GetSuccessRatio(pred_lb, tt_lb)
% pred_lb��tt_lb����һ�����������ֱ��ʾԤ������ʵ�����
% SuccessRatioEachClass�Ǹ����ķ���ƽ��׼ȷ�ʣ�successRatio��ʾ���ص���ƽ��Ԥ��ɹ��ʡ�
% ���������д��
successRatio = sum(pred_lb == tt_lb) / length(pred_lb);
disp(['success ratio is ', num2str(successRatio)]);

temp = unique(tt_lb);
SuccessRatioEachClass = [];
for i = 1:size(temp, 2)
    temp2 = (tt_lb == temp(i));
    SuccessRatioEachClass(i) = sum(pred_lb(temp2) == tt_lb(temp2)) / length(pred_lb(temp2));
end
end