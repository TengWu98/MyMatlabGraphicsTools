%% ��tr_datת��ΪMatlab���ѧϰ������ܽ��ܵ�4D����X_Trainѵ������
function X_Train = szy_Convert_tr_dat_To_X_Train_For_DeepLearning(tr_dat)
for i = 1:size(tr_dat, 2)
    X_Train(1, :, 1, i) = tr_dat(:, i)';
end