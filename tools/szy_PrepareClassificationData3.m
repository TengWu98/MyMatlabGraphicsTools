function [train_x, test_x, train_y, test_y] = szy_PrepareClassificationData3(...
    AllSamples, classNum, sampleNumInClass, trainingNum)
% [train_x, test_x, train_y, test_y] = szy_PrepareClassificationData3(AllSamples, classNum, sampleNumInClass, trainingNum)
% ׼���������з�����������ݡ�ע�⣺������������������������ģ�͡�
% AllSamples��һ�����󣬱�ʾ����������ÿһ����һ��������classNum��ʾ�ܹ��ж����࣬
% sampleNumInClass��ʾÿ���ж��ٸ�������trainingNum��ʾÿ������ǰ���ٸ���Ϊѵ��������
% ������Ϊ����������train_x��test_x���Ǿ���ÿһ����һ���������ֱ��ʾѵ�������Ͳ���������
% train_y��test_y���Ǿ��󣬷ֱ��ʾѵ�������Ͳ�����������ȷ�����ǩ��ÿһ�д���һ�������ķ�����Ϣ��
% train_y��test_y����[1 1 1 ... 1 0 0 0 ... 0 0...0
%                     0 0 0 ... 0 1 1 1 ..1 0 0...0
%                     .............................
%                     0.. ..................1 1...1]


[train_x, test_x, tr_lb, tt_lb] = szy_PrepareClassificationData(...
    AllSamples, classNum, sampleNumInClass, trainingNum);

% �����Ա����������������ܵĸ�ʽ��ÿ��һ��������������������Ҫת��һ�¡�
train_y = [];
for i = 1:size(train_x, 2)
    train_y(tr_lb(i), i) = 1;
end
test_y = [];
for i = 1:size(test_x, 2)
    test_y(tt_lb(i), i) = 1;
end

end