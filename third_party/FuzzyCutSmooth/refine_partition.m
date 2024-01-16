function [face_patchids_opt] = refine_partition(model, seg, para)
% refine�����������Ϊ���º��ÿ��face��Ӧ��segmentָ��

% segment��Ŀ
num_patches = max(seg.face_patchids);
if num_patches > 1000 || num_patches < 2
    face_patchids_opt = seg.face_patchids;
    return;
end

% face��Ӧ�ĳ�ʼsegmentָ��
Data.initial_patch_ids = seg.face_patchids;

% ����segment������Ӿ��󣬽�����embed����һ���ռ��ϣ���������3D����ÿ��segment��Ӧһ����
if size(seg.face_patchids,1) < size(seg.face_patchids,2) % seg.face_patchidsΪ������
    seg.face_patchids = seg.face_patchids';
end

% ������������˹�ϵ��ÿ��face��Ӧ��segmentָ�꣬���ÿ��face��Ӧ��depth
% depth�������ÿ����Ƭ������segment�߽����ӵ�������Ȧ��
facedepth = boundarydistance(int32(model.edge_fids-1),...
    int32(seg.face_patchids'-1));

num_faces = length(seg.face_patchids);
Data.patch_centerids = zeros(1, num_patches); % ��¼ÿ��segment��center

Data.active_vids = zeros(1, num_faces); % ��face��Ӧ��active_vids��1�������Ӧ��segmentָ��ɱ� 
for patch_id = 1 : num_patches
    ids = find(seg.face_patchids == patch_id);
    [max_patch_depth, max_id] = max(facedepth(ids)); % ÿ��segment��depth����face�Լ���depthֵ
    Data.patch_centerids(patch_id) = ids(max_id); % ÿ��segment��center��depth����face
    Data.active_vids(ids(find(facedepth(ids)<max_patch_depth/2))) = 1; % ��depthС��max/2������Ϊactive
    Data.active_vids(Data.patch_centerids(patch_id)) = 0; % ��center���Ϊinactive
    Data.active_vids(find(facedepth > para.half_brush_width)) = 0; % ��depthֵ����para.half_brush_widthҲ���Ϊinactive
end
Data.active_vids = find(Data.active_vids == 1);% Data.active_vids��¼active��faceָ��

% do graph embedding, compute the optimal coordinate of each patch
% ��ÿ��patch��Ӧ��3D�ռ���ȥ���׷���
Data.patch_coords = graph_embedding(seg.patch_adj_mat); 

% ��������˽�����������濴��node������һ��graph
Data.graph = sparse(double(model.edge_fids(1, :)),...
    double(model.edge_fids(2, :)),...
    ones(1,size(model.edge_fids, 2)));
%graph = graph*graph;
[v1_ids, v2_ids, edge_w] = find(Data.graph); % ����face������ӹ�ϵ����ʵ���ǽ�model.edge_fids��������

flags = zeros(num_faces, 1); % ��active��face��flag��Ϊ1
flags(Data.active_vids) = 1;
ids = find(v1_ids < v2_ids & (flags(v1_ids) > 0 | flags(v2_ids) > 0)); % ids��¼������������������һ��active�ıߵ�ָ��
v1_ids = v1_ids(ids);
v2_ids = v2_ids(ids);  % ������һ��face��active�ıߵ�ָ����

v1_nor = model.face_nor(:, v1_ids); % ����face��Ӧ��normal
v2_nor = model.face_nor(:, v2_ids);
v1_pos = model.face_centers(:, v1_ids); % ����face��Ӧ�����ĵ�
v2_pos = model.face_centers(:, v2_ids);

angles = acos(max(min(sum(v1_nor.*v2_nor),1),-1)); % ��Щ����face֮��ķ���н�

% weight the angle based 
% ����ÿ���ߵĳ��ȣ���һ��
edge_dis = model.vertex_pos(:, model.edge_vids(1,:)) - model.vertex_pos(:, model.edge_vids(2,:));
edge_len = sqrt(sum(edge_dis.*edge_dis));
edge_len = edge_len/max(edge_len);
edge_len = edge_len(ids');

% concave regions
% ���Ļ�inner>0�������ı�angle��Ϊ1�� angle��ȡֵ��-1��1֮�䣬angleԽ��˵����ķ���н�Խ��
inner = sum((v2_pos - v1_pos).*v1_nor) + sum((v1_pos - v2_pos).*v2_nor);
angles(find(inner < 0)) = 0;

% weight curveness
% ������Щ����face֮��ߵ�Ȩ�أ���Ƕȳɷ��ȣ�����ļн�ԽС����֮���edge_w��Խ��
% ��߳������ȣ���������Խ��Ȩ��Ҳ��Խ��
edge_w = exp(-angles/para.sigma_angle).*edge_len;

for i=1:length(edge_w)
    Data.graph(v1_ids(i),v2_ids(i)) = edge_w(i);
end
% Perform robust-cut
% ��ÿ��faceӳ�䵽segment��embeded�Ŀռ���
% ��Ҫ�Ǹ���active��face��Ӧ��segmentָ��
ver_pos_opt = robust_cut(Data, para); 

face_patchids = seg.face_patchids; % ÿ��face��ʼ��Ӧ��segmentָ��
face_patchids(Data.active_vids) = 0; % ��active��face��Ӧsegmentָ����Ϊ0
face_patchids_opt = finishsegmentation(int32(model.edge_fids-1),...  % �Ż�ÿ��face��Ӧ��segmentָ��
    ver_pos_opt, int32(Data.patch_centerids-1),...
    int32(face_patchids-1));
% ʵ���Ͼ��Ƕ�����ÿ��face��patch�ľ��룬inactive��face������segment���붼Ϊ0��Ȼ����Щ���뱻����queue�������Щface��segment��
% ��������queue��������Щactive��face����ͨ�������ڵ�face pop��queue��ʱ���queue
