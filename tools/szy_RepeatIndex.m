% result = szy_RepeatIndex(index, interval, repeatCount)
% ��index��ʼ�����ɼ��Ϊinterval�ģ���repeatCount������ƴ�ɵ�һά������
% ��szy_RepeatIndex(1:5, 10, 3)��������1 2 3 4 5 11 12 13 14 15 21 22 23 24 25
% ���������д��
function result = szy_RepeatIndex(index, interval, repeatCount)
result = zeros(1, length(index)*repeatCount);
for i = 1:repeatCount
	% 	tr_index(:, i*(1:length(Index))) = Index;
	% 	Index = Index + stepInterval + length(Index) - 1;
% 	result(:, (i-1)*length(index) +(1:length(index))) = index + ...
% 		(i-1) * (length(index) + interval);
	result(:, (i-1)*length(index) +(1:length(index))) = index + ...
		(i-1) * interval;
%	result(:, (i-1)*length(index) +(1:length(index))) = newValue;
%	newValue = newValue(end) + interval - 1 + index;
end

end