function pred_lb = szy_DBNClassify_GPU(tr_dat, tr_lb, tt_dat, structure, batch_size, num_epoch)

tr_dat = tr_dat';
tt_dat = tt_dat';
% ת��tr_lbΪtrain_y
train_y = [];
for i = 1:size(tr_dat, 1)
    train_y(i, tr_lb(i)) = 1;
end

%% 200ά����άģ����������������ͨ��һ��200-100-50-30�����������Ԥ����࣬
% ����100-50�������м�㣬30�Ƿ�������������200-100-50��Stacked Auto Encoder��
% 50-30�����softmax�������������ڣ�
% http://deeplearning.stanford.edu/wiki/index.php/%E6%A0%88%E5%BC%8F%E8%87%AA%E7%BC%96%E7%A0%81%E7%AE%97%E6%B3%95
%

% Ԥѵ��200-100-50��Stacked Auto Encoder���ڲ��ṹ��200-100-200,100-50-100��Auto Encoder���зֱ�ѵ����
% �õ��ֲ����ŵĳ�ʼȨ�ز���w����̰����˼�룩
rng(0);
structure_1 =structure(:, 1:(end-1));
sae = saesetup(structure_1); % //��ʵ����nn�е�W�Ѿ��������ʼ����
for i = 1:(size(structure_1, 2) - 1)
    sae.ae{i}.activation_function       = 'sigm';
    sae.ae{i}.learningRate              = 1;
    sae.ae{i}.inputZeroMaskedFraction   = 0.;
end
opts.numepochs = num_epoch;
opts.batchsize = batch_size;
sae = saetrain_gpu(sae, tr_dat, opts);% //�޼ලѧϰ������Ҫ�����ǩֵ��ѧϰ�õ�Ȩ�ط���sae�У�
%  //����train_x�����һ�������������������Ƿֲ�Ԥѵ��
%  //�ģ�����ÿ��ѵ����ʵֻ������һ�������㣬�������������
%  //��Ӧ��denoise����
% visualize(sae.ae{1}.W{1}(:,2:end)')

% ����200-100-50-30�������磨�����������������ࣩ��
% ��ǰ��Ԥѵ���õ����Ա��������Ȩֵw��Ϊ���������ǰ����200-100-50�ĳ�ʼȨ�أ�
% ���һ��50-30�ĳ�ʼȨ�����ȡֵ��ͬʱ���һ����SoftMax��������
% ����������������������ÿ����ͬ����ĸ���ֵ����30����
% ȡ�����Ǹ���ΪԤ��õ��ķ�������
nn = nnsetup(structure);
nn.activation_function              = 'sigm';
nn.learningRate                     = 1;
nn.output = 'softmax';  % ָ�����һ��Ϊsoftmax������
%add pretrained weights
for i = 1:(size(structure_1, 2)-1)
    nn.W{i} = sae.ae{i}.W{1}; % ��saeѵ�����˵�Ȩֵ����nn������Ϊ��ʼֵ��������ǰ��������ʼ��
end
% Train the FFNN
opts.numepochs = num_epoch;
opts.batchsize = batch_size;
nn = nntrain_gpu(nn, tr_dat, train_y, opts);

pred_lb = nnpredict(nn, tt_dat);
pred_lb = pred_lb';
end