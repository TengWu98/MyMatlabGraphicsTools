% ����Matlab�Դ���SVM���ܽ��ж���ࡣ
function pred_lb = szy_SVMClassify(tr_dat, tr_lb, tt_dat)
t = templateSVM('Standardize', 1);
Mdl = fitcecoc(tr_dat', tr_lb', 'Learners', t);
pred_lb = predict(Mdl, tt_dat');
pred_lb = pred_lb';
end