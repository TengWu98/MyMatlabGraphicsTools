function smooth_hie(dir, filename)
% ������ģ�͵ķָ����߽����smooth
% dir��ģ�������ļ���Ŀ¼
% filename��ģ�ͷָ�������

%% face_cluster
% ��ȡģ�����ƺͷָ���
idx = strfind(filename,'_');
model_name = filename(1:(idx(1)-1));
patch_num = str2double(filename((idx(1)+1):(idx(2)-1)));

% ��ȡpatch_cluster�ļ�����֮ǰ�Ľ���ļ�
fid_pc = fopen([dir,'\',filename,'.txt'],'r');
X_temp = textscan(fid_pc, '%d');
fclose(fid_pc);
patch_cluster = X_temp{1};

% ��ȡface_patch�ļ�
name_fp = [model_name,'_',num2str(patch_num)];
fid_fp = fopen([dir,'\',name_fp,'.txt'],'r');
X_temp = textscan(fid_fp, '%d');
fclose(fid_fp);
face_patch = X_temp{1} + 1;

% �õ�face_cluster, ��ÿ��face��Ӧ��clusterָ�꣬���ڶ�refine_seg֮���ָ��ӳ���ԭ����ָ��
face_cluster = patch_cluster(face_patch);
clear patch_cluster face_patch

%% smooth
% Parameters
Para.minEdgeWeight = 0.1;               % minimum edge weights
Para.alphaAngle = 0.33;                 % Used in make the edge weights more uniformly distributed
Para.half_brush_width = 10;

% load model
[model] = loadfobj([dir,'\',model_name,'.obj']);
% Compute edge weights based on concavity
edgeConcavityWeights = compute_angle_weights(model);
% Smooth the edge concavity weights
edgeConcavityWeights = power(edgeConcavityWeights, Para.alphaAngle);
% Edge weights, the smaller, the better
edgeWeights = 1 - (1- Para.minEdgeWeight)*edgeConcavityWeights;

% Perform hierachical clustering�� �������face��Ϊ���
graph = [double(model.edge_fids); edgeWeights];
% ��ȡface_segment�ļ�,face_patchids,��ÿ����Ƭ��Ӧ��segmentָ��
fid_fs = fopen([dir,'\',filename,'.fs'],'r');
X_temp = textscan(fid_fs, '%f');
fclose(fid_fs);
seg.face_patchids = X_temp{1}+1;

% ������������˹�ϵ��ÿ��face��Ӧ��segmentָ�꣬���ÿ��face��Ӧ��depth
% depth�������ÿ����Ƭ������segment�߽����ӵ�������Ȧ��
facedepth = boundarydistance(int32(model.edge_fids-1),...
    int32(seg.face_patchids'-1));
num_faces = length(seg.face_patchids);
num_patches = max(seg.face_patchids(:));
patch_centerids = zeros(1, num_patches); % ��¼ÿ��segment��center
active_vids = zeros(1, num_faces); % ��face��Ӧ��active_vids��1�������Ӧ��segmentָ��ɱ� 
for patch_id = 1 : num_patches
    ids = find(seg.face_patchids == patch_id);
    [max_patch_depth, max_id] = max(facedepth(ids)); % ÿ��segment��depth����face�Լ���depthֵ
    patch_centerids(patch_id) = ids(max_id); % ÿ��segment��center��depth����face
    active_vids(ids(find(facedepth(ids)<max_patch_depth/2))) = 1; % ��depthС��max/2������Ϊactive
    active_vids(patch_centerids(patch_id)) = 0; % ��center���Ϊinactive
    active_vids(find(facedepth > Para.half_brush_width)) = 0; % ��depthֵ����para.half_brush_widthҲ���Ϊinactive
end
seg.face_patchids = hie_clus_new(graph, active_vids, seg.face_patchids' , num_patches);


%% ��refine_seg֮���ָ��ӳ���ԭ����ָ��
seg_num = max(seg.face_patchids);
mapping = zeros(1,seg_num);
idxs = cell(1,seg_num);
for i = 1:seg_num
    idxs{i} = seg.face_patchids == i;
    [B,I,J] = unique(face_cluster(idxs{i}));
    n = length(B);
    max_num = 0;
    idx = 0;
    for j=1:n
        m = sum(J==j);
        if m > max_num
            idx = B(j);
            max_num = m;
        end
    end
    mapping(i) = idx;
end
for i = 1:seg_num
    seg.face_patchids(idxs{i}) = mapping(i);
end
clear idxs

%% ��refine��Ľ�����
output_name = [filename,'_refin_'];
fid=fopen([dir,'\',output_name,'.txt'],'wt');
for i=1:length(seg.face_patchids)
    fprintf(fid,'%d\n',seg.face_patchids(i));
end
fclose(fid);

function [edgeConcavityWeights] = compute_angle_weights(model)

vertexPos1 = model.vertex_pos(:, model.face_vids(1,:));
vertexPos2 = model.vertex_pos(:, model.face_vids(2,:));
vertexPos3 = model.vertex_pos(:, model.face_vids(3,:));

faceCenters = (vertexPos1 + vertexPos2 + vertexPos3)/3;

thetas = sum(model.face_nor(:, double(model.edge_fids(1,:)))...
    .*model.face_nor(:, double(model.edge_fids(2,:))));
thetas = acos(max(min(thetas, 1), -1));

edgeConcavityWeights = min(1, thetas);
edgeConcavityWeights = edgeConcavityWeights/max(edgeConcavityWeights);

%only concave edges
edges = faceCenters(:, double(model.edge_fids(1,:)))-...
    faceCenters(:, double(model.edge_fids(2,:)));

inner1 = -sum(edges.*model.face_nor(:, model.edge_fids(1,:)));
inner2 = sum(edges.*model.face_nor(:, model.edge_fids(2,:)));

edgeConcavityWeights(find(inner1 + inner2 < 0)) = 0;