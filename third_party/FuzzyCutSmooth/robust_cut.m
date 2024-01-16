function [ver_pos_opt] = robust_cut(Data, para)
% Data.initial_patch_ids;
% Data.patch_coords
% Data.active_vids (only those vertices can be on the boundary)
% Data.graph
% para.weight_vertex_min
% para.weight_vertex_max
% para.alpha_min
% para.alpha_max
% para.num_iterations

% Initialize the vertex positions
ver_pos_init = Data.patch_coords(:, Data.initial_patch_ids); % ��ÿ��face��Ӧ��������patch��Ӧ��3D��coord��
dim = size(ver_pos_init, 1); % ver_pos��ά��
nv = size(ver_pos_init, 2);  % ver_pos�ĸ�������Ϊface��
ver_pos_init = reshape(ver_pos_init, [dim*nv, 1]); % ������ver_pos���һ��dim*nv,�ɵ�����
ver_pos_opt = ver_pos_init; 

% Return if we just have one segment
num_patches = max(Data.initial_patch_ids);
if num_patches < 2
    return;
end

% Precomputation for edge terms
[v1_ids, v2_ids, edge_w] = find(Data.graph); % v1_ids��v2_ids���ڣ�edge_wΪ��������face�ıߵ�Ȩ��
ids = find(v1_ids < v2_ids);
v1_ids = v1_ids(ids); % v1_idsΪ��Ϊne������
v2_ids = v2_ids(ids); % v2_idsΪ��Ϊne������
edge_w = edge_w(ids);

ne = length(v1_ids); % �ߵ�����
rows_G = kron(1:(dim*ne), ones(1, 2*dim)); % ����dim*ne*2*dim�����飬2*dim��1,2*dim��2,...,2*dim��(dim*ne)

% ע��(v1_ids(1)-1)*dim+1,+2,...,+dimΪָ��Ϊv1_ids(1)��Ӧ��coord
tp = kron([v1_ids'; v2_ids']-1, dim*ones(dim, dim)); % Ϊ(2*ne*dim)*(dim)�ľ���, ÿһ�ж���ͬ����Ӧ����([v1_ids'; v2_ids']-1)*dim
cols_G = reshape(tp, [1,2*dim*dim*ne]) + kron(ones(1, 2*dim*ne), 1:dim); % ��dim����ͬ�������ų�һ��
% ͬ����ɳ���dim*ne*2*dim�����飬���Ϊdim����ͬ�������ųɵ�һ��
% ÿ���Ӧ����v1_ids��v2_idsÿ��v��Ӧ��coord��ver_pos_opt�е�ָ�꣬��cols_G��v1_ids��v2_idsÿ��v��Ӧ��coordָ��������ظ�dim��


active_var_ids = dim*kron(Data.active_vids-1, ones(1, dim))...
    + kron(ones(1, length(Data.active_vids)), 1:dim);
% Data.active_vids��Ӧ��coord��ver_pos_opt�е�ָ�꣬����Ϊlength(Data.active_vids)*dim


% Apply Gauss-Newton method �����ã�������
for iteration = 0 : para.num_iterations
    % Set parameters
    if iteration == 0
        alpha = 0;
        lambda = 0;
    else
        t = (iteration - 1)/(para.num_iterations-1); % tΪ0-1��������para.num_iterations��
        lambda = exp(-10*t); % lambda��ʼΪ1������������С
        alpha = exp((1-t)*log(para.alpha_min)... % alpha��para.alpha_min��para.alpha_max��͹���
            + t*log(para.alpha_max));
    end
   
    tp = reshape(ver_pos_opt, [dim, nv]);
    res = tp(:, v1_ids) - tp(:, v2_ids); % ��������face��coord�Ĳ�
    
    if dim > 1
        tp = (1 + alpha*sum(res.*res)); % ��¼ÿ����face��ŷ�Ͼ����ƽ��s��tp=1+alpha*s
    else
        tp = 1 + alpha*(res.*res);
    end
    scale1 = sqrt(edge_w)' ./ power(tp, 0.5); 
    scale2 = (scale1 ./ tp)*alpha;
    
    tp = kron(res, ones(1, dim)).*...
        kron(reshape(res, [1, ne*dim]), ones(dim, 1));
    
    vals_G = kron(scale1, [eye(dim); -eye(dim)])...
        - kron(scale2, ones(2*dim, dim)).*[tp;-tp];
   
    vals_G = reshape(vals_G, [1, dim*dim*2*ne]);
    G = sparse(rows_G, cols_G, vals_G);
    
    num_vars = length(active_var_ids);
    
    G = G(:, active_var_ids);
    c = reshape(res, [dim*ne,1]).*kron(scale1', ones(dim,1));
    
    H = sparse(1:num_vars, 1:num_vars, ones(1, num_vars))*lambda;
    
    dx = -(G'*G+H)\(G'*c);
    
    ver_pos_opt(active_var_ids) = ver_pos_opt(active_var_ids) + dx;
    
    if norm(dx) < 1e-6
        break;
    end
    if iteration < para.num_iterations || iteration == para.num_iterations
        deviation = sum(sum(abs(ver_pos_opt - ver_pos_init)));
%         fprintf('alpha = %f, norm(dx) = %f, deviation = %f.\n',...
%             alpha, norm(dx), deviation);
    end
end

ver_pos_opt = reshape(ver_pos_opt, [dim, nv]);
