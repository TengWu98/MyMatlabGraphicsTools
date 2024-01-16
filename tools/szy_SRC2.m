function [pred_lb, R, X] = szy_SRC2(tr_dat, tr_lb, tt_dat, lambda, rel_tol)
% [pred_lb, R, X] = szy_SRC(tr_dat, tr_lb, tt_dat, lambda, rel_tol)
% ��ϡ���ʾ���������з��ࡣtr_dat��ʾѵ��������ÿһ�б�ʾһ��������
% tr_lb��ÿ��ѵ����������֪�������������tt_dat��ʾ����������ÿһ��һ��������
% ����lambda��Ĭ��ֵΪ0.01��rel_tol��Ĭ��ֵΪ0.01��
% pred_lb��ʾ������������������R��ʾϡ���ʾ�Ĳвÿһ�ж�Ӧһ����������
% �ڸ���ѵ�������ϵĲв
% ��������������׫д��

if nargin < 5
    rel_tol = 0.01;  % regularization parameter
end
if nargin < 4
    lambda = 0.01;   % relative target duality gap
end
% ϡ���ʾ
X = [];
for i = 1:size(tt_dat, 2)
    y = tt_dat(:, i);
    disp(['ϡ���ʾ��', int2str(i), '����������...']);
    [x, status]=l1_ls(tr_dat, y, lambda, rel_tol, 1);
    if strcmp(status, 'Solved') == 0
        disp('L1��С������');
    end
    X(:,i) = x;
end

% ����в�
R = [];
uniquelabels = unique(tr_lb);
c = max(size(uniquelabels));
for j = 1:c
    index = find(tr_lb == uniquelabels(j));
    temp = tt_dat - tr_dat(:, index) * X(index,:);
    R(j,:) = sqrt(sum(temp.*temp));
end
[minR,indices] = min(R);

% ��ʱע�͡�����
pred_lb = [];
% pred_lb = uniqlabels(indices);

end